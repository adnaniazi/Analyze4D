function [deSquarifiedData] = desquarify(header, data)

    verticalStripsAppended          = header.verticalStripsAppended;
    horizontalStripsAppended        = header.horizontalStripsAppended;  
    xResOriginal                    = header.xResOriginal;       
    yResOriginal                    = header.yResOriginal;               
    xRes                            = header.xRes;                       
    yRes                            = header.yRes; 
    numSlices                       = header.numSlices;
    squarified                      = header.squarified;                  

    if strcmp(class(data),'uint16')
        deSquarifiedData = uint16(zeros(prod([xResOriginal yResOriginal numSlices]), size(data,2)));
    else
        deSquarifiedData = single(zeros(prod([xResOriginal yResOriginal numSlices]), size(data,2)));
    end
    
    for j = 1:size(data,2)
        vol = reshape(data(:,j), xRes,yRes,numSlices);
        deSquarifiedVol = uint16(zeros(xResOriginal,yResOriginal,numSlices));
        for i = 1:numSlices
            slice = vol(:,:,i);
            % first remove the horizontal strips
            slice(1:horizontalStripsAppended(1),:) = [];
            slice(end-horizontalStripsAppended(2)+1:end,:) = [];
            % now remove the vertical strips
            slice(:,1:verticalStripsAppended(1)) = [];
            slice(:,end-verticalStripsAppended(2)+1:end) = [];
            deSquarifiedVol(:,:,i) = slice;
        end
        deSquarifiedData(:,j) = reshape(deSquarifiedVol, [], 1);
    end