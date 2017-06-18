function [imgSag imgCor imgAxial] = roiMosaic2VoxelsXScansVector(m, ind)
%% Axial: Convert img coords to poistion in the data matrix
xyRes = m.xyRes;
mosaic = m.mosaic;
numVoxelsIncludingPadding = xyRes^2 * mosaic^2;

% ind             = uint32(1:numVoxelsIncludingPadding);
axialData       = reshape(ind', xyRes, xyRes, mosaic^2);

for i = 1:mosaic^2
    axialData(:,:,i) = rot90(squeeze(axialData(:,:,i)));
end
imgAxial = [];
for i = 1:mosaic
    if i==1
        increment = 0;
    end
    imgAxial_row = [];
    for j= 1+increment:mosaic+ increment
        imgAxial_row = [imgAxial_row axialData(:,:,j)];
    end
    imgAxial = [imgAxial; imgAxial_row];
    increment = increment + mosaic;
end
%     handle_image = imagesc(imgAxial);

%% Sagital: Convert img coords to poistion in the data matrix
% ind             = uint32(1:numVoxelsIncludingPadding);
sagDataOrig     = reshape(ind', xyRes, xyRes, mosaic^2);
sagData         = [];
for i = 1:xyRes
    sagData(:,:,i) = rot90(squeeze(sagDataOrig(i,:,:))); % rotate each slice
end
imgSag = [];
for i= 1:sqrt(xyRes) %make mosaic
    if i==1
        increment = 0;
    end
    imgSag_row = [];
    for j= 1+increment:sqrt(xyRes)+ increment
        imgSag_row = [imgSag_row sagData(:,:,j)];
    end
    imgSag = [imgSag; imgSag_row];
    increment = increment + sqrt(xyRes);
end
% handle_image = imagesc(imgSag);


%% Coronal: Convert img coords to poistion in the data matrix
% ind             = uint32(1:numVoxelsIncludingPadding);
corDataOrig     = reshape(ind', xyRes, xyRes, mosaic^2);
corData         = [];
for i = 1:xyRes
    corData(:,:,i) = rot90(squeeze(corDataOrig(:,i,:))); % rotate each slice
end
imgCor = [];
for i= 1:sqrt(xyRes) %make mosaic
    if i==1
        increment = 0;
    end
    imgCor_row = [];
    for j= 1+increment:sqrt(xyRes)+ increment
        imgCor_row = [imgCor_row corData(:,:,j)];
    end
    imgCor = [imgCor; imgCor_row];
    increment = increment + sqrt(xyRes);
end
% handle_image = imagesc(imgCor);