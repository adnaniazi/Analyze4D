function varargout = saveFig(varargin)
% SAVEFIG MATLAB code for saveFig.fig
%      SAVEFIG, by itself, creates a new SAVEFIG or raises the existing
%      singleton*.
%
%      H = SAVEFIG returns the handle to a new SAVEFIG or the handle to
%      the existing singleton*.
%
%      SAVEFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SAVEFIG.M with the given input arguments.
%
%      SAVEFIG('Property','Value',...) creates a new SAVEFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before saveFig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to saveFig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help saveFig

% Last Modified by GUIDE v2.5 11-May-2012 11:36:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @saveFig_OpeningFcn, ...
                   'gui_OutputFcn',  @saveFig_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before saveFig is made visible.
function saveFig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to saveFig (see VARARGIN)

% Choose default command line output for saveFig
handles.output = hObject;
set(handles.figure1,'Name', 'Save Figure...');
% change the software icon
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
jframe=get(handles.figure1,'javaframe');
st = dbstack('-completenames');
path = st.file;
path = path(1:end-21-numel('saveFig'));
jIcon=javax.swing.ImageIcon(fullfile(path,'assets','a4d.png'));
jframe.setFigureIcon(jIcon);

bgColor = get(handles.tip,'BackgroundColor');
%update axes
[img1,map, alpha1] = imread('tool_plottools_show.png');
axes(handles.showAxes);
imshow(img1);

[img2,map, alpha2] = imread('tool_plottools_hide.png');
axes(handles.hideAxes);
imshow(img2);
handles.figHandle = varargin{1,1}{1,1};
name = varargin{1,1}{2,1};
if strcmp(name, 'Mosaic Figure')
    figlist = findall(0,'Type','fig','Name', 'Mosaic Figure');
    handles.figHandle = figlist;
    set(handles.tipText,'String','If you are not happy with how the picture looks like, then you can customize the look of the picture by clicking the ''Show Plot Tools'' in the ''Mosaic Figure'' window and edit the picture to your hearts desire. Once you are done editing, close the Plot tools by clicking the ''Hide Plot Tool'' button. Then proceed to saving this new customized figure.')
    try
        defaultTextColor =get(findall(handles.figHandle, 'Type', 'text','String','1'), 'color');
        if isequal(defaultTextColor, [1 1 1])
        set(findall(handles.figHandle, 'Type', 'text'), 'color', [1 1 1]*0.999);
        end
        set(handles.textColorIndicator, 'BackgroundColor', defaultTextColor);
    end
    try
        defaultLineColor =get(findall(handles.figHandle, 'Type', 'Line'), 'color');
        if isequal(defaultLineColor{1,1}, [1 1 1])
            set(findall(handles.figHandle, 'Type', 'line'), 'color', [1 1 1]*0.999);
        end
        set(handles.lineColorIndicator, 'BackgroundColor', defaultLineColor{1,1});
    end
end

if strcmp(name, 'Time Course Figure')
    figlist = findall(0,'Type','fig','Name', 'Time Course Figure');
    handles.figHandle = figlist;
    set(handles.tipText,'String','If you are not happy with how the picture looks like, then you can customize the look of the picture by clicking the ''Show Plot Tools'' in the ''Time Course Figure'' window and edit the picture to your hearts desire. Once you are done editing, close the Plot tools by clicking the ''Hide Plot Tool'' button. Then proceed to saving this new customized figure.')
    try
        defaultTextColor =get(findall(handles.figHandle, 'Type', 'text','String','1'), 'color');
        if isequal(defaultTextColor, [1 1 1])
        set(findall(handles.figHandle, 'Type', 'text'), 'color', [1 1 1]*0.999);
        end
        set(handles.textColorIndicator, 'BackgroundColor', defaultTextColor);
    end
    try
        defaultLineColor =get(findall(handles.figHandle, 'Type', 'Line', 'color', [1 1 1]));
        if isequal(defaultLineColor.Color, [1 1 1])
            set(findall(handles.figHandle, 'Type', 'line'), 'color', [1 1 1]*0.999);
        end
        set(handles.lineColorIndicator, 'BackgroundColor', defaultLineColor.Color);
    end
end


set(handles.status,'string', 'Status: Idle...');
handles.dpi =     300;
handles.renderer = 'opengl';
set(handles.rendererStaticText,'TooltipString', sprintf('Rendering method used for screen and printing. \nSelects the method used to render MATLAB graphics. The choices are:\npainters — The original rendering method used by MATLAB is faster when the \nfigure contains only simple or small graphics objects. \n\nzbuffer — MATLAB draws graphics objects faster and more accurately because \nit colors objects on a per-pixel basis and MATLAB renders only those \npixels that are visible in the scene (thus eliminating front-to-back sorting \nerrors). Note that this method can consume a lot of system memory if MATLAB is \ndisplaying a complex scene. \n\nOpenGL — OpenGL is a renderer that is available on many computer systems. \nThis renderer is generally faster than painters or zbuffer and \nin some cases enables MATLAB to access graphics hardware that is \navailable on some systems.'))
set(handles.mFile,'enable','off');


set(handles.antialiasing, 'Value', 1);
guidata(hObject, handles);
hObjectCall = handles.antialiasing;
saveFig('antialiasing_Callback',hObjectCall,eventdata,guidata(hObjectCall));

% tightfig(handles.figHandle)
% gca = findobj(handles.figHandle, 'Type', 'Axes');
% set(gca, 'LooseInset', [0,0,0,0]);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes saveFig wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = saveFig_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in saveFIG.
function saveFIG_Callback(hObject, eventdata, handles)
% hObject    handle to saveFIG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of saveFIG


% --- Executes on button press in saveFIGv6.
function saveFIGv6_Callback(hObject, eventdata, handles)
% hObject    handle to saveFIGv6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of saveFIGv6


% --- Executes on button press in mFile.
function mFile_Callback(hObject, eventdata, handles)
% hObject    handle to mFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mFile


% --- Executes on button press in saveJPEG.
function saveJPEG_Callback(hObject, eventdata, handles)
% hObject    handle to saveJPEG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of saveJPEG


% --- Executes on button press in savePDF.
function savePDF_Callback(hObject, eventdata, handles)
% hObject    handle to savePDF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of savePDF


% --- Executes on button press in saveEPSL2BlackAndWhite.
function saveEPSL2BlackAndWhite_Callback(hObject, eventdata, handles)
% hObject    handle to saveEPSL2BlackAndWhite (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of saveEPSL2BlackAndWhite


% --- Executes on button press in saveTIFF.
function saveTIFF_Callback(hObject, eventdata, handles)
% hObject    handle to saveTIFF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of saveTIFF


% --- Executes on button press in saveEMF.
function saveEMF_Callback(hObject, eventdata, handles)
% hObject    handle to saveEMF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of saveEMF


% --- Executes on button press in saveEPSBlackAndWhite.
function saveEPSBlackAndWhite_Callback(hObject, eventdata, handles)
% hObject    handle to saveEPSBlackAndWhite (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of saveEPSBlackAndWhite


% --- Executes on button press in saveILL.
function saveILL_Callback(hObject, eventdata, handles)
% hObject    handle to saveILL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of saveILL


% --- Executes on button press in savePNG.
function savePNG_Callback(hObject, eventdata, handles)
% hObject    handle to savePNG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of savePNG


% --- Executes on button press in saveBMP.
function saveBMP_Callback(hObject, eventdata, handles)
% hObject    handle to saveBMP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of saveBMP


% --- Executes on button press in saveHDF.
function saveHDF_Callback(hObject, eventdata, handles)
% hObject    handle to saveHDF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of saveHDF


% --- Executes on button press in saveEPSColor.
function saveEPSColor_Callback(hObject, eventdata, handles)
% hObject    handle to saveEPSColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of saveEPSColor

% --- Executes on button press in saveEPSL2Color.
function saveEPSL2Color_Callback(hObject, eventdata, handles)
% hObject    handle to saveEPSL2Color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of saveEPSL2Color


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename = get(handles.fileName,'String');
path = get(handles.savePath,'String');
if strcmp(path,'Save path')
    set(handles.status,'string',...
        'Error: Please Specifiy a valid path for saving the figures');
    return;
end
if ~(get(handles.saveFIG, 'value') || get(handles.saveFIGv6, 'value') ||...
        get(handles.saveFIGv73, 'value') ||...
        get(handles.saveEPSBlackAndWhite, 'value') ||...
        get(handles.saveEPSColor, 'value') ||...
        get(handles.saveEPSL2BlackAndWhite, 'value') ||...
        get(handles.saveEPSL2Color, 'value') ||...
        get(handles.savePNG, 'value') || get(handles.saveBMP, 'value') ||...
        get(handles.saveJPEG, 'value') || get(handles.saveTIFF, 'value') ||...
        get(handles.saveHDF, 'value') || get(handles.saveEMF, 'value') ||...
        get(handles.savePDF, 'value') || get(handles.saveILL, 'value') ||...
        get(handles.mFile, 'value'))
    msgbox('No file type has been selected. Please specify a file type to be saved.','Error | File type not selected','error','modal');
    return;
end

% restack: bring text to the top and the lines below it

% % Bring texts to the top of the visual stack
% 
% 
% hline = findall(handles.figHandle, 'Type', 'line');
% uistack(hline, 'down', 1) ;
% hText = findall(handles.figHandle, 'Type', 'text');
% uistack(hText, 'top') ;

if ~isempty(get(handles.defineCustomResolution,'String'))
    handles.dpi = str2double(get(handles.defineCustomResolution,'String'));
end
res = strcat('-r',num2str(handles.dpi));
renderer = strcat('-',num2str(handles.renderer));

% bring the figure into focus
figure(handles.figHandle);
figure(handles.figure1);

try
    dlg = ProgressDialog('StatusMessage', 'Started saving..','Indeterminate', true);
    set(handles.status,'String', strcat('Status: Saving...........Please be patient!. Resolution(DPI) = ',num2str(handles.dpi)) );
    if get(handles.saveFIG, 'value')
        dlg.StatusMessage = 'Saving PNG';
        hgsave(handles.figHandle,fullfile(path,filename)); end
    if get(handles.saveFIGv6, 'value')
        dlg.StatusMessage = 'Saving fig (v6)';
        hgsave(handles.figHandle,fullfile(path,filename),'-v6'); end
    if get(handles.saveFIGv73, 'value')
        dlg.StatusMessage ='Saving fig (v7.3)';
        hgsave(handles.figHandle,fullfile(path,filename),'-v7.3'); end
    
    if get(handles.saveEPSBlackAndWhite, 'value')
        dlg.StatusMessage = 'Saving EPS Black and White';
        print(handles.figHandle,'-deps',res,fullfile(path,filename),renderer); end
    if get(handles.saveEPSColor, 'value')
        dlg.StatusMessage = 'Saving EPS Color';
        print(handles.figHandle,'-depsc',res,fullfile(path,filename),renderer); end
    if get(handles.saveEPSL2BlackAndWhite, 'value')
        dlg.StatusMessage = 'Saving Level 2 EPS Black and white';
        print(handles.figHandle,'-deps2',res,fullfile(path,filename),renderer); end
    if get(handles.saveEPSL2Color, 'value')
        dlg.StatusMessage = 'Saving Level 2 EPS Color';
        print(handles.figHandle,'-depsc2',res,fullfile(path,filename),renderer); end
    
    if get(handles.savePNG, 'value')
        dlg.StatusMessage = 'Saving PNG';
        print(handles.figHandle,'-dpng',res,fullfile(path,filename),renderer); end
    if get(handles.saveBMP, 'value')
        dlg.StatusMessage = 'Saving BMP';
        print(handles.figHandle,'-dbmp',res,fullfile(path,filename),renderer); end
    if get(handles.saveJPEG, 'value')
        dlg.StatusMessage = 'Saving JPEG';
        print(handles.figHandle,'-djpeg ',res,fullfile(path,filename),renderer); end
    
    if get(handles.saveTIFF, 'value')
        dlg.StatusMessage = 'Saving TIFF';
        print(handles.figHandle,'-dtiff',res,fullfile(path,filename),renderer); end
    if get(handles.saveHDF, 'value')
        dlg.StatusMessage ='Saving HDF';
        print(handles.figHandle,'-dhdf',res,fullfile(path,filename),renderer); end
    if get(handles.saveEMF, 'value')
        dlg.StatusMessage ='Saving EMF';
        print(handles.figHandle,'-dmeta',res,fullfile(path,filename),renderer); end
    
    if get(handles.savePDF, 'value')
        glg.StatusMessage ='Saving PDF';
        print(handles.figHandle,'-dpdf',res,fullfile(path,filename),renderer); end
    if get(handles.saveILL, 'value')
        dlg.StatusMessage = 'Saving AI (AbobeIllustrator)';
        print(handles.figHandle,'-dill ',res,fullfile(path,filename),renderer); end
    
    if get(handles.mFile, 'value')
        dlg.StatusMessage = 'Saving m-file';
        %    hgsave(handles.figHandle,fullfile(path,filename)); % first make the figure file
        fig2mfile(handles.figHandle, fullfile(path,filename)); end
    set(handles.status,'String', 'Status: Done.');
    delete(dlg);
catch ME
    delete(dlg);
    Error = ME.message
    set(handles.status,'String', 'Status: An error has occured. Please see the command window for more details.');
end


% --- Executes on button press in close.
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(handles.figure1);
try
close(handles.figHandle);
end

function savePath_Callback(hObject, eventdata, handles)
% hObject    handle to savePath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of savePath as text
%        str2double(get(hObject,'String')) returns contents of savePath as a double


% --- Executes during object creation, after setting all properties.
function savePath_CreateFcn(hObject, eventdata, handles)
% hObject    handle to savePath (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% path = uigetdir2('','Please select the location for saving the figures');
path = pickDirUsingJFileChooser();
set(handles.savePath, 'String',path);
set(handles.status,'string','Status: ');
guidata(hObject,handles);

function fileName_Callback(hObject, eventdata, handles)
% hObject    handle to fileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fileName as text
%        str2double(get(hObject,'String')) returns contents of fileName as a double

% --- Executes during object creation, after setting all properties.
function fileName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fileName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in resolutionMenu.
function resolutionMenu_Callback(hObject, eventdata, handles)
% hObject    handle to resolutionMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns resolutionMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from resolutionMenu
contents = cellstr(get(hObject,'String'));
handles.dpi =     contents{get(hObject,'Value')};

guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function resolutionMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to resolutionMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function defineCustomResolution_Callback(hObject, eventdata, handles)
% hObject    handle to defineCustomResolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of defineCustomResolution as text
%        str2double(get(hObject,'String')) returns contents of defineCustomResolution as a double
handles.dpi =     str2double(get(hObject,'String'));
set(handles.resolutionMenu,'Value',1);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function defineCustomResolution_CreateFcn(hObject, eventdata, handles)
% hObject    handle to defineCustomResolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in textSize.
function textSize_Callback(hObject, eventdata, handles)
% hObject    handle to textSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(hObject,'String'));
fontSize = contents{get(hObject,'Value')};
if strcmp(fontSize,'Define new..')
        prompt = {'Please define a new value for text size'};
    dlg_title = 'Define a new value';
    num_lines = 1;
    def = {'10'};
    fontSize = inputdlg(prompt,dlg_title,num_lines,def);    
end
fontSize = str2double(fontSize);
set(findall(handles.figHandle, 'Type', 'text'), 'FontSize', fontSize);
guidata(hObject,handles);

% Hints: contents = cellstr(get(hObject,'String')) returns textSize contents as cell array
%        contents{get(hObject,'Value')} returns selected item from textSize


% --- Executes during object creation, after setting all properties.
function textSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in lineWidthStaticText.
function lineWidth_Callback(hObject, eventdata, handles)
% hObject    handle to lineWidthStaticText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns lineWidthStaticText contents as cell array
%        contents{get(hObject,'Value')} returns selected item from lineWidthStaticText


% --- Executes during object creation, after setting all properties.
function lineWidthStaticText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lineWidthStaticText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in bringFigureToFront.
function bringFigureToFront_Callback(hObject, eventdata, handles)
% hObject    handle to bringFigureToFront (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure(handles.figHandle);

% --- Executes on button press in showPlotToolsButton.
function showPlotToolsButton_Callback(hObject, eventdata, handles)
% hObject    handle to showPlotToolsButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in hidePlotToolsButton.
function hidePlotToolsButton_Callback(hObject, eventdata, handles)
% hObject    handle to hidePlotToolsButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in saveFIGv73.
function saveFIGv73_Callback(hObject, eventdata, handles)
% hObject    handle to saveFIGv73 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of saveFIGv73


% --- Executes on button press in textColor.
function textColor_Callback(hObject, eventdata, handles)
% hObject    handle to textColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

textColor = uicolorpicker;
if textColor == [1 1 1]
    textColor = textColor * 0.999;
end
set(findall(handles.figHandle, 'Type', 'text'), 'color',textColor);
set(handles.textColorIndicator, 'BackgroundColor', textColor);
guidata(hObject,handles);


% --- Executes on button press in lineColor.
function lineColor_Callback(hObject, eventdata, handles)
% hObject    handle to lineColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
lineColor = uicolorpicker;
if lineColor == [1 1 1]
    lineColor = lineColor * 0.999;
end
set(findall(handles.figHandle, 'Type', 'line'), 'color',lineColor);
set(handles.lineColorIndicator, 'BackgroundColor', lineColor);
guidata(hObject,handles);
% --- Executes on selection change in renderer.
function renderer_Callback(hObject, eventdata, handles)
% hObject    handle to renderer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns renderer contents as cell array
%        contents{get(hObject,'Value')} returns selected item from renderer
contents = cellstr(get(hObject,'String'));
handles.renderer = contents{get(hObject,'Value')} ;
guidata(hObject,handles);
 
% --- Executes during object creation, after setting all properties.
function renderer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to renderer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in lineThickness.
function lineThickness_Callback(hObject, eventdata, handles)
% hObject    handle to lineThickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(hObject,'String'));
lineThickness = str2double(contents{get(hObject,'Value')});

lineThickness = contents{get(hObject,'Value')};
if strcmp(lineThickness,'Define new..')
        prompt = {'Please define a new value for line width'};
    dlg_title = 'Define a new value';
    num_lines = 1;
    def = {'1'};
    lineThickness = inputdlg(prompt,dlg_title,num_lines,def);    
end
lineThickness = str2double(lineThickness);
set(findall(handles.figHandle, 'Type', 'line'), 'LineWidth',lineThickness);	%make all other lines correct
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function lineThickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lineThickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in antialiasing.
function antialiasing_Callback(hObject, eventdata, handles)
% hObject    handle to antialiasing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of antialiasing
if  get(hObject,'Value') 
set(findall(handles.figHandle, 'Type', 'line'), 'LineSmoothing','on');
% set(findall(handles.figHandle, 'Type', 'axes'), 'LineSmoothing','on');
% set(findall(handles.figHandle, 'Type', 'text'), 'LineSmoothing','on');

else
    set(findall(handles.figHandle, 'Type', 'line'), 'LineSmoothing','off');	
end
guidata(hObject,handles)


% --- Executes on button press in selectAll.
function selectAll_Callback(hObject, eventdata, handles)
% hObject    handle to selectAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
set(handles.saveEPSL2Color,'Value',1);
set(handles.saveFIGv73,'Value',1);
set(handles.saveEPSColor,'Value',1);
set(handles.saveHDF,'Value',1);
set(handles.saveBMP,'Value',1);
set(handles.savePNG,'Value',1);
set(handles.saveILL,'Value',1);
set(handles.saveEPSBlackAndWhite,'Value',1);
set(handles.saveEMF,'Value',1);
set(handles.saveTIFF,'Value',1);
set(handles.saveEPSL2BlackAndWhite,'Value',1);
set(handles.savePDF,'Value',1);
set(handles.saveJPEG,'Value',1);
% set(handles.mFile,'Value',1);
set(handles.saveFIGv6,'Value',1);
set(handles.saveFIG,'Value',1);
guidata(hObject,handles);

% --- Executes on button press in deselectAll.
function deselectAll_Callback(hObject, eventdata, handles)
% hObject    handle to deselectAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.saveEPSL2Color,'Value',0);
set(handles.saveFIGv73,'Value',0);
set(handles.saveEPSColor,'Value',0);
set(handles.saveHDF,'Value',0);
set(handles.saveBMP,'Value',0);
set(handles.savePNG,'Value',0);
set(handles.saveILL,'Value',0);
set(handles.saveEPSBlackAndWhite,'Value',0);
set(handles.saveEMF,'Value',0);
set(handles.saveTIFF,'Value',0);
set(handles.saveEPSL2BlackAndWhite,'Value',0);
set(handles.savePDF,'Value',0);
set(handles.saveJPEG,'Value',0);
% set(handles.mFile,'Value',0);
set(handles.saveFIGv6,'Value',0);
set(handles.saveFIG,'Value',0);
guidata(hObject,handles);