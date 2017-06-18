function varargout = getHeader(varargin)
% GETHEADER MATLAB code for getHeader.fig
%      GETHEADER, by itself, creates a new GETHEADER or raises the existing
%      singleton*.
%
%      H = GETHEADER returns the handle to a new GETHEADER or the handle to
%      the existing singleton*.
%
%      GETHEADER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GETHEADER.M with the given input arguments.
%
%      GETHEADER('Property','Value',...) creates a new GETHEADER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before getHeader_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to getHeader_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help getHeader

% Last Modified by GUIDE v2.5 26-Apr-2012 11:46:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @getHeader_OpeningFcn, ...
                   'gui_OutputFcn',  @getHeader_OutputFcn, ...
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


% --- Executes just before getHeader is made visible.
function getHeader_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to getHeader (see VARARGIN)
str1 = '<html><a>Number of slices in each volume of the functional data</a>';
set(handles.numSlices,'tooltipString',str1);
set(handles.numSlicesStaticText,'tooltipString',str1);

str2 = '<html><a>In this field specify the number of many voxels acquired</a><br>in the frequency encoding direction (usually along X-direction).<br> Most commonly for fMRI data, it is 64. So you should specify 64 <br>in this field. If you are unsure, consult your MRI technician, or <br>view data in MRICron and see how many steps are there in <br>X direction.</a>';
set(handles.xRes,'tooltipString',str2);
set(handles.xResStaticText,'tooltipString',str2);

str3 = '<html><a>In this field specify the number of many voxels acquired</a><br>in the phase encoding direction (usually along Y-direction).<br> Most commonly for fMRI data, it is 64. So you should specify 64 <br>in this field. If you are unsure, consult your MRI technician, or <br>view data in MRICron and see how many steps are there in <br>Y direction.</a>';
set(handles.yRes,'tooltipString',str3);
set(handles.yResStaticText,'tooltipString',str3);

str4 = '<html><a>The time interval between successive excitations is called the Repetition Time.</a><br><i><font color="red">Please sepecify it in seconds';
set(handles.tr,'tooltipString',str4);
set(handles.trStaticText,'tooltipString',str4);

% Choose default command line output for getHeader
% handles.output = hObject;
handles.header   = [];
handles.stateVar                          = [];
% Update handles structure
guidata(hObject, handles);
set(handles. figure1, 'Name', 'Specify functiona data parameters');
% set(handles.volumesAvailable, 'String', strcat('You have a total of',{' '}, num2str(varargin{1}),{' '},'volumes available.'))

% change the software icon
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
jframe=get(handles.figure1,'javaframe');
st = dbstack('-completenames');
path = st.file;
path = path(1:end-21-numel('getHeader'));
jIcon=javax.swing.ImageIcon(fullfile(path,'assets','a4d.png'));
jframe.setFigureIcon(jIcon);
loadState(handles, eventdata, hObject);

% UIWAIT makes getHeader wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = getHeader_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
% varargout{1} = handles.output;
varargout{1} = handles.header;
delete(handles.figure1);



% --- Executes on button press in Cancel.
function Cancel_Callback(hObject, eventdata, handles)
% hObject    handle to Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(handles.figure1);



% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles)
% hObject    handle to ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% in                      = get(handles.volumesToRead, 'String');
% stringEntered           = eval(in);
% handles.samplesToRead   = [handles.samplesToRead stringEntered];
% handles.samplesToRead   = unique(handles.samplesToRead)
% handles.in              = [handles.in;{in}];
% set(handles.volumesChosen, 'String' , handles.in);
% guidata(hObject, handles);
saveState(handles);
close(handles.figure1);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isequal(get(hObject,'waitstatus'), 'waiting')
    uiresume(hObject);
else    
    delete(hObject);
end



function numSlices_Callback(hObject, eventdata, handles)
% hObject    handle to numSlices (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.header.numSlices = str2double(get(hObject,'String')); 
guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function numSlices_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numSlices (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xRes_Callback(hObject, eventdata, handles)
% hObject    handle to xRes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.header.xRes = str2double(get(hObject,'String')); 
guidata(hObject,handles);



% --- Executes during object creation, after setting all properties.
function xRes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xRes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yRes_Callback(hObject, eventdata, handles)
% hObject    handle to yRes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.header.yRes = str2double(get(hObject,'String')); 
guidata(hObject,handles);


% --- Executes during object creation, after setting all properties.
function yRes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yRes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tr_Callback(hObject, eventdata, handles)
% hObject    handle to tr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.header.TR = str2double(get(hObject,'String')); 
guidata(hObject,handles);
% --- Executes during object creation, after setting all properties.
function tr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function saveState(handles)
handles.stateVar(end+1) = str2double(get(handles.numSlices , 'String' ));	%selectAnatomicalRegions('Amygdala_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = str2double(get(handles.xRes , 'String' ));	%selectAnatomicalRegions('Amygdala_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = str2double(get(handles.yRes , 'String' ));	%selectAnatomicalRegions('Angular_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = str2double(get(handles.tr , 'String' ));	%selectAnatomicalRegions('Angular_R_Callback',hObject,eventdata,guidata(hObject));
stateMat = handles.stateVar;
S = dbstack('-completenames');
savePath = fileparts(S(1).file);
save(fullfile(savePath,'stateMatgetHeader.mat'),'stateMat')

function loadState(handles, eventdata, hObject)
S = dbstack('-completenames');
loadPath = fileparts(S(1).file);
filename = fullfile(loadPath,'stateMatgetHeader.mat');
i = 1; 
if exist(filename)
    load(filename);
    set(handles.numSlices ,'String', num2str(stateMat(i))); i = i + 1; hObject = handles.numSlices  ;    getHeader('numSlices_Callback',hObject,eventdata,guidata(hObject));
    set(handles.xRes ,'String', num2str(stateMat(i))); i = i + 1; hObject = handles.xRes  ;    getHeader('xRes_Callback',hObject,eventdata,guidata(hObject));
    set(handles.yRes ,'String', num2str(stateMat(i))); i = i + 1; hObject = handles.yRes  ;    getHeader('yRes_Callback',hObject,eventdata,guidata(hObject));
    set(handles.tr ,'String', num2str(stateMat(i))); i = i + 1; hObject = handles.tr   ;    getHeader('tr_Callback',hObject,eventdata,guidata(hObject));
    delete(filename);
end
