function makeDesignMatrixBars(numScans, onsets, durations, offset, okAddACondition, deleteLastCondition, deleteAllConditions, minY, maxY, cm, axesHandle, plotData)
% numScans    = 100;
% offset      = 4;
offset      = offset;
numScans    = numScans;
startX      = 0+0.5;
endX        = numScans-0.5;
startY      = minY; %min(signla)max();
endY        = maxY; %max(signal to be plotted)
global lineWidth lineColor;

designMatrix.units = 'scans';
designMatrix.inc   = 1; %increment- if scans then inc=1 elseif time then inc= TR
if okAddACondition || (okAddACondition == 0 && deleteLastCondition == 0 && deleteAllConditions == 0) % the last condition is for offset adding
    designMatrix.onsets    = onsets;
    designMatrix.durations = durations;
elseif deleteLastCondition
    onsets(end)     = [];%delete the last element
    durations(end)  = [];
    designMatrix.onsets    = onsets;
    designMatrix.durations = durations;
else % delete everything
    designMatrix.onsets  = [];
    designMatrix.durations = [];
end

% designMatrix.onsets{1} = [1:16:20];
% designMatrix.onsets{2} = [5:16:100];
% designMatrix.onsets{3} = [9:16:100];
% designMatrix.onsets{4} = [13:16:100];
% designMatrix.durations{1} = 4;
% designMatrix.durations{2} = 4;
% designMatrix.durations{3} = 4;
% designMatrix.durations{4} = 4;

% % make a vector of acquistion points for all conditions
for j = 1:numel(designMatrix.onsets)
    
    designMatrix.acqPoints{1,j} = [];
    
    for i = 1: numel(designMatrix.onsets{j})
        designMatrix.acqPoints{1,j}(end+1:end+designMatrix.durations{j}) = ...
            repmat(designMatrix.onsets{1,j}(i) ,1,...
            designMatrix.durations{j})+ [0: designMatrix.durations{j}-1];
    end
end

% % Make a vector for the edges of the fill box to be overlayed over each scan
% designMatrix.startY          = Y(1);
% designMatrix.endY            = Y(2);
% for j = 1:numel(designMatrix.onsets)
%     designMatrix.xVectorFill{1,j} =[];
%     designMatrix.yVectorFill{1,j} =[];
%
%     for i = 1: numel(designMatrix.acqPoints{j})-1         %[0 0 1 1 1]
%         designMatrix.xVectorFill{1,j}(end+1:end+5) = ...
%         [designMatrix.acqPoints{1,j}(i) ...
%         designMatrix.acqPoints{1,j}(i) ...
%          designMatrix.acqPoints{1,j}(i+1) ...
%          designMatrix.acqPoints{1,j}(i+1) ...
%          designMatrix.acqPoints{1,j}(i+1)];
%
%         designMatrix.yVectorFill{1,j}(end+1:end+5) = ...  %[0 1 1 0 0]
%             [designMatrix.startY designMatrix.endY designMatrix.endY....
%             designMatrix.startY designMatrix.startY];
%     end
% end
%
% % for j = 1:numel(designMatrix.onsets)
% fill(designMatrix.xVectorFill{1,1},designMatrix.yVectorFill{1,1},...
%     [1 0 0], 'faceAlpha', 0.2);
% % end
% interactivemouse on;

% make and sticks vector
for j = 1:numel(designMatrix.onsets)
    designMatrix.sticksVector{1,j} = zeros(designMatrix.onsets{1,j}(end),1);
    designMatrix.sticksVector{1,j}(designMatrix.acqPoints{1,j}) = ...
        (j)*ones(1,numel(designMatrix.acqPoints{1,j}));   % the j part control the color
    % clip the vector till the last scan if bigger
    % else append zeros
    if numel( designMatrix.sticksVector{1,j}) > numScans
        designMatrix.sticksVector{1,j}(numScans+1:end) = [];
    elseif numel( designMatrix.sticksVector{1,j}) < numScans
        designMatrix.sticksVector{1,j}(end+1:numScans) = ...
            zeros(numScans-numel(designMatrix.sticksVector{1,j}),1);
    else
        designMatrix.sticksVector{1,j} = designMatrix.sticksVector{1,j};
    end
end

% add all the stick vectors
designMatrix.combinedsticksVector = zeros(numScans,1);
for j = 1:numel(designMatrix.onsets)
    designMatrix.combinedsticksVector =  designMatrix.combinedsticksVector +...
        designMatrix.sticksVector{1,j};
end

for i = 1:numel(designMatrix.combinedsticksVector)
    if designMatrix.combinedsticksVector(i) == 0
        designMatrix.combinedsticksVector(i) = nan;
    end
end

tmp             = designMatrix.combinedsticksVector; %save temporarily
%%
% deal with offset
% offset = 4;
offsetVector    = 1*nan(offset,1);
designMatrix.combinedsticksVector = ...
    [offsetVector;tmp(1:end-offset,1)];
%define the number of colors
if numel(designMatrix.onsets)+1 < 3
    numCbrewerColors = 3;
else
    numCbrewerColors = numel(designMatrix.onsets)+1;
end

%define cutom colormaps
if strcmp(cm, 'IsoL')
    cm = pmkmp(256, 'isol');
    % cm = colorGray(numel(designMatrix.onsets)+2);
elseif  strcmp(cm, 'ESA')
    cm = colormap(esa);
elseif strcmp(cm, 'CubicL')
    cm = pmkmp(256);
elseif strcmp(cm, 'Maximally Distinct')
    cm = distinguishable_colors(numel(designMatrix.onsets)+1);
elseif strcmp(cm, 'Color Brewer Set1')
    cm = cbrewer('qual', 'Set1', numCbrewerColors);
elseif strcmp(cm, 'Color Brewer Set2')
    cm = cbrewer('qual', 'Set2', numCbrewerColors);
elseif strcmp(cm, 'Color Brewer Set3')
    cm = cbrewer('qual', 'Set3', numCbrewerColors);
elseif strcmp(cm, 'Color Brewer Paired')
    cm = cbrewer('qual', 'Paired',numCbrewerColors);
elseif strcmp(cm, 'Color Brewer Accent')
    cm = cbrewer('qual', 'Accent',numCbrewerColors);
elseif strcmp(cm, 'Color Brewer Dark')
    cm = cbrewer('qual', 'Dark2',numCbrewerColors);
elseif strcmp(cm, 'Color Brewer Pastel')
    cm = cbrewer('qual', 'Pastel2',numCbrewerColors);
else %else use the matlab colormaps
    cm = colormap(cm);
end

% if only one condition exists then dont do double2rgb because for some
% colormaps the codition wont be visible
if numel(designMatrix.onsets)~= 1
    img = double2rgb(designMatrix.combinedsticksVector', cm, [1 numel(designMatrix.onsets)+1]);
else
    img = designMatrix.combinedsticksVector';
end

axes(axesHandle);
imagesc([startX endX], [startY endY],img);
freezeColors;
hold on
if ~isempty(plotData) % for plotting motion regressors
    plotDataMean = mean(plotData,1);
    a=plot(axesHandle, 0:numel(plotDataMean)-1, plotDataMean,'LineSmoothing','on',  'LineWidth', lineWidth,'Color', lineColor);
    set(a,'uicontextmenu',linecmenu);
    set(axesHandle, 'yLim', [startY endY]);
    set(axesHandle,'Color',[0 0 0]); % change the plot background to black
    hold off;
end
% expandAxes(axesHandle);
% x = plotData;
% y = 1:numel(plotDataMean);
% shadedErrorBar(x,mean(y,1),std(y),'g');
% shadedErrorBar(x,y,{@median,@std},{'r-o','markerfacecolor','r'});
% shadedErrorBar([],y,{@median,@std},{'r-o','markerfacecolor','r'});

% set the y-axis back to normal.
set(gca,'ydir','normal');