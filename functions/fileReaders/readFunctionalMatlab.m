function [data,header] = readFunctionalMatlab(numFilesToRead)
filePaths = uipickfiles('Type' , {'*.mat', 'Matlab .mat'}, 'Prompt', 'Please select Matlab .mat file with [Voxels x Scans] format', 'NumFiles', numFilesToRead);
filePaths = filePaths';
numFiles = size(filePaths,1);
c = load(filePaths{1,1});

if  ~isfield(c,'d')
    header = getHeader();
    header.MRAcquistionType = 3;
    f = fieldnames(c);
    f = f{1,1};
    header.numScans = numel(c.(f)(1,:));
    if numel(c.(f)(:,1)) ~= header.xRes * header.yRes * header.numSlices
        msgbox({'It seems like that the data parameters you specified dont match up with the data you are trying to load.';'The number of voxels in each scan should be equal to (Number of Slices X Frequency Resolution X Phase Resolution).'},...
            'Dimension mismatch.',...
            'error','modal');
        return;
    end
else
    header          = c.d.header;  
end


dlg = ProgressDialog( ...
    'StatusMessage', 'Reading the data....', ...
    'Indeterminate', true);

if isfield(header,'squarified')
    squarifySlice = 1;
else
    if (header.xRes ~= header.yRes) | (floor(sqrt(double(header.xRes))) ~= sqrt(double(header.xRes))) | (floor(sqrt(double(header.yRes))) ~= sqrt(double(header.yRes)))
        squarifySlice = 1;
    else
        squarifySlice = 0;
    end
end

try
    data            = c.d.data;
    header          = c.d.header;
    if squarifySlice
    vol = reshape(data,header.xResOriginal,header.yResOriginal,header.numSlices);
    siz = [header.xResOriginal header.yResOriginal header.numSlices];
    [data verticalStripsAppended horizontalStripsAppended] = squarify(vol,siz);
    end
%     data = reshape(data, [], 1);
catch
    header  = header;
    data    = c.(f); % put what ever user has specified
    if squarifySlice
    vol = reshape(data,header.xRes,header.yRes,header.numSlices);
    siz = [header.xRes header.yRes header.numSlices];
    [data verticalStripsAppended horizontalStripsAppended] = squarify(vol,siz);
    end  
%     data = reshape(data, [], 1);
end

if exist('verticalStripsAppended', 'var')
    header.verticalStripsAppended       = verticalStripsAppended;
    header.horizontalStripsAppended     = horizontalStripsAppended;
    header.xResOriginal                 = header.xRes;
    header.yResOriginal                 = header.yRes;
    header.xRes                         = siz(1) + sum(horizontalStripsAppended);
    header.yRes                         = siz(2) + sum(verticalStripsAppended);
    header.squarified                   = 1;
end
delete(dlg);
fprintf('Finished reading the data. \n');






