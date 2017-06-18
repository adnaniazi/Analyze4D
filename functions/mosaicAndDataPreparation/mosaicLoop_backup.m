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
%plays the mosiac in a loop
% 4D visualization loop
for tseries = startPoint:endPoint
    if view == 1 %sagital
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
        axes(axisHandle);
        mosaicHandle = imagesc(img,[contrast brightness]);
        %         if xLimits(1)~=0  && xLimits(2)~=0 % ifthe user has zoomed then retian the axis value
        %             if ~viewSwitching | brightnessContrastChanging % restore default axes if user switches views
        %             axis(reshape([xLimits yLimits], 1, []));
        %             else
        %                 viewSwitching = 0;
        %                 xLimits = xLim;
        %                 yLimits = yLim;
        %             end
        %         end
        
        if xLimits(1)~=0  && xLimits(2)~=0 % ifthe user has zoomed then retian the axis value
            if viewSwitching & ~brightnessContrastChanging % restore default axes if user switches views
                viewSwitching = 0;
                xLimits = xLim;
                yLimits = yLim;
            else
                axis(reshape([xLimits yLimits], 1, []));
            end
        end
        
        set(mosaicHandle, 'HitTest', 'off');
        colormap(mosaicColormap);
        freezeColors;
%                 axis square;
        axis off;

        if gridOn % plot moasic lines
            vlineMosaic(vLineLocationsSagital, [],[],[],[],gridColor, 0.5, (mosaic^2)*(sqrt(xyRes))+0.0);
            hlineMosaic(hLineLocationsSagital, [],[],[],[],gridColor, 0.5, xyRes*sqrt(xyRes)+0.0);
        end
        % plot the slice numbers
        if tileLabelOn
            for m = 1:xyRes
                textborder(positionMatrixXFullSagCor(m), positionMatrixYFullSagCor(m), num2str(m), tileLabelColor);
            end
        end
    end
    
    if view == 2 %coronal
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
        axes(axisHandle);
        mosaicHandle = imagesc(img ,[contrast brightness]);
        if xLimits(1)~=0  && xLimits(2)~=0 % ifthe user has zoomed then retian the axis value
            if viewSwitching & ~brightnessContrastChanging % restore default axes if user switches views
                viewSwitching = 0;
                xLimits = xLim;
                yLimits = yLim;
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
            vlineMosaic(vLineLocationsCoronal, [],[],[],[], gridColor, 0.5, (mosaic^2)*(sqrt(xyRes))+0.0);
            hlineMosaic(hLineLocationsCoronal, [],[],[],[], gridColor, 0.5, xyRes*sqrt(xyRes)+0.0);
        end
        
        % plot the slice numbers
        if tileLabelOn
            for m = 1:xyRes
                textborder(positionMatrixXFullSagCor(m), positionMatrixYFullSagCor(m), num2str(m), tileLabelColor);
            end
        end
    end
    
    if view == 3 % axial
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
        axes(axisHandle);
        mosaicHandle = imagesc(img,[contrast brightness]);
        if xLimits(1)~=0  && xLimits(2)~=0 % ifthe user has zoomed then retian the axis value
            if viewSwitching & ~brightnessContrastChanging % restore default axes if user switches views
                viewSwitching = 0;
                xLimits = xLim;
                yLimits = yLim;
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
            vlineMosaic(vLinehLineLocationsAxial, [],[],[],[], gridColor, 0.5, xyRes*mosaic+0.0);
            hlineMosaic(vLinehLineLocationsAxial, [],[],[],[], gridColor, 0.5, xyRes*mosaic+0.0);
        end
        % plot the slice numbers
        if tileLabelOn
            for m = 1:mosaic^2
                textborder(positionMatrixXFullAxial(m), positionMatrixYFullAxial(m), num2str(m), tileLabelColor);
                %               text(positionMatrixXFullAxial(m), positionMatrixYFullAxial(m), num2str(m), 'Color',tileLabelColor,'Clipping','on','FontSize',7);
            end
        end
    end
    
    if view == 4 % 4D-Visualization
        axes(axisHandle);
        mosaicHandle = imagesc(data(:,1:tseries),[contrast brightness]);
        if xLimits(1)~=0  && xLimits(2)~=0 % ifthe user has zoomed then retian the axis value
            if viewSwitching & ~brightnessContrastChanging % restore default axes if user switches views
                viewSwitching = 0;
                xLimits = xLim;
                yLimits = yLim;
            else
                axis(reshape([xLimits yLimits], 1, []));
            end
        end
        set(mosaicHandle, 'HitTest', 'off');
        colormap(mosaicColormap);
        freezeColors;
    end
    if firstScanLastScanOn == 1 && tseries == 2 %display title of the last scan
        title(strcat('Volume',{' '}, num2str(timePoints)));
    else
        title(strcat('Volume',{' '}, num2str(tseries)));
    end
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
end
% profile viewer