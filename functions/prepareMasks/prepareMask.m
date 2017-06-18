function [mask] = prepareMask(data, m)
% prepares mask in all three orientations
xyRes       = m.xyRes;
mosaic      = m.mosaic;

%sagital
scan  = reshape(data, xyRes, xyRes, mosaic^2);% extract scan (x,y,z)
scann = [];
for i = 1:xyRes
    scann(:,:,i) = rot90(squeeze(scan(i,:,:))); % rotate each slice
end
img = [];
for i= 1:sqrt(xyRes) %make mosaic
    if i==1
        increment = 0;
    end
    img_row = [];
    for j= 1+increment:sqrt(xyRes)+ increment
        img_row = [img_row scann(:,:,j)];
    end
    img = [img; img_row];
    increment = increment + sqrt(xyRes);
end
maskSagittal = img;


%corronal

scan = reshape(data, xyRes, xyRes, mosaic^2);% extract scan (x,y,z)
scann = [];

for i = 1:xyRes
    scann(:,:,i) = rot90(squeeze(scan(:,i,:)));
end
img = [];
for i= 1:sqrt(xyRes)
    if i==1
        increment = 0;
    end
    img_row = [];
    for j= 1+increment:sqrt(xyRes)+ increment
        img_row = [img_row scann(:,:,j)];
    end
    img = [img; img_row];
    increment = increment + sqrt(xyRes);
    
end
maskCoronal = img;

% axial
scan = reshape(data, xyRes, xyRes, mosaic^2);% extract scan (x,y,z)
scann = [];
for i = 1:mosaic^2
    scann(:,:,i) = rot90(squeeze(scan(:,:,i)));
end
img = [];
for i= 1:mosaic
    if i==1
        increment = 0;
    end
    img_row = [];
    for j= 1+increment:mosaic+ increment
        img_row = [img_row scann(:,:,j)];
    end
    img = [img; img_row];
    increment = increment + mosaic;
end
maskAxial = img;

mask. maskAxial = maskAxial;
mask. maskSagittal = maskSagittal;
mask. maskCoronal = maskCoronal;

