function varargout = updateAvailable(varargin)
% UPDATEAVAILABLE MATLAB code for updateAvailable.fig
%      UPDATEAVAILABLE, by itself, creates a new UPDATEAVAILABLE or raises the existing
%      singleton*.
%
%      H = UPDATEAVAILABLE returns the handle to a new UPDATEAVAILABLE or the handle to
%      the existing singleton*.
%
%      UPDATEAVAILABLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UPDATEAVAILABLE.M with the given input arguments.
%
%      UPDATEAVAILABLE('Property','Value',...) creates a new UPDATEAVAILABLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before updateAvailable_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to updateAvailable_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help updateAvailable

% Last Modified by GUIDE v2.5 04-May-2012 19:00:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @updateAvailable_OpeningFcn, ...
                   'gui_OutputFcn',  @updateAvailable_OutputFcn, ...
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


% --- Executes just before updateAvailable is made visible.
function updateAvailable_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to updateAvailable (see VARARGIN)

set(handles. figure1, 'Name', 'Update Available ...');

versionInfo = varargin{1,1};
set(handles.versionInfo, 'String',...
    strcat('You are using Analyze4D version',{' '}, versionInfo.currentVersion,...
    {' .'}, 'This version is', {' '}, num2str(versionInfo.numDaysOld),{' '}, 'days old.' ));

set(handles.wouldYouLikeDownload, 'String',...
    strcat('Would you like me to download the latest updated version (v', versionInfo.internetVersion, ') for you?'));

handles.versionInfo = versionInfo;
handles.output = hObject;

% change the software icon
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
jframe=get(handles.figure1,'javaframe');
st = dbstack('-completenames');
path = st.file;
path = path(1:end-21-numel('updateAvailable'));
jIcon=javax.swing.ImageIcon(fullfile(path,'assets','a4d.png'));
jframe.setFigureIcon(jIcon);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes updateAvailable wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = updateAvailable_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in NoNotNow.
function NoNotNow_Callback(hObject, eventdata, handles)
% hObject    handle to NoNotNow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(handles.figure1);

% --- Executes on button press in SureWhyNot.
function SureWhyNot_Callback(hObject, eventdata, handles)
% hObject    handle to SureWhyNot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.figure1, 'visible','off')
 downloadUpdate(handles.versionInfo.internetVersion);
close(handles.figure1);

% --- Executes on button press in dontShowTheMessageAgain.
function dontShowTheMessageAgain_Callback(hObject, eventdata, handles)
% hObject    handle to dontShowTheMessageAgain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dontShowTheMessageAgain
if get(hObject,'Value')
    handles.versionInfo.checkForUpdates = 0;
else
      handles.versionInfo.checkForUpdates = 1;
end
versionInfo = handles.versionInfo;
save(versionInfo.path, 'versionInfo');

function closeGui(hObject, eventdata, handles)
