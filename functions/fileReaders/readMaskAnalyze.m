function [data,header] = readMaskAnalyze(numFilesToRead)
%% Read NIFTI 3D (functional)
filePaths = uipickfiles('Type' , {'*.img', 'Analyze'}, 'Prompt', 'Please select Analyze files with .img extension', 'NumFiles', numFilesToRead);
filePaths = filePaths';
% Process Data to .mat format
numFiles = size(filePaths,1);
% read the first scan to assses the size and the header
X       = load_untouch_nii(filePaths{1,1});
siz     = size(X.img);
if strcmp(class(X.img), 'uint16')
    data    = uint16(zeros(prod(siz),numFiles));
else
    data    = single(zeros(prod(siz),numFiles));    
end
% Read header
header.numSlices                    = siz(3);
header.xRes                         = siz(1);
header.yRes                         = siz(2);
header.MRAcquistionType             = X.hdr.dime.dim(1);
header.numScans                     = numFiles;
try
    header.TR                           = str2num(X.hdr.hist.descrip(16:19))/1000;
catch
%     fprintf('TR information Not found while reading the data');
%     return;
end
siz                                 = prod(siz);
% Read all files
if ~isempty(numFiles) progressbar('Volumes'); end
for i = 1 : numFiles
    fprintf('Reading Nifti file %i of %i \n' , i, numFiles);
    X = load_untouch_nii(filePaths{i,1});
    data(:,i) = reshape(X.img,siz,1);
            progressbar(i/numFiles);
end
fprintf('Finished reading the mask. \n');
