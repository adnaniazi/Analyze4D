function [data,m] = prepareMosaicData(data, header)

% Prepare the data by appending extra padding to the data to make it in a
% square. Also calulate the position of the slice labels and poistion of
% the mosaic tile spearation lines.

% data            = scanData.data;
numSlices       = double(header.numSlices);
siz             = size(data);
timePoints      = siz(2); % time series points
numVoxels       = siz(1); % number of voxels
xyRes           = sqrt(double(numVoxels/numSlices)); % Readout and Phase Resolution

%% Determine the size of the mosaic
% if ~rem(sqrt(numSlices),1) == 0
mosaic              = ceil(sqrt(numSlices)); % Square Mosaic dimension
numTiles            = (mosaic)^2;
extraTilesToAppend  = numTiles - numSlices; % Extra tiles to be appended to
% make the square mosaic. Calculate zeros matrix to append to the original data
if strcmp(class(data), 'uint16')
    matrixAppend        = uint16(zeros((xyRes^2)*extraTilesToAppend,timePoints));
else
    matrixAppend        = single(zeros((xyRes^2)*extraTilesToAppend,timePoints));
end
data                = [data; matrixAppend];
% end
%% Calculate slice numbering poistions for axial sagital and coronal views
positionMatrixXFullAxial = [];
positionMatrixYFullAxial = [];
startX = 3;
startY = 7;
xPositionVector = repmat(startX, 1, mosaic);
yPositionVector = repmat(startY, mosaic, 1);
for t = 0:mosaic-1
    positionMatrixXFullAxial = [positionMatrixXFullAxial; repmat(xyRes*t, 1, mosaic) + xPositionVector];
    positionMatrixYFullAxial = [positionMatrixYFullAxial  repmat(xyRes*t, mosaic, 1) + yPositionVector];
end

% Calculate slice numbering poistions for sagital and coronal views
startXSagCor = 2;
startYSagCor = 5;
positionMatrixXFullSagCor = [];
positionMatrixYFullSagCor = [];
xPositionVectorSagCor = repmat(startXSagCor, 1, sqrt(xyRes));
yPositionVectorSagCor = repmat(startYSagCor, sqrt(xyRes), 1);
for t = 0:sqrt(xyRes)-1
    positionMatrixXFullSagCor = [positionMatrixXFullSagCor; repmat(xyRes*t, 1, sqrt(xyRes)) + xPositionVectorSagCor];
    positionMatrixYFullSagCor = [positionMatrixYFullSagCor  repmat((mosaic^2)*t, sqrt(xyRes), 1)+ yPositionVectorSagCor];
end

%% Calculate the location of the horizontal and vertical separators between
% the slices
vLinehLineLocationsAxial    = 0.5:xyRes:(mosaic)*xyRes+0.5;
vLineLocationsSagital       = 0.5:xyRes:sqrt(xyRes)*xyRes+0.5 ;
hLineLocationsSagital       = 0.5:mosaic^2:(mosaic^2)*sqrt(xyRes)+0.5 ; % Horzontal line = mosaic
vLineLocationsCoronal       = 0.5:xyRes:sqrt(xyRes)*xyRes+0.5;
hLineLocationsCoronal       = 0.5:mosaic^2:(mosaic^2)*sqrt(xyRes)+0.5;

% solve the missing begin and end line issues
% vLinehLineLocationsAxial(1) = vLinehLineLocationsAxial(1) +0.5;
% vLineLocationsSagital(1)    = vLineLocationsSagital(1) + 1.0;
% hLineLocationsSagital(1)    = hLineLocationsSagital(1) + 0.5;
% vLineLocationsCoronal(1)    = vLineLocationsCoronal(1) + 1.0;
% hLineLocationsCoronal(1)    = hLineLocationsCoronal(1) + 0.5;

vLinehLineLocationsAxial(1) = [];
vLinehLineLocationsAxial(end) = [];
vLineLocationsSagital(end)    = [];
hLineLocationsSagital(end)    = [];
vLineLocationsCoronal(end)    = [];
hLineLocationsCoronal(end)    = [];
%% make a structure for return
m.positionMatrixXFullAxial      = positionMatrixXFullAxial;
m.positionMatrixYFullAxial      = positionMatrixYFullAxial;
m.positionMatrixXFullSagCor     = positionMatrixXFullSagCor;
m.positionMatrixYFullSagCor     = positionMatrixYFullSagCor;
m.vLinehLineLocationsAxial      = vLinehLineLocationsAxial;
m.vLineLocationsSagital         = vLineLocationsSagital;
m.hLineLocationsSagital         = hLineLocationsSagital;
m.vLineLocationsCoronal         = vLineLocationsCoronal;
m.hLineLocationsCoronal         = hLineLocationsCoronal;
m.numSlices                     = numSlices;
m.xyRes                         = xyRes ; % Readout and Phase Resolution
m.mosaic                        = mosaic;
m.timePoints                    = timePoints;