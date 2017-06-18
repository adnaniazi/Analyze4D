function [squarifiedVol verticalStripsAppended horizontalStripsAppended] = squarify(vol,siz)
% gets a volume and makes it a square in X and Y directions.
% Z- direction is handled in the 'mosaic' logic elsewhere

% the function retuns the squarified volume, the extra strips appended in
% the X[top bottom] and Y[left right] direction

% (Axial View) Vertical Strips of zeros are added equally to the begining and end
% to make mosaic squre in Y direction(see picture in help resousreces folder). If 
% If there is one more Zero strip (let say 5), in that case, 3 strips are
% added to the begining(left) and 2 strips are added to the end(right).

% (Axial View) Horizontal Strips of zeros are added equally to the top and
% bottom to make mosaic squre in X direction(see picture in help resousreces folder). If 
% If there is one more Zero strip (let say 5), in that case, 3 strips are
% added to the top and 2 strips are added to the end.
% vol = X.img;
% sizX = 79;
% sizY = 95;
% sizZ = 68;

sizX = siz(1);
sizY = siz(2);
sizZ = siz(3);
% check which dimension is the biggest and then take the biggest one

if sizX > sizY
    xySiz = ceil(sqrt(sizX))^2;
elseif sizY > sizX
    xySiz = ceil(sqrt(sizY))^2;
end

verticalStripsToAppend      = xySiz - sizY;
horizontalStripsToAppend    = xySiz - sizX;

verticalStripsToAppend = [ceil(verticalStripsToAppend/2) floor(verticalStripsToAppend/2)];
horizontalStripsToAppend = [ceil(horizontalStripsToAppend/2) floor(horizontalStripsToAppend/2)];

% First add vertical strips and then add horizontal strips to the new
% formed slice
for i = 1:sizZ
    slice = vol(:,:,i);
    % Add vertical strips
    slice = [zeros(sizX, verticalStripsToAppend(1)) slice zeros(sizX, verticalStripsToAppend(2))];
    % Add horizontal strips
    slice = [zeros(horizontalStripsToAppend(1), sizY+sum(verticalStripsToAppend)); slice; zeros(horizontalStripsToAppend(2), sizY+sum(verticalStripsToAppend))];
    squarifiedVol(:,:,i) = slice;
end
verticalStripsAppended = verticalStripsToAppend;
horizontalStripsAppended = horizontalStripsToAppend;


% in the second pass add horizontal strips

