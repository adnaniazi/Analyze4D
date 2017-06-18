function [] = psom_demo_pipeline(path_demo,opt)
%
% _________________________________________________________________________
% SUMMARY OF PSOM_DEMO_PIPELINE
%
% This is a script to demonstrate how to use the pipeline system for Octave
% and Matlab (PSOM).
%
% SYNTAX:
% PSOM_DEMO_PIPELINE(PATH_DEMO,OPT)
%
% _________________________________________________________________________
% INPUTS:
%
% PATH_DEMO
%       (string, default local_path_demo defined in the file 
%       PSOM_GB_VARS) 
%       the full path to the PSOM demo folder. IMPORTANT WARNING : PSOM 
%       will empty totally this folder and then build example files and 
%       logs in it.
%
% OPT
%       (structure, optional) the option structure passed on to 
%       PSOM_RUN_PIPELINE. If not specified, the default values will be
%       used. Note that the default for the demo are different from
%       NIAK_RUN_PIPELINE. Specifically :
%
%       MODE
%           default 'batch'
%
%       MODE_PIPELINE_MANAGER
%           default 'session'
%
%       MAX_QUEUED
%           default 2
%
%       TIME_BETWEEN_CHECKS
%           default 0.5
%
%       This default configuration was selected for fast execution of the
%       demo. Note that these defaults cannot be changed through editing 
%       PSOM_GB_VARS.
%
% _________________________________________________________________________
% OUTPUTS:
% 
% _________________________________________________________________________
% COMMENTS:
%
% The blocks of code follow the tutorial that can be found at the following 
% address : 
% http://code.google.com/p/psom/w/edit/HowToUsePsom
%
% You can run a specific block of code by selecting it and press F9, or by
% putting the cursor anywhere in the block and press CTRL+ENTER.
%
% _________________________________________________________________________
% COMMENTS:
%
% This demo will create some files and one folder in PATH_DEMO
%
% Copyright (c) Pierre Bellec, Montreal Neurological Institute, 2008-2010.
% Maintainer : pbellec@bic.mni.mcgill.ca
% See licensing information in the code.
% Keywords : pipeline, PSOM, demo

% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included in
% all copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
% THE SOFTWARE.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Setting up the default execution mode %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

psom_gb_vars

if nargin<1||isempty(path_demo)
    local_path_demo = gb_psom_path_demo;    
else
    local_path_demo = path_demo;
end

% Set up the options to run the pipeline
opt.path_logs = [local_path_demo 'logs' filesep];  % where to store the log files

if ~isfield(opt,'mode')
    opt.mode = 'batch';
end

if ~isfield(opt,'mode_pipeline_manager')
    opt.mode_pipeline_manager = 'session';
end

if ~isfield(opt,'max_queued')
    opt.max_queued = 2;
end

if ~isfield(opt,'time_between_checks')
    opt.time_between_checks = 0.5;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Prepare the demo folder %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

msg = 'The demo is about to remove the content of the following folder and save the demo results there:';
msg2 = local_path_demo;
msg3 = 'Press CTRL-C to stop here or any key to continue.';
stars = repmat('*',[1 max([length(msg),length(msg2),length(msg3)])]);
fprintf('\n%s\n%s\n%s\n%s\n%s\n\n',stars,msg,msg2,msg3,stars);
pause

if exist(local_path_demo,'dir')
    rmdir(local_path_demo,'s');
end

file_weights = [local_path_demo filesep 'weights.mat'];
weights = rand([2 50]);
psom_mkdir(local_path_demo);
save(file_weights,'weights');

%%%%%%%%%%%%%%%%%%%%%%%%%%
%% What is a pipeline ? %%
%%%%%%%%%%%%%%%%%%%%%%%%%%    

msg = 'The demo is about to generate a toy pipeline and plot the dependency graph.';
msg2 = 'Press CTRL-C to stop here or any key to continue.';
stars = repmat('*',[1 max(length(msg),length(msg2))]);
fprintf('\n%s\n%s\n%s\n%s\n\n',stars,msg,msg2,stars);
pause

% Job "message"
pipeline.message.command = 'fprintf(''The number of samples was : %i. Well that info will be in the logs anyway but still...\n'',opt.nb_samples)';
pipeline.message.opt.nb_samples = 30;

% Job "tseries1"
pipeline.tseries1.command = 'tseries = randn([opt.nb_samples 1]); save(files_out,''tseries'')';
pipeline.tseries1.files_in = {};
pipeline.tseries1.files_out = [local_path_demo 'tseries1.mat'];
pipeline.tseries1.opt.nb_samples = pipeline.message.opt.nb_samples;

% Job "tseries2"
pipeline.tseries2.command = 'tseries = randn([opt.nb_samples 1]); save(files_out,''tseries'')';
pipeline.tseries2.files_in = {};
pipeline.tseries2.files_out = [local_path_demo 'tseries2.mat'];
pipeline.tseries2.opt.nb_samples = pipeline.message.opt.nb_samples;

% Job "fft"
pipeline.fft.command = 'load(files_in{1}); ftseries = zeros([size(tseries,1) 2]); ftseries(:,1) = fft(tseries); load(files_in{2}); ftseries(:,2) = fft(tseries); save(files_out,''ftseries'')';
pipeline.fft.files_in = {pipeline.tseries1.files_out,pipeline.tseries2.files_out};
pipeline.fft.files_out = [local_path_demo 'ftseries.mat'];
pipeline.fft.opt = struct();

% Job "weights"
pipeline.weights.command = 'load(files_in.fft); load(files_in.sessions.session1); res = ftseries * weights; save(files_out,''res'')';
pipeline.weights.files_in.fft = pipeline.fft.files_out;
pipeline.weights.files_in.sessions.session1 = [local_path_demo 'weights.mat'];
pipeline.weights.files_out = [local_path_demo 'results.mat'];
pipeline.weights.opt = struct();

psom_visu_dependencies(pipeline);

%%%%%%%%%%%%%%%%%%%%
%% Run a pipeline %%
%%%%%%%%%%%%%%%%%%%%

msg = 'The demo is about to execute the toy pipeline.';
msg2 = 'Press CTRL-C to stop here or any key to continue.';
stars = repmat('*',[1 max(length(msg),length(msg2))]);
fprintf('\n%s\n%s\n%s\n%s\n\n',stars,msg,msg2,stars);
pause

% The following line is running the pipeline manager on the toy pipeline
psom_run_pipeline(pipeline,opt);

%%%%%%%%%%%%%%%%%%%%%%%%
%% Restart a pipeline %%
%%%%%%%%%%%%%%%%%%%%%%%%

%% Test 1 : change the options
msg = 'The demo is about to change an option of the job ''fft'' and restart the pipeline.';
msg2 = 'Press CTRL-C to stop here or any key to continue.';
stars = repmat('*',[1 max(length(msg),length(msg2))]);
fprintf('\n%s\n%s\n%s\n%s\n\n',stars,msg,msg2,stars);
pause

pipeline.fft.opt = 'let''s change something...';
psom_run_pipeline(pipeline,opt);

%% Test 2 : failed jobs
msg = 'The demo is about to change the job ''fft'' to create a bug, and then restart the pipeline.';
msg2 = 'Press CTRL-C to stop here or any key to continue.';
stars = repmat('*',[1 max(length(msg),length(msg2))]);
fprintf('\n%s\n%s\n%s\n%s\n\n',stars,msg,msg2,stars);
pause

pipeline.fft.command = 'BUG';
psom_run_pipeline(pipeline,opt);

% Visualize the log file of the failed job
msg = 'The demo is about to display the log file of the failed job ''fft''.';
msg2 = 'Press CTRL-C to stop here or any key to continue.';
stars = repmat('*',[1 max(length(msg),length(msg2))]);
fprintf('\n%s\n%s\n%s\n%s\n\n',stars,msg,msg2,stars);
pause

psom_pipeline_visu(opt.path_logs,'log','fft');

% fix the bug, restart the pipeline
msg = 'The demo is about to fix the bug in the job ''fft'' and restart the pipeline.';
msg2 = 'Press CTRL-C to stop here or any key to continue.';
stars = repmat('*',[1 max(length(msg),length(msg2))]);
fprintf('\n%s\n%s\n%s\n%s\n\n',stars,msg,msg2,stars);
pause

pipeline.fft.command = 'load(files_in{1}); ftseries = zeros([size(tseries,1) 2]); ftseries(:,1) = fft(tseries); load(files_in{2}); ftseries(:,2) = fft(tseries); save(files_out,''ftseries'')';
psom_run_pipeline(pipeline,opt);

%% Test 3 : Add a new job
msg = 'The demo is about to add new job ''message2'', plot the updated dependency graph and restart the pipeline.';
msg2 = 'Press CTRL-C to stop here or any key to continue.';
stars = repmat('*',[1 max(length(msg),length(msg2))]);
fprintf('\n%s\n%s\n%s\n%s\n\n',stars,msg,msg2,stars);
pause

pipeline.message2.command = 'load(files_in), fprintf(''The size of the result is %i times %i'',size(res,1),size(res,2))';
pipeline.message2.files_in = pipeline.weights.files_out;
psom_visu_dependencies(pipeline);
psom_run_pipeline(pipeline,opt);


%% Test 4 : Change the options after deleting files
msg = 'The demo is about to change an option of the job ''fft'', delete its input file from ''tseries1'' and restart the pipeline.';
msg2 = 'Press CTRL-C to stop here or any key to continue.';
stars = repmat('*',[1 max(length(msg),length(msg2))]);
fprintf('\n%s\n%s\n%s\n%s\n\n',stars,msg,msg2,stars);
pause

pipeline.fft.opt = 'yet another dummy change';
delete(pipeline.tseries1.files_out);
psom_run_pipeline(pipeline,opt);

%% Test 5 : Restart jobs
msg = 'The demo is about to explicitely restart the ''*tseries*'' and ''*message*'' jobs and then restart the pipeline.';
msg2 = 'Press CTRL-C to stop here or any key to continue.';
stars = repmat('*',[1 max(length(msg),length(msg2))]);
fprintf('\n%s\n%s\n%s\n%s\n\n',stars,msg,msg2,stars);
pause

opt.restart = {'tseries','message'};
psom_run_pipeline(pipeline,opt);
opt = rmfield(opt,'restart');

%%%%%%%%%%%%%%%%%%%%%%%%
%% Monitor a pipeline %%
%%%%%%%%%%%%%%%%%%%%%%%%

%% Display flowchart
msg = 'The demo is about to display the flowchart of the pipeline';
msg2 = 'Press CTRL-C to stop here or any key to continue.';
stars = repmat('*',[1 max(length(msg),length(msg2))]);
fprintf('\n%s\n%s\n%s\n%s\n\n',stars,msg,msg2,stars);
pause

psom_pipeline_visu(opt.path_logs,'flowchart')

%% List the jobs
msg = 'The demo is about to display a list of the finished jobs';
msg2 = 'Press CTRL-C to stop here or any key to continue.';
stars = repmat('*',[1 max(length(msg),length(msg2))]);
fprintf('\n%s\n%s\n%s\n%s\n\n',stars,msg,msg2,stars);
pause

psom_pipeline_visu(opt.path_logs,'finished')

%% Display log
msg = 'The demo is about to display the log of the ''message'' job';
msg2 = 'Press CTRL-C to stop here or any key to continue.';
stars = repmat('*',[1 max(length(msg),length(msg2))]);
fprintf('\n%s\n%s\n%s\n%s\n\n',stars,msg,msg2,stars);
pause

psom_pipeline_visu(opt.path_logs,'log','message')

%% Display Computation time
msg = 'The demo is about to display the computation time for all jobs of the pipeline';
msg2 = 'Press CTRL-C to stop here or any key to continue.';
stars = repmat('*',[1 max(length(msg),length(msg2))]);
fprintf('\n%s\n%s\n%s\n%s\n\n',stars,msg,msg2,stars);
pause

psom_pipeline_visu(opt.path_logs,'time','')

%% Monitor history
msg = 'The demo is about to monitor the history of the pipeline';
msg2 = 'Press CTRL-C to stop here or any key to continue.';
stars = repmat('*',[1 max(length(msg),length(msg2))]);
fprintf('\n%s\n%s\n%s\n%s\n\n',stars,msg,msg2,stars);
pause

psom_pipeline_visu(opt.path_logs,'monitor')

