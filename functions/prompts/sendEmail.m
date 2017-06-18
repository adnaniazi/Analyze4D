function varargout = sendEmail(varargin)
% SENDEMAIL MATLAB code for sendEmail.fig
%      SENDEMAIL, by itself, creates a new SENDEMAIL or raises the existing
%      singleton*.
%
%      H = SENDEMAIL returns the handle to a new SENDEMAIL or the handle to
%      the existing singleton*.
%
%      SENDEMAIL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SENDEMAIL.M with the given input arguments.
%
%      SENDEMAIL('Property','Value',...) creates a new SENDEMAIL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sendEmail_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sendEmail_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sendEmail

% Last Modified by GUIDE v2.5 01-May-2012 15:44:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sendEmail_OpeningFcn, ...
                   'gui_OutputFcn',  @sendEmail_OutputFcn, ...
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


% --- Executes just before sendEmail is made visible.
function sendEmail_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sendEmail (see VARARGIN)
set(handles. figure1, 'Name', 'Send email');

% Choose default command line output for sendEmail
handles.output = hObject;
handles.stateVar                          = [];
% change the software icon
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
jframe=get(handles.figure1,'javaframe');
st = dbstack('-completenames');
path = st.file;
path = path(1:end-21-numel('sendEmail'));
jIcon=javax.swing.ImageIcon(fullfile(path,'assets','a4d.png'));
jframe.setFigureIcon(jIcon);

%get current folder
p = mfilename('fullpath');
folderPath = p(1:end-numel('sendEmail'));
handles.statesPath = fullfile(folderPath,'states');

loadState(handles, eventdata, hObject);


guidata(hObject,handles);
% UIWAIT makes sendEmail wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sendEmail_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in send.
function send_Callback(hObject, eventdata, handles)
% hObject    handle to send (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Define these variables appropriately:
dlg = ProgressDialog( ...
    'StatusMessage', 'Sending Message...', ...
    'FractionComplete', 0.25);

mail = 'errorreportanalyze4d@gmail.com'; %Your GMail email address
password = 'shearluck'; %Your GMail password
setpref('Internet','SMTP_Server','smtp.gmail.com');
setpref('Internet','E_mail',mail);
setpref('Internet','SMTP_Username',mail);
setpref('Internet','SMTP_Password',password);
props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.class', 'javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','465');

sendersEmail = get(handles.fromEmail,'String');
subject = get(handles.subject,'String');
message = get(handles.message,'String');

% get matlab version of the user
[v d] = version;
% get users operating system
comp = computer;
pc = num2str(ispc);
mac = num2str(ismac);
unix = num2str(isunix);
installed = areTheseToolboxesInstalled('Image Processing Toolbox');
if installed
    iptb = 'Installed';
else
    iptb = 'Not Installed';    
end

dlg. StatusMessage = 'Sending Message...';
dlg. FractionComplete = 0.75;

fromText = strcat('FROM: ',sendersEmail);
computerTypeText =  strcat('COMPUTER TYPE: ',comp);
isPcText = strcat('ISPC: ',pc);
isMacText = strcat('ISMAC: ',mac);
isUnixText = strcat('ISUNIX: ',unix);
iptbText = strcat('IMAGE PTB: ', iptb);
matlabVersionText = strcat('MATLAB VERSION: ', v);
messageText =  strcat('MESSAGE: ', message);
spaceText = '_____________________________________________';
message = [{fromText};{computerTypeText};{isPcText};{isMacText};{isUnixText};{iptbText};{matlabVersionText};{spaceText};{messageText}];
% message = strcat('FROM: ',sendersEmail, '  COMPUTER TYPE: ',comp,...
%     '  ISPC: ',pc, '  ISMAC: ',mac, '  ISUNIX: ',unix, '  IMAGE PTB: ', iptb,...
%     '  MATLAB VERSION: ', v, '  MESSAGE: ', message);
% Send the email. Note that the first input is the address you are sending the email to
sendmail(mail,subject,message);

dlg. StatusMessage = 'Message sent successfully...';
dlg. FractionComplete = 1;
pause(1);
delete(dlg);
set(handles.cancel,'String', 'Close');
msgbox('Thank you. Your email has been sent.','Successful', 'modal');


% --- Executes on button press in cancel.
function cancel_Callback(hObject, eventdata, handles)
% hObject    handle to cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close(handles.figure1);


function fromEmail_Callback(hObject, eventdata, handles)
% hObject    handle to fromEmail (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fromEmail as text
%        str2double(get(hObject,'String')) returns contents of fromEmail as a double


% --- Executes during object creation, after setting all properties.
function fromEmail_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fromEmail (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function subject_Callback(hObject, eventdata, handles)
% hObject    handle to subject (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of subject as text
%        str2double(get(hObject,'String')) returns contents of subject as a double


% --- Executes during object creation, after setting all properties.
function subject_CreateFcn(hObject, eventdata, handles)
% hObject    handle to subject (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function message_Callback(hObject, eventdata, handles)
% hObject    handle to message (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of message as text
%        str2double(get(hObject,'String')) returns contents of message as a double


% --- Executes during object creation, after setting all properties.
function message_CreateFcn(hObject, eventdata, handles)
% hObject    handle to message (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in saveEmail.
function saveEmail_Callback(hObject, eventdata, handles)
% hObject    handle to saveEmail (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% handles.stateVar{1,1} = get(handles.fromEmail , 'String' );	
handles.stateVar{2,1}  = get(handles.subject , 'String' );	
handles.stateVar{3,1}  = get(handles.message , 'String' );	
stateMat = handles.stateVar;
save(fullfile(handles.statesPath,'stateMatEmail.mat'),'stateMat');
msgbox('Draft has been saved. It will be loaded when you open this window again', 'Draft Saved');
set(handles.cancel,'String', 'Close');


function loadState(handles, eventdata, hObject)
filename = fullfile(handles.statesPath, 'stateMatEmail.mat');
i = 1; 
if exist(filename)
    load(filename);
%     set(handles.fromEmail ,'String',stateMat{1,1}); i = i + 1; hObject = handles.fromEmail  ;    sendEmail('fromEmail_Callback',hObject,eventdata,guidata(hObject));
    set(handles.subject ,'String', stateMat{2,1}); i = i + 1; hObject = handles.subject  ;    sendEmail('subject_Callback',hObject,eventdata,guidata(hObject));
    set(handles.message ,'String', stateMat{3,1}); i = i + 1; hObject = handles.message  ;    sendEmail('message_Callback',hObject,eventdata,guidata(hObject));
%     delete(filename);
end
