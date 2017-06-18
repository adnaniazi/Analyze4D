function [data,header] = readFunctionalRealTimePace(numFilesToRead)
% Reads the first series from the buffer for a realTime PACE sequence
filePaths   = uipickfiles('num',numFilesToRead,'Type' , ...
    {'', 'Raw Data buffer samples file'},'REFilter', 'samples' , ...
    'output', 'char',...
    'Prompt', 'Please select Samples file generated by the FieldTrip buffer');
filePaths   = filePaths(1:end-7); % gets the path of the samples folder
hdr = ft_read_header(filePaths);
header.numSlices                    = double(hdr.nifti_1.dim(3));
header.xRes                         = double(hdr.nifti_1.dim(1));
header.yRes                         = double(hdr.nifti_1.dim(2));
header.MRAcquistionType             = 3;
header.TR                           = 1/hdr.Fs;
scans                               = hdr.nSamples;
samplesToRead                       = Pace(scans);
if isempty(samplesToRead)
    samplesToRead                   = 2:2:scans; % Read all the samples
else
    samplesToRead                   = samplesToRead*2; % Moco series- pick odd samples
end

data                                = single(zeros(hdr.nChans,numel(samplesToRead)));

if ~isempty(filePaths) progressbar('Reading PACE Volumes'); end
j = 1;
for i = samplesToRead
    data(:,j) = ft_read_data(filePaths, 'begsample' ,i, 'endsample', i);
    progressbar(j/numel(samplesToRead));
    fprintf('Reading Sample %i of %i \n', j, numel(samplesToRead));
    fprintf('..... Actually I am reading Sample %i of %i from the buffer \n', i, scans);
    j = j + 1;
end
header.numScans = numel(samplesToRead);