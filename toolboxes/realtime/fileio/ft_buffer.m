classdef ft_buffer
	% Simple class for managing a connection to a FieldTrip buffer
	% Not complete yet -- only reading functions are implemented!
	%
	% This class is intended to be used for convenient realtime processing of incoming data and events
	% using a logic like this:
	%
	% ftb = ft_buffer('buffer://localhost:1972');  % open connection
	% disp(ftb.hdr);                               % this should contain the header information
	%   ...
	% lastNum = ftb.poll();                        % get currently present number of events and samples
	% timeout = 100;                               % polling timeout in milliseconds
	% while someCondition
	%    newNum = ftb.poll(lastNum, timeout);
	%    if newNum.nsamples > lastNum.nsamples
	%       D = ftb.read_data([lastNum.nsamples+1  newNum.nsamples]);   % read new samples
	%       ...
	%    end
	%    if newNum.nevents > lastNum.nevents
	%       E = ftb.read_events([lastNum.nevents+1  newNum.nevents]);   % read new events
	%       ...
	%    end
	%    lastNum = newNum;     % for the next iteration
	% end
	%
	% Copyright (c) 2010, S.Klanke
	%
	% May 2011, P.L.C. van den Broek
	%		Made object backwards compatible with fieldtrip buffer "version 1
	%		without extension".
	%		Property 'bc' indicates if backward compatibility method
	%		'poll_bc' or buffer('WAIT_DAT', .... should be called.
	
	properties
		host		= [];
		port		= 0;
		hdr		= [];
		bc			= 0; % use backwards compatibility mode
	end
	
	methods
		
		function obj = ft_buffer(filename)
			% FT_BUFFER - Create a connection and read header information
			%
			% Call this like
			%    ftb = ft_buffer('buffer://localhost:1972');
			%
			% This function will fail if no header information is present yet,
			% so you should put this in a try-catch statement.
			dataformat = ft_filetype(filename);
			
			if ~strcmp(dataformat, 'fcdc_buffer')
				error 'Given filename does not represent FieldTrip buffer';
			end
			
			[obj.host, obj.port] = filetype_check_uri(filename);
			% better use ft_read_header here?
			obj.hdr = buffer('GET_HDR', [], obj.host, obj.port);
			
			% check if backwards compatibilty mode is required
			try
				buffer('WAIT_DAT', [-1 -1 0], obj.host, obj.port);
			catch
				% must be buffer version 1 without extensions
				obj.bc = 1; 
			end			
		end
		
		function D = read_data(obj, sel)
			% read_data  -- get samples from the buffer
			%
			% Calling without input arguments retrieves all currently present samples
			%   D = object.read_data()
			% Alternatively, you can ask for a specific interval (1-based indices)
			%   D = object.read_data([start end])
			% The second form will fail if less then 'end' samples have been written to
			% the buffer previously, or if 'start' or more samples have already fallen out
			% of the ring buffer.
			if nargin>=1 && numel(sel)==2
				sel = sel-1;  % 0-based indices on MEX level
			else
				sel = [];
			end
			DD = buffer('GET_DAT', double(sel), obj.host, obj.port);
			D = DD.buf;
		end
		
		function E = read_events(obj, sel)
			% read_events  -- get events from the buffer
			%
			% Calling without input arguments retrieves all currently present events
			%   E = object.read_events()
			% Alternatively, you can ask for a specific interval (1-based indices)
			%   E = object.read_events([start end])
			% The second form will fail if less then 'end' events have been written to
			% the buffer previously, or if 'start' or more events have already fallen out
			% of the ring buffer.
			if nargin>=2 && numel(sel)==2
				sel = sel-1;  % 0-based indices on MEX level
			else
				sel = [];
			end
						
			% check for new events, note all events will be returned
			try
				E = buffer('GET_EVT', sel, obj.host, obj.port);
			catch err
				if strfind(err.message, 'the buffer returned an error')
					disp('Failure reading events, return empty result');
					E = [];
				else
					rethrow(err);
				end
			end
		end
		
		function R = poll(obj, thresholds, timeout)
			% poll  -- poll for updated sample and event counts
			%
			% Calling without arguments just returns the number of samples and events
			% in a two-element structure with fields 'nsamples' and 'nevents'.
			%   numNew = object.poll()
			%
			% You can also define a threshold on both samples and events, and give a
			% timeout in milliseconds that you're willing to wait until more samples
			% or events are present in the buffer than described by your threshold.
			% The return value is always the two-element structure with the *current*
			% quantities (might be lower or equal to threshold values in case of timeout).
			%
			% The following will wait up to 100ms, or until more than 20 samples are present:
			%   threshold = [];
			%   threshold.nsamples = 20;
			%   timeout = 100;
			%   numNew = object.poll(threshold, timeout);
			%
			% Exchaning 'nsamples' by 'nevents' waits for events instead.
			% Defining both fields, e.g.,
			%   threshold.nsamples = 20;
			%   threshold.nevents = 10;
			% will wait until one of the quantities is reached.
			threshtime = [-1 -1 0];
			if nargin>1
				if isfield(thresholds, 'nsamples')
					threshtime(1) = thresholds.nsamples;
				end
				if isfield(thresholds, 'nevents')
					threshtime(2) = thresholds.nevents;
				end
			end
			if nargin>2
				threshtime(3) = timeout;
			end
			
			if ~obj.bc
				R = buffer('WAIT_DAT', threshtime, obj.host, obj.port);
			else		
				% use backwards compatible solution
				R = obj.poll_bc(threshtime);
			end
		end
		
		% poll implementation for backwards compatibility with ft buffer
		% version 1 without extension
		function R = poll_bc(obj, th) % timeout (th(3)) in msec!
			% also implement waiting for nsamples/events/timeout
			if th(3) > 0
				t=clock; 
				tstart = [3600 60 1]*t(4:6)'; 
			else
				tstart = [];
			end
			
			% results are retrieved in the order written to the buffer
			orig = buffer('GET_HDR', [], obj.host, obj.port);
			
			% wait maximal th(3) ms until more than th(1) samples 
			% or th(2) events have been received
			if th(3) > 0 && (th(1) ~= -1 || th(2) ~= -1)
				while 1
					if th(1) ~= -1 && orig.nsamples > th(1),	break, end
					if th(2) ~= -1 && orig.nevents  > th(2),	break, end
					if timed_out(tstart,th(3)/1000),				break, end
					% update nsamples and nevents status
					orig = buffer('GET_HDR', [], obj.host, obj.port);
					pause(0.001);
				end
			end
			
			% return results
			R.nsamples	= orig.nsamples;
			R.nevents	= orig.nevents;
		end
	end
end

function ret = timed_out(tstart,to)
t = clock; 
if [3600 60 1]*t(4:6)' > tstart + to
	ret = true; % timed out
else
	ret = false;	
end
end

