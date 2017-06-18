function p = colorpixel(xpos,ypos,coloropt)
% Creates patch(es) of a specified color at user-specified x- y- positions.
%
% SYNTAX:
% P = COLORPIXEL(XPOS,YPOS,COLOROPT)
% 
%     Creates patches on the current axes corresponding to the x-,y-
%     positions specified by vectors XPOS and YPOS, of a color specified by
%     COLOROPT (Default: 'r'). Uses the PATCH command, so is constrained by
%     anything that constrains patches.
%
% INPUTS:
%     XPOS is a vector of x (column) positions.
%     YPOS is a vector (the same length as XPOS) of y (row) positions.
%     COLOROPT is an RGB color or standard string recognized as a color by
%           MATLAB. (Default = 'r')
% 
% OUTPUTS:
%     P is a vector of handles to patch objects. (Note that all patches are
%     created, for convenience, with a tag of 'colorpixel'.) All patches
%     are modifiable using the handles to the patch objects.
%
% NOTE: As the name suggests, I wrote this initially to modify pixels in an
% image. However, it works wherever PATCH works.
%
% EXAMPLES:
% % Example. 1: 
% mat = rand(100);
% imagesc(mat);colormap(gray)
% [xrange, yrange]  = meshgrid(1:100,1:100);
% [rows,cols] = find(xrange > 20 & xrange < 30  & yrange > 50  & yrange < 70);
% p = colorpixel(cols,rows,'g')
% pause(1)
% set(p,'facecolor',[1 0.4 0],'facealpha',0.5)
%
% % Ex. 2 (Requires the Image Processing Toolbox):
% img = imread('cameraman.tif');
% imshow(img);
% theta = 0:360;
% xs = 225 + 15*cos(theta);
% ys = 30 + 15*sin(theta);
% [xrange, yrange]  = meshgrid(1:size(img,2),1:size(img,1));
% invals = inpolygon(xrange,yrange,xs,ys);
% [ys,xs] = find(invals);
% colorpixel(xs,ys,'y');
%
% Written by Brett Shoelson, Ph.D.
% 4/18/2011
% Copyright 2011 The MathWorks.

if nargin < 2
    error('COLORPIXEL: Requires at least two input arguments, specifying XPositions and YPositions.');
end
if nargin < 3
    coloropt = 'r';
end

p=zeros(numel(xpos),1);
for ii=1:length(xpos)
      p(ii) = patch([xpos(ii)-0.5 xpos(ii)+0.5 xpos(ii)+0.5 xpos(ii)-0.5],...
         [ypos(ii)-0.5 ypos(ii)-0.5 ypos(ii)+0.5 ypos(ii)+0.5],coloropt,'edgecolor','none','tag','colorpixel');
end

if nargout < 1
    clear('p')
end