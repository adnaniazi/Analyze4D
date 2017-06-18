function varargout = selectAnatomicalRegions(varargin)
%  SELECTANATOMICALREGIONS MATLAB code for selectAnatomicalRegions.fig
%      SELECTANATOMICALREGIONS, by itself, creates a new SELECTANATOMICALREGIONS or raises the existing
%      singleton*.
%
%      H = SELECTANATOMICALREGIONS returns the handle to a new SELECTANATOMICALREGIONS or the handle to
%      the existing singleton*.
%
%      SELECTANATOMICALREGIONS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SELECTANATOMICALREGIONS.M with the given input arguments.
%
%      SELECTANATOMICALREGIONS('Property','Value',...) creates a new SELECTANATOMICALREGIONS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before selectAnatomicalRegions_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to selectAnatomicalRegions_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help selectAnatomicalRegions

% Last Modified by GUIDE v2.5 10-Apr-2012 15:14:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @selectAnatomicalRegions_OpeningFcn, ...
    'gui_OutputFcn',  @selectAnatomicalRegions_OutputFcn, ...
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


% --- Executes just before selectAnatomicalRegions is made visible.
function selectAnatomicalRegions_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to selectAnatomicalRegions (see VARARGIN)
set(handles. figure1, 'Name', 'Choose regions to be masked');
handles.maskedRegionValues = [];
% Choose default command line output for selectAnatomicalRegions
handles.output = hObject;
% DEFINE THE GRAY VALUES
handles.value. Amygdala_L                 = 41;
handles.value. Amygdala_R                 = 42;
handles.value. Angular_L                  = 65;
handles.value. Angular_R                  = 66;
handles.value. Calcarine_L                = 43;
handles.value. Calcarine_R                = 44;
handles.value. Caudate_L                  = 71;
handles.value. Caudate_R                  = 72;
handles.value. Cerebelum_10_L             = 107;
handles.value. Cerebelum_10_R             = 108;
handles.value. Cerebelum_3_L              = 95;
handles.value. Cerebelum_3_R              = 96;
handles.value. Cerebelum_4_5_L            = 97;
handles.value. Cerebelum_4_5_R            = 98;
handles.value. Cerebelum_6_L              = 99;
handles.value. Cerebelum_6_R              = 100;
handles.value. Cerebelum_7b_L             = 101;
handles.value. Cerebelum_7b_R             = 102;
handles.value. Cerebelum_8_L              = 103;
handles.value. Cerebelum_8_R              = 104;
handles.value. Cerebelum_9_L              = 105;
handles.value. Cerebelum_9_R              = 106;
handles.value. Cerebelum_Crus1_L          = 91;
handles.value. Cerebelum_Crus1_R          = 92;
handles.value. Cerebelum_Crus2_L          = 93;
handles.value. Cerebelum_Crus2_R          = 94;
handles.value. Cingulum_Ant_L             = 31;
handles.value. Cingulum_Ant_R             = 32;
handles.value. Cingulum_Mid_L             = 33;
handles.value. Cingulum_Mid_R             = 34;
handles.value. Cingulum_Post_L            = 35;
handles.value. Cingulum_Post_R            = 36;
handles.value. Cuneus_L                   = 45;
handles.value. Cuneus_R                   = 46;
handles.value. Frontal_Inf_Oper_L         = 11;
handles.value. Frontal_Inf_Oper_R         = 12;
handles.value. Frontal_Inf_Orb_L          = 15;
handles.value. Frontal_Inf_Orb_R          = 16;
handles.value. Frontal_Inf_Tri_L          = 13;
handles.value. Frontal_Inf_Tri_R          = 14;
handles.value. Frontal_Med_Orb_L          = 25; %
handles.value. Frontal_Med_Orb_R          = 26; %
handles.value. Frontal_Mid_L              = 7;
handles.value. Frontal_Mid_R              = 8;
handles.value. Frontal_Mid_Orb_L          = 9;  % 25
handles.value. Frontal_Mid_Orb_R          = 10; % 26
handles.value. Frontal_Sup_L              = 3;
handles.value. Frontal_Sup_R              = 4;
handles.value. Frontal_Sup_Medial_L       = 23;
handles.value. Frontal_Sup_Medial_R       = 24;
handles.value. Frontal_Sup_Orb_L          = 5;
handles.value. Frontal_Sup_Orb_R          = 6;
handles.value. Fusiform_L                 = 55;
handles.value. Fusiform_R                 = 56;
handles.value. Heschl_L                   = 79;
handles.value. Heschl_R                   = 80;
handles.value. Hippocampus_L              = 37;
handles.value. Hippocampus_R              = 38;
handles.value. Insula_L                   = 29;
handles.value. Insula_R                   = 30;
handles.value. Lingual_L                  = 47;
handles.value. Lingual_R                  = 48;
handles.value. Occipital_Inf_L            = 53;
handles.value. Occipital_Inf_R            = 54;
handles.value. Occipital_Mid_L            = 51;
handles.value. Occipital_Mid_R            = 52;
handles.value. Occipital_Sup_L            = 49;
handles.value. Occipital_Sup_R            = 50;
handles.value. Olfactory_L                = 21;
handles.value. Olfactory_R                = 22;
handles.value. Pallidum_L                 = 75;
handles.value. Pallidum_R                 = 76;
handles.value. Paracentral_Lobule_L       = 69;
handles.value. Paracentral_Lobule_R       = 70;
handles.value. ParaHippocampal_L          = 39;
handles.value. ParaHippocampal_R          = 40;
handles.value. Parietal_Inf_L             = 61;
handles.value. Parietal_Inf_R             = 62;
handles.value. Parietal_Sup_L             = 59;
handles.value. Parietal_Sup_R             = 60;
handles.value. Postcentral_L              = 57;
handles.value. Postcentral_R              = 58;
handles.value. Precentral_L               = 1;
handles.value. Precentral_R               = 2;
handles.value. Precuneus_L                = 67;
handles.value. Precuneus_R                = 68;
handles.value. Putamen_L                  = 73;
handles.value. Putamen_R                  = 74;
handles.value. Rectus_L                   = 27;
handles.value. Rectus_R                   = 28;
handles.value. Rolandic_Oper_L            = 17;
handles.value. Rolandic_Oper_R            = 18;
handles.value. Supp_Motor_Area_L          = 19;
handles.value. Supp_Motor_Area_R          = 20;
handles.value. SupraMarginal_L            = 63;
handles.value. SupraMarginal_R            = 64;
handles.value. Temporal_Inf_L             = 89;
handles.value. Temporal_Inf_R             = 90;
handles.value. Temporal_Mid_L             = 85;
handles.value. Temporal_Mid_R             = 86;
handles.value. Temporal_Pole_Mid_L        = 87;
handles.value. Temporal_Pole_Mid_R        = 88;
handles.value. Temporal_Pole_Sup_L        = 83;
handles.value. Temporal_Pole_Sup_R        = 84;
handles.value. Temporal_Sup_L             = 81;
handles.value. Temporal_Sup_R             = 82;
handles.value. Thalamus_L                 = 77;
handles.value. Thalamus_R                 = 78;
handles.value. Vermis_1_2                 = 109;
handles.value. Vermis_10                  = 116;
handles.value. Vermis_3                   = 110;
handles.value. Vermis_4_5                 = 111;
handles.value. Vermis_6                   = 112;
handles.value. Vermis_7                   = 113;
handles.value. Vermis_8                   = 114;
handles.value. Vermis_9                   = 115;
handles.stateVar                          = [];

% % DEFINE THE GRAY VALUES
% handles.value.Amygdala_L                  = 4201;
% handles.value. Amygdala_R                 = 4202;
% handles.value. Angular_L                  = 6221;
% handles.value. Angular_R                  = 6222;
% handles.value. Calcarine_L                = 5001;
% handles.value. Calcarine_R                = 5002;
% handles.value. Caudate_L                  = 7001;
% handles.value. Caudate_R                  = 7002;
% handles.value. Cerebelum_10_L             = 9081;
% handles.value. Cerebelum_10_R             = 9082;
% handles.value. Cerebelum_3_L              = 9021;
% handles.value. Cerebelum_3_R              = 9022;
% handles.value. Cerebelum_4_5_L            = 9031;
% handles.value. Cerebelum_4_5_R            = 9032;
% handles.value. Cerebelum_6_L              = 9041;
% handles.value. Cerebelum_6_R              = 9042;
% handles.value. Cerebelum_7b_L             = 9051;
% handles.value. Cerebelum_7b_R             = 9052;
% handles.value. Cerebelum_8_L              = 9061;
% handles.value. Cerebelum_8_R              = 9062;
% handles.value. Cerebelum_9_L              = 9071;
% handles.value. Cerebelum_9_R              = 9072;
% handles.value. Cerebelum_Crus1_L          = 9001;
% handles.value. Cerebelum_Crus1_R          = 9002;
% handles.value. Cerebelum_Crus2_L          = 9011;
% handles.value. Cerebelum_Crus2_R          = 9012;
% handles.value. Cingulum_Ant_L             = 4001;
% handles.value. Cingulum_Ant_R             = 4002;
% handles.value. Cingulum_Mid_L             = 4011;
% handles.value. Cingulum_Mid_R             = 4012;
% handles.value. Cingulum_Post_L            = 4021;
% handles.value. Cingulum_Post_R            = 4022;
% handles.value. Cuneus_L                   = 5011;
% handles.value. Cuneus_R                   = 5012;
% handles.value. Frontal_Inf_Oper_L         = 2301;
% handles.value. Frontal_Inf_Oper_R         = 2302;
% handles.value. Frontal_Inf_Orb_L          = 2321;
% handles.value. Frontal_Inf_Orb_R          = 2322;
% handles.value. Frontal_Inf_Tri_L          = 2311;
% handles.value. Frontal_Inf_Tri_R          = 2312;
% handles.value. Frontal_Med_Orb_L          = 2611;
% handles.value. Frontal_Med_Orb_R          = 2612;
% handles.value. Frontal_Mid_L              = 2201;
% handles.value. Frontal_Mid_R              = 2202;
% handles.value. Frontal_Mid_Orb_L          = 2211;
% handles.value. Frontal_Mid_Orb_R          = 2212;
% handles.value. Frontal_Sup_L              = 2101;
% handles.value. Frontal_Sup_R              = 2102;
% handles.value. Frontal_Sup_Medial_L       = 2601;
% handles.value. Frontal_Sup_Medial_R       = 2602;
% handles.value. Frontal_Sup_Orb_L          = 2111;
% handles.value. Frontal_Sup_Orb_R          = 2112;
% handles.value. Fusiform_L                 = 5401;
% handles.value. Fusiform_R                 = 5402;
% handles.value. Heschl_L                   = 8101;
% handles.value. Heschl_R                   = 8102;
% handles.value. Hippocampus_L              = 4101;
% handles.value. Hippocampus_R              = 4102;
% handles.value. Insula_L                   = 3001;
% handles.value. Insula_R                   = 3002;
% handles.value. Lingual_L                  = 5021;
% handles.value. Lingual_R                  = 5022;
% handles.value. Occipital_Inf_L            = 5301;
% handles.value. Occipital_Inf_R            = 5302;
% handles.value. Occipital_Mid_L            = 5201;
% handles.value. Occipital_Mid_R            = 5202;
% handles.value. Occipital_Sup_L            = 5101;
% handles.value. Occipital_Sup_R            = 5102;
% handles.value. Olfactory_L                = 2501;
% handles.value. Olfactory_R                = 2502;
% handles.value. Pallidum_L                 = 7021;
% handles.value. Pallidum_R                 = 7022;
% handles.value. Paracentral_Lobule_L       = 6401;
% handles.value. Paracentral_Lobule_R       = 6402;
% handles.value. ParaHippocampal_L          = 4111;
% handles.value. ParaHippocampal_R          = 4112;
% handles.value. Parietal_Inf_L             = 6201;
% handles.value. Parietal_Inf_R             = 6202;
% handles.value. Parietal_Sup_L             = 6101;
% handles.value. Parietal_Sup_R             = 6102;
% handles.value. Postcentral_L              = 6001;
% handles.value. Postcentral_R              = 6002;
% handles.value. Precentral_L               = 2001;
% handles.value. Precentral_R               = 2002;
% handles.value. Precuneus_L                = 6301;
% handles.value. Precuneus_R                = 6302;
% handles.value. Putamen_L                  = 7011;
% handles.value. Putamen_R                  = 7012;
% handles.value. Rectus_L                   = 2701;
% handles.value. Rectus_R                   = 2702;
% handles.value. Rolandic_Oper_L            = 2331;
% handles.value. Rolandic_Oper_R            = 2332;
% handles.value. Supp_Motor_Area_L          = 2401;
% handles.value. Supp_Motor_Area_R          = 2402;
% handles.value. SupraMarginal_L            = 6211;
% handles.value. SupraMarginal_R            = 6212;
% handles.value. Temporal_Inf_L             = 8301;
% handles.value. Temporal_Inf_R             = 8302;
% handles.value. Temporal_Mid_L             = 8201;
% handles.value. Temporal_Mid_R             = 8202;
% handles.value. Temporal_Pole_Mid_L        = 8211;
% handles.value. Temporal_Pole_Mid_R        = 8212;
% handles.value. Temporal_Pole_Sup_L        = 8119;
% handles.value. Temporal_Pole_Sup_R        = 8122;
% handles.value. Temporal_Sup_L             = 8111;
% handles.value. Temporal_Sup_R             = 8112;
% handles.value. Thalamus_L                 = 7101;
% handles.value. Thalamus_R                 = 7102;
% handles.value. Vermis_1_2                 = 9100;
% handles.value. Vermis_10                  = 9170;
% handles.value. Vermis_3                   = 9110;
% handles.value. Vermis_4_5                 = 9120;
% handles.value. Vermis_6                   = 9130;
% handles.value. Vermis_7                   = 9140;
% handles.value. Vermis_8                   = 9150;
% handles.value. Vermis_9                   = 9160;
% handles.stateVar                          = [];
% 


% Update handles structure
guidata(hObject, handles);
loadState(handles, eventdata, hObject);

% change the software icon
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
jframe=get(handles.figure1,'javaframe');
st = dbstack('-completenames');
path = st.file;
path = path(1:end-44);
jIcon=javax.swing.ImageIcon(fullfile(path,'assets','a4d.png'));
jframe.setFigureIcon(jIcon);


% UIWAIT makes selectAnatomicalRegions wait for user response (see UIRESUME)
uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = selectAnatomicalRegions_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
X =  handles.maskedRegionValues;
[Xs, SortVec] = sort(X(:));
UV(SortVec) = ([1; diff(Xs)] ~= 0);
Y = X(UV);
varargout{1} = Y;
delete(handles.figure1);

% --- Executes on button press in all.
function all_Callback(hObject, eventdata, handles)
% hObject    handle to all (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle handles.stateVar of all


% --- Executes on button press in Amygdala_L.
function Amygdala_L_Callback(hObject, eventdata, handles)
% hObject    handle to Amygdala_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Amygdala_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Amygdala_L)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Amygdala_L


% --- Executes on button press in Amygdala_R.
function Amygdala_R_Callback(hObject, eventdata, handles)
% hObject    handle to Amygdala_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Amygdala_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Amygdala_R)) = [];
end
guidata(hObject,handles);

% Hint: get(hObject,'Value') returns toggle handles.stateVar of Amygdala_R


% --- Executes on button press in Angular_L.
function Angular_L_Callback(hObject, eventdata, handles)
% hObject    handle to Angular_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Angular_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Angular_L)) = [];
end
guidata(hObject,handles);

% Hint: get(hObject,'Value') returns toggle handles.stateVar of Angular_L


% --- Executes on button press in Angular_R.
function Angular_R_Callback(hObject, eventdata, handles)
% hObject    handle to Angular_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Angular_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Angular_R)) = [];
end
guidata(hObject,handles);

% Hint: get(hObject,'Value') returns toggle handles.stateVar of Angular_R


% --- Executes on button press in Calcarine_L.
function Calcarine_L_Callback(hObject, eventdata, handles)
% hObject    handle to Calcarine_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Calcarine_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Calcarine_L)) = [];
end
guidata(hObject,handles);

% Hint: get(hObject,'Value') returns toggle handles.stateVar of Calcarine_L


% --- Executes on button press in Calcarine_R.
function Calcarine_R_Callback(hObject, eventdata, handles)
% hObject    handle to Calcarine_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Calcarine_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Calcarine_R)) = [];
end
guidata(hObject,handles);

% Hint: get(hObject,'Value') returns toggle handles.stateVar of Calcarine_R


% --- Executes on button press in Caudate_L.
function Caudate_L_Callback(hObject, eventdata, handles)
% hObject    handle to Caudate_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Caudate_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Caudate_L)) = [];
end
guidata(hObject,handles);

% Hint: get(hObject,'Value') returns toggle handles.stateVar of Caudate_L


% --- Executes on button press in Caudate_R.
function Caudate_R_Callback(hObject, eventdata, handles)
% hObject    handle to Caudate_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Caudate_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Caudate_R)) = [];
end
guidata(hObject,handles);

% Hint: get(hObject,'Value') returns toggle handles.stateVar of Caudate_R


% --- Executes on button press in Cerebelum_10_L.
function Cerebelum_10_L_Callback(hObject, eventdata, handles)
% hObject    handle to Cerebelum_10_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Cerebelum_10_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Cerebelum_10_L)) = [];
end
guidata(hObject,handles);

% Hint: get(hObject,'Value') returns toggle handles.stateVar of Cerebelum_10_L


% --- Executes on button press in Cerebelum_10_R.
function Cerebelum_10_R_Callback(hObject, eventdata, handles)
% hObject    handle to Cerebelum_10_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Cerebelum_10_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Cerebelum_10_R)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Cerebelum_10_R


% --- Executes on button press in Cerebelum_3_L.
function Cerebelum_3_L_Callback(hObject, eventdata, handles)
% hObject    handle to Cerebelum_3_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Cerebelum_3_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Cerebelum_3_L)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Cerebelum_3_L


% --- Executes on button press in Cerebelum_3_R.
function Cerebelum_3_R_Callback(hObject, eventdata, handles)
% hObject    handle to Cerebelum_3_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Cerebelum_3_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Cerebelum_3_R)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Cerebelum_3_R


% --- Executes on button press in Cerebelum_4_5_L.
function Cerebelum_4_5_L_Callback(hObject, eventdata, handles)
% hObject    handle to Cerebelum_4_5_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Cerebelum_4_5_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Cerebelum_4_5_L)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Cerebelum_4_5_L


% --- Executes on button press in Cerebelum_4_5_R.
function Cerebelum_4_5_R_Callback(hObject, eventdata, handles)
% hObject    handle to Cerebelum_4_5_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Cerebelum_4_5_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Cerebelum_4_5_R)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Cerebelum_4_5_R


% --- Executes on button press in Cerebelum_6_L.
function Cerebelum_6_L_Callback(hObject, eventdata, handles)
% hObject    handle to Cerebelum_6_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Cerebelum_6_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Cerebelum_6_L)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Cerebelum_6_L


% --- Executes on button press in Cerebelum_6_R.
function Cerebelum_6_R_Callback(hObject, eventdata, handles)
% hObject    handle to Cerebelum_6_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Cerebelum_6_R
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Cerebelum_6_R)) = [];
end
guidata(hObject,handles);

% Hint: get(hObject,'Value') returns toggle handles.stateVar of Cerebelum_6_R


% --- Executes on button press in Cerebelum_7b_L.
function Cerebelum_7b_L_Callback(hObject, eventdata, handles)
% hObject    handle to Cerebelum_7b_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Cerebelum_7b_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Cerebelum_7b_L)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Cerebelum_7b_L


% --- Executes on button press in Cerebelum_7b_R.
function Cerebelum_7b_R_Callback(hObject, eventdata, handles)
% hObject    handle to Cerebelum_7b_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Cerebelum_7b_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Cerebelum_7b_R)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Cerebelum_7b_R


% --- Executes on button press in Cerebelum_8_L.
function Cerebelum_8_L_Callback(hObject, eventdata, handles)
% hObject    handle to Cerebelum_8_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Cerebelum_8_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Cerebelum_8_L)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Cerebelum_8_L


% --- Executes on button press in Cerebelum_8_R.
function Cerebelum_8_R_Callback(hObject, eventdata, handles)
% hObject    handle to Cerebelum_8_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Cerebelum_8_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Cerebelum_8_R)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Cerebelum_8_R


% --- Executes on button press in Cerebelum_9_L.
function Cerebelum_9_L_Callback(hObject, eventdata, handles)
% hObject    handle to Cerebelum_9_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Cerebelum_9_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Cerebelum_9_L)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Cerebelum_9_L


% --- Executes on button press in Cerebelum_9_R.
function Cerebelum_9_R_Callback(hObject, eventdata, handles)
% hObject    handle to Cerebelum_9_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Cerebelum_9_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Cerebelum_9_R)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Cerebelum_9_R


% --- Executes on button press in Cerebelum_Crus1_L.
function Cerebelum_Crus1_L_Callback(hObject, eventdata, handles)
% hObject    handle to Cerebelum_Crus1_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Cerebelum_Crus1_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Cerebelum_Crus1_L)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Cerebelum_Crus1_L


% --- Executes on button press in Cerebelum_Crus1_R.
function Cerebelum_Crus1_R_Callback(hObject, eventdata, handles)
% hObject    handle to Cerebelum_Crus1_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Cerebelum_Crus1_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Cerebelum_Crus1_R)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Cerebelum_Crus1_R


% --- Executes on button press in Cerebelum_Crus2_L.
function Cerebelum_Crus2_L_Callback(hObject, eventdata, handles)
% hObject    handle to Cerebelum_Crus2_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Cerebelum_Crus2_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Cerebelum_Crus2_L)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Cerebelum_Crus2_L


% --- Executes on button press in Cerebelum_Crus2_R.
function Cerebelum_Crus2_R_Callback(hObject, eventdata, handles)
% hObject    handle to Cerebelum_Crus2_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Cerebelum_Crus2_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Cerebelum_Crus2_R)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Cerebelum_Crus2_R


% --- Executes on button press in Cingulum_Ant_L.
function Cingulum_Ant_L_Callback(hObject, eventdata, handles)
% hObject    handle to Cingulum_Ant_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Cingulum_Ant_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Cingulum_Ant_L)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Cingulum_Ant_L


% --- Executes on button press in Cingulum_Ant_R.
function Cingulum_Ant_R_Callback(hObject, eventdata, handles)
% hObject    handle to Cingulum_Ant_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Cingulum_Ant_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Cingulum_Ant_R)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Cingulum_Ant_R


% --- Executes on button press in Cingulum_Mid_L.
function Cingulum_Mid_L_Callback(hObject, eventdata, handles)
% hObject    handle to Cingulum_Mid_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Cingulum_Mid_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Cingulum_Mid_L)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Cingulum_Mid_L


% --- Executes on button press in Cingulum_Mid_R.
function Cingulum_Mid_R_Callback(hObject, eventdata, handles)
% hObject    handle to Cingulum_Mid_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Cingulum_Mid_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Cingulum_Mid_R)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Cingulum_Mid_R


% --- Executes on button press in Cingulum_Post_L.
function Cingulum_Post_L_Callback(hObject, eventdata, handles)
% hObject    handle to Cingulum_Post_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Cingulum_Post_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Cingulum_Post_L)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Cingulum_Post_L


% --- Executes on button press in Cingulum_Post_R.
function Cingulum_Post_R_Callback(hObject, eventdata, handles)
% hObject    handle to Cingulum_Post_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Cingulum_Post_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Cingulum_Post_R)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Cingulum_Post_R


% --- Executes on button press in Cuneus_L.
function Cuneus_L_Callback(hObject, eventdata, handles)
% hObject    handle to Cuneus_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Cuneus_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Cuneus_L)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Cuneus_L


% --- Executes on button press in Cuneus_R.
function Cuneus_R_Callback(hObject, eventdata, handles)
% hObject    handle to Cuneus_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Cuneus_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Cuneus_R)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Cuneus_R


% --- Executes on button press in Frontal_Inf_Oper_L.
function Frontal_Inf_Oper_L_Callback(hObject, eventdata, handles)
% hObject    handle to Frontal_Inf_Oper_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Frontal_Inf_Oper_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Frontal_Inf_Oper_L)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Frontal_Inf_Oper_L


% --- Executes on button press in Frontal_Inf_Oper_R.
function Frontal_Inf_Oper_R_Callback(hObject, eventdata, handles)
% hObject    handle to Frontal_Inf_Oper_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Frontal_Inf_Oper_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Frontal_Inf_Oper_R)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Frontal_Inf_Oper_R


% --- Executes on button press in Frontal_Inf_Orb_L.
function Frontal_Inf_Orb_L_Callback(hObject, eventdata, handles)
% hObject    handle to Frontal_Inf_Orb_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Frontal_Inf_Orb_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Frontal_Inf_Orb_L)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Frontal_Inf_Orb_L


% --- Executes on button press in Frontal_Inf_Orb_R.
function Frontal_Inf_Orb_R_Callback(hObject, eventdata, handles)
% hObject    handle to Frontal_Inf_Orb_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Frontal_Inf_Orb_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Frontal_Inf_Orb_R)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Frontal_Inf_Orb_R


% --- Executes on button press in Frontal_Inf_Tri_L.
function Frontal_Inf_Tri_L_Callback(hObject, eventdata, handles)
% hObject    handle to Frontal_Inf_Tri_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Frontal_Inf_Tri_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Frontal_Inf_Tri_L)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Frontal_Inf_Tri_L


% --- Executes on button press in Frontal_Inf_Tri_R.
function Frontal_Inf_Tri_R_Callback(hObject, eventdata, handles)
% hObject    handle to Frontal_Inf_Tri_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Frontal_Inf_Tri_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Frontal_Inf_Tri_R)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Frontal_Inf_Tri_R


% --- Executes on button press in Frontal_Med_Orb_L.
function Frontal_Med_Orb_L_Callback(hObject, eventdata, handles)
% hObject    handle to Frontal_Med_Orb_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Frontal_Med_Orb_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Frontal_Med_Orb_L)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Frontal_Med_Orb_L


% --- Executes on button press in Frontal_Med_Orb_R.
function Frontal_Med_Orb_R_Callback(hObject, eventdata, handles)
% hObject    handle to Frontal_Med_Orb_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Frontal_Med_Orb_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Frontal_Med_Orb_R)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Frontal_Med_Orb_R


% --- Executes on button press in Frontal_Mid_L.
function Frontal_Mid_L_Callback(hObject, eventdata, handles)
% hObject    handle to Frontal_Mid_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Frontal_Mid_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Frontal_Mid_L)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Frontal_Mid_L


% --- Executes on button press in checkbox51.
function checkbox51_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox51 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle handles.stateVar of checkbox51


% --- Executes on button press in Frontal_Mid_Orb_L.
function Frontal_Mid_Orb_L_Callback(hObject, eventdata, handles)
% hObject    handle to Frontal_Mid_Orb_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Frontal_Mid_Orb_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Frontal_Mid_Orb_L)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Frontal_Mid_Orb_L


% --- Executes on button press in Frontal_Mid_Orb_R.
function Frontal_Mid_Orb_R_Callback(hObject, eventdata, handles)
% hObject    handle to Frontal_Mid_Orb_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Frontal_Mid_Orb_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Frontal_Mid_Orb_R)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Frontal_Mid_Orb_R


% --- Executes on button press in Frontal_Mid_R.
function Frontal_Mid_R_Callback(hObject, eventdata, handles)
% hObject    handle to Frontal_Mid_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Frontal_Mid_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Frontal_Mid_R)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Frontal_Mid_R


% --- Executes on button press in Frontal_Sup_L.
function Frontal_Sup_L_Callback(hObject, eventdata, handles)
% hObject    handle to Frontal_Sup_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Frontal_Sup_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Frontal_Sup_L)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Frontal_Sup_L


% --- Executes on button press in Frontal_Sup_Medial_L.
function Frontal_Sup_Medial_L_Callback(hObject, eventdata, handles)
% hObject    handle to Frontal_Sup_Medial_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Frontal_Sup_Medial_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Frontal_Sup_Medial_L)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Frontal_Sup_Medial_L


% --- Executes on button press in Frontal_Sup_Medial_R.
function Frontal_Sup_Medial_R_Callback(hObject, eventdata, handles)
% hObject    handle to Frontal_Sup_Medial_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Frontal_Sup_Medial_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Frontal_Sup_Medial_R)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Frontal_Sup_Medial_R


% --- Executes on button press in Frontal_Sup_Orb_L.
function Frontal_Sup_Orb_L_Callback(hObject, eventdata, handles)
% hObject    handle to Frontal_Sup_Orb_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Frontal_Sup_Orb_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Frontal_Sup_Orb_L)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Frontal_Sup_Orb_L


% --- Executes on button press in Frontal_Sup_Orb_R.
function Frontal_Sup_Orb_R_Callback(hObject, eventdata, handles)
% hObject    handle to Frontal_Sup_Orb_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Frontal_Sup_Orb_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Frontal_Sup_Orb_R)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Frontal_Sup_Orb_R


% --- Executes on button press in Frontal_Sup_R.
function Frontal_Sup_R_Callback(hObject, eventdata, handles)
% hObject    handle to Frontal_Sup_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Frontal_Sup_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Frontal_Sup_R)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Frontal_Sup_R


% --- Executes on button press in Fusiform_L.
function Fusiform_L_Callback(hObject, eventdata, handles)
% hObject    handle to Fusiform_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Fusiform_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Fusiform_L)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Fusiform_L


% --- Executes on button press in Fusiform_R.
function Fusiform_R_Callback(hObject, eventdata, handles)
% hObject    handle to Fusiform_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Fusiform_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Fusiform_R)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Fusiform_R


% --- Executes on button press in Heschl_L.
function Heschl_L_Callback(hObject, eventdata, handles)
% hObject    handle to Heschl_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Heschl_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Heschl_L)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Heschl_L


% --- Executes on button press in Heschl_R.
function Heschl_R_Callback(hObject, eventdata, handles)
% hObject    handle to Heschl_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Heschl_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Heschl_R)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Heschl_R


% --- Executes on button press in Hippocampus_L.
function Hippocampus_L_Callback(hObject, eventdata, handles)
% hObject    handle to Hippocampus_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Hippocampus_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Hippocampus_L)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Hippocampus_L


% --- Executes on button press in Hippocampus_R.
function Hippocampus_R_Callback(hObject, eventdata, handles)
% hObject    handle to Hippocampus_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Hippocampus_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Hippocampus_R)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Hippocampus_R


% --- Executes on button press in Insula_L.
function Insula_L_Callback(hObject, eventdata, handles)
% hObject    handle to Insula_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Insula_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Insula_L)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Insula_L


% --- Executes on button press in Insula_R.
function Insula_R_Callback(hObject, eventdata, handles)
% hObject    handle to Insula_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Insula_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Insula_R)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Insula_R


% --- Executes on button press in Lingual_L.
function Lingual_L_Callback(hObject, eventdata, handles)
% hObject    handle to Lingual_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Lingual_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Lingual_L)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Lingual_L


% --- Executes on button press in Lingual_R.
function Lingual_R_Callback(hObject, eventdata, handles)
% hObject    handle to Lingual_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Lingual_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Lingual_R)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Lingual_R


% --- Executes on button press in Occipital_Inf_L.
function Occipital_Inf_L_Callback(hObject, eventdata, handles)
% hObject    handle to Occipital_Inf_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Occipital_Inf_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Occipital_Inf_L)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Occipital_Inf_L


% --- Executes on button press in Occipital_Inf_R.
function Occipital_Inf_R_Callback(hObject, eventdata, handles)
% hObject    handle to Occipital_Inf_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Occipital_Inf_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Occipital_Inf_R)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Occipital_Inf_R


% --- Executes on button press in Occipital_Mid_L.
function Occipital_Mid_L_Callback(hObject, eventdata, handles)
% hObject    handle to Occipital_Mid_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Occipital_Mid_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Occipital_Mid_L)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Occipital_Mid_L


% --- Executes on button press in Occipital_Mid_R.
function Occipital_Mid_R_Callback(hObject, eventdata, handles)
% hObject    handle to Occipital_Mid_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Occipital_Mid_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Occipital_Mid_R)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Occipital_Mid_R


% --- Executes on button press in Occipital_Sup_L.
function Occipital_Sup_L_Callback(hObject, eventdata, handles)
% hObject    handle to Occipital_Sup_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Occipital_Sup_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Occipital_Sup_L)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Occipital_Sup_L


% --- Executes on button press in Occipital_Sup_R.
function Occipital_Sup_R_Callback(hObject, eventdata, handles)
% hObject    handle to Occipital_Sup_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value. Occipital_Sup_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Occipital_Sup_R)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Occipital_Sup_R


% --- Executes on button press in Olfactory_L.
function Olfactory_L_Callback(hObject, eventdata, handles)
% hObject    handle to Olfactory_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value. Olfactory_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Olfactory_L)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Olfactory_L


% --- Executes on button press in Olfactory_R.
function Olfactory_R_Callback(hObject, eventdata, handles)
% hObject    handle to Olfactory_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value. Olfactory_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Olfactory_R)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Olfactory_R


% --- Executes on button press in Pallidum_L.
function Pallidum_L_Callback(hObject, eventdata, handles)
% hObject    handle to Pallidum_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value. Pallidum_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Pallidum_L)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Pallidum_L


% --- Executes on button press in Pallidum_R.
function Pallidum_R_Callback(hObject, eventdata, handles)
% hObject    handle to Pallidum_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value. Pallidum_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Pallidum_R)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Pallidum_R


% --- Executes on button press in Paracentral_Lobule_L.
function Paracentral_Lobule_L_Callback(hObject, eventdata, handles)
% hObject    handle to Paracentral_Lobule_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value. Paracentral_Lobule_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Paracentral_Lobule_L)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Paracentral_Lobule_L


% --- Executes on button press in Paracentral_Lobule_R.
function Paracentral_Lobule_R_Callback(hObject, eventdata, handles)
% hObject    handle to Paracentral_Lobule_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Paracentral_Lobule_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Paracentral_Lobule_R)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of Paracentral_Lobule_R


% --- Executes on button press in ParaHippocampal_L.
function ParaHippocampal_L_Callback(hObject, eventdata, handles)
% hObject    handle to ParaHippocampal_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.ParaHippocampal_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.ParaHippocampal_L)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of ParaHippocampal_L


% --- Executes on button press in ParaHippocampal_R.
function ParaHippocampal_R_Callback(hObject, eventdata, handles)
% hObject    handle to ParaHippocampal_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.ParaHippocampal_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.ParaHippocampal_R)) = [];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle handles.stateVar of ParaHippocampal_R


% --- Executes on button press in Parietal_Inf_L.
function Parietal_Inf_L_Callback(hObject, eventdata, handles)
% hObject    handle to Parietal_Inf_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Parietal_Inf_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Parietal_Inf_L)) = [];
end
guidata(hObject,handles);

% Hint: get(hObject,'Value') returns toggle handles.stateVar of Parietal_Inf_L


% --- Executes on button press in Parietal_Inf_R.
function Parietal_Inf_R_Callback(hObject, eventdata, handles)
% hObject    handle to Parietal_Inf_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Parietal_Inf_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Parietal_Inf_R)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Parietal_Inf_R


% --- Executes on button press in Parietal_Sup_L.
function Parietal_Sup_L_Callback(hObject, eventdata, handles)
% hObject    handle to Parietal_Sup_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Parietal_Sup_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Parietal_Sup_L)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Parietal_Sup_L


% --- Executes on button press in Parietal_Sup_R.
function Parietal_Sup_R_Callback(hObject, eventdata, handles)
% hObject    handle to Parietal_Sup_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Parietal_Sup_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Parietal_Sup_R)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Parietal_Sup_R


% --- Executes on button press in Postcentral_L.
function Postcentral_L_Callback(hObject, eventdata, handles)
% hObject    handle to Postcentral_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Postcentral_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Postcentral_L)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Postcentral_L


% --- Executes on button press in Postcentral_R.
function Postcentral_R_Callback(hObject, eventdata, handles)
% hObject    handle to Postcentral_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Postcentral_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Postcentral_R)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Postcentral_R


% --- Executes on button press in Precentral_L.
function Precentral_L_Callback(hObject, eventdata, handles)
% hObject    handle to Precentral_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Precentral_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Precentral_L)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Precentral_L


% --- Executes on button press in Precentral_R.
function Precentral_R_Callback(hObject, eventdata, handles)
% hObject    handle to Precentral_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Precentral_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Precentral_R)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Precentral_R



% --- Executes on button press in Precuneus_L.
function Precuneus_L_Callback(hObject, eventdata, handles)
% hObject    handle to Precuneus_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Precuneus_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Precuneus_L)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Precuneus_L


% --- Executes on button press in Precuneus_R.
function Precuneus_R_Callback(hObject, eventdata, handles)
% hObject    handle to Precuneus_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Precuneus_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Precuneus_R)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Precuneus_R


% --- Executes on button press in Putamen_L.
function Putamen_L_Callback(hObject, eventdata, handles)
% hObject    handle to Putamen_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles.value.Putamen_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Putamen_L)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Putamen_L


% --- Executes on button press in Putamen_R.
function Putamen_R_Callback(hObject, eventdata, handles)
% hObject    handle to Putamen_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Putamen_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Putamen_R)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Putamen_R


% --- Executes on button press in Rectus_L.
function Rectus_L_Callback(hObject, eventdata, handles)
% hObject    handle to Rectus_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Rectus_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Rectus_L)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Rectus_L


% --- Executes on button press in Rectus_R.
function Rectus_R_Callback(hObject, eventdata, handles)
% hObject    handle to Rectus_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Rectus_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Rectus_R)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Rectus_R


% --- Executes on button press in Rolandic_Oper_L.
function Rolandic_Oper_L_Callback(hObject, eventdata, handles)
% hObject    handle to Rolandic_Oper_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Rolandic_Oper_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Rolandic_Oper_L)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Rolandic_Oper_L


% --- Executes on button press in Rolandic_Oper_R.
function Rolandic_Oper_R_Callback(hObject, eventdata, handles)
% hObject    handle to Rolandic_Oper_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Rolandic_Oper_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Rolandic_Oper_R)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Rolandic_Oper_R


% --- Executes on button press in Supp_Motor_Area_L.
function Supp_Motor_Area_L_Callback(hObject, eventdata, handles)
% hObject    handle to Supp_Motor_Area_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Supp_Motor_Area_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Supp_Motor_Area_L)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Supp_Motor_Area_L


% --- Executes on button press in Supp_Motor_Area_R.
function Supp_Motor_Area_R_Callback(hObject, eventdata, handles)
% hObject    handle to Supp_Motor_Area_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Supp_Motor_Area_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Supp_Motor_Area_R)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Supp_Motor_Area_R


% --- Executes on button press in SupraMarginal_L.
function SupraMarginal_L_Callback(hObject, eventdata, handles)
% hObject    handle to SupraMarginal_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.SupraMarginal_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.SupraMarginal_L)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of SupraMarginal_L


% --- Executes on button press in SupraMarginal_R.
function SupraMarginal_R_Callback(hObject, eventdata, handles)
% hObject    handle to SupraMarginal_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.SupraMarginal_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.SupraMarginal_R)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of SupraMarginal_R


% --- Executes on button press in Temporal_Inf_L.
function Temporal_Inf_L_Callback(hObject, eventdata, handles)
% hObject    handle to Temporal_Inf_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Temporal_Inf_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Temporal_Inf_L)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Temporal_Inf_L


% --- Executes on button press in Temporal_Inf_R.
function Temporal_Inf_R_Callback(hObject, eventdata, handles)
% hObject    handle to Temporal_Inf_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Temporal_Inf_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Temporal_Inf_R)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Temporal_Inf_R


% --- Executes on button press in Temporal_Mid_L.
function Temporal_Mid_L_Callback(hObject, eventdata, handles)
% hObject    handle to Temporal_Mid_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Temporal_Mid_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Temporal_Mid_L)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Temporal_Mid_L


% --- Executes on button press in Temporal_Mid_R.
function Temporal_Mid_R_Callback(hObject, eventdata, handles)
% hObject    handle to Temporal_Mid_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Temporal_Mid_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Temporal_Mid_R)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Temporal_Mid_R


% --- Executes on button press in Temporal_Pole_Mid_L.
function Temporal_Pole_Mid_L_Callback(hObject, eventdata, handles)
% hObject    handle to Temporal_Pole_Mid_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Temporal_Pole_Mid_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Temporal_Pole_Mid_L)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Temporal_Pole_Mid_L


% --- Executes on button press in Temporal_Pole_Mid_R.
function Temporal_Pole_Mid_R_Callback(hObject, eventdata, handles)
% hObject    handle to Temporal_Pole_Mid_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Temporal_Pole_Mid_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Temporal_Pole_Mid_R)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Temporal_Pole_Mid_R


% --- Executes on button press in Temporal_Pole_Sup_L.
function Temporal_Pole_Sup_L_Callback(hObject, eventdata, handles)
% hObject    handle to Temporal_Pole_Sup_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Temporal_Pole_Sup_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Temporal_Pole_Sup_L)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Temporal_Pole_Sup_L


% --- Executes on button press in Temporal_Pole_Sup_R.
function Temporal_Pole_Sup_R_Callback(hObject, eventdata, handles)
% hObject    handle to Temporal_Pole_Sup_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Temporal_Pole_Sup_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Temporal_Pole_Sup_R)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Temporal_Pole_Sup_R


% --- Executes on button press in Temporal_Sup_L.
function Temporal_Sup_L_Callback(hObject, eventdata, handles)
% hObject    handle to Temporal_Sup_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Temporal_Sup_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Temporal_Sup_L)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Temporal_Sup_L


% --- Executes on button press in Temporal_Sup_R.
function Temporal_Sup_R_Callback(hObject, eventdata, handles)
% hObject    handle to Temporal_Sup_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Temporal_Sup_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Temporal_Sup_R)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Temporal_Sup_R


% --- Executes on button press in Thalamus_L.
function Thalamus_L_Callback(hObject, eventdata, handles)
% hObject    handle to Thalamus_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Thalamus_L;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Thalamus_L)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Thalamus_L


% --- Executes on button press in Thalamus_R.
function Thalamus_R_Callback(hObject, eventdata, handles)
% hObject    handle to Thalamus_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Thalamus_R;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Thalamus_R)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Thalamus_R


% --- Executes on button press in Vermis_1_2.
function Vermis_1_2_Callback(hObject, eventdata, handles)
% hObject    handle to Vermis_1_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Vermis_1_2;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Vermis_1_2)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Vermis_1_2


% --- Executes on button press in Vermis_10.
function Vermis_10_Callback(hObject, eventdata, handles)
% hObject    handle to Vermis_10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Vermis_10;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Vermis_10)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Vermis_10


% --- Executes on button press in Vermis_3.
function Vermis_3_Callback(hObject, eventdata, handles)
% hObject    handle to Vermis_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Vermis_3;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Vermis_3)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Vermis_3


% --- Executes on button press in Vermis_4_5.
function Vermis_4_5_Callback(hObject, eventdata, handles)
% hObject    handle to Vermis_4_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Vermis_4_5;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Vermis_4_5)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Vermis_4_5


% --- Executes on button press in Vermis_6.
function Vermis_6_Callback(hObject, eventdata, handles)
% hObject    handle to Vermis_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Vermis_6;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Vermis_6)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Vermis_6


% --- Executes on button press in Vermis_7.
function Vermis_7_Callback(hObject, eventdata, handles)
% hObject    handle to Vermis_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Vermis_7;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Vermis_7)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Vermis_7


% --- Executes on button press in Vermis_8.
function Vermis_8_Callback(hObject, eventdata, handles)
% hObject    handle to Vermis_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Vermis_8;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Vermis_8)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Vermis_8


% --- Executes on button press in Vermis_9.
function Vermis_9_Callback(hObject, eventdata, handles)
% hObject    handle to Vermis_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value') == 1
    handles.maskedRegionValues(end+1,1) = handles. value.Vermis_9;
else
    handles.maskedRegionValues(find(handles.maskedRegionValues == handles.value.Vermis_9)) = [];
end
guidata(hObject,handles);% Hint: get(hObject,'Value') returns toggle handles.stateVar of Vermis_9

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in DeselectAll.
function DeselectAll_Callback(hObject, eventdata, handles)
% hObject    handle to DeselectAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in selectAll.
function selectAll_Callback(hObject, eventdata, handles)
set(handles.Amygdala_L , 'Value' , 1);	selectAnatomicalRegions('Amygdala_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Amygdala_R , 'Value' , 1);	selectAnatomicalRegions('Amygdala_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Angular_L , 'Value' , 1);	selectAnatomicalRegions('Angular_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Angular_R , 'Value' , 1);	selectAnatomicalRegions('Angular_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Calcarine_L , 'Value' , 1);	selectAnatomicalRegions('Calcarine_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Calcarine_R , 'Value' , 1);	selectAnatomicalRegions('Calcarine_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Caudate_L , 'Value' , 1);	selectAnatomicalRegions('Caudate_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Caudate_R , 'Value' , 1);	selectAnatomicalRegions('Caudate_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_10_L , 'Value' , 1);	selectAnatomicalRegions('Cerebelum_10_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_10_R , 'Value' , 1);	selectAnatomicalRegions('Cerebelum_10_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_3_L , 'Value' , 1);	selectAnatomicalRegions('Cerebelum_3_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_3_R , 'Value' , 1);	selectAnatomicalRegions('Cerebelum_3_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_4_5_L , 'Value' , 1);	selectAnatomicalRegions('Cerebelum_4_5_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_4_5_R , 'Value' , 1);	selectAnatomicalRegions('Cerebelum_4_5_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_6_L , 'Value' , 1);	selectAnatomicalRegions('Cerebelum_6_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_6_R , 'Value' , 1);	selectAnatomicalRegions('Cerebelum_6_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_7b_L , 'Value' , 1);	selectAnatomicalRegions('Cerebelum_7b_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_7b_R , 'Value' , 1);	selectAnatomicalRegions('Cerebelum_7b_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_8_L , 'Value' , 1);	selectAnatomicalRegions('Cerebelum_8_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_8_R , 'Value' , 1);	selectAnatomicalRegions('Cerebelum_8_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_9_L , 'Value' , 1);	selectAnatomicalRegions('Cerebelum_9_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_9_R , 'Value' , 1);	selectAnatomicalRegions('Cerebelum_9_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_Crus1_L , 'Value' , 1);	selectAnatomicalRegions('Cerebelum_Crus1_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_Crus1_R , 'Value' , 1);	selectAnatomicalRegions('Cerebelum_Crus1_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_Crus2_L , 'Value' , 1);	selectAnatomicalRegions('Cerebelum_Crus2_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_Crus2_R , 'Value' , 1);	selectAnatomicalRegions('Cerebelum_Crus2_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cingulum_Ant_L , 'Value' , 1);	selectAnatomicalRegions('Cingulum_Ant_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cingulum_Ant_R , 'Value' , 1);	selectAnatomicalRegions('Cingulum_Ant_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cingulum_Mid_L , 'Value' , 1);	selectAnatomicalRegions('Cingulum_Mid_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cingulum_Mid_R , 'Value' , 1);	selectAnatomicalRegions('Cingulum_Mid_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cingulum_Post_L , 'Value' , 1);	selectAnatomicalRegions('Cingulum_Post_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cingulum_Post_R , 'Value' , 1);	selectAnatomicalRegions('Cingulum_Post_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cuneus_L , 'Value' , 1);	selectAnatomicalRegions('Cuneus_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cuneus_R , 'Value' , 1);	selectAnatomicalRegions('Cuneus_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Inf_Oper_L , 'Value' , 1);	selectAnatomicalRegions('Frontal_Inf_Oper_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Inf_Oper_R , 'Value' , 1);	selectAnatomicalRegions('Frontal_Inf_Oper_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Inf_Orb_L , 'Value' , 1);	selectAnatomicalRegions('Frontal_Inf_Orb_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Inf_Orb_R , 'Value' , 1);	selectAnatomicalRegions('Frontal_Inf_Orb_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Inf_Tri_L , 'Value' , 1);	selectAnatomicalRegions('Frontal_Inf_Tri_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Inf_Tri_R , 'Value' , 1);	selectAnatomicalRegions('Frontal_Inf_Tri_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Med_Orb_L , 'Value' , 1);	selectAnatomicalRegions('Frontal_Med_Orb_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Med_Orb_R , 'Value' , 1);	selectAnatomicalRegions('Frontal_Med_Orb_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Mid_L , 'Value' , 1);	selectAnatomicalRegions('Frontal_Mid_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Mid_R , 'Value' , 1);	selectAnatomicalRegions('Frontal_Mid_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Mid_Orb_L , 'Value' , 1);	selectAnatomicalRegions('Frontal_Mid_Orb_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Mid_Orb_R , 'Value' , 1);	selectAnatomicalRegions('Frontal_Mid_Orb_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Sup_L , 'Value' , 1);	selectAnatomicalRegions('Frontal_Sup_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Sup_R , 'Value' , 1);	selectAnatomicalRegions('Frontal_Sup_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Sup_Medial_L , 'Value' , 1);	selectAnatomicalRegions('Frontal_Sup_Medial_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Sup_Medial_R , 'Value' , 1);	selectAnatomicalRegions('Frontal_Sup_Medial_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Sup_Orb_L , 'Value' , 1);	selectAnatomicalRegions('Frontal_Sup_Orb_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Sup_Orb_R , 'Value' , 1);	selectAnatomicalRegions('Frontal_Sup_Orb_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Fusiform_L , 'Value' , 1);	selectAnatomicalRegions('Fusiform_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Fusiform_R , 'Value' , 1);	selectAnatomicalRegions('Fusiform_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Heschl_L , 'Value' , 1);	selectAnatomicalRegions('Heschl_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Heschl_R , 'Value' , 1);	selectAnatomicalRegions('Heschl_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Hippocampus_L , 'Value' , 1);	selectAnatomicalRegions('Hippocampus_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Hippocampus_R , 'Value' , 1);	selectAnatomicalRegions('Hippocampus_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Insula_L , 'Value' , 1);	selectAnatomicalRegions('Insula_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Insula_R , 'Value' , 1);	selectAnatomicalRegions('Insula_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Lingual_L , 'Value' , 1);	selectAnatomicalRegions('Lingual_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Lingual_R , 'Value' , 1);	selectAnatomicalRegions('Lingual_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Occipital_Inf_L , 'Value' , 1);	selectAnatomicalRegions('Occipital_Inf_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Occipital_Inf_R , 'Value' , 1);	selectAnatomicalRegions('Occipital_Inf_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Occipital_Mid_L , 'Value' , 1);	selectAnatomicalRegions('Occipital_Mid_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Occipital_Mid_R , 'Value' , 1);	selectAnatomicalRegions('Occipital_Mid_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Occipital_Sup_L , 'Value' , 1);	selectAnatomicalRegions('Occipital_Sup_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Occipital_Sup_R , 'Value' , 1);	selectAnatomicalRegions('Occipital_Sup_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Olfactory_L , 'Value' , 1);	selectAnatomicalRegions('Olfactory_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Olfactory_R , 'Value' , 1);	selectAnatomicalRegions('Olfactory_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Pallidum_L , 'Value' , 1);	selectAnatomicalRegions('Pallidum_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Pallidum_R , 'Value' , 1);	selectAnatomicalRegions('Pallidum_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Paracentral_Lobule_L , 'Value' , 1);	selectAnatomicalRegions('Paracentral_Lobule_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Paracentral_Lobule_R , 'Value' , 1);	selectAnatomicalRegions('Paracentral_Lobule_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.ParaHippocampal_L , 'Value' , 1);	selectAnatomicalRegions('ParaHippocampal_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.ParaHippocampal_R , 'Value' , 1);	selectAnatomicalRegions('ParaHippocampal_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Parietal_Inf_L , 'Value' , 1);	selectAnatomicalRegions('Parietal_Inf_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Parietal_Inf_R , 'Value' , 1);	selectAnatomicalRegions('Parietal_Inf_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Parietal_Sup_L , 'Value' , 1);	selectAnatomicalRegions('Parietal_Sup_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Parietal_Sup_R , 'Value' , 1);	selectAnatomicalRegions('Parietal_Sup_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Postcentral_L , 'Value' , 1);	selectAnatomicalRegions('Postcentral_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Postcentral_R , 'Value' , 1);	selectAnatomicalRegions('Postcentral_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Precentral_L , 'Value' , 1);	selectAnatomicalRegions('Precentral_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Precentral_R , 'Value' , 1);	selectAnatomicalRegions('Precentral_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Precuneus_L , 'Value' , 1);	selectAnatomicalRegions('Precuneus_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Precuneus_R , 'Value' , 1);	selectAnatomicalRegions('Precuneus_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Putamen_L , 'Value' , 1);	selectAnatomicalRegions('Putamen_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Putamen_R , 'Value' , 1);	selectAnatomicalRegions('Putamen_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Rectus_L , 'Value' , 1);	selectAnatomicalRegions('Rectus_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Rectus_R , 'Value' , 1);	selectAnatomicalRegions('Rectus_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Rolandic_Oper_L , 'Value' , 1);	selectAnatomicalRegions('Rolandic_Oper_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Rolandic_Oper_R , 'Value' , 1);	selectAnatomicalRegions('Rolandic_Oper_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Supp_Motor_Area_L , 'Value' , 1);	selectAnatomicalRegions('Supp_Motor_Area_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Supp_Motor_Area_R , 'Value' , 1);	selectAnatomicalRegions('Supp_Motor_Area_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.SupraMarginal_L , 'Value' , 1);	selectAnatomicalRegions('SupraMarginal_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.SupraMarginal_R , 'Value' , 1);	selectAnatomicalRegions('SupraMarginal_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Temporal_Inf_L , 'Value' , 1);	selectAnatomicalRegions('Temporal_Inf_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Temporal_Inf_R , 'Value' , 1);	selectAnatomicalRegions('Temporal_Inf_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Temporal_Mid_L , 'Value' , 1);	selectAnatomicalRegions('Temporal_Mid_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Temporal_Mid_R , 'Value' , 1);	selectAnatomicalRegions('Temporal_Mid_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Temporal_Pole_Mid_L , 'Value' , 1);	selectAnatomicalRegions('Temporal_Pole_Mid_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Temporal_Pole_Mid_R , 'Value' , 1);	selectAnatomicalRegions('Temporal_Pole_Mid_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Temporal_Pole_Sup_L , 'Value' , 1);	selectAnatomicalRegions('Temporal_Pole_Sup_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Temporal_Pole_Sup_R , 'Value' , 1);	selectAnatomicalRegions('Temporal_Pole_Sup_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Temporal_Sup_L , 'Value' , 1);	selectAnatomicalRegions('Temporal_Sup_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Temporal_Sup_R , 'Value' , 1);	selectAnatomicalRegions('Temporal_Sup_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Thalamus_L , 'Value' , 1);	selectAnatomicalRegions('Thalamus_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Thalamus_R , 'Value' , 1);	selectAnatomicalRegions('Thalamus_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Vermis_1_2 , 'Value' , 1);	selectAnatomicalRegions('Vermis_1_2_Callback',hObject,eventdata,guidata(hObject));
set(handles.Vermis_10 , 'Value' , 1);	selectAnatomicalRegions('Vermis_10_Callback',hObject,eventdata,guidata(hObject));
set(handles.Vermis_3 , 'Value' , 1);	selectAnatomicalRegions('Vermis_3_Callback',hObject,eventdata,guidata(hObject));
set(handles.Vermis_4_5 , 'Value' , 1);	selectAnatomicalRegions('Vermis_4_5_Callback',hObject,eventdata,guidata(hObject));
set(handles.Vermis_6 , 'Value' , 1);	selectAnatomicalRegions('Vermis_6_Callback',hObject,eventdata,guidata(hObject));
set(handles.Vermis_7 , 'Value' , 1);	selectAnatomicalRegions('Vermis_7_Callback',hObject,eventdata,guidata(hObject));
set(handles.Vermis_8 , 'Value' , 1);	selectAnatomicalRegions('Vermis_8_Callback',hObject,eventdata,guidata(hObject));
set(handles.Vermis_9 , 'Value' , 1);	selectAnatomicalRegions('Vermis_9_Callback',hObject,eventdata,guidata(hObject));



% --- Executes on button press in deselectAll.
function deselectAll_Callback(hObject, eventdata, handles)
% hObject    handle to deselectAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Amygdala_L , 'Value' , 0);	%selectAnatomicalRegions('Amygdala_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Amygdala_R , 'Value' , 0);	%selectAnatomicalRegions('Amygdala_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Angular_L , 'Value' , 0);	%selectAnatomicalRegions('Angular_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Angular_R , 'Value' , 0);	%selectAnatomicalRegions('Angular_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Calcarine_L , 'Value' , 0);	%selectAnatomicalRegions('Calcarine_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Calcarine_R , 'Value' , 0);	%selectAnatomicalRegions('Calcarine_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Caudate_L , 'Value' , 0);	%selectAnatomicalRegions('Caudate_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Caudate_R , 'Value' , 0);	%selectAnatomicalRegions('Caudate_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_10_L , 'Value' , 0);	%selectAnatomicalRegions('Cerebelum_10_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_10_R , 'Value' , 0);	%selectAnatomicalRegions('Cerebelum_10_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_3_L , 'Value' , 0);	%selectAnatomicalRegions('Cerebelum_3_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_3_R , 'Value' , 0);	%selectAnatomicalRegions('Cerebelum_3_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_4_5_L , 'Value' , 0);	%selectAnatomicalRegions('Cerebelum_4_5_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_4_5_R , 'Value' , 0);	%selectAnatomicalRegions('Cerebelum_4_5_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_6_L , 'Value' , 0);	%selectAnatomicalRegions('Cerebelum_6_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_6_R , 'Value' , 0);	%selectAnatomicalRegions('Cerebelum_6_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_7b_L , 'Value' , 0);	%selectAnatomicalRegions('Cerebelum_7b_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_7b_R , 'Value' , 0);	%selectAnatomicalRegions('Cerebelum_7b_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_8_L , 'Value' , 0);	%selectAnatomicalRegions('Cerebelum_8_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_8_R , 'Value' , 0);	%selectAnatomicalRegions('Cerebelum_8_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_9_L , 'Value' , 0);	%selectAnatomicalRegions('Cerebelum_9_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_9_R , 'Value' , 0);	%selectAnatomicalRegions('Cerebelum_9_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_Crus1_L , 'Value' , 0);	%selectAnatomicalRegions('Cerebelum_Crus1_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_Crus1_R , 'Value' , 0);	%selectAnatomicalRegions('Cerebelum_Crus1_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_Crus2_L , 'Value' , 0);	%selectAnatomicalRegions('Cerebelum_Crus2_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cerebelum_Crus2_R , 'Value' , 0);	%selectAnatomicalRegions('Cerebelum_Crus2_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cingulum_Ant_L , 'Value' , 0);	%selectAnatomicalRegions('Cingulum_Ant_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cingulum_Ant_R , 'Value' , 0);	%selectAnatomicalRegions('Cingulum_Ant_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cingulum_Mid_L , 'Value' , 0);	%selectAnatomicalRegions('Cingulum_Mid_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cingulum_Mid_R , 'Value' , 0);	%selectAnatomicalRegions('Cingulum_Mid_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cingulum_Post_L , 'Value' , 0);	%selectAnatomicalRegions('Cingulum_Post_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cingulum_Post_R , 'Value' , 0);	%selectAnatomicalRegions('Cingulum_Post_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cuneus_L , 'Value' , 0);	%selectAnatomicalRegions('Cuneus_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Cuneus_R , 'Value' , 0);	%selectAnatomicalRegions('Cuneus_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Inf_Oper_L , 'Value' , 0);	%selectAnatomicalRegions('Frontal_Inf_Oper_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Inf_Oper_R , 'Value' , 0);	%selectAnatomicalRegions('Frontal_Inf_Oper_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Inf_Orb_L , 'Value' , 0);	%selectAnatomicalRegions('Frontal_Inf_Orb_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Inf_Orb_R , 'Value' , 0);	%selectAnatomicalRegions('Frontal_Inf_Orb_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Inf_Tri_L , 'Value' , 0);	%selectAnatomicalRegions('Frontal_Inf_Tri_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Inf_Tri_R , 'Value' , 0);	%selectAnatomicalRegions('Frontal_Inf_Tri_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Med_Orb_L , 'Value' , 0);	%selectAnatomicalRegions('Frontal_Med_Orb_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Med_Orb_R , 'Value' , 0);	%selectAnatomicalRegions('Frontal_Med_Orb_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Mid_L , 'Value' , 0);	%selectAnatomicalRegions('Frontal_Mid_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Mid_R , 'Value' , 0);	%selectAnatomicalRegions('Frontal_Mid_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Mid_Orb_L , 'Value' , 0);	%selectAnatomicalRegions('Frontal_Mid_Orb_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Mid_Orb_R , 'Value' , 0);	%selectAnatomicalRegions('Frontal_Mid_Orb_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Sup_L , 'Value' , 0);	%selectAnatomicalRegions('Frontal_Sup_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Sup_R , 'Value' , 0);	%selectAnatomicalRegions('Frontal_Sup_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Sup_Medial_L , 'Value' , 0);	%selectAnatomicalRegions('Frontal_Sup_Medial_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Sup_Medial_R , 'Value' , 0);	%selectAnatomicalRegions('Frontal_Sup_Medial_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Sup_Orb_L , 'Value' , 0);	%selectAnatomicalRegions('Frontal_Sup_Orb_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Frontal_Sup_Orb_R , 'Value' , 0);	%selectAnatomicalRegions('Frontal_Sup_Orb_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Fusiform_L , 'Value' , 0);	%selectAnatomicalRegions('Fusiform_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Fusiform_R , 'Value' , 0);	%selectAnatomicalRegions('Fusiform_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Heschl_L , 'Value' , 0);	%selectAnatomicalRegions('Heschl_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Heschl_R , 'Value' , 0);	%selectAnatomicalRegions('Heschl_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Hippocampus_L , 'Value' , 0);	%selectAnatomicalRegions('Hippocampus_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Hippocampus_R , 'Value' , 0);	%selectAnatomicalRegions('Hippocampus_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Insula_L , 'Value' , 0);	%selectAnatomicalRegions('Insula_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Insula_R , 'Value' , 0);	%selectAnatomicalRegions('Insula_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Lingual_L , 'Value' , 0);	%selectAnatomicalRegions('Lingual_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Lingual_R , 'Value' , 0);	%selectAnatomicalRegions('Lingual_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Occipital_Inf_L , 'Value' , 0);	%selectAnatomicalRegions('Occipital_Inf_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Occipital_Inf_R , 'Value' , 0);	%selectAnatomicalRegions('Occipital_Inf_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Occipital_Mid_L , 'Value' , 0);	%selectAnatomicalRegions('Occipital_Mid_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Occipital_Mid_R , 'Value' , 0);	%selectAnatomicalRegions('Occipital_Mid_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Occipital_Sup_L , 'Value' , 0);	%selectAnatomicalRegions('Occipital_Sup_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Occipital_Sup_R , 'Value' , 0);	%selectAnatomicalRegions('Occipital_Sup_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Olfactory_L , 'Value' , 0);	%selectAnatomicalRegions('Olfactory_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Olfactory_R , 'Value' , 0);	%selectAnatomicalRegions('Olfactory_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Pallidum_L , 'Value' , 0);	%selectAnatomicalRegions('Pallidum_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Pallidum_R , 'Value' , 0);	%selectAnatomicalRegions('Pallidum_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Paracentral_Lobule_L , 'Value' , 0);	%selectAnatomicalRegions('Paracentral_Lobule_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Paracentral_Lobule_R , 'Value' , 0);	%selectAnatomicalRegions('Paracentral_Lobule_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.ParaHippocampal_L , 'Value' , 0);	%selectAnatomicalRegions('ParaHippocampal_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.ParaHippocampal_R , 'Value' , 0);	%selectAnatomicalRegions('ParaHippocampal_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Parietal_Inf_L , 'Value' , 0);	%selectAnatomicalRegions('Parietal_Inf_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Parietal_Inf_R , 'Value' , 0);	%selectAnatomicalRegions('Parietal_Inf_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Parietal_Sup_L , 'Value' , 0);	%selectAnatomicalRegions('Parietal_Sup_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Parietal_Sup_R , 'Value' , 0);	%selectAnatomicalRegions('Parietal_Sup_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Postcentral_L , 'Value' , 0);	%selectAnatomicalRegions('Postcentral_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Postcentral_R , 'Value' , 0);	%selectAnatomicalRegions('Postcentral_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Precentral_L , 'Value' , 0);	%selectAnatomicalRegions('Precentral_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Precentral_R , 'Value' , 0);	%selectAnatomicalRegions('Precentral_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Precuneus_L , 'Value' , 0);	%selectAnatomicalRegions('Precuneus_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Precuneus_R , 'Value' , 0);	%selectAnatomicalRegions('Precuneus_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Putamen_L , 'Value' , 0);	%selectAnatomicalRegions('Putamen_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Putamen_R , 'Value' , 0);	%selectAnatomicalRegions('Putamen_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Rectus_L , 'Value' , 0);	%selectAnatomicalRegions('Rectus_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Rectus_R , 'Value' , 0);	%selectAnatomicalRegions('Rectus_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Rolandic_Oper_L , 'Value' , 0);	%selectAnatomicalRegions('Rolandic_Oper_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Rolandic_Oper_R , 'Value' , 0);	%selectAnatomicalRegions('Rolandic_Oper_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Supp_Motor_Area_L , 'Value' , 0);	%selectAnatomicalRegions('Supp_Motor_Area_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Supp_Motor_Area_R , 'Value' , 0);	%selectAnatomicalRegions('Supp_Motor_Area_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.SupraMarginal_L , 'Value' , 0);	%selectAnatomicalRegions('SupraMarginal_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.SupraMarginal_R , 'Value' , 0);	%selectAnatomicalRegions('SupraMarginal_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Temporal_Inf_L , 'Value' , 0);	%selectAnatomicalRegions('Temporal_Inf_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Temporal_Inf_R , 'Value' , 0);	%selectAnatomicalRegions('Temporal_Inf_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Temporal_Mid_L , 'Value' , 0);	%selectAnatomicalRegions('Temporal_Mid_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Temporal_Mid_R , 'Value' , 0);	%selectAnatomicalRegions('Temporal_Mid_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Temporal_Pole_Mid_L , 'Value' , 0);	%selectAnatomicalRegions('Temporal_Pole_Mid_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Temporal_Pole_Mid_R , 'Value' , 0);	%selectAnatomicalRegions('Temporal_Pole_Mid_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Temporal_Pole_Sup_L , 'Value' , 0);	%selectAnatomicalRegions('Temporal_Pole_Sup_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Temporal_Pole_Sup_R , 'Value' , 0);	%selectAnatomicalRegions('Temporal_Pole_Sup_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Temporal_Sup_L , 'Value' , 0);	%selectAnatomicalRegions('Temporal_Sup_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Temporal_Sup_R , 'Value' , 0);	%selectAnatomicalRegions('Temporal_Sup_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Thalamus_L , 'Value' , 0);	%selectAnatomicalRegions('Thalamus_L_Callback',hObject,eventdata,guidata(hObject));
set(handles.Thalamus_R , 'Value' , 0);	%selectAnatomicalRegions('Thalamus_R_Callback',hObject,eventdata,guidata(hObject));
set(handles.Vermis_1_2 , 'Value' , 0);	%selectAnatomicalRegions('Vermis_1_2_Callback',hObject,eventdata,guidata(hObject));
set(handles.Vermis_10 , 'Value' , 0);	%selectAnatomicalRegions('Vermis_10_Callback',hObject,eventdata,guidata(hObject));
set(handles.Vermis_3 , 'Value' , 0);	%selectAnatomicalRegions('Vermis_3_Callback',hObject,eventdata,guidata(hObject));
set(handles.Vermis_4_5 , 'Value' , 0);	%selectAnatomicalRegions('Vermis_4_5_Callback',hObject,eventdata,guidata(hObject));
set(handles.Vermis_6 , 'Value' , 0);	%selectAnatomicalRegions('Vermis_6_Callback',hObject,eventdata,guidata(hObject));
set(handles.Vermis_7 , 'Value' , 0);	%selectAnatomicalRegions('Vermis_7_Callback',hObject,eventdata,guidata(hObject));
set(handles.Vermis_8 , 'Value' , 0);	%selectAnatomicalRegions('Vermis_8_Callback',hObject,eventdata,guidata(hObject));
set(handles.Vermis_9 , 'Value' , 0);	%selectAnatomicalRegions('Vermis_9_Callback',hObject,eventdata,guidata(hObject));
% empty the container
handles.maskedRegionValues = [];
guidata(hObject, handles);

% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles)
% hObject    handle to ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
saveState(handles);
close(handles.figure1);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
if isequal(get(hObject,'waitstatus'), 'waiting')
    uiresume(hObject);
else
    saveState(handles);
    delete(hObject);
end

function saveState(handles)
handles.stateVar(end+1) = get(handles.Amygdala_L , 'Value' );	%selectAnatomicalRegions('Amygdala_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Amygdala_R , 'Value' );	%selectAnatomicalRegions('Amygdala_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Angular_L , 'Value' );	%selectAnatomicalRegions('Angular_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Angular_R , 'Value' );	%selectAnatomicalRegions('Angular_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Calcarine_L , 'Value' );	%selectAnatomicalRegions('Calcarine_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Calcarine_R , 'Value' );	%selectAnatomicalRegions('Calcarine_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Caudate_L , 'Value' );	%selectAnatomicalRegions('Caudate_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Caudate_R , 'Value' );	%selectAnatomicalRegions('Caudate_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Cerebelum_10_L , 'Value' );	%selectAnatomicalRegions('Cerebelum_10_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Cerebelum_10_R , 'Value' );	%selectAnatomicalRegions('Cerebelum_10_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Cerebelum_3_L , 'Value' );	%selectAnatomicalRegions('Cerebelum_3_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Cerebelum_3_R , 'Value' );	%selectAnatomicalRegions('Cerebelum_3_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Cerebelum_4_5_L , 'Value' );	%selectAnatomicalRegions('Cerebelum_4_5_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Cerebelum_4_5_R , 'Value' );	%selectAnatomicalRegions('Cerebelum_4_5_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Cerebelum_6_L , 'Value' );	%selectAnatomicalRegions('Cerebelum_6_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Cerebelum_6_R , 'Value' );	%selectAnatomicalRegions('Cerebelum_6_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Cerebelum_7b_L , 'Value' );	%selectAnatomicalRegions('Cerebelum_7b_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Cerebelum_7b_R , 'Value' );	%selectAnatomicalRegions('Cerebelum_7b_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Cerebelum_8_L , 'Value' );	%selectAnatomicalRegions('Cerebelum_8_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Cerebelum_8_R , 'Value' );	%selectAnatomicalRegions('Cerebelum_8_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Cerebelum_9_L , 'Value' );	%selectAnatomicalRegions('Cerebelum_9_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Cerebelum_9_R , 'Value' );	%selectAnatomicalRegions('Cerebelum_9_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Cerebelum_Crus1_L , 'Value' );	%selectAnatomicalRegions('Cerebelum_Crus1_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Cerebelum_Crus1_R , 'Value' );	%selectAnatomicalRegions('Cerebelum_Crus1_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Cerebelum_Crus2_L , 'Value' );	%selectAnatomicalRegions('Cerebelum_Crus2_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Cerebelum_Crus2_R , 'Value' );	%selectAnatomicalRegions('Cerebelum_Crus2_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Cingulum_Ant_L , 'Value' );	%selectAnatomicalRegions('Cingulum_Ant_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Cingulum_Ant_R , 'Value' );	%selectAnatomicalRegions('Cingulum_Ant_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Cingulum_Mid_L , 'Value' );	%selectAnatomicalRegions('Cingulum_Mid_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Cingulum_Mid_R , 'Value' );	%selectAnatomicalRegions('Cingulum_Mid_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Cingulum_Post_L , 'Value' );	%selectAnatomicalRegions('Cingulum_Post_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Cingulum_Post_R , 'Value' );	%selectAnatomicalRegions('Cingulum_Post_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Cuneus_L , 'Value' );	%selectAnatomicalRegions('Cuneus_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Cuneus_R , 'Value' );	%selectAnatomicalRegions('Cuneus_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Frontal_Inf_Oper_L , 'Value' );	%selectAnatomicalRegions('Frontal_Inf_Oper_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Frontal_Inf_Oper_R , 'Value' );	%selectAnatomicalRegions('Frontal_Inf_Oper_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Frontal_Inf_Orb_L , 'Value' );	%selectAnatomicalRegions('Frontal_Inf_Orb_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Frontal_Inf_Orb_R , 'Value' );	%selectAnatomicalRegions('Frontal_Inf_Orb_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Frontal_Inf_Tri_L , 'Value' );	%selectAnatomicalRegions('Frontal_Inf_Tri_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Frontal_Inf_Tri_R , 'Value' );	%selectAnatomicalRegions('Frontal_Inf_Tri_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Frontal_Med_Orb_L , 'Value' );	%selectAnatomicalRegions('Frontal_Med_Orb_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Frontal_Med_Orb_R , 'Value' );	%selectAnatomicalRegions('Frontal_Med_Orb_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Frontal_Mid_L , 'Value' );	%selectAnatomicalRegions('Frontal_Mid_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Frontal_Mid_R , 'Value' );	%selectAnatomicalRegions('Frontal_Mid_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Frontal_Mid_Orb_L , 'Value' );	%selectAnatomicalRegions('Frontal_Mid_Orb_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Frontal_Mid_Orb_R , 'Value' );	%selectAnatomicalRegions('Frontal_Mid_Orb_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Frontal_Sup_L , 'Value' );	%selectAnatomicalRegions('Frontal_Sup_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Frontal_Sup_R , 'Value' );	%selectAnatomicalRegions('Frontal_Sup_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Frontal_Sup_Medial_L , 'Value' );	%selectAnatomicalRegions('Frontal_Sup_Medial_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Frontal_Sup_Medial_R , 'Value' );	%selectAnatomicalRegions('Frontal_Sup_Medial_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Frontal_Sup_Orb_L , 'Value' );	%selectAnatomicalRegions('Frontal_Sup_Orb_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Frontal_Sup_Orb_R , 'Value' );	%selectAnatomicalRegions('Frontal_Sup_Orb_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Fusiform_L , 'Value' );	%selectAnatomicalRegions('Fusiform_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Fusiform_R , 'Value' );	%selectAnatomicalRegions('Fusiform_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Heschl_L , 'Value' );	%selectAnatomicalRegions('Heschl_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Heschl_R , 'Value' );	%selectAnatomicalRegions('Heschl_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Hippocampus_L , 'Value' );	%selectAnatomicalRegions('Hippocampus_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Hippocampus_R , 'Value' );	%selectAnatomicalRegions('Hippocampus_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Insula_L , 'Value' );	%selectAnatomicalRegions('Insula_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Insula_R , 'Value' );	%selectAnatomicalRegions('Insula_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Lingual_L , 'Value' );	%selectAnatomicalRegions('Lingual_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Lingual_R , 'Value' );	%selectAnatomicalRegions('Lingual_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Occipital_Inf_L , 'Value' );	%selectAnatomicalRegions('Occipital_Inf_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Occipital_Inf_R , 'Value' );	%selectAnatomicalRegions('Occipital_Inf_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Occipital_Mid_L , 'Value' );	%selectAnatomicalRegions('Occipital_Mid_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Occipital_Mid_R , 'Value' );	%selectAnatomicalRegions('Occipital_Mid_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Occipital_Sup_L , 'Value' );	%selectAnatomicalRegions('Occipital_Sup_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Occipital_Sup_R , 'Value' );	%selectAnatomicalRegions('Occipital_Sup_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Olfactory_L , 'Value' );	%selectAnatomicalRegions('Olfactory_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Olfactory_R , 'Value' );	%selectAnatomicalRegions('Olfactory_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Pallidum_L , 'Value' );	%selectAnatomicalRegions('Pallidum_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Pallidum_R , 'Value' );	%selectAnatomicalRegions('Pallidum_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Paracentral_Lobule_L , 'Value' );	%selectAnatomicalRegions('Paracentral_Lobule_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Paracentral_Lobule_R , 'Value' );	%selectAnatomicalRegions('Paracentral_Lobule_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.ParaHippocampal_L , 'Value' );	%selectAnatomicalRegions('ParaHippocampal_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.ParaHippocampal_R , 'Value' );	%selectAnatomicalRegions('ParaHippocampal_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Parietal_Inf_L , 'Value' );	%selectAnatomicalRegions('Parietal_Inf_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Parietal_Inf_R , 'Value' );	%selectAnatomicalRegions('Parietal_Inf_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Parietal_Sup_L , 'Value' );	%selectAnatomicalRegions('Parietal_Sup_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Parietal_Sup_R , 'Value' );	%selectAnatomicalRegions('Parietal_Sup_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Postcentral_L , 'Value' );	%selectAnatomicalRegions('Postcentral_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Postcentral_R , 'Value' );	%selectAnatomicalRegions('Postcentral_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Precentral_L , 'Value' );	%selectAnatomicalRegions('Precentral_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Precentral_R , 'Value' );	%selectAnatomicalRegions('Precentral_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Precuneus_L , 'Value' );	%selectAnatomicalRegions('Precuneus_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Precuneus_R , 'Value' );	%selectAnatomicalRegions('Precuneus_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Putamen_L , 'Value' );	%selectAnatomicalRegions('Putamen_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Putamen_R , 'Value' );	%selectAnatomicalRegions('Putamen_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Rectus_L , 'Value' );	%selectAnatomicalRegions('Rectus_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Rectus_R , 'Value' );	%selectAnatomicalRegions('Rectus_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Rolandic_Oper_L , 'Value' );	%selectAnatomicalRegions('Rolandic_Oper_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Rolandic_Oper_R , 'Value' );	%selectAnatomicalRegions('Rolandic_Oper_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Supp_Motor_Area_L , 'Value' );	%selectAnatomicalRegions('Supp_Motor_Area_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Supp_Motor_Area_R , 'Value' );	%selectAnatomicalRegions('Supp_Motor_Area_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.SupraMarginal_L , 'Value' );	%selectAnatomicalRegions('SupraMarginal_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.SupraMarginal_R , 'Value' );	%selectAnatomicalRegions('SupraMarginal_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Temporal_Inf_L , 'Value' );	%selectAnatomicalRegions('Temporal_Inf_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Temporal_Inf_R , 'Value' );	%selectAnatomicalRegions('Temporal_Inf_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Temporal_Mid_L , 'Value' );	%selectAnatomicalRegions('Temporal_Mid_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Temporal_Mid_R , 'Value' );	%selectAnatomicalRegions('Temporal_Mid_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Temporal_Pole_Mid_L , 'Value' );	%selectAnatomicalRegions('Temporal_Pole_Mid_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Temporal_Pole_Mid_R , 'Value' );	%selectAnatomicalRegions('Temporal_Pole_Mid_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Temporal_Pole_Sup_L , 'Value' );	%selectAnatomicalRegions('Temporal_Pole_Sup_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Temporal_Pole_Sup_R , 'Value' );	%selectAnatomicalRegions('Temporal_Pole_Sup_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Temporal_Sup_L , 'Value' );	%selectAnatomicalRegions('Temporal_Sup_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Temporal_Sup_R , 'Value' );	%selectAnatomicalRegions('Temporal_Sup_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Thalamus_L , 'Value' );	%selectAnatomicalRegions('Thalamus_L_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Thalamus_R , 'Value' );	%selectAnatomicalRegions('Thalamus_R_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Vermis_1_2 , 'Value' );	%selectAnatomicalRegions('Vermis_1_2_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Vermis_10 , 'Value' );	%selectAnatomicalRegions('Vermis_10_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Vermis_3 , 'Value' );	%selectAnatomicalRegions('Vermis_3_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Vermis_4_5 , 'Value' );	%selectAnatomicalRegions('Vermis_4_5_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Vermis_6 , 'Value' );	%selectAnatomicalRegions('Vermis_6_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Vermis_7 , 'Value' );	%selectAnatomicalRegions('Vermis_7_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Vermis_8 , 'Value' );	%selectAnatomicalRegions('Vermis_8_Callback',hObject,eventdata,guidata(hObject));
handles.stateVar(end+1) = get(handles.Vermis_9 , 'Value' );	%selectAnatomicalRegions('Vermis_9_Callback',hObject,eventdata,guidata(hObject));
stateMat = handles.stateVar;
save('stateMat.mat','stateMat');

function loadState(handles, eventdata, hObject)
filename = 'stateMat.mat';
i = 1; 
if exist(filename)
    load(filename);
    set(handles.Amygdala_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Amygdala_L  ;    selectAnatomicalRegions('Amygdala_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Amygdala_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Amygdala_R  ;    selectAnatomicalRegions('Amygdala_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Angular_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Angular_L  ;    selectAnatomicalRegions('Angular_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Angular_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Angular_R   ;    selectAnatomicalRegions('Angular_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Calcarine_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Calcarine_L  ;    selectAnatomicalRegions('Calcarine_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Calcarine_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Calcarine_R  ;    selectAnatomicalRegions('Calcarine_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Caudate_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Caudate_L   ;    selectAnatomicalRegions('Caudate_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Caudate_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Caudate_R  ;    selectAnatomicalRegions('Caudate_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Cerebelum_10_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Cerebelum_10_L  ;    selectAnatomicalRegions('Cerebelum_10_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Cerebelum_10_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Cerebelum_10_R  ;    selectAnatomicalRegions('Cerebelum_10_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Cerebelum_3_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Cerebelum_3_L  ;    selectAnatomicalRegions('Cerebelum_3_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Cerebelum_3_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Cerebelum_3_R  ;    selectAnatomicalRegions('Cerebelum_3_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Cerebelum_4_5_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Cerebelum_4_5_L  ;    selectAnatomicalRegions('Cerebelum_4_5_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Cerebelum_4_5_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Cerebelum_4_5_R  ;    selectAnatomicalRegions('Cerebelum_4_5_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Cerebelum_6_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Cerebelum_6_L  ;    selectAnatomicalRegions('Cerebelum_6_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Cerebelum_6_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Cerebelum_6_R  ;    selectAnatomicalRegions('Cerebelum_6_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Cerebelum_7b_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Cerebelum_7b_L  ;    selectAnatomicalRegions('Cerebelum_7b_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Cerebelum_7b_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Cerebelum_7b_R  ;    selectAnatomicalRegions('Cerebelum_7b_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Cerebelum_8_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Cerebelum_8_L  ;    selectAnatomicalRegions('Cerebelum_8_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Cerebelum_8_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Cerebelum_8_R  ;    selectAnatomicalRegions('Cerebelum_8_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Cerebelum_9_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Cerebelum_9_L  ;    selectAnatomicalRegions('Cerebelum_9_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Cerebelum_9_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Cerebelum_9_R  ;    selectAnatomicalRegions('Cerebelum_9_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Cerebelum_Crus1_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Cerebelum_Crus1_L  ;    selectAnatomicalRegions('Cerebelum_Crus1_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Cerebelum_Crus1_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Cerebelum_Crus1_R  ;    selectAnatomicalRegions('Cerebelum_Crus1_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Cerebelum_Crus2_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Cerebelum_Crus2_L  ;    selectAnatomicalRegions('Cerebelum_Crus2_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Cerebelum_Crus2_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Cerebelum_Crus2_R  ;    selectAnatomicalRegions('Cerebelum_Crus2_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Cingulum_Ant_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Cingulum_Ant_L   ;    selectAnatomicalRegions('Cingulum_Ant_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Cingulum_Ant_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Cingulum_Ant_R  ;    selectAnatomicalRegions('Cingulum_Ant_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Cingulum_Mid_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Cingulum_Mid_L  ;    selectAnatomicalRegions('Cingulum_Mid_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Cingulum_Mid_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Cingulum_Mid_R  ;    selectAnatomicalRegions('Cingulum_Mid_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Cingulum_Post_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Cingulum_Post_L  ;    selectAnatomicalRegions('Cingulum_Post_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Cingulum_Post_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Cingulum_Post_R  ;    selectAnatomicalRegions('Cingulum_Post_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Cuneus_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Cuneus_L  ;    selectAnatomicalRegions('Cuneus_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Cuneus_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Cuneus_R  ;    selectAnatomicalRegions('Cuneus_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Frontal_Inf_Oper_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Frontal_Inf_Oper_L  ;    selectAnatomicalRegions('Frontal_Inf_Oper_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Frontal_Inf_Oper_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Frontal_Inf_Oper_R  ;    selectAnatomicalRegions('Frontal_Inf_Oper_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Frontal_Inf_Orb_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Frontal_Inf_Orb_L  ;    selectAnatomicalRegions('Frontal_Inf_Orb_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Frontal_Inf_Orb_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Frontal_Inf_Orb_R  ;    selectAnatomicalRegions('Frontal_Inf_Orb_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Frontal_Inf_Tri_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Frontal_Inf_Tri_L  ;    selectAnatomicalRegions('Frontal_Inf_Tri_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Frontal_Inf_Tri_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Frontal_Inf_Tri_R  ;    selectAnatomicalRegions('Frontal_Inf_Tri_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Frontal_Med_Orb_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Frontal_Med_Orb_L  ;    selectAnatomicalRegions('Frontal_Med_Orb_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Frontal_Med_Orb_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Frontal_Med_Orb_R  ;    selectAnatomicalRegions('Frontal_Med_Orb_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Frontal_Mid_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Frontal_Mid_L  ;    selectAnatomicalRegions('Frontal_Mid_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Frontal_Mid_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Frontal_Mid_R  ;    selectAnatomicalRegions('Frontal_Mid_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Frontal_Mid_Orb_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Frontal_Mid_Orb_L  ;    selectAnatomicalRegions('Frontal_Mid_Orb_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Frontal_Mid_Orb_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Frontal_Mid_Orb_R  ;    selectAnatomicalRegions('Frontal_Mid_Orb_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Frontal_Sup_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Frontal_Sup_L  ;    selectAnatomicalRegions('Frontal_Sup_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Frontal_Sup_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Frontal_Sup_R  ;    selectAnatomicalRegions('Frontal_Sup_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Frontal_Sup_Medial_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Frontal_Sup_Medial_L  ;    selectAnatomicalRegions('Frontal_Sup_Medial_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Frontal_Sup_Medial_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Frontal_Sup_Medial_R  ;    selectAnatomicalRegions('Frontal_Sup_Medial_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Frontal_Sup_Orb_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Frontal_Sup_Orb_L  ;    selectAnatomicalRegions('Frontal_Sup_Orb_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Frontal_Sup_Orb_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Frontal_Sup_Orb_R   ;    selectAnatomicalRegions('Frontal_Sup_Orb_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Fusiform_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Fusiform_L  ;    selectAnatomicalRegions('Fusiform_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Fusiform_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Fusiform_R  ;    selectAnatomicalRegions('Fusiform_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Heschl_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Heschl_L  ;    selectAnatomicalRegions('Heschl_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Heschl_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Heschl_R  ;    selectAnatomicalRegions('Heschl_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Hippocampus_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Hippocampus_L  ;    selectAnatomicalRegions('Hippocampus_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Hippocampus_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Hippocampus_R  ;    selectAnatomicalRegions('Hippocampus_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Insula_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Insula_L   ;    selectAnatomicalRegions('Insula_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Insula_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Insula_R  ;    selectAnatomicalRegions('Insula_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Lingual_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Lingual_L  ;    selectAnatomicalRegions('Lingual_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Lingual_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Lingual_R  ;    selectAnatomicalRegions('Lingual_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Occipital_Inf_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Occipital_Inf_L  ;    selectAnatomicalRegions('Occipital_Inf_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Occipital_Inf_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Occipital_Inf_R  ;    selectAnatomicalRegions('Occipital_Inf_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Occipital_Mid_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Occipital_Mid_L  ;    selectAnatomicalRegions('Occipital_Mid_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Occipital_Mid_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Occipital_Mid_R  ;    selectAnatomicalRegions('Occipital_Mid_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Occipital_Sup_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Occipital_Sup_L  ;    selectAnatomicalRegions('Occipital_Sup_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Occipital_Sup_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Occipital_Sup_R  ;    selectAnatomicalRegions('Occipital_Sup_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Olfactory_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Olfactory_L  ;    selectAnatomicalRegions('Olfactory_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Olfactory_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Olfactory_R  ;    selectAnatomicalRegions('Olfactory_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Pallidum_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Pallidum_L  ;    selectAnatomicalRegions('Pallidum_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Pallidum_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Pallidum_R  ;    selectAnatomicalRegions('Pallidum_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Paracentral_Lobule_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Paracentral_Lobule_L  ;    selectAnatomicalRegions('Paracentral_Lobule_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Paracentral_Lobule_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Paracentral_Lobule_R  ;    selectAnatomicalRegions('Paracentral_Lobule_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.ParaHippocampal_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.ParaHippocampal_L   ;    selectAnatomicalRegions('ParaHippocampal_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.ParaHippocampal_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.ParaHippocampal_R  ;    selectAnatomicalRegions('ParaHippocampal_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Parietal_Inf_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Parietal_Inf_L  ;    selectAnatomicalRegions('Parietal_Inf_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Parietal_Inf_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Parietal_Inf_R  ;    selectAnatomicalRegions('Parietal_Inf_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Parietal_Sup_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Parietal_Sup_L  ;    selectAnatomicalRegions('Parietal_Sup_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Parietal_Sup_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Parietal_Sup_R  ;    selectAnatomicalRegions('Parietal_Sup_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Postcentral_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Postcentral_L  ;    selectAnatomicalRegions('Postcentral_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Postcentral_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Postcentral_R  ;    selectAnatomicalRegions('Postcentral_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Precentral_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Precentral_L  ;    selectAnatomicalRegions('Precentral_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Precentral_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Precentral_R  ;    selectAnatomicalRegions('Precentral_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Precuneus_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Precuneus_L  ;    selectAnatomicalRegions('Precuneus_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Precuneus_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Precuneus_R  ;    selectAnatomicalRegions('Precuneus_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Putamen_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Putamen_L  ;    selectAnatomicalRegions('Putamen_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Putamen_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Putamen_R  ;    selectAnatomicalRegions('Putamen_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Rectus_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Rectus_L  ;    selectAnatomicalRegions('Rectus_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Rectus_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Rectus_R  ;    selectAnatomicalRegions('Rectus_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Rolandic_Oper_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Rolandic_Oper_L  ;    selectAnatomicalRegions('Rolandic_Oper_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Rolandic_Oper_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Rolandic_Oper_R  ;    selectAnatomicalRegions('Rolandic_Oper_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Supp_Motor_Area_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Supp_Motor_Area_L  ;    selectAnatomicalRegions('Supp_Motor_Area_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Supp_Motor_Area_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Supp_Motor_Area_R  ;    selectAnatomicalRegions('Supp_Motor_Area_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.SupraMarginal_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.SupraMarginal_L  ;    selectAnatomicalRegions('SupraMarginal_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.SupraMarginal_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.SupraMarginal_R  ;    selectAnatomicalRegions('SupraMarginal_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Temporal_Inf_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Temporal_Inf_L  ;    selectAnatomicalRegions('Temporal_Inf_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Temporal_Inf_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Temporal_Inf_R  ;    selectAnatomicalRegions('Temporal_Inf_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Temporal_Mid_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Temporal_Mid_L  ;    selectAnatomicalRegions('Temporal_Mid_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Temporal_Mid_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Temporal_Mid_R  ;    selectAnatomicalRegions('Temporal_Mid_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Temporal_Pole_Mid_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Temporal_Pole_Mid_L  ;    selectAnatomicalRegions('Temporal_Pole_Mid_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Temporal_Pole_Mid_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Temporal_Pole_Mid_R  ;    selectAnatomicalRegions('Temporal_Pole_Mid_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Temporal_Pole_Sup_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Temporal_Pole_Sup_L  ;    selectAnatomicalRegions('Temporal_Pole_Sup_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Temporal_Pole_Sup_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Temporal_Pole_Sup_R   ;    selectAnatomicalRegions('Temporal_Pole_Sup_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Temporal_Sup_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Temporal_Sup_L  ;    selectAnatomicalRegions('Temporal_Sup_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Temporal_Sup_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Temporal_Sup_R  ;    selectAnatomicalRegions('Temporal_Sup_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Thalamus_L ,'Value', stateMat(i)); i = i + 1; hObject =handles.Thalamus_L  ;    selectAnatomicalRegions('Thalamus_L_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Thalamus_R ,'Value', stateMat(i)); i = i + 1; hObject =handles.Thalamus_R  ;    selectAnatomicalRegions('Thalamus_R_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Vermis_1_2 ,'Value', stateMat(i)); i = i + 1; hObject =handles.Vermis_1_2  ;    selectAnatomicalRegions('Vermis_1_2_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Vermis_10 ,'Value', stateMat(i)); i = i + 1; hObject =handles.Vermis_10  ;    selectAnatomicalRegions('Vermis_10_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Vermis_3 ,'Value', stateMat(i)); i = i + 1; hObject =handles.Vermis_3  ;    selectAnatomicalRegions('Vermis_3_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Vermis_4_5 ,'Value', stateMat(i)); i = i + 1; hObject =handles.Vermis_4_5  ;    selectAnatomicalRegions('Vermis_4_5_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Vermis_6 ,'Value', stateMat(i)); i = i + 1; hObject =handles.Vermis_6  ;    selectAnatomicalRegions('Vermis_6_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Vermis_7 ,'Value', stateMat(i)); i = i + 1; hObject =handles.Vermis_7  ;    selectAnatomicalRegions('Vermis_7_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Vermis_8 ,'Value', stateMat(i)); i = i + 1; hObject =handles.Vermis_8  ;    selectAnatomicalRegions('Vermis_8_Callback',hObject,eventdata,guidata(hObject));
    set(handles.Vermis_9 ,'Value', stateMat(i)); i = i + 1; hObject =handles.Vermis_9  ;    selectAnatomicalRegions('Vermis_9_Callback',hObject,eventdata,guidata(hObject));

     
    
    
    delete(filename);
end
