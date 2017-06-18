function varargout=msgboxa(varargin)
%msgboxa Message box.
%   msgboxa(Message) creates a message box that automatically wraps
%   Message to fit an appropriately sized Figure.  Message is a string
%   vector, string matrix or cell array.
%
%   msgboxa(Message,Title) specifies the title of the message box.
%
%   msgboxa(Message,Title,Icon) specifies which Icon to display in
%   the message box.  Icon is 'none', 'error', 'help', 'warn', or
%   'custom'. The default is 'none'.
%
%   msgboxa(Message,Title,'custom',IconData,IconCMap) defines a
%   customized icon.  IconData contains image data defining the icon;
%   IconCMap is the colormap used for the image.
%
%   msgboxa(Message,...,CreateMode) specifies whether a message box is modal
%   or non-modal. Valid values for CreateMode are 'modal', 'non-modal', and
%   'replace'. If CreateMode is 'modal' or 'replace', the first available
%   message box with the specified title is updated to reflect the new
%   properties of the message box. All other such message boxes are deleted.
%   If CreateMode is 'non-modal', the message-box is not replaced and a new
%   handle is created. The default value for CreateMode is 'non-modal'.
%
%   CreateMode may also be a structure with fields WindowStyle and
%   Interpreter.  WindowStyle may be any of the values above.
%   Interpreter may be 'tex' or 'none'.  The default value for the
%   Interpreter is 'none';
%
%   h = msgboxa(...) returns the handle of the box in h.
%
%   To make msgboxa block execution until the user responds, include the
%   string 'modal' in the input argument list and wrap the call to
%   msgboxa with UIWAIT.
%
%   Examples:
%       %An example which blocks execution until the user responds:
%       uiwait(msgboxa('String','Title','modal'));
%
%       %An example using a custom Icon is:
%       Data=1:64;Data=(Data'*Data)/64;
%       h=msgboxa('String','Title','custom',Data,hot(64))
%
%       %An example which reuses the existing msgboxa window:
%       CreateStruct.WindowStyle='replace';
%       CreateStruct.Interpreter='tex';
%       h=msgboxa('X^2 + Y^2','Title','custom',Data,hot(64),CreateStruct);
%
%   See also DIALOG, ERRORDLG, HELPDLG, INPUTDLG, LISTDLG,
%            QUESTDLG, TEXTWRAP, UIWAIT, WARNDLG.

%  Copyright 1984-2010 The MathWorks, Inc.
%  $Revision: 1.57.4.15 $ $Date: 2010/11/17 11:30:31 $


%%%%%%%%%%%%%%%%%%%%
%%% Nargin Check %%%
%%%%%%%%%%%%%%%%%%%%
error(nargchk(1,6,nargin));
error(nargoutchk(0,1,nargout));

inputStr = varargin{1};
BodyTextString = dialogCellstrHelper(inputStr);

% setup defaults
TitleString=' ';
IconString ='none';
IconData   =[];
IconCMap   =[];


createArg = '';
if nargin > 1
    createArg = varargin{nargin};
end

[Flag,CreateMode,Interpreter]=InternalCreateFlag(createArg);

% Do a check on the Interpreter property upfront.
if (any(strcmpi(Interpreter, {'latex', 'tex', 'none'})) ~= 1)
    error('MATLAB:msgboxa:interpreter', ...
          'Bad value for text property: ''Interpreter''');
end


switch nargin,
    case 2,
        if ~Flag
            TitleString=varargin{2};
        end
    case 3,
        TitleString=varargin{2};
        if ~Flag
            IconString=varargin{3};
        end
    case 4,
        TitleString=varargin{2};
        IconString=varargin{3};
        if ~Flag
            IconData = varargin{4};
        end
    case 5,
        if Flag
            error('MATLAB:msgboxa:colormap', ...
                'A Colormap must be specified when calling msgboxa with 5 input arguments.');
        end
        TitleString=varargin{2};
        IconString=varargin{3};
        if ~strcmpi(IconString,'custom'),
            warning('MATLAB:msgboxa:customicon', ...
                'Icon must be ''custom'' when specifying icon data in msgboxa');
            IconString='custom';
        end
        IconData=varargin{4};
        IconCMap=varargin{5};
    case 6,
        TitleString=varargin{2};
        IconString=varargin{3};
        IconData=varargin{4};
        IconCMap=varargin{5};
end

IconString=lower(IconString);
switch(IconString)
    case {'custom'}
        % check for icon data
        if isempty(IconData)
            error('MATLAB:msgboxa:icondata', ...
                'Must specify icon data when Icon is ''custom''.')
        end
        if ~isnumeric(IconData)
            error('MATLAB:msgboxa:icondatatype', ...
                'Must specify numeric data for icon when Icon is ''custom''.')
        end
        if ~isnumeric(IconCMap)
            error('MATLAB:msgboxa:icondatatype', ...
                'Colormap must be an array of type double, float or sparse when Icon is ''custom''.')
        end
    case {'none','help','warn','error'}
        % icon String OK
    otherwise
        warning('MATLAB:msgboxa:iconstring', ...
            'Invalid string for Icon in msgboxa.');
        IconString='none';
end

Black = [0 0 0];

%%%%%%%%%%%%%%%%%%%%%
%%% Set Positions %%%
%%%%%%%%%%%%%%%%%%%%%
DefFigPos=get(0,'DefaultFigurePosition');

MsgOff=7;
%IconWidth=32;
IconWidth=38;

if strcmp(IconString,'none'),
    FigWidth=125;
    MsgTxtWidth=FigWidth-2*MsgOff;
else
    FigWidth=190;
    MsgTxtWidth=FigWidth-2*MsgOff-IconWidth;
end
FigHeight=50;
DefFigPos(3:4)=[FigWidth FigHeight];

OKWidth=40;
OKHeight=17;
OKXOffset=(FigWidth-OKWidth)/2;
OKYOffset=MsgOff;


MsgTxtXOffset=MsgOff;
MsgTxtYOffset=MsgOff+OKYOffset+OKHeight;
MsgTxtHeight=FigHeight-MsgOff-MsgTxtYOffset;
MsgTxtForeClr=Black;

%IconHeight=32;
IconHeight=38;
IconXOffset=MsgTxtXOffset;
IconYOffset=FigHeight-MsgOff-IconHeight;

%%%%%%%%%%%%%%%%%%%%%
%%% Create msgboxa %%%
%%%%%%%%%%%%%%%%%%%%%

figureHandle=[];

% See if a modal or replace dialog already exists and delete all of its
% children
msgboxaTag = ['msgboxa_', TitleString];
if ~strcmp(CreateMode,'non-modal')
    TempHide=get(0,'ShowHiddenHandles');
    set(0,'ShowHiddenHandles','on');
    OldFig=findobj(0,'Type','figure','Tag',msgboxaTag,'Name',TitleString);
    set(0,'ShowHiddenHandles',TempHide);
    if ~isempty(OldFig)
        figureHandle=OldFig;
        if length(OldFig)>1
            figureHandle=OldFig(1);
            close(OldFig(2:end));
            OldFig(2:end)=[];  %#ok
        end % if length
        CurPos=get(figureHandle,'Position');
        CurPos(3:4)=[FigWidth FigHeight];
        set(figureHandle,'Position',CurPos);
        BoxChildren=get(figureHandle,'Children');
        delete(BoxChildren);
        figure(figureHandle);
    end
end

% % change the software icon
% warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
% jframe=get(handles.figure1,'javaframe');
% st = dbstack('-completenames');
% path = st.file;
% path = path(1:end-28);
% jIcon=javax.swing.ImageIcon(fullfile(path,'assets','a4d.png'));
% jframe.setFigureIcon(jIcon);

if strcmpi(CreateMode,'modal')
    WindowStyle='modal';
else
    WindowStyle='normal';
end

if isempty(figureHandle)
    figureHandle=dialog(                                ...
        'Name'            ,TitleString             , ...
        'Pointer'         ,'arrow'                 , ...
        'Units'           ,'points'                , ...
        'Visible'         ,'off'                   , ...
        'KeyPressFcn'     ,@doKeyPress             , ...
        'WindowStyle'     ,WindowStyle             , ...
        'Toolbar'         ,'none'                  , ...
        'HandleVisibility','on'                    , ...
        'Tag'             ,msgboxaTag                 ...
        );
    % should this be 'on' to match the case below?
    %'HandleVisibility','callback'              , ...

else
    set(figureHandle,   ...
        'WindowStyle'     ,WindowStyle, ...
        'HandleVisibility','on'         ...
        );
end 

FigColor=get(figureHandle,'Color');

MsgTxtBackClr=FigColor;

Font.FontUnits='points';
Font.FontSize=get(0,'FactoryUicontrolFontSize');
Font.FontName=get(0,'FactoryUicontrolFontName');
Font.FontWeight=get(figureHandle,'DefaultUicontrolFontWeight');

StFont = Font;
StFont.FontWeight=get(figureHandle, 'DefaultTextFontWeight');

okPos = [ OKXOffset OKYOffset OKWidth OKHeight ];
OKHandle=uicontrol(figureHandle                             , ...
    Font                                                    , ...
    'Style'              ,'pushbutton'                      , ...
    'Units'              ,'points'                          , ...
    'Position'           , okPos                            , ...
    'Callback'           ,'delete(gcbf)'                    , ...
    'KeyPressFcn'        ,@doKeyPress                       , ...
    'String'             ,'OK'                              , ...
    'HorizontalAlignment','center'                          , ...
    'Tag'                ,'OKButton'                          ...
    );

msgPos = [ MsgTxtXOffset MsgTxtYOffset MsgTxtWidth MsgTxtHeight ];
MsgHandle=uicontrol(figureHandle         , ...
    StFont                               , ...
    'Style'              ,'text'         , ...
    'Units'              ,'points'       , ...
    'Position'           , msgPos        , ...
    'String'             ,' '            , ...
    'Tag'                ,'MessageBox'   , ...
    'HorizontalAlignment','left'         , ...
    'BackgroundColor'    ,MsgTxtBackClr  , ...
    'ForegroundColor'    ,MsgTxtForeClr    ...
    );


[WrapString,NewMsgTxtPos]=textwrap(MsgHandle,BodyTextString,75);
delete(MsgHandle);

% place an axes for the messge string (use an axes so we can get
% latex interpreter if required
AxesHandle=axes( ...
    'Parent'             ,figureHandle  , ...
    'Position'           ,[0 0 1 1]     , ...
    'Visible'            ,'off'           ...
    );

texthandle = text( ...
    'Parent'              ,AxesHandle                        , ...
    'Units'               ,'points'                          , ...
    'String'              ,WrapString                        , ...
    'Color'               ,get(OKHandle,'ForegroundColor')   , ...
    StFont                                                   , ...
    'HorizontalAlignment' ,'left'                            , ...
    'VerticalAlignment'   ,'bottom'                          , ...
    'Interpreter'         ,Interpreter                       , ...
    'Tag'                 ,'MessageBox'                        ...
    );

textExtent = get(texthandle, 'Extent');

% (g357851)textExtent and extent from uicontrol are not the same. For window, extent from uicontrol is larger
%than textExtent. But on Mac, it is reverse. Pick the max value.
MsgTxtWidth=max([MsgTxtWidth NewMsgTxtPos(3) textExtent(3)]);
MsgTxtHeight=max([MsgTxtHeight NewMsgTxtPos(4) textExtent(4)]);

if ~strcmp(IconString,'none')
    MsgTxtXOffset=IconXOffset+IconWidth+MsgOff;
    FigWidth=MsgTxtXOffset+MsgTxtWidth+MsgOff;
    % Center Vertically around icon
    if IconHeight>MsgTxtHeight
        IconYOffset=OKYOffset+OKHeight+MsgOff;
        MsgTxtYOffset=IconYOffset+(IconHeight-MsgTxtHeight)/2;
        FigHeight=IconYOffset+IconHeight+MsgOff;
        % center around text
    else
        MsgTxtYOffset=OKYOffset+OKHeight+MsgOff;
        IconYOffset=MsgTxtYOffset+(MsgTxtHeight-IconHeight)/2;
        FigHeight=MsgTxtYOffset+MsgTxtHeight+MsgOff;
    end

else
    FigWidth=MsgTxtWidth+2*MsgOff;
    MsgTxtYOffset=OKYOffset+OKHeight+MsgOff;
    FigHeight=MsgTxtYOffset+MsgTxtHeight+MsgOff;
end % if ~strcmp

OKXOffset=(FigWidth-OKWidth)/2;
DefFigPos(3:4)=[FigWidth FigHeight];
DefFigPos = getnicedialoglocation(DefFigPos, get(figureHandle,'Units'));

% if there is a figure out there and it's modal, we need to be modal too
if ~isempty(gcbf) && strcmp(get(gcbf,'WindowStyle'),'modal')
    set(figureHandle,'WindowStyle','modal');
end

set(figureHandle,'Position',DefFigPos);

set(OKHandle,'Position',[OKXOffset OKYOffset OKWidth OKHeight]);

% calculate location for shadow box and put behind the button
setdefaultbutton(figureHandle, OKHandle);

txtPos = [ MsgTxtXOffset MsgTxtYOffset 0 ];
set(texthandle, 'Position'            ,txtPos);

if ~strcmp(IconString,'none'),
    % create an axes for the icon
    iconPos = [IconXOffset IconYOffset IconWidth IconHeight];
    IconAxes=axes(                                   ...
        'Parent'          ,figureHandle               , ...
        'Units'           ,'points'                , ...
        'Position'        ,iconPos                 , ...
        'Tag'             ,'IconAxes'                ...
        );

    if ~strcmp(IconString,'custom')
        a = load('dialogicons.mat');
        switch(IconString)
            case'warn'
                IconData=a.warnIconData;
                a.warnIconMap(256,:)=get(figureHandle,'Color');
                IconCMap=a.warnIconMap;

            case 'help'
                IconData=a.helpIconData;
                a.helpIconMap(256,:)=get(figureHandle,'Color');
                IconCMap=a.helpIconMap;

            case 'error'
                IconData=a.errorIconData;
                a.errorIconMap(146,:)=get(figureHandle,'Color');
                IconCMap=a.errorIconMap;
        end
    end

    % place the icon - if this fails, rethrow the error
    % after deleting the figure
    try
        Img=image('CData',IconData,'Parent',IconAxes);
        set(figureHandle, 'Colormap', IconCMap);
    catch ex
        delete(figureHandle);
        rethrow(ex);
    end
    if ~isempty(get(Img,'XData')) && ~isempty(get(Img,'YData'))
        set(IconAxes          , ...
            'XLim'            ,get(Img,'XData')+[-0.5 0.5], ...
            'YLim'            ,get(Img,'YData')+[-0.5 0.5]  ...
            );
    end

    set(IconAxes          , ...
        'Visible'         ,'off'       , ...
        'YDir'            ,'reverse'     ...
        );

end % if ~strcmp

% make sure we are on screen
movegui(figureHandle)

set(figureHandle,'HandleVisibility','callback','Visible','on');

% make sure the window gets drawn even if we are in a pause
drawnow

if nargout==1
    varargout{1}=figureHandle;
end

end

%%%%% InternalCreateFlag
function [Flag,CreateMode,Interpreter]=InternalCreateFlag(mode)
    Flag=0;
    CreateMode='non-modal';
    Interpreter='none';

    if isempty(mode)
        return;
    end

    if iscell(mode)
        mode=mode{:};
    end

    if isstruct(mode)
        errMsg = ['Must specifify fields Interpreter and WindowStyle when ' ...
                  'passing struct as last input argument.'];
        if ~isfield(mode,'Interpreter') || ~isfield(mode,'WindowStyle')
            error('MATLAB:msgboxa:InvalidInput', ...
                  errMsg);
        end
        
        Interpreter=mode.Interpreter;
        mode=mode.WindowStyle;
    end

    if ~ischar(mode)
        return;
    end

    mode=lower(mode);
    switch(mode)
        case {'non-modal','modal','replace'}
         CreateMode = mode;
         Flag=1;
    end
end

%%%%% doKeyPress
function doKeyPress(obj, evd)
    switch(evd.Key)
        case {'return','space','escape'}
            delete(ancestor(obj,'figure'));
    end
end
