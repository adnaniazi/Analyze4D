function [data,header] = readFunctionalIma(numFilesToRead)
%% 2- IMA format( functional)
% Select Data
filePaths = uipickfiles('Type' , {'*.IMA', 'Siemens DICOM(ACR-NEMA)'}, 'Prompt', 'Please select DICOM files with .ima extension', 'NumFiles', numFilesToRead);
filePaths = filePaths';
% 2- Process Data to .mat format
numFiles = size(filePaths,1);
% read the first scan to assses the size and the header
X = dicomread(filePaths{1,1});
siz = prod(size(X));
if strcmp(class(X),'uint16')
    data = uint16(zeros(siz,numFiles));
else
    data = single(zeros(siz,numFiles));
end
% Read header
hdr = dicominfo(filePaths{1,1});
if hdr.MRAcquisitionType == '3D'
    header.numSlicesOriginal = 1;
else
    header.numSlicesOriginal = double(hdr. Private_0019_100a);
end
header.xRes = sqrt(eval(hdr.Private_0051_100b));
header.yRes = sqrt(eval(hdr.Private_0051_100b));
header.TR   = hdr.RepetitionTime/1000;
header.ScanningSequence = hdr.ScanningSequence;
header.numScans = numFiles;
dim  = size(X);
mosaic = ceil(sqrt(header.numSlicesOriginal));
xRes = dim(1)/mosaic;
% Read all files
if ~isempty(numFiles) progressbar('Volumes'); end
for i = 1 : numFiles
    fprintf('Reading DICOM file %i of %i \n' , i, numFiles);
    X = dicomread(filePaths{i,1});
    b_cat = [];
    for j = 0 : mosaic -1
        b = X((j*xRes)+1: xRes*(j+1),:); % extracts a row of the mosaic
        c = [];
        for k = 0 : mosaic -1
            c =  [c flipud(b(:,(k*xRes)+1: xRes*(k+1)))']; %rotate each slice so that its the same orientation as nifiti
        end    
        b_cat = [b_cat c];
    end
    data(:,i) = reshape(b_cat,[],1);
    progressbar(i/numFiles);
end
fprintf('Finished reading the data. \n');

header.numSlices = mosaic^2;