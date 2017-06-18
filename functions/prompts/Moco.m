function varargout = Moco(varargin)
% MOCO MATLAB code for Moco.fig
%      MOCO, by itself, creates a new MOCO or raises the existing
%      singleton*.
%
%      H = MOCO returns the handle to a new MOCO or the handle to
%      the existing singleton*.
%
%      MOCO('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOCO.M with the given input arguments.
%
%      MOCO('Property','Value',...) creates a new MOCO or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Moco_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Moco_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Moco

% Last Modified by GUIDE v2.5 05-Apr-2012 10:32:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Moco_OpeningFcn, ...
                   'gui_OutputFcn',  @Moco_OutputFcn, ...
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


% --- Executes just before Moco is made visible.
function Moco_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Moco (see VARARGIN)

% Choose default command line output for Moco
% handles.output = hObject;
handles.in              = [];
handles.samplesToRead   = [];
% Update handles structure
guidata(hObject, handles);
set(handles. figure1, 'Name', 'Select Volumes in Moco series');
set(handles.volumesAvailable, 'String', strcat('You have a total of',{' '}, num2str(varargin{1}),{' '},'volumes available.'))

% change the software icon
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
jframe=get(handles.figure1,'javaframe');
st = dbstack('-completenames');
path = st.file;
path = path(1:end-25);
jIcon=javax.swing.ImageIcon(fullfile(path,'assets','a4d.png'));
jframe.setFigureIcon(jIcon);

% UIWAIT makes Moco wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Moco_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
% varargout{1} = handles.output;
varargout{1} = handles.samplesToRead;
delete(handles.figure1);

% --- Executes on button press in apply.
function apply_Callback(hObject, eventdata, handles)
% hObject    handle to apply (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(handles.figure1);

% --- Executes on button press in Cancel.
function Cancel_Callback(hObject, eventdata, handles)
% hObject    handle to Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(handles.figure1);


function volumesToRead_Callback(hObject, eventdata, handles)
% hObject    handle to volumesToRead (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of volumesToRead as text
%        str2double(get(hObject,'String')) returns contents of volumesToRead as a double


% --- Executes during object creation, after setting all properties.
function volumesToRead_CreateFcn(hObject, eventdata, handles)
% hObject    handle to volumesToRead (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles)
% hObject    handle to ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
in                      = get(handles.volumesToRead, 'String');
stringEntered           = eval(in);
handles.samplesToRead   = [handles.samplesToRead stringEntered];
handles.samplesToRead   = unique(handles.samplesToRead)
handles.in              = [handles.in;{in}];
set(handles.volumesChosen, 'String' , handles.in);
guidata(hObject, handles);


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
