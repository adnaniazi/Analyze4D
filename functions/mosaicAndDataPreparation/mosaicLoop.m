function [mosaicHandle] = mosaicLoop(data, m, displayProperties, axisHandle)
% profile on
%expand structures
positionMatrixXFullAxial      = m.positionMatrixXFullAxial;
positionMatrixYFullAxial      = m.positionMatrixYFullAxial;
positionMatrixXFullSagCor     = m.positionMatrixXFullSagCor;
positionMatrixYFullSagCor     = m.positionMatrixYFullSagCor;
vLinehLineLocationsAxial      = m.vLinehLineLocationsAxial;
vLineLocationsSagital         = m.vLineLocationsSagital;
hLineLocationsSagital         = m.hLineLocationsSagital;
vLineLocationsCoronal         = m.vLineLocationsCoronal;
hLineLocationsCoronal         = m.hLineLocationsCoronal;
numSlices                     = m.numSlices;
xyRes                         = m.xyRes ; % Readout and Phase Resolution
mosaic                        = m.mosaic;
timePoints                    = m.timePoints; % numScans
view                          = displayProperties.view;
startPoint                    = displayProperties.startPoint;
endPoint                      = displayProperties.endPoint;
% brightness                    = displayProperties.brightness;
% contrast                      = displayProperties.contrast;
% mosaicColormap                = displayProperties.mosaicColormap;
gridColor                     = displayProperties.gridColor;
tileLabelColor                = displayProperties.tileLabelColor;
% gridOn                        = displayProperties.gridOn;
% tileLabelOn                   = displayProperties.tileLabelOn;
% interScanPause                = displayProperties.interScanPause;
% define globals pertaining to mosaic moview panel
global currentScan pauseData playData interScanPause firstScanLastScanOn viewSwitching;
% define globals pertaining to mosaic display properties panel
global tileLabelOn gridOn mosaicColormap brightness contrast ;

global xLimits yLimits brightnessContrastChanging showSubtractionPlots;

global mask overlayMask maskThreshold maskColor showMaskedVoxelsOnly mskIdx mskView;

global specialData;

global sliceLabelColor mosaicGridColor;


% maskThreshold = 0.5
%plays the mosiac in a loop
% 4D visualization loop
previousScan = [];
orig_previousScan =[];
for tseries = startPoint:endPoint
    if tseries ~= 1
        previousScan = orig_previousScan;
    end
%     set(axisHandle, 'Ydir', 'reverse')
    %% Sagittal View
    if view == 1
        scan  = reshape(data(:,tseries), xyRes, xyRes, mosaic^2);% extract scan (x,y,z)
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
        % handles subtraction plots for motion anaylsis
        if showSubtractionPlots
            orig_previousScan = img;
            if isempty(previousScan)
                previousScan = img; %zeros(size(img));
            end
            img = imabsdiff(previousScan, img)*2;
        end
        
        if showSubtractionPlots & (firstScanLastScanOn | brightnessContrastChanging) & (tseries == 1 | tseries ~= endPoint)
            continue;
        end
        
        axes(axisHandle);
%         hold on;
        if overlayMask
            if ~showMaskedVoxelsOnly
                out = imoverlay(mat2gray(img),mask.maskSagittal/max(max(mask.maskSagittal)) > maskThreshold, maskColor);
                mosaicHandle = imagesc(out,[contrast brightness]);
                
            else
                mskIdx = find(mask.maskSagittal/max(max(mask.maskSagittal)) > maskThreshold);
                if strcmp(class(img), 'uint16')
                    imgMaskedVoxelsOnly = uint16(zeros(size(img)));
                else
                    imgMaskedVoxelsOnly = single(zeros(size(img)));
                end
                imgMaskedVoxelsOnly(mskIdx) = img(mskIdx);
                mosaicHandle = imagesc(imgMaskedVoxelsOnly,[contrast brightness]);
                mskView = 1;
                mask.imgMaskedVoxelsOnlySagittal = imgMaskedVoxelsOnly;
            end
        else
            mosaicHandle = imagesc(img,[contrast brightness]);
            if specialData & ~brightnessContrastChanging % activate the auto limiting mode
                ax = gca;
                set(ax, 'CLim', [min(min(img)), max(max(img))]);
            end
        end
        
        if xLimits(1)~=0  && xLimits(2)~=0 % ifthe user has zoomed then retian the axis value
            if viewSwitching & ~brightnessContrastChanging % restore default axes if user switches views
                viewSwitching = 0;
                xLimits = xlim;
                yLimits = ylim;
            else
                axis(reshape([xLimits yLimits], 1, []));
            end
        end
        set(mosaicHandle, 'HitTest', 'off');
        colormap(mosaicColormap);
        freezeColors;
%                         axis square;
        axis off;
        
        if gridOn % plot moasic lines
            vHandle = vlineMosaic(vLineLocationsSagital, [],[],[],[],mosaicGridColor, 0.5, (mosaic^2)*(sqrt(xyRes))+0.0);
            hHandle = hlineMosaic(hLineLocationsSagital, [],[],[],[],mosaicGridColor, 0.5, xyRes*sqrt(xyRes)+0.0);
%                     set(vHandle, 'HitTest', 'off');
%         set(hHandle, 'HitTest', 'off');

        end
        % plot the slice numbers
        if tileLabelOn
            for m = 1:xyRes
                labelHandle = textborder(positionMatrixXFullSagCor(m), positionMatrixYFullSagCor(m), num2str(m), sliceLabelColor);
%                         set(labelHandle, 'HitTest', 'off');

            end
        end
    end
    
    %% Coronal View
    if view == 2
        scan = reshape(data(:,tseries), xyRes, xyRes, mosaic^2);% extract scan (x,y,z)
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
        
        % handles subtraction plots for motion anaylsis
        if showSubtractionPlots
            orig_previousScan = img;
            if isempty(previousScan)
                previousScan = zeros(size(img));
            end
            img = imabsdiff(previousScan, img)*2;
        end
        
        if showSubtractionPlots & (firstScanLastScanOn | brightnessContrastChanging) & (tseries == 1 | tseries ~= endPoint)
            continue;
        end
        axes(axisHandle);
        if overlayMask
            if ~showMaskedVoxelsOnly
                out = imoverlay(mat2gray(img),mask.maskCoronal/max(max(mask.maskCoronal)) > maskThreshold, maskColor);
                mosaicHandle = imagesc(out,[contrast brightness]);
            else
                mskIdx = find(mask.maskCoronal/max(max(mask.maskCoronal)) > maskThreshold);
                if strcmp(class(img), 'uint16')
                    imgMaskedVoxelsOnly = uint16(zeros(size(img)));
                else
                    imgMaskedVoxelsOnly = single(zeros(size(img)));
                end
                imgMaskedVoxelsOnly(mskIdx) = img(mskIdx);
                mosaicHandle = imagesc(imgMaskedVoxelsOnly,[contrast brightness]);
                mskView = 2;
                mask.imgMaskedVoxelsOnlyCoronal = imgMaskedVoxelsOnly;
            end
        else
            mosaicHandle = imagesc(img,[contrast brightness]);
            if specialData & ~brightnessContrastChanging % activate the auto limiting mode
                ax = gca;
                set(ax, 'CLim', [min(min(img)), max(max(img))]);
            end
        end
        if xLimits(1)~=0  && xLimits(2)~=0 % ifthe user has zoomed then retian the axis value
            if viewSwitching & ~brightnessContrastChanging % restore default axes if user switches views
                viewSwitching = 0;
                xLimits = xlim;
                yLimits = ylim;
            else
                axis(reshape([xLimits yLimits], 1, []));
            end
        end
        set(mosaicHandle, 'HitTest', 'off');
        colormap(mosaicColormap);
        freezeColors;
        %         axis square;
        axis off;
        %         colormap(colorMap);
        if gridOn % plot moasic lines
            vlineMosaic(vLineLocationsCoronal, [],[],[],[], mosaicGridColor, 0.5, (mosaic^2)*(sqrt(xyRes))+0.0);
            hlineMosaic(hLineLocationsCoronal, [],[],[],[], mosaicGridColor, 0.5, xyRes*sqrt(xyRes)+0.0);
        end
        
        % plot the slice numbers
        if tileLabelOn
            for m = 1:xyRes
                textborder(positionMatrixXFullSagCor(m), positionMatrixYFullSagCor(m), num2str(m), sliceLabelColor);
            end
        end
    end
    
    %% Axial View
    if view == 3
        scan = reshape(data(:,tseries), xyRes, xyRes, mosaic^2);% extract scan (x,y,z)
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
        % handles subtraction plots for motion anaylsis
        if showSubtractionPlots
            orig_previousScan = img;
            if isempty(previousScan)
                previousScan = zeros(size(img));
            end
            img = imabsdiff(previousScan, img)*2;
        end
        
        if showSubtractionPlots & (firstScanLastScanOn | brightnessContrastChanging) & (tseries == 1 | tseries ~= endPoint)
            continue;
        end
        axes(axisHandle);
        if overlayMask
            if ~showMaskedVoxelsOnly
                out = imoverlay(mat2gray(img),mask.maskAxial/max(max(mask.maskAxial)) > maskThreshold, maskColor);
                mosaicHandle = imagesc(out,[contrast brightness]);
            else
                mskIdx = find(mask.maskAxial/max(max(mask.maskAxial)) > maskThreshold);
                if strcmp(class(img), 'uint16')
                    imgMaskedVoxelsOnly = uint16(zeros(size(img)));                    
                else
                    imgMaskedVoxelsOnly = single(zeros(size(img)));                    
                end
                imgMaskedVoxelsOnly(mskIdx) = img(mskIdx);
                mosaicHandle = imagesc(imgMaskedVoxelsOnly,[contrast brightness]);
                mskView = 3;
                mask.imgMaskedVoxelsOnlyAxial = imgMaskedVoxelsOnly;
            end
        else
            mosaicHandle = imagesc(img,[contrast brightness]);
            if specialData & ~brightnessContrastChanging % activate the auto limiting mode
                ax = gca;
                set(ax, 'CLim', [min(min(img)), max(max(img))]);
            end
        end
        if xLimits(1)~=0  && xLimits(2)~=0 % ifthe user has zoomed then retian the axis value
            if viewSwitching & ~brightnessContrastChanging % restore default axes if user switches views
                viewSwitching = 0;
                xLimits = xlim;
                yLimits = ylim;
            else
                axis(reshape([xLimits yLimits], 1, []));
            end
        end
        set(mosaicHandle, 'HitTest', 'off');
        colormap(mosaicColormap);
        freezeColors;
        axis square;
        axis off;
        if gridOn % plot moasic lines
            vlineMosaic(vLinehLineLocationsAxial, [],[],[],[], mosaicGridColor, 0.5, xyRes*mosaic+0.0);
            hlineMosaic(vLinehLineLocationsAxial, [],[],[],[], mosaicGridColor, 0.5, xyRes*mosaic+0.0);
        end
        % plot the slice numbers
        if tileLabelOn
            for m = 1:mosaic^2
                textborder(positionMatrixXFullAxial(m), positionMatrixYFullAxial(m), num2str(m), sliceLabelColor);
                %               text(positionMatrixXFullAxial(m), positionMatrixYFullAxial(m), num2str(m), 'Color',tileLabelColor,'Clipping','on','FontSize',7);
            end
        end
    end
    
    %% 4D View Imagesc
    if view == 4
        axes(axisHandle);
        mosaicHandle = imagesc(data(:,1:tseries),[contrast brightness]);
        if xLimits(1)~=0  && xLimits(2)~=0 % ifthe user has zoomed then retian the axis value
            if viewSwitching & ~brightnessContrastChanging % restore default axes if user switches views
                viewSwitching = 0;
                xLimits = xlim;
                yLimits = ylim;
            else
                axis(reshape([xLimits yLimits], 1, []));
            end
        end
        set(mosaicHandle, 'HitTest', 'off');
        colormap(mosaicColormap);
        freezeColors;
    end
    
    
    if showSubtractionPlots
        if firstScanLastScanOn
            title(strcat('| Volume', {' '}, num2str(tseries -1), {' - '}, 'Volume', {' '}, num2str(timePoints), {' |'}));
        else
            if tseries == 1
                title(strcat('|Volume 1', {' '}, {' - '}, 'Nothing|'));
            else
                title(strcat('| Volume', {' '}, num2str(tseries -1), {' - '}, 'Volume', {' '}, num2str(tseries), {' |'}));
            end
        end
    else
        if firstScanLastScanOn == 1 && tseries == 2 %display title of the last scan
            title(strcat('Volume',{' '}, num2str(timePoints)));
        else
            title(strcat('Volume',{' '}, num2str(tseries)));
        end
    end
%         h = get(axisHandle,'Children');
%             set(h, 'HitTest', 'off');
%             hold off;

    pause(interScanPause);
    %if pause is pressed quit the loop
    %break the loop here
    if pauseData == 1 || playData == 0 %(|| if reset is pressed quit playing as well)
        pauseData = 0; %but before doing that reset the pause vairable
        break;
    end
    
    if currentScan == timePoints %quit the loop without incrementing the currentScan counter
        break;
    end
    currentScan = currentScan + 1; % update the count of how many scan have been played
    
    if brightnessContrastChanging & showSubtractionPlots
        break;
    end

end

% profile viewer