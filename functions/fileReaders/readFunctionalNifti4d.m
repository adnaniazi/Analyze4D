function [data,header] = readFunctionalNifti4d(numFilesToRead)

%% Read NIFTI 4D
filePaths = uipickfiles('Type' , {'*.nii', 'NIFTI'}, 'Prompt', 'Please select NIFTI 4D files(FSL Style)', 'NumFiles', numFilesToRead);

filePaths   = filePaths';

numFiles    = size(filePaths,1);
% read the first scan to assses the size and the header
allData     = [];
if ~isempty(numFiles) progressbar('4D Volumes','3D Vols in 4D Vol '); end
count = 0;
for i = 1: numFiles
    X           = load_untouch_header_only(filePaths{i,1});
    % Read header
    header.numSlices                    = X.dime.dim(4);
    header.xRes                         = X.dime.dim(2);
    header.yRes                         = X.dime.dim(3);
    header.MRAcquistionType             = X.dime.dim(1);
    header.TR                           = 'NA';
    scans                               = X.dime.dim(5);
    siz                                 = prod(X.dime.dim(2:4));
    % Read all files
    fprintf('Reading 4D Nifti file %i of %i \n' , i, numFiles);
    X = load_untouch_nii(filePaths{i,1});
    if strcmp(class(X.img), 'uint16')
        data                                = uint16(zeros(siz, scans));
    else
        data                                = single(zeros(siz, scans));
    end
    progressbar([],0);
    for j = 1 : scans
        data(:,j) = reshape(X.img(:,:,:,j),siz,1);
        fprintf('....Reading 3D Nifti file %i of %i \n' , j, scans);
        progressbar([],j/scans);
        count = count +1;
    end
    allData = [allData data];
    progressbar(i/numFiles);

end
data = allData;
clear allData;
fprintf('Finished reading the data. \n');
header.numScans                         = count;
