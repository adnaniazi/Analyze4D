function SelectedColour = uicolorpicker(varargin)

% UICOLORPICKER([X Y])
%
% Displays a mini colour picker similar to the Microsoft Office Style
% Colour Pickers.
%
% [X Y] Optional. Position of ColorPicker Dialogbox. If unspecified, dialog
% will appear centred on screen.
%
%
% Author: Richard Medlock 21/8/02
%
% Overhaul: 6/6/03

% NB: Next version should allow palettes of any size.

% Create a figure window, 160x215...
SysCol = get(0,'DefaultUicontrolBackgroundColor');
DkSys = SysCol * 0.6; DkSys(DkSys < 0) = 0;
LtSys = SysCol / 1.1; LtSys(LtSys > 1) = 1;

% Set Startup position...
if nargin == 1
    position = varargin{1};
else
    SSize = get(0,'ScreenSize');
    Centre = SSize(3:4)/2;
    position = [Centre(1)-80 Centre(2)-107];
end

% Draw Dialog...
hFig = figure('position',[position(1) position(2) 157 130],...
    'Name','Color',...
    'NumberTitle','off',...
    'Menubar','none',...
    'Color',SysCol,...
    'Visible','off',...
    'Resize','off');
    
% find out what directory this function is in...
[pathstr] = fileparts(which(mfilename));

% Then load the palette...
Loaded = load(fullfile(pathstr,'palette.col'),'-mat');
Palette = Loaded.Palette;
RGBColours = Palette.Colours;
Names = Palette.ColourNames;
% You could modify Palette.col to show different colours.
% use "load palette.col -mat" in workspace

% Create the grid of frames (12x12 pixels)...
L = 10;
B = 110;
W = 12;
H = 12;
S = 6;

CLR = 0;

% This is quicker than doing num2str in a loop...
Labels(1,:) = {'Col11','Col21','Col31','Col41','Col51','Col61','Col71','Col81'};
Labels(2,:) = {'Col12','Col22','Col32','Col42','Col52','Col62','Col72','Col82'};
Labels(3,:) = {'Col13','Col23','Col33','Col43','Col53','Col63','Col73','Col83'};
Labels(4,:) = {'Col14','Col24','Col34','Col44','Col54','Col64','Col74','Col84'};
Labels(5,:) = {'Col15','Col25','Col35','Col45','Col55','Col65','Col75','Col85'};

CtrlTags(1,:) = {'FrmCol11','FrmCol21','FrmCol31','FrmCol41','FrmCol51','FrmCol61','FrmCol71','FrmCol81'};
CtrlTags(2,:) = {'FrmCol12','FrmCol22','FrmCol32','FrmCol42','FrmCol52','FrmCol62','FrmCol72','FrmCol82'};
CtrlTags(3,:) = {'FrmCol13','FrmCol23','FrmCol33','FrmCol43','FrmCol53','FrmCol63','FrmCol73','FrmCol83'};
CtrlTags(4,:) = {'FrmCol14','FrmCol24','FrmCol34','FrmCol44','FrmCol54','FrmCol64','FrmCol74','FrmCol84'};
CtrlTags(5,:) = {'FrmCol15','FrmCol25','FrmCol35','FrmCol45','FrmCol55','FrmCol65','FrmCol75','FrmCol85'};

for i = 1:5 % For each row in the grid...
   
    for ctrl = 1:8
        CLR = CLR + 1;            
        myColour = RGBColours(CLR,:);
        CtrlP = [(ctrl*19)-14, (i*19)+15, 15, 15];
        uicontrol('style','frame',...
                  'position',CtrlP,...
                  'BackgroundColor',myColour,...
                  'ForegroundColor',DkSys,...
                  'enable','inactive',...
                  'TooltipString',Names{CLR},...
                  'ButtonDownFcn',@SelectColour);
    end 
end

% Making the grid 'inactive' prevents the tool tips from showing
% But if you don't make it 'inactive' the buttons won't work!

% Create an 'etched' border...
uicontrol('style','frame',...
          'position',[10 25 138 1],...
          'BackgroundColor',SysCol,...
          'ForegroundColor',DkSys);

uicontrol('style','frame',...
          'position',[10 24 138 1],...
          'BackgroundColor',SysCol,...
          'ForegroundColor',LtSys);
      
% Create a text box which will be the 'more colours' button...
uicontrol('style','text',...
          'position',[10 0 138 20],...
          'Tag','BtnMoreColours',...
          'string','More Colors...',...
          'BackgroundColor',SysCol,...
          'enable','inactive',...
          'ButtonDownFcn',@MoreColours);
      
set(hFig,'visible','on');

% Wait for the user to respond to the dialog...
try 
    uiwait(hFig)
catch
    delete (hFig)
end

% This will fail if the user closes the dialog using the 'close' button.
% When this happens, the returned value is empty.
try
    SelectedColour = get(hFig,'UserData');
    delete(hFig)
catch
    SelectedColour = [];
end

% -----------------------------------------------------------
function SelectColour(hObj,EventData)

% Get the Selected Colour...
SelectedColour = get(hObj,'BackgroundColor');

% Get the Handle to the figure...
hFig = get(hObj,'Parent');

% Set the UserData to the Selected Colour...
set(hFig,'UserData',SelectedColour);

% Resume Execution of the Code... (suspended by uiwait)
uiresume;

% -----------------------------------------------------------
function MoreColours(hObj,EventData)

% Use SetColor to get more colours & mixer...
SelectedColour = uisetcolor;

% Get the Handle to the figure...
hFig = get(hObj,'Parent');

% Set the UserData to the Selected Colour...
set(hFig,'UserData',SelectedColour);

% Resume Execution of the Code... (suspended by uiwait)
uiresume;