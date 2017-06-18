function [data,header] = readFunctionalAnalyze(numFilesToRead)
%% Read NIFTI 3D (functional)
filePaths = uipickfiles('Type' , {'*.img', 'Analyze'}, 'Prompt', 'Please select Analyze format files with .img extension', 'NumFiles', numFilesToRead);
filePaths = filePaths';
% Process Data to .mat format
numFiles = size(filePaths,1);
% read the first scan to assses the size and the header
X       = load_untouch_nii(filePaths{1,1});
siz     = size(X.img);
type = class(X.img);
if strcmp(type,'uint16')
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
    fprintf('TR information Not found while reading the data')
%     return;
end

% check whether or not to squarify and if yes then calcuate the container
% for the data
if (header.xRes ~= header.yRes) | (floor(sqrt(header.xRes)) ~= sqrt(header.xRes)) | (floor(sqrt(header.yRes)) ~= sqrt(header.yRes))
    squarifySlice = 1;
    sizX = header.xRes;
    sizY = header.yRes;
    if sizX > sizY
        xySiz = ceil(sqrt(sizX))^2;
    elseif sizY > sizX
        xySiz = ceil(sqrt(sizY))^2;
    end
    if strcmp(class(X.img),'uint16')
        data    = uint16(zeros(prod([xySiz xySiz header.numSlices]),numFiles));
    else
        data    = single(zeros(prod([xySiz xySiz header.numSlices]),numFiles));
    end
else
    squarifySlice = 0;
    if strcmp(class(X.img),'uint16')
        data    = uint16(zeros(prod(siz),numFiles));
    else
        data    = single(zeros(prod(siz),numFiles));
    end
end

% Read all files
if ~isempty(numFiles) progressbar('Volumes'); end
for i = 1 : numFiles
    fprintf('Reading Nifti file %i of %i \n' , i, numFiles);
    X = load_untouch_nii(filePaths{i,1});
    %replaces NaNs by zeros otherwise display of appended zeros becomes
    %visible
    X.img(isnan(X.img)) = 0;    
    if squarifySlice
        [squarifiedVol verticalStripsAppended horizontalStripsAppended] = squarify(X.img,siz);
         data(:,i) = reshape(squarifiedVol,[],1);
    else
        data(:,i) = reshape(X.img,[],1);
    end
    progressbar(i/numFiles);
end
fprintf('Finished reading the data. \n');

if exist('verticalStripsAppended', 'var')
    header.verticalStripsAppended       = verticalStripsAppended;
    header.horizontalStripsAppended     = horizontalStripsAppended;
    header.xResOriginal                 = header.xRes;
    header.yResOriginal                 = header.yRes;
    header.xRes                         = siz(1) + sum(horizontalStripsAppended);
    header.yRes                         = siz(2) + sum(verticalStripsAppended);
    header.squarified                   = 1;
end