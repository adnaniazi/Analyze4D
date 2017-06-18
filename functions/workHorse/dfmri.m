function varargout = dfmri(varargin)
% DFMRI MATLAB code for dfmri.fig
%      DFMRI, by itself, creates a new DFMRI or raises the existing
%      singleton*.
%
%      H = DFMRI returns the handle to a new DFMRI or the handle to
%      the existing singleton*.
%
%      DFMRI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DFMRI.M with the given input arguments.
%
%      DFMRI('Property','Value',...) creates a new DFMRI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dfmri_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dfmri_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dfmri

% Last Modified by GUIDE v2.5 25-Oct-2012 13:08:04
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dfmri_OpeningFcn, ...
                   'gui_OutputFcn',  @dfmri_OutputFcn, ...
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


% --- Executes just before dfmri is made visible.
function dfmri_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dfmri (see VARARGIN)
% Choose default command line output for dfmri
% global currentlyOpen;
handles.vararginBackup = varargin;
handles.hObjectBackup = hObject;
handles.eventdataBackup = eventdata;
handles.handlesBackup = handles;



set(handles.goAbortRoiSelection,'Visible', 'off');
set(handles. figure1, 'Name', 'Analyze4D');
handles.output = hObject;
% add defaults at start%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
handles.scanData.data                           = [];
handles.scanData.header                         = [];
handles.displayProperties.view                  = 1;
handles.displayProperties.mosaicZoomOn          = 0;
handles.displayProperties.startPoint            = 1;
handles.displayProperties.endPoint              = 1;
handles.displayProperties.brightness            = 1000;
handles.displayProperties.contrast              = 0;
handles.displayProperties.mosaicColormap        = gray;
handles.displayProperties.gridColor             = [1 1 1]*1;
handles.displayProperties.tileLabelColor        = [1 1 1]*0.9;
handles.displayProperties.gridOn                = 1;
handles.displayProperties.tileLabelOn           = 1;
handles.displayProperties.interScanPause        = 0.001;
handles.designMatrix.onsets                     = [];
handles.designMatrix.durations                  = [];
handles.designMatrix.offset                     = 0;
handles.designMatrix.colormap                   = jet;
handles.designMatrix.conditionCount             = 0;
handles.designMatrix.minY                       = -1;
handles.designMatrix.maxY                       = 1;
handles.mosaicHandle                            = [];
handles.plotHandle                              = [];
handles.toolBoxOpenAlready                      = 1;
handles.roi.roiColor                            = [1 1 1];
handles.roi.roiData                             = []; % contains mask
handles.roi.roiHandle                           = [];
handles.roi.roiHandle.pAxial                    = [];
handles.roi.roiHandle.pCor                      = [];
handles.roi.roiHandle.pSag                      = [];
handles.roi.roiData.imgSag= [];
handles.roi.roiData.imgCor= [];
handles.roi.roiData.imgAxial= [];
handles.roi.roiMaskSag                          = [];
handles.roi.roiMaskCor                          = [];
handles.roi.roiMaskAxial                        = [];
handles.roi.plotDataMean                        = [];
handles.roi.plotData                            = [];
handles.roi.plotDataMeanDetrended               = [];
handles.roi.plotDataDetrended                   = [];
handles.roi.maxYDetrended                       = [];
handles.roi.minYDetrended                       = [];
handles.roi.maxY                                = [];
handles.roi.minY                                = [];
handles.img2Coords.axial                        = [];
handles.img2Coords.sagittal                     = [];
handles.img2Coords.coronal                      = [];
handles.maskData.data                           = [];
handles.motionRegressors                        = [];
handles.aalMask                                 = []; %contains the entire aal Mask without any thresholding
handles.aalMask.isActive                        = 0; % a flag to indicate if the AAL mask is active
handles.pauseButtonPressed                      = 0;
handles.mask.chosenTruecolorColormap            = 'None';
global lineWidth lineColor;
lineColor                                       = [1 1 1];
lineWidth                                       = 1.0;

axes(handles.mosaicAxes);
% cla(handles.mosaicAxes);
axes(handles.plotAxes);
% cla(handles.plotAxes);
% plot(1:10,zeros(1,10));
% Define Globals pertaining to mosaic movie panel
global currentScan pauseData reset interScanPause playData firstScanLastScanOn;
playData                                       = 0;
currentScan                                    = 0;
reset                                          = 0;
pauseData                                      = 0;
interScanPause                                 = 0.00001;
firstScanLastScanOn                            = 0;
% Define Globals pertaining to mosaic display properties panel
global tileLabelOn gridOn mosaicColormap brightness contrast brightnessContrastChanging;
tileLabelOn                                    = 1;
gridOn                                         = 1;
mosaicColormap                                 = jet;
brightness                                     = 1000;
contrast                                       = 0;
brightnessContrastChanging                     = 0;
global xLimits yLimits
xLimits = [0 0];
yLimits = [0 0];

global viewSwitching;
viewSwitching = [];

global showSubtractionPlots;
showSubtractionPlots                            = 0;

global overlayMask maskThreshold maskColor showMaskedVoxelsOnly;
maskThreshold                                   = 0.5;
maskColor                                       = [1 1 1];
showMaskedVoxelsOnly                            = 0;
overlayMask                                     = 0;

%for Clickables legend
global plotAxesCl;
plotAxesCl = handles.plotAxes;

global specialData; % special data like tmaps and cmaps for which CLim should be set to auto
specialData                                    = 0;

global sliceLabelColor mosaicGridColor;
sliceLabelColor                                = [1 1 1];
mosaicGridColor                                = [1 1 1];

% disable the visibity of certain items
set(handles.selectNewAnatomicalRegions, 'visible', 'off');
set(handles.showMaskedVoxelsOnly, 'Enable', 'inactive');
set(handles.colormapTrueColorsStaticText, 'visible', 'off');
set(handles.colormapTrueColors, 'visible', 'off');
set(handles.trueColor, 'Enable', 'inactive', 'ForegroundColor', [1 1 1]*0.7);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Update handles structure
guidata(hObject, handles);

% change the software icon
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
jframe=get(handles.figure1,'javaframe');
st = dbstack('-completenames');
path = st.file;
path = path(1:end-28);
jIcon=javax.swing.ImageIcon(fullfile(path,'assets','a4d.png'));
jframe.setFigureIcon(jIcon);

set(handles. statusString, 'String', 'Status: Please load data.....')

% for mac and unix systems reset the colors for proper display
% 1- set the color of main window to default
if ismac || isunix
set(gcf,'Color','default'); 
set(findall(gcf,'Type','uipanel'), 'BackgroundColor','default',...
    'ShadowColor','default', 'ForegroundColor', 'default');
% 2- set the color of buttons to normal
set(findall(gcf,'Type','uicontrol'), 'BackgroundColor','default',...
    'ForegroundColor', 'default');
% 3- change the size and position of text elements
set(handles.specifyOnsets2, 'Position',...
    [0.06806282722513089 0.8081395348837209 0.6335078534031414 0.12790697674418605]);
set(handles.specifyDuration, 'Position',...
    [0.06806282722513089 0.627906976744186 0.6335078534031414 0.13953488372093023]);
set(handles.specifyDurationText,'Position',...
    [0.06666666666666667 0.7267441860465116 0.6387434554973822 0.09883720930232558]);
set(handles.brightnessValue,'Position',...
    [0.6760259179265663 0.43037974683544306 0.31101511879049676 0.13924050632911392]);
set(handles.contrastValue,'Position',...
    [0.6760259179265662 0.18354430379746836 0.31317494600431967 0.13924050632911392]);
set(handles.maskThresholdValue,'Position',...
    [0.43243243243243246 0.27868852459016413 0.5236486486486487 0.18032786885245902]);
end

% --- Outputs from this function are returned to the command line.
function varargout = dfmri_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function importData_Callback(hObject, eventdata, handles)
% hObject    handle to importData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function dondersrtfMRI_Callback(hObject, eventdata, handles)
% hObject    handle to dondersrtfMRI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function rawDataBuffer_Callback(hObject, eventdata, handles)
% hObject    handle to rawDataBuffer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function pickMocoSeries_Callback(hObject, eventdata, handles)
% hObject    handle to pickMocoSeries (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[data, header]              = readFunctionalRealTimeMoco(1);
intializeBrigtnessContrast(handles,eventdata,hObject,data);
% format the data in mosaic and get the slice labels and separators
[data,m]        = prepareMosaicData(data, header);
% Make Mosaic to Scans Mosaic2VoxelsXScansVector vecotr
[handles.scanData.imgSag handles.scanData.imgCor handles.scanData.imgAxial]...
    = mosaic2VoxelsXScansVector(m);
% data is the appended dataset
% m contains the location of annotations
[mosaicHandle]  = mosaicLoop(data, m, handles.displayProperties,...
    handles.mosaicAxes);
% prepare to share the data among gui
handles.scanData.data       = data;
handles.scanData.header     = header;
handles.m                   = m;
handles.mosaicHandle        = mosaicHandle;
%update data
guidata(hObject, handles);
set(handles.statusString, 'String', 'Status: Functional data loaded');


% --------------------------------------------------------------------
function pickPaceSeries_Callback(hObject, eventdata, handles)
% hObject    handle to pickPaceSeries (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[data, header]              = readFunctionalRealTimePace(1);
intializeBrigtnessContrast(handles,eventdata,hObject,data);
% format the data in mosaic and get the slice labels and separators
[data,m]        = prepareMosaicData(data, header);
% Make Mosaic to Scans Mosaic2VoxelsXScansVector vecotr
[handles.scanData.imgSag handles.scanData.imgCor handles.scanData.imgAxial]...
    = mosaic2VoxelsXScansVector(m)
% data is the appended dataset
% m contains the location of annotations
[mosaicHandle]  = mosaicLoop(data, m, handles.displayProperties,...
    handles.mosaicAxes);
% prepare to share the data among gui
handles.scanData.data       = data;
handles.scanData.header     = header;
handles.m                   = m;
handles.mosaicHandle        = mosaicHandle;
%update data
guidata(hObject, handles);
set(handles.statusString, 'String', 'Status: Functional data loaded');

% --------------------------------------------------------------------
function pickAll_Callback(hObject, eventdata, handles)
% hObject    handle to pickAll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[data, header]              = readFunctionalRealTimeUntouchedRaw(1);
intializeBrigtnessContrast(handles,eventdata,hObject,data);
% format the data in mosaic and get the slice labels and separators
[data,m]        = prepareMosaicData(data, header);
% Make Mosaic to Scans Mosaic2VoxelsXScansVector vecotr
[handles.scanData.imgSag handles.scanData.imgCor handles.scanData.imgAxial]...
    = mosaic2VoxelsXScansVector(m)
% data is the appended dataset
% m contains the location of annotations
[mosaicHandle]  = mosaicLoop(data, m, handles.displayProperties,...
    handles.mosaicAxes);
% prepare to share the data among gui
handles.scanData.data       = data;
handles.scanData.header     = header;
handles.m                   = m;
handles.mosaicHandle        = mosaicHandle;
%update data
guidata(hObject, handles);
set(handles.statusString, 'String', 'Status: Functional data loaded');

% --------------------------------------------------------------------
function dicomFunctional_Callback(hObject, eventdata, handles)
% hObject    handle to dicomFunctional (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function niftiFunctional_Callback(hObject, eventdata, handles)
% hObject    handle to niftiFunctional (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --------------------------------------------------------------------
function niftiFunctional3d_Callback(hObject, eventdata, handles)
% hObject    handle to niftiFunctional3d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% dfmri_OpeningFcn(handles.hObjectBackup, handles.eventdataBackup,...
%     handles.handlesBackup, handles.vararginBackup);
% hObject         = handles.hObjectBackup;
% eventdata       = handles.eventdataBackup;
% handles         = handles.handlesBackup;

[data, header]              = readFunctionalNifti3d([]);
intializeBrigtnessContrast(handles,eventdata,hObject,data);
% format the data in mosaic and get the slice labels and separators
[data,m]        = prepareMosaicData(data, header);
% data is the appended dataset
% m contains the location of annotations
[mosaicHandle]  = mosaicLoop(data, m, handles.displayProperties,...
    handles.mosaicAxes);
% prepare to share the data among gui
handles.scanData.data       = data;
handles.scanData.header     = header;
handles.m                   = m;
handles.mosaicHandle        = mosaicHandle;
%update data
guidata(hObject, handles);
set(handles.statusString, 'String', 'Status: Functional data loaded');

% --------------------------------------------------------------------
function niftiFunctional4d_Callback(hObject, eventdata, handles)
% hObject    handle to niftiFunctional4d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[data, header]              = readFunctionalNifti4d([]);
intializeBrigtnessContrast(handles,eventdata,hObject,data);
% format the data in mosaic and get the slice labels and separators
[data,m]        = prepareMosaicData(data, header);
% data is the appended dataset
% m contains the location of annotations
[mosaicHandle]  = mosaicLoop(data, m, handles.displayProperties,...
    handles.mosaicAxes);
% prepare to share the data among gui
handles.scanData.data       = data;
handles.scanData.header     = header;
handles.m                   = m;
handles.mosaicHandle        = mosaicHandle;
%update data
guidata(hObject, handles);
set(handles.statusString, 'String', 'Status: Functional data loaded');

% --------------------------------------------------------------------
function imaFunctional_Callback(hObject, eventdata, handles)
% hObject    handle to imaFunctional (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Read the data
[data, header]              = readFunctionalIma([]);
intializeBrigtnessContrast(handles,eventdata,hObject,data);
% format the data in mosaic and get the slice labels and separators
[data,m]        = prepareMosaicData(data, header);
% Make Mosaic to Scans Mosaic2VoxelsXScansVector vecotr
[handles.scanData.imgSag handles.scanData.imgCor handles.scanData.imgAxial]...
    = mosaic2VoxelsXScansVector(m)
% data is the appended dataset
% m contains the location of annotations
[mosaicHandle]  = mosaicLoop(data, m, handles.displayProperties,...
    handles.mosaicAxes);
% prepare to share the data among gui
handles.scanData.data       = data;
handles.scanData.header     = header;
handles.m                   = m;
handles.mosaicHandle        = mosaicHandle;
%update data
guidata(hObject, handles);
set(handles.statusString, 'String', 'Status: Functional data loaded');

% --------------------------------------------------------------------
function dcmFunctional_Callback(hObject, eventdata, handles)
% hObject    handle to dcmFunctional (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.statusString, 'String', 'Status: Functional data loaded');


% --------------------------------------------------------------------
function dicFunctional_Callback(hObject, eventdata, handles)
% hObject    handle to dicFunctional (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.statusString, 'String', 'Status: Functional data loaded');


% --------------------------------------------------------------------
function analyzeFunctional_Callback(hObject, eventdata, handles)
% hObject    handle to analyzeFunctional (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[data, header]              = readFunctionalAnalyze([]);
intializeBrigtnessContrast(handles,eventdata,hObject,data);
% format the data in mosaic and get the slice labels and separators
[data,m]        = prepareMosaicData(data, header);
% data is the appended dataset
% m contains the location of annotations
[mosaicHandle]  = mosaicLoop(data, m, handles.displayProperties,...
    handles.mosaicAxes);
% prepare to share the data among gui
handles.scanData.data       = data;
handles.scanData.header     = header;
handles.m                   = m;
handles.mosaicHandle        = mosaicHandle;
%update data
guidata(hObject, handles);
set(handles.statusString, 'String', 'Status: Functional data loaded');

% --------------------------------------------------------------------
function brainVoyagerFunctional_Callback(hObject, eventdata, handles)
% hObject    handle to brainVoyagerFunctional (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.statusString, 'String', 'Status: Functional data loaded');


% --------------------------------------------------------------------
function afniFunctional_Callback(hObject, eventdata, handles)
% hObject    handle to afniFunctional (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.statusString, 'String', 'Status: Functional data loaded');


% --------------------------------------------------------------------
function mincFunctional_Callback(hObject, eventdata, handles)
% hObject    handle to mincFunctional (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.statusString, 'String', 'Status: Functional data loaded');


% --------------------------------------------------------------------
function Functional_Callback(hObject, eventdata, handles)
% hObject    handle to Functional (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global specialData;
specialData                                    = 0; % tmaps/ beta maps



% --------------------------------------------------------------------
function anatomical_Callback(hObject, eventdata, handles)
% hObject    handle to anatomical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function maltabMatFunctional_Callback(hObject, eventdata, handles)
% hObject    handle to maltabMatFunctional (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[data, header]              = readFunctionalMatlab([]);
intializeBrigtnessContrast(handles,eventdata,hObject,data);
% format the data in mosaic and get the slice labels and separators
[data,m]        = prepareMosaicData(data, header);
% data is the appended dataset
% m contains the location of annotations
[mosaicHandle]  = mosaicLoop(data, m, handles.displayProperties,...
    handles.mosaicAxes);
% prepare to share the data among gui
handles.scanData.data       = data;
handles.scanData.header     = header;
handles.m                   = m;
handles.mosaicHandle        = mosaicHandle;
%update data
guidata(hObject, handles);
set(handles.statusString, 'String', 'Status: Functional data loaded');

% --------------------------------------------------------------------
function file_Callback(hObject, eventdata, handles)
% hObject    handle to file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function dicomAnatomical_Callback(hObject, eventdata, handles)
% hObject    handle to dicomAnatomical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function niftiAnatomical3d_Callback(hObject, eventdata, handles)
% hObject    handle to niftiAnatomical3d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function analyzeAnatomical_Callback(hObject, eventdata, handles)
% hObject    handle to analyzeAnatomical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function afniAnatomical_Callback(hObject, eventdata, handles)
% hObject    handle to afniAnatomical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function brainvoyagerAnatomical_Callback(hObject, eventdata, handles)
% hObject    handle to brainvoyagerAnatomical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function imaAnatomical_Callback(hObject, eventdata, handles)
% hObject    handle to imaAnatomical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function dcmAnatomical_Callback(hObject, eventdata, handles)
% hObject    handle to dcmAnatomical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function dicAnatomical_Callback(hObject, eventdata, handles)
% hObject    handle to dicAnatomical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mask_Callback(hObject, eventdata, handles)
% hObject    handle to mask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function importMask_Callback(hObject, eventdata, handles)
% hObject    handle to importMask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function niftiMask3d_Callback(hObject, eventdata, handles)
% hObject    handle to niftiMask3d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global maskThreshold;
maskThreshold                   = 0.5;
set(handles.maskThresholdSlider,'Enable', 'on');
set(handles.maskThresholdValue,'Enable', 'on');
set(handles.maskThresholdSlider,'Value', maskThreshold);
set(handles.maskThresholdValue,'String', maskThreshold);
set(handles.selectNewAnatomicalRegions, 'visible', 'off');


if isempty(handles.scanData.data) 
    msgbox(['You must have the functional data loaded before you can load '...
        'the mask. So first load the functional data and then load the '...
        'mask data. Only then you will be able to see the mask overlayed ' ...
        'over your functional data. If you only want to view the mask data '...
        'then load it as if it was a functional data. In that case, ' ...
        'just go to the File > Import Data > Functional ...'...
        'and load it like you would do a regular functional scan. '...
        'Pheew !!! That was a big warning.'],...
        'No functional data found', 'warn');
    return;
end
[maskData, maskHeader]      = readMaskNifti3d([]);
% format the data in mosaic and get the slice labels and separators
[maskData,maskm]            = prepareMosaicData(maskData, maskHeader);
% prepare mask in all three views
maskData(find(maskData== 0))= NaN;
mask                        = prepareMask(maskData, handles.m);
handles.maskData.data       = mask;
% handles.maskData.header     = maskHeader;
% handles.maskm               = maskm;
guidata(hObject, handles);

% invoke overlay mask button
set(handles.overlayMask, 'Value', 1);
guidata(hObject, handles);
hObject = handles.overlayMask;
dfmri('overlayMask_Callback',hObject,eventdata,guidata(hObject));
set(handles.statusString, 'String', 'Status: Mask loaded.');


% --------------------------------------------------------------------
function matlabMatMask_Callback(hObject, eventdata, handles)
% hObject    handle to matlabMatMask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mask maskThreshold;
[a,b,mask,maskThreshold] = readMaskMatlab(1);
if isempty(mask) % if user has loaded a custom mask that he made himself then..
    maskData = a;
    maskHeader = b;
    [maskData,maskm]            = prepareMosaicData(maskData, maskHeader);
    maskData(find(maskData== 0))= NaN;

    % prepare mask in all three views
    mask                        = prepareMask(maskData, maskm);
    handles.maskData.data       = mask;
    maskThreshold               = 0.5;    
    guidata(hObject, handles);
    
    % invoke overlay mask button
    set(handles.overlayMask, 'Value', 1);
    guidata(hObject, handles);
    hObjectCall = handles.overlayMask;
    dfmri('overlayMask_Callback',hObjectCall,eventdata,guidata(hObjectCall));
    set(handles.statusString, 'String', 'Status: Mask loaded.');
    
else
    handles.maskData.data.maskAxial       = mask.maskAxial ;
    handles.maskData.data.maskSagittal       = mask.maskSagittal ;
    handles.maskData.data.maskCoronal       = mask.maskCoronal ;
    
    % call overlay mask
    set(handles.overlayMask, 'Value', 1);
    guidata(hObject, handles);
    hObjectCall = handles.overlayMask;
    dfmri('overlayMask_Callback',hObjectCall,eventdata,guidata(hObjectCall));
    
    % call slider threshold
    set(handles.maskThresholdSlider, 'Value', maskThreshold);
    guidata(hObject, handles);
    hObjectCall = handles.maskThresholdSlider;
    dfmri('maskThresholdSlider_Callback',hObjectCall,eventdata,guidata(hObjectCall));
    set(handles.statusString, 'String', 'Status: Mask succesfully imported and applied.');
end

% --------------------------------------------------------------------
function afniMask_Callback(hObject, eventdata, handles)
% hObject    handle to afniMask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.statusString, 'String', 'Status: Mask loaded.');


% --------------------------------------------------------------------
function brainVoyagerMask_Callback(hObject, eventdata, handles)
% hObject    handle to brainVoyagerMask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.statusString, 'String', 'Status: Mask loaded.');


% --------------------------------------------------------------------
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function saveDataMat_Callback(hObject, eventdata, handles)
% hObject    handle to saveDataMat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

d.header = handles.scanData.header;
numSlices = double(d.header.numSlices);
xRes      = double(d.header.xRes);
yRes      = double(d.header.yRes);
ending    = numSlices*xRes*yRes;
%discard the zero padding
d.data = handles.scanData.data(1 : ending, :);
% desquarify
if exist('handles.scanData.header.squarified','var')
    if handles.scanData.header.squarified
    d.data = desquarify(handles.scanData.header, d.data);
    end
end
[FileName,PathName,FilterIndex] = uiputfile('*.mat');
set(handles.statusString, 'String', 'Status: Started saving masked ......Please be patient !!!!');


% Construct a questdlg with three options
choice = questdlg(['Do you want to save the header information as well ',...
    'alongwith the data? By saving header information, it will be easier '...
    'for you to load the mask again in Analyze4D.'], ...
    'Save options', ...
    'Yes, save the header information too (Recommended)',...
    'No, just save the scan data. Don''t save the header information',...
    'Yes, save the header information too (Recommended)');
% Handle response
switch choice
    case 'Yes, save the header information too (Recommended)'
        save(fullfile(PathName,FileName),'d');
    case 'No, just save the scan data. Don''t save the header information'
        data = d.data;
        save(fullfile(PathName,FileName),'data'); 
end



% --------------------------------------------------------------------
function print_Callback(hObject, eventdata, handles)
% hObject    handle to print (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function saveMatlabMatDataMasked_Callback(hObject, eventdata, handles)
% hObject    handle to saveMatlabMatDataMasked (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mask;
if isempty(mask)
    msgbox('You must import a mask before you can save the functional data under the mask.', 'No mask found !', 'warn', 'modal');
    return;
end
set(handles.statusString, 'String', 'Status: ');

% if show maked voxels only is off, then turn it on to get the desired data
% and turn it off later
showMaskedVoxelsOnlyStatus = get(handles.showMaskedVoxelsOnly, 'Value');
if showMaskedVoxelsOnlyStatus == 0
    set(handles.showMaskedVoxelsOnly, 'Value', 1);
    guidata(hObject, handles);
    hObjectCall = handles.showMaskedVoxelsOnly;
    dfmri('showMaskedVoxelsOnly_Callback',hObjectCall,eventdata,guidata(hObjectCall));
end
% convert the mask in the current views in binary
if  handles.displayProperties.view == 1
    binaryMask = mask.imgMaskedVoxelsOnlySagittal;
elseif  handles.displayProperties.view == 2
    binaryMask = mask.imgMaskedVoxelsOnlyCoronal;    
else  % handles.displayProperties.view == 3
    binaryMask = mask.imgMaskedVoxelsOnlyAxial;    
end
    binaryMask(find(binaryMask)) = 1;
% pick the ind of the masked voxels
[handles.saveMaskedData.coordsSag handles.saveMaskedData.coordsCor handles.saveMaskedData.coordsAxial] = ...
    mosaic2VoxelsXScansVector(handles.m);
if  handles.displayProperties.view == 1
    idx = handles.saveMaskedData.coordsSag(find(binaryMask));
elseif  handles.displayProperties.view == 2
    idx = handles.saveMaskedData.coordsCor(find(binaryMask));    
else  % handles.displayProperties.view == 3
    idx = handles.saveMaskedData.coordsAxial(find(binaryMask));    
end
% choose time courses of the masked voxels, set the rest to zero
type = class(handles.scanData.data);
if strcmp(type,'uint16')
    d.data = uint16(zeros(size(handles.scanData.data)));
else
    d.data = single(zeros(size(handles.scanData.data)));
end
d.data(idx,:) = handles.scanData.data(idx,:);
d.header = handles.scanData.header;

%first discard the zero padded slices in the z-direction
d.data = d.data(1 : d.header.numSlices * d.header.xRes * d.header.yRes, :);
try % for real-time data, squarified does not exist
    if handles.scanData.header.squarified
        d.data = desquarify(handles.scanData.header, d.data);
    end
end
[FileName,PathName,FilterIndex] = uiputfile('*.mat');
set(handles.statusString, 'String', 'Status: Started saving masked data......Please be patient !!!!');
save(fullfile(PathName,FileName),'d');

% return the show masked voxels only to its previous position
if showMaskedVoxelsOnlyStatus == 0
    set(handles.showMaskedVoxelsOnly, 'Value', 0);
    guidata(hObject, handles);
    hObjectCall = handles.showMaskedVoxelsOnly;
    dfmri('showMaskedVoxelsOnly_Callback',hObjectCall,eventdata,guidata(hObjectCall));
end
set(handles.statusString, 'String', 'Status: Masked Functional Data has been successfully saved. !!!!');

% --------------------------------------------------------------------
function roi_Callback(hObject, eventdata, handles)
% hObject    handle to roi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function saveroi_Callback(hObject, eventdata, handles)
% hObject    handle to saveroi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function importRoi_Callback(hObject, eventdata, handles)
% hObject    handle to importRoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Movie_Callback(hObject, eventdata, handles)
% hObject    handle to Movie (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function makeMosaicMovie_Callback(hObject, eventdata, handles)
% hObject    handle to makeMosaicMovie (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function markers_Callback(hObject, eventdata, handles)
% hObject    handle to markers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function loadMarkers_Callback(hObject, eventdata, handles)
% hObject    handle to loadMarkers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function saveMarkers_Callback(hObject, eventdata, handles)
% hObject    handle to saveMarkers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function saveMarkersToTextFile_Callback(hObject, eventdata, handles)
% hObject    handle to saveMarkersToTextFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function saveMarkersToMatlabMatFile_Callback(hObject, eventdata, handles)
% hObject    handle to saveMarkersToMatlabMatFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function markersFromTextFile_Callback(hObject, eventdata, handles)
% hObject    handle to markersFromTextFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function markersFromMatlabMat_Callback(hObject, eventdata, handles)
% hObject    handle to markersFromMatlabMat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function loadMotionRegressors_Callback(hObject, eventdata, handles)
% hObject    handle to loadMotionRegressors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% reads one motion regressor file
handles.motionRegressors = readSPMStyledMotionRegressors(1);
guidata(hObject,handles);

% plot motion regressors
set(handles.plotMotionRegressors, 'Value', 1);
guidata(hObject, handles);
hObject = handles.plotMotionRegressors;
dfmri('plotMotionRegressors_Callback',hObject,eventdata,guidata(hObject));
set(handles.statusString, 'String', 'Status: Motion regressors loaded.');

% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function detrendCurrentData_Callback(hObject, eventdata, handles)
% hObject    handle to detrendCurrentData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function saveDetrendedData_Callback(hObject, eventdata, handles)
% hObject    handle to saveDetrendedData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function contrastSlider_Callback(hObject, eventdata, handles)
% hObject    handle to contrastSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global contrast playData currentScan brightnessContrastChanging firstScanLastScanOn showSubtractionPlots;
set(handles.plotAxes, 'HandleVisibility' , 'off');
set(handles.mosaicAxes, 'HandleVisibility' , 'on');
contrast = get(hObject, 'Value');
brightnessContrastChanging = 1;
if contrast == get(handles.contrastSlider,'Min');
    set(handles.contrastSlider,'Min', get(handles.contrastSlider,'Min')-500); % double the limit if that doesnot help
%     msgbox('doubled the limmit');
end

set(handles.contrastValue,'String', num2str(contrast));
if playData == 0 | ~firstScanLastScanOn;
    if currentScan == 0 % handle the situation when reset has been pressed and the currentScan =0
        currentScan = 1;
    end
    if showSubtractionPlots
            handles.displayProperties. startPoint = currentScan-1;
            handles.displayProperties. endPoint = currentScan ;
    else
        handles.displayProperties. startPoint = currentScan;
        handles.displayProperties. endPoint = currentScan;
    end
    [mosaicHandle]  = mosaicLoop(handles.scanData.data, handles.m,...
        handles.displayProperties, handles.mosaicAxes);
end
% overlay ROI
refreshROIOverlay(handles)

brightnessContrastChanging = 0;
% hack to turn on the zoom functionality after this button is pressed
if handles.displayProperties.mosaicZoomOn % a hack to Keep interactivemouse on whenevr the view changes
interactivemouse off;
interactivemouse on;
end
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function contrastSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to contrastSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function contrastValue_Callback(hObject, eventdata, handles)
% hObject    handle to contrastValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global contrast currentScan playData;
set(handles.plotAxes, 'HandleVisibility' , 'off');
set(handles.mosaicAxes, 'HandleVisibility' , 'on');
try
    contrastValueFromUser = str2double(get(hObject,'String'));
    contrast = contrastValueFromUser;
    if playData == 0;
        if currentScan == 0 % handle the situation when reset has been pressed and the currentScan =0
            currentScan = 1;
        end
        handles.displayProperties. startPoint = currentScan;
        handles.displayProperties. endPoint = currentScan;
        [mosaicHandle]  = mosaicLoop(handles.scanData.data, handles.m,...
            handles.displayProperties, handles.mosaicAxes);
    end
catch
    msgbox('Please enter a number');
end
% Hints: get(hObject,'String') returns contents of contrastValue as text
%        str2double(get(hObject,'String')) returns contents of contrastValue as a double


% --- Executes during object creation, after setting all properties.
function contrastValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to contrastValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function brightnessSlider_Callback(hObject, eventdata, handles)
% hObject    handle to brightnessSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global brightness playData currentScan brightnessContrastChanging firstScanLastScanOn showSubtractionPlots;
set(handles.plotAxes, 'HandleVisibility' , 'off');
set(handles.mosaicAxes, 'HandleVisibility' , 'on');

brightnessContrastChanging = 1; % prevents the axis reset when brightness is changed
brightness = get(hObject,'Value');
if brightness == get(handles.brightnessSlider,'Max');
    set(handles.brightnessSlider,'Max', get(handles.brightnessSlider,'Max')+2000); % double the limit if that doesnot help
%     msgbox('doubled the limmit');
end
set(handles.brightnessValue,'String', num2str(brightness));
if playData == 0 | ~firstScanLastScanOn 
    if currentScan == 0 % handle the situation when reset has been pressed and the currentScan =0
        currentScan = 1;
    end
    if showSubtractionPlots
            handles.displayProperties. startPoint = currentScan-1;
            handles.displayProperties. endPoint = currentScan ;
    else
        handles.displayProperties. startPoint = currentScan;
        handles.displayProperties. endPoint = currentScan;
    end
    [mosaicHandle]  = mosaicLoop(handles.scanData.data, handles.m,...
        handles.displayProperties, handles.mosaicAxes);
end
refreshROIOverlay(handles);
brightnessContrastChanging = 0;
% hack to turn on the zoom functionality after this button is pressed
if handles.displayProperties.mosaicZoomOn % a hack to Keep interactivemouse on whenevr the view changes
interactivemouse off;
interactivemouse on;
end

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function brightnessSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to brightnessSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function brightnessValue_Callback(hObject, eventdata, handles)
% hObject    handle to brightnessValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global brightness playData currentScan;
set(handles.plotAxes, 'HandleVisibility' , 'off');
set(handles.mosaicAxes, 'HandleVisibility' , 'on');
try
brightnessValueFromUser = str2double(get(hObject,'String'));
brightness = brightnessValueFromUser;
if playData == 0;
    if currentScan == 0 % handle the situation when reset has been pressed and the currentScan =0
        currentScan = 1;
    end
    handles.displayProperties. startPoint = currentScan;
    handles.displayProperties. endPoint = currentScan;
    [mosaicHandle]  = mosaicLoop(handles.scanData.data, handles.m,...
        handles.displayProperties, handles.mosaicAxes);
end
catch
    msgbox('Please enter a number');
end
% Hints: get(hObject,'String') returns contents of brightnessValue as text
%        str2double(get(hObject,'String')) returns contents of brightnessValue as a double


% --- Executes during object creation, after setting all properties.
function brightnessValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to brightnessValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in showMosaicGrid.
function showMosaicGrid_Callback(hObject, eventdata, handles)
% hObject    handle to showMosaicGrid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gridOn currentScan playData;
set(handles.plotAxes, 'HandleVisibility' , 'off');
set(handles.mosaicAxes, 'HandleVisibility' , 'on');
if get(hObject,'Value') == 1
    gridOn = 1;
    if currentScan == 0 % handle the situation when reset has been pressed and the currentScan =0
        currentScan = 1;
    end
    if playData == 0; %if data is not playing then show the current scan only with toggle slice labels
        handles.displayProperties. startPoint = currentScan;
        handles.displayProperties. endPoint = currentScan;
        [mosaicHandle]  = mosaicLoop(handles.scanData.data, handles.m,...
            handles.displayProperties, handles.mosaicAxes);
    end
    set(handles.statusString, 'String', 'Status: Mosiac grid is now ON');
else
    gridOn = 0;
    if playData == 0;
        if currentScan == 0 % handle the situation when reset has been pressed and the currentScan =0
            currentScan = 1;
        end
        handles.displayProperties. startPoint = currentScan;
        handles.displayProperties. endPoint = currentScan;
        [mosaicHandle]  = mosaicLoop(handles.scanData.data, handles.m,...
            handles.displayProperties, handles.mosaicAxes);
    end
    set(handles.statusString, 'String', 'Status: Mosiac grid is now OFF');
end
refreshROIOverlay(handles);

% invoke trueMaskcolor
if get(handles.overlayMask,'Value') && get(handles.trueColor,'Value')
    set(handles.trueColor, 'Value', 1);
    guidata(hObject, handles);
    hObjectCall = handles.trueColor;
    dfmri('trueColor_Callback',hObjectCall,eventdata,guidata(hObjectCall));
end

% hack to turn on the zoom functionality after this button is pressed
if handles.displayProperties.mosaicZoomOn % a hack to Keep interactivemouse on whenevr a button is pressed
    try
    interactivemouse off;
    catch
    end
    interactivemouse on;
end
guidata(hObject,handles);


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in customizeMosaicGridColor.
function customizeMosaicGridColor_Callback(hObject, eventdata, handles)
% hObject    handle to customizeMosaicGridColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mosaicGridColor currentScan playData;
mosaicGridColor = uicolorpicker;
set(handles.mosaicGridColorBox,'BackgroundColor',mosaicGridColor);
set(handles.plotAxes, 'HandleVisibility' , 'off');
set(handles.mosaicAxes, 'HandleVisibility' , 'on');
if get(hObject,'Value') == 1
    gridOn = 1;
    if currentScan == 0 % handle the situation when reset has been pressed and the currentScan =0
        currentScan = 1;
    end
    if playData == 0; %if data is not playing then show the current scan only with toggle slice labels
        handles.displayProperties. startPoint = currentScan;
        handles.displayProperties. endPoint = currentScan;
        [mosaicHandle]  = mosaicLoop(handles.scanData.data, handles.m,...
            handles.displayProperties, handles.mosaicAxes);
    end
else
    gridOn = 0;
    if playData == 0;
        if currentScan == 0 % handle the situation when reset has been pressed and the currentScan =0
            currentScan = 1;
        end
        handles.displayProperties. startPoint = currentScan;
        handles.displayProperties. endPoint = currentScan;
        [mosaicHandle]  = mosaicLoop(handles.scanData.data, handles.m,...
            handles.displayProperties, handles.mosaicAxes);
    end
end
refreshROIOverlay(handles);
% hack to turn on the zoom functionality after this button is pressed
if handles.displayProperties.mosaicZoomOn % a hack to Keep interactivemouse on whenevr a button is pressed
    try
    interactivemouse off;
    catch
    end
    interactivemouse on;
end
guidata(hObject,handles);



% --- Executes on button press in showSliceLabels.
function showSliceLabels_Callback(hObject, eventdata, handles)
% hObject    handle to showSliceLabels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of showSliceLabels
global tileLabelOn currentScan playData;
set(handles.plotAxes, 'HandleVisibility' , 'off');
set(handles.mosaicAxes, 'HandleVisibility' , 'on');
if get(hObject,'Value') == 1
    tileLabelOn = 1;
    if playData == 0; %if data is not playing then show the current scan only with toggle slice labels
        if currentScan == 0 % handles the case when reset has been set and the currentScan is set to zero
            currentScan = 1;
        end
        handles.displayProperties. startPoint = currentScan;
        handles.displayProperties. endPoint = currentScan;
        [mosaicHandle]  = mosaicLoop(handles.scanData.data, handles.m,...
            handles.displayProperties, handles.mosaicAxes);
    end
        set(handles.statusString, 'String', 'Status: Slice numbers are now visible on each slice');
else
    tileLabelOn = 0;
    if playData == 0;
        if currentScan == 0
            currentScan = 1;
        end
        handles.displayProperties. startPoint = currentScan;
        handles.displayProperties. endPoint = currentScan;
        [mosaicHandle]  = mosaicLoop(handles.scanData.data, handles.m,...
            handles.displayProperties, handles.mosaicAxes);
    end
    set(handles.statusString, 'String', 'Status: Slice numbering has been disabled');
end
refreshROIOverlay(handles);

% invoke trueMaskcolor
if get(handles.overlayMask,'Value') && get(handles.trueColor,'Value')
    set(handles.trueColor, 'Value', 1);
    guidata(hObject, handles);
    hObjectCall = handles.trueColor;
    dfmri('trueColor_Callback',hObjectCall,eventdata,guidata(hObjectCall));
end

% hack to turn on the zoom functionality after this button is pressed
if handles.displayProperties.mosaicZoomOn % a hack to Keep interactivemouse on whenevr a button is pressed
    try
    interactivemouse off;
    catch
    end
    interactivemouse on;
end

guidata(hObject,handles);

% --- Executes on button press in customizeSliceLabelColor.
function customizeSliceLabelColor_Callback(hObject, eventdata, handles)
% hObject    handle to customizeSliceLabelColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sliceLabelColor currentScan playData;
sliceLabelColor = uicolorpicker;
set(handles.sliceLabelColorBox,'BackgroundColor',sliceLabelColor);
set(handles.plotAxes, 'HandleVisibility' , 'off');
set(handles.mosaicAxes, 'HandleVisibility' , 'on');
if get(hObject,'Value') == 1
    gridOn = 1;
    if currentScan == 0 % handle the situation when reset has been pressed and the currentScan =0
        currentScan = 1;
    end
    if playData == 0; %if data is not playing then show the current scan only with toggle slice labels
        handles.displayProperties. startPoint = currentScan;
        handles.displayProperties. endPoint = currentScan;
        [mosaicHandle]  = mosaicLoop(handles.scanData.data, handles.m,...
            handles.displayProperties, handles.mosaicAxes);
    end
else
    gridOn = 0;
    if playData == 0;
        if currentScan == 0 % handle the situation when reset has been pressed and the currentScan =0
            currentScan = 1;
        end
        handles.displayProperties. startPoint = currentScan;
        handles.displayProperties. endPoint = currentScan;
        [mosaicHandle]  = mosaicLoop(handles.scanData.data, handles.m,...
            handles.displayProperties, handles.mosaicAxes);
    end
end
refreshROIOverlay(handles);
% hack to turn on the zoom functionality after this button is pressed
if handles.displayProperties.mosaicZoomOn % a hack to Keep interactivemouse on whenevr a button is pressed
    try
    interactivemouse off;
    catch
    end
    interactivemouse on;
end
guidata(hObject,handles);

% --- Executes on button press in captureRestorePoint.
function captureRestorePoint_Callback(hObject, eventdata, handles)
% hObject    handle to captureRestorePoint (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in loadRestorePointMosaic.
function loadRestorePointMosaic_Callback(hObject, eventdata, handles)
% hObject    handle to loadRestorePointMosaic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
interactivemouse restore;

if handles.displayProperties.mosaicZoomOn % a hack to Keep interactivemouse on whenevr a button is pressed
    try
    interactivemouse off;
    catch
    end
    interactivemouse on;
end


% --- Executes on button press in captureRestorePointPlot.
function captureRestorePointPlot_Callback(hObject, eventdata, handles)
% hObject    handle to captureRestorePointPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global axesNumber;
axesNumber = 1;
interactivemouse reset;
% --- Executes on button press in turnOnZoomAndPanMosaic.
function turnOnZoomAndPanMosaic_Callback(hObject, eventdata, handles)
% hObject    handle to turnOnZoomAndPanMosaic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% AXES(handles.mosaicHandle);
% interactivemouse(handles.mosaicHandle);
% set the current axes as the mosiac axes
global xLimits yLimits;
if (get(hObject,'Value') == get(hObject,'Max'))
    % if no data is present then do not let user toggle the button
    if isempty(handles.scanData.data)
        msgbox('Nothing to zoom into Your highness!!. Please first load any data by going to the File menu.','Warning','warn','modal');
        set(handles.turnOnZoomAndPanMosaic, 'Value', 0);
        return;
    end
    % Turn off plot axes
    set(handles.turnOnZoomAndPanPlot, 'Value', 0);
    guidata(hObject, handles);
    hObjectCall = handles.turnOnZoomAndPanPlot;
    dfmri('turnOnZoomAndPanPlot_Callback',hObjectCall,eventdata,guidata(hObjectCall));
    
    % turn on mosaic axes
    set(handles.plotAxes, 'HandleVisibility' , 'off');
    set(handles.mosaicAxes, 'HandleVisibility' , 'on');
    guidata(hObject,handles);
    interactivemouse on ;
    handles.displayProperties.mosaicZoomOn = 1; % a hack to Keep interactivemouse on whenevr the view changes  

else
    % Checkbox is unchecked-take appropriate action
    set(handles.mosaicAxes, 'HandleVisibility' , 'on'); % restore the other axes
    set(handles.plotAxes, 'HandleVisibility' , 'on'); % restore the other axes
    guidata(hObject,handles);
    try
        interactivemouse off ;
    catch
    end
    handles.displayProperties.mosaicZoomOn          = 0; % a hack to Keep interactivemouse on whenevr the view changes
    set(handles.plotAxes, 'HandleVisibility' , 'off'); % restore the other axes
    set(handles.mosaicAxes, 'HandleVisibility' , 'off'); % restore the other axes
end
% Hint: get(hObject,'Value') returns toggle state of turnOnZoomAndPanMosaic
guidata(hObject,handles);

% --- Executes on button press in turnOnZoomAndPanPlot.
function turnOnZoomAndPanPlot_Callback(hObject, eventdata, handles)
% hObject    handle to turnOnZoomAndPanPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xLimits yLimits;

if (get(hObject,'Value') == get(hObject,'Max'))
    % if no data is present then do not let user toggle the button
    if isempty(handles.motionRegressors) & isempty(handles.roi.plotData)
        msgbox('Nothing to zoom into Your highness!!. Please select an ROI in the Spatio-Temporal Analysis panel or Load SPM motion regressors. ','Warning','warn','modal');
        set(handles.turnOnZoomAndPanPlot, 'Value', 0);
        return;
    end
    % Turn off plot axes
    set(handles.turnOnZoomAndPanMosaic, 'Value', 0);
    guidata(hObject, handles);
    hObjectCall = handles.turnOnZoomAndPanMosaic;
    dfmri('turnOnZoomAndPanMosaic_Callback',hObjectCall,eventdata,guidata(hObjectCall));
    
    % turn on mosaic axes
    set(handles.mosaicAxes, 'HandleVisibility' , 'off');
    set(handles.plotAxes, 'HandleVisibility' , 'on');
    guidata(hObject,handles);
    interactivemouse on ;
    handles.displayProperties.plotZoomOn = 1; % a hack to Keep interactivemouse on whenevr the view changes  

else
    % Checkbox is unchecked-take appropriate action
    set(handles.plotAxes, 'HandleVisibility' , 'on'); % restore the other axes
    set(handles.mosaicAxes, 'HandleVisibility' , 'on'); % restore the other axes
    guidata(hObject,handles);
    try
        interactivemouse off ;
    catch
    end
    handles.displayProperties.plotZoomOn          = 0; % a hack to Keep interactivemouse on whenevr the view changes
    set(handles.mosaicAxes, 'HandleVisibility' , 'off'); % restore the other axes
    set(handles.plotAxes, 'HandleVisibility' , 'off'); % restore the other axes
end
% Hint: get(hObject,'Value') returns toggle state of turnOnZoomAndPanMosaic
guidata(hObject,handles);


% --- Executes on button press in loadRestorePointPlot.
function loadRestorePointPlot_Callback(hObject, eventdata, handles)
% hObject    handle to loadRestorePointPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global axesNumber;
axesNumber = 1;
interactivemouse restore;

% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global currentScan playData pauseData xLimits yLimits firstScanLastScanOn;
set(handles.plotAxes, 'HandleVisibility' , 'off');
set(handles.mosaicAxes, 'HandleVisibility' , 'on');
% Play the data from start it the all the scans have been played and the
% play button is pressed again
firstScanLastScanOn = 0;
if currentScan == handles.scanData.header.numScans;
    currentScan = 0;
end
% otherwise proceed as normal
originalColor = [0.3490    0.2000    0.3294]; %get(hObject, 'BackgroundColor');
playData                                = 1;
set(hObject,'BackgroundColor', [0.5137    0.3804    0.4824]);
handles.displayProperties.startPoint    = currentScan + 1;
currentScan = currentScan + 1;
handles.displayProperties.endPoint      = handles.scanData.header.numScans;
guidata(hObject,handles);
set(handles.statusString, 'String', 'Status: Playing data..... Press Pause to stop playing.');
[mosaicHandle]  = mosaicLoop(handles.scanData.data, handles.m,...
    handles.displayProperties, handles.mosaicAxes);
playData                                = 0;
set(hObject, 'BackgroundColor', originalColor);
if handles.displayProperties.mosaicZoomOn % a hack to Keep interactivemouse on whenevr the view changes
    try
        interactivemouse off;
    catch
    end
    interactivemouse on;
end
set(handles.statusString, 'String', 'Status: Done.' );
refreshROIOverlay(handles);

% --- Executes on button press in pause.
function pause_Callback(hObject, eventdata, handles)
% hObject    handle to pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global pauseData playData;
if playData % if something is playing then pause it
    set(handles.plotAxes, 'HandleVisibility' , 'off');
    set(handles.mosaicAxes, 'HandleVisibility' , 'on');
    pauseData = 1;
    playData  = 0;
    if handles.displayProperties.mosaicZoomOn
        handles.displayProperties.mosaicZoomOn
        try
            interactivemouse off;
        catch
        end
        interactivemouse on;
    end
    guidata(hObject,handles)
else
    set(handles.statusString, 'String', 'Status: Nothing to pause.');  
    return;
end
refreshROIOverlay(handles);

% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global currentScan playData;
currentScan                             = 0;
playData                                = 0; % pauseData if already running play
handles.displayProperties.startPoint    = currentScan + 1;
handles.displayProperties.endPoint      = handles.displayProperties.startPoint;
guidata(hObject,handles);
[mosaicHandle]  = mosaicLoop(handles.scanData.data, handles.m,...
    handles.displayProperties, handles.mosaicAxes);
if handles.displayProperties.mosaicZoomOn % a hack to Keep interactivemouse on whenevr a button is pressed
    try
    interactivemouse off;
    catch
    end
    interactivemouse on;
end
set(handles.statusString, 'String', 'Status: Resetted to Volume 1.');  
refreshROIOverlay(handles);

% --- Executes on button press in firstScanLastScanLoop.
function firstScanLastScanLoop_Callback(hObject, eventdata, handles)
global firstScanLastScanOn currentScan playData;
if ~isempty(handles.scanData.data)
    button_state = get(hObject,'Value');
    originalColor = [0.3490    0.2000    0.3294];
    
    while button_state == get(hObject,'Max')
        set(handles.statusString, 'String', 'Status: Playing the data in first Scan-last Scan loop.');
        set(hObject,'BackgroundColor',[0.5137    0.3804    0.4824] );
        % Toggle button is pressed-take appropriate action
        firstScanLastScanOn = 1;
        playData             = 1;
        firstScanLastScanData = handles.scanData.data(:,[1 end]);
        currentScan = 0;
        handles.displayProperties.startPoint    = currentScan + 1;
        handles.displayProperties.endPoint      = currentScan + 2;
        [mosaicHandle]  = mosaicLoop(firstScanLastScanData, handles.m,...
            handles.displayProperties, handles.mosaicAxes);
        currentScan = 0;
        button_state = get(hObject,'Value');
    end
    set(hObject,'BackgroundColor',originalColor);
    firstScanLastScanOn = 0;
    guidata(hObject,handles);
    set(handles.statusString, 'String', 'Status: Stopped first Scan-last Scan loop.');
    
    % hack to turn on the zoom functionality after this button is pressed
    if handles.displayProperties.mosaicZoomOn % a hack to Keep interactivemouse on whenevr a button is pressed
        try
            interactivemouse off;
        catch
        end
        interactivemouse on;
    end
    refreshROIOverlay(handles);
else %if scanData is emtpy, then retun
    set(handles.firstScanLastScanLoop, 'Value', 0);
    set(handles.statusString, 'String', 'Status: You must load at least two functional scans first for this option to work.');
    return;
end

% --- Executes on selection change in interescanPauseIntervalPopupMenu.
function interescanPauseIntervalPopupMenu_Callback(hObject, eventdata, handles)
% hObject    handle to interescanPauseIntervalPopupMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global interScanPause;
% contents            = cellstr(get(hObject,'String')) ;
% contents{get(hObject,'Value')}
% interScanPause      = contents;
% % hack to turn on the zoom functionality after this button is pressed
% if handles.displayProperties.mosaicZoomOn % a hack to Keep interactivemouse on whenevr a button is pressed
%     try
%     interactivemouse off;
%     catch
%     end
%     interactivemouse on;
% end
% Hints: contents = cellstr(get(hObject,'String')) returns interescanPauseIntervalPopupMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from interescanPauseIntervalPopupMenu


% --- Executes during object creation, after setting all properties.
function interescanPauseIntervalPopupMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to interescanPauseIntervalPopupMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in overlayMask.
function overlayMask_Callback(hObject, eventdata, handles)
% hObject    handle to overlayMask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global overlayMask mask currentScan showSubtractionPlots maskThreshold showMaskedVoxelsOnly;

if isempty(handles.scanData.data) & get(hObject, 'Value')
    msgbox(['You must have functional data loaded before you can overlay '...
        'mask over it. So first load the functional data and then load the '...
        'mask data. Only then you will be able to see the mask overlayed ' ...
        'over your functional data.'], 'No functional data found', 'warn');
    set(handles.overlayMask,'Value',0);
    return;
end

if get(hObject, 'Value') == 1

    % turn the trueColor buttons on
    set(handles.trueColor, 'Enable', 'on', 'ForegroundColor', [1 1 1]);
    
    if isempty(handles.maskData.data)
        msgbox(['No mask found. Please go the the Mask menu and load the mask ' ...
            'data. The mask should be in the same space as the data ' ...
            'itself. This means that if you have created Gray, White or CSF '...
            'masks, then you need to reslice these masks to your functional '...
            'data and then load them.'], 'Error', 'warn');
        set(handles.overlayMask, 'Value', 0);
        return;
    else
        mask = handles.maskData.data;
    end
    overlayMask = 1;
    set(handles.showMaskedVoxelsOnly, 'Enable', 'on');
    set(handles.showMaskedVoxelsOnly, 'ForegroundColor', [1 1 1]);

    set(handles.maskThresholdValue, 'String' , num2str(maskThreshold));
    if currentScan == 0 % handle the situation when reset has been pressed and the currentScan =0
        currentScan = 1;
    end
    if showSubtractionPlots
%         msgbox('turn off subtraction plots')
        set(handles.showSubtractionPlots, 'Value', 0);
        hObjectCall = handles.showSubtractionPlots;
        dfmri('showSubtractionPlots_Callback',hObjectCall,eventdata,guidata(hObjectCall))
    else
        handles.displayProperties. startPoint = currentScan;
        handles.displayProperties. endPoint = currentScan;
    end
    [mosaicHandle]  = mosaicLoop(handles.scanData.data, handles.m,...
        handles.displayProperties, handles.mosaicAxes);
%     if get(handles.trueColor, 'Value') % if true colors is on then
%         % invoke trueMaskcolor
%         set(handles.trueColor, 'Value', 1);
%         hObjectCall = handles.trueColor;
%         dfmri('trueColor_Callback',hObjectCall,eventdata,guidata(hObjectCall));
%     end
else
    overlayMask = 0;
    showMaskedVoxelsOnly = 0;
    mask = handles.maskData.data;
    % turn off trueColor button 
    set(handles.trueColor, 'Enable', 'on','Value',1, 'ForegroundColor', [1 1 1]);

    % disable control
    set(handles.showMaskedVoxelsOnly, 'ForegroundColor', [1 1 1]*0.7);
    set(handles.showMaskedVoxelsOnly, 'Value', 0);
    set(handles.showMaskedVoxelsOnly, 'Enable', 'inactive');
    
    if currentScan == 0 % handle the situation when reset has been pressed and the currentScan =0
        currentScan = 1;
    end
    if showSubtractionPlots
        %msgbox('turn off subtraction plots');
        set(handles.showSubtractionPlots, 'Value', 0);
        hObjectCall = handles.showSubtractionPlots;
        dfmri('showSubtractionPlots_Callback',hObjectCall,eventdata,guidata(hObjectCall));
%         set(handles.showSubtractionPlots, 'Value', 0);
    else
        handles.displayProperties. startPoint = currentScan;
        handles.displayProperties. endPoint = currentScan;
    end

    [mosaicHandle]  = mosaicLoop(handles.scanData.data, handles.m,...
        handles.displayProperties, handles.mosaicAxes);
end


% overlay ROI
if ~isempty(handles.roi.roiData)
    if handles.displayProperties.view == 1
        [posX posY] = find(handles.roi.roiData.imgSag);
        pSag = colorpixel(posY,posX,handles.roi.roiColor);
    elseif handles.displayProperties.view == 2
        [posX posY] = find(handles.roi.roiData.imgCor);
        pCor = colorpixel(posY,posX,handles.roi.roiColor);
    else
        [posX posY] = find(handles.roi.roiData.imgAxial);
        pAxial = colorpixel(posY,posX,handles.roi.roiColor);
    end
end

if handles.displayProperties.mosaicZoomOn % a hack to Keep interactivemouse on whenevr a button is pressed
    try
        interactivemouse off;
    catch
    end
    interactivemouse on;
end

% --- Executes on slider movement.
function maskThresholdSlider_Callback(hObject, eventdata, handles)
% hObject    handle to maskThresholdSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global mask currentScan showSubtractionPlots maskThreshold;
if get(handles.overlayMask, 'Value') == 1    
    % if there is ROI data then clear it when the slider is moved 
    if ~isempty(handles.roi.roiData)
        Object = handles.clearAllRois;
        dfmri('clearAllRois_Callback',Object,eventdata,guidata(Object));
    end
    
    maskThreshold = get(hObject,'Value') ;
    set(handles.maskThresholdValue, 'String' , num2str(maskThreshold));
    mask = handles.maskData.data;
    if currentScan == 0 % handle the situation when reset has been pressed and the currentScan =0
        currentScan = 1;
    end
    if showSubtractionPlots
        msgbox('turn off subtraction plots')
    else
        handles.displayProperties. startPoint = currentScan;
        handles.displayProperties. endPoint = currentScan;
    end
    [mosaicHandle]  = mosaicLoop(handles.scanData.data, handles.m,...
        handles.displayProperties, handles.mosaicAxes);
    % invoke trueMaskcolor
    if get(handles.trueColor, 'Value')
        hObjectCall = handles.trueColor;
        dfmri('trueColor_Callback',hObjectCall,eventdata,guidata(hObjectCall));
    end
%  refreshROIOverlay(handles);   
    if handles.displayProperties.mosaicZoomOn % a hack to Keep interactivemouse on whenevr a button is pressed
        try
            interactivemouse off;
        catch
        end
        interactivemouse on;
    end    
end



% --- Executes during object creation, after setting all properties.
function maskThresholdSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maskThresholdSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in customizeMaskColor.
function customizeMaskColor_Callback(hObject, eventdata, handles)
% hObject    handle to customizeMaskColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


global maskColor;
maskColor = uicolorpicker;
set(handles.maskColorBox, 'BackgroundColor', maskColor);
dfmri('overlayMask_Callback',hObject,eventdata,guidata(hObject));
guidata(hObject,handles);

% --- Executes on button press in showMaskedVoxelsOnly.
function showMaskedVoxelsOnly_Callback(hObject, eventdata, handles)
% hObject    handle to showMaskedVoxelsOnly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global showMaskedVoxelsOnly;

if get(hObject,'Value') == 1
%     if get(handles.overlayMask,'Value') == 1
%         set(handles.showMaskedVoxelsOnly, 'Enable', 'off');
%         return;
%     end
    showMaskedVoxelsOnly = 1;
    dfmri('overlayMask_Callback',hObject,eventdata,guidata(hObject));
    set(handles.customizeMaskColor, 'Enable','inactive');
else
    showMaskedVoxelsOnly = 0;
    hObject = handles.overlayMask;
    dfmri('overlayMask_Callback',hObject,eventdata,guidata(hObject));
    set(handles.customizeMaskColor, 'Enable','on');

end
[x y] = getAxesLimits(handles.mosaicAxes);
setAxesLimits(handles.mosaicAxes, x, y);
% Hint: get(hObject,'Value') returns toggle state of showMaskedVoxelsOnly


% --- Executes on button press in selectVovelsInARectangularRoi.
function selectVovelsInARectangularRoi_Callback(hObject, eventdata, handles)
% hObject    handle to selectVovelsInARectangularRoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in selectOneVoxelAtATime.
function selectOneVoxelAtATime_Callback(hObject, eventdata, handles)
% hObject    handle to selectOneVoxelAtATime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox8


% --- Executes on selection change in listbox3.
function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox3


% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes on selection change in nVoxels.
function nVoxels_Callback(hObject, eventdata, handles)
% hObject    handle to nVoxels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns nVoxels contents as cell array
%        contents{get(hObject,'Value')} returns selected item from nVoxels


% --- Executes during object creation, after setting all properties.
function nVoxels_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nVoxels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in colorizeRoiVoxels.
function colorizeRoiVoxels_Callback(hObject, eventdata, handles)
% hObject    handle to colorizeRoiVoxels (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hint: get(hObject,'Value') returns toggle state of colorizeRoiVoxels


% --- Executes on button press in clearAllRois.
function clearAllRois_Callback(hObject, eventdata, handles)
% hObject    handle to clearAllRois (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global currentScan showSubtractionPlots xLimits yLimits;
handles.roi.roiHandle                           = [];
handles.roi.roiHandle.pSag                      = [];
handles.roi.roiHandle.pCor                      = [];
handles.roi.roiHandle.pAxial                    = [];
handles.roi.roiData.imgSag                      = [];
handles.roi.roiData.imgCor                      = [];
handles.roi.roiData.imgAxial                    = [];
handles.roi.roiMaskSag                         = [];
handles.roi.roiMaskCor                         = [];
handles.roi.roiMaskAxial                         = [];
handles.img2Coords.sagittal                     = [];
handles.img2Coords.coronal                      = [];
handles.img2Coords.axial                        = [];
handles.roi.plotDataMean                        = [];
handles.roi.plotData                            = [];
handles.roi.maxY                                = [];
handles.roi.minY                                = [];
handles.roi.roiData                             = [];
handles.roi.plotDataMeanDetrended               = [];
handles.roi.plotDataDetrended                   = [];
handles.roi.maxYDetrended                       = [];
handles.roi.minYDetrended                       = [];
guidata(hObject, handles);

if get(handles.turnOnZoomAndPanPlot,'Value')
    set(handles.turnOnZoomAndPanPlot, 'Value', 0);
    guidata(hObject, handles);
    hObjectCall = handles.turnOnZoomAndPanPlot;
    dfmri('turnOnZoomAndPanPlot_Callback',hObjectCall,eventdata,guidata(hObjectCall));
end

if currentScan == 0 % handle the situation when reset has been pressed and the currentScan =0
    currentScan = 1;
end
if showSubtractionPlots
    msgbox('turn off subtraction plots')
else
    handles.displayProperties. startPoint = currentScan;
    handles.displayProperties. endPoint = currentScan;
end


% Clear the mosaic
set(handles.plotAxes, 'HandleVisibility' , 'off');
set(handles.mosaicAxes, 'HandleVisibility' , 'on');


%get the axis state
xLimits = get(handles.mosaicAxes,'XLim'); % this prevent the zoom state of plot to be copied to the zoom state of mosiac
yLimits = get(handles.mosaicAxes,'YLim');

[mosaicHandle]  = mosaicLoop(handles.scanData.data, handles.m,...
    handles.displayProperties, handles.mosaicAxes);

% Clear the plot axes with previously plotted ROI time series
set(handles.plotAxes, 'HandleVisibility' , 'on');
set(handles.mosaicAxes, 'HandleVisibility' , 'off');
cla(handles.plotAxes);

set(handles.plotAxes, 'XLim', [0,1]);% prevent loss of display the user has cleared all th roi and proceeds to select a new one
set(handles.plotAxes, 'YLim', [0,1]);

% restore the control to mosaic
set(handles.plotAxes, 'HandleVisibility' , 'off');
set(handles.mosaicAxes, 'HandleVisibility' , 'on');

if get(handles.trueColor,'Value')
    % invoke trueMaskcolor
    hObjectCall = handles.trueColor;
    dfmri('trueColor_Callback',hObjectCall,eventdata,guidata(hObjectCall));
    set(handles.statusString, 'String', 'Status: Colormap for the mask changed!');
end

if handles.displayProperties.mosaicZoomOn % a hack to Keep interactivemouse on whenevr a button is pressed
    try
        interactivemouse off;
    catch
    end
    interactivemouse on;
end

set(handles.statusString,'String','Status: All ROIs cleared.');
guidata(hObject, handles);

% --- Executes on button press in plotMotionRegressors.
function plotMotionRegressors_Callback(hObject, eventdata, handles)
% hObject    handle to plotMotionRegressors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isempty(handles.motionRegressors) & get(handles.plotMotionRegressors, 'Value')
    set(handles.plotMotionRegressors, 'Value',0);
    msgbox('You have not loaded any motions regressors. Please go to the Motion Regressors menu and load the motion regressors.','Are you kidding me !!!', 'warn');
    return;
end
set(handles.plotAxes, 'HandleVisibility' , 'on'); % so that plot is in the plot axes
set(handles.mosaicAxes, 'HandleVisibility' , 'off');

if get(hObject,'Value')
    time        = handles.motionRegressors.time;
    x           = handles.motionRegressors.x;
    y           = handles.motionRegressors.y;
    z           = handles.motionRegressors.z;
    yaw         = handles.motionRegressors.yaw;
    pitch       =  handles.motionRegressors.pitch;
    roll        = handles.motionRegressors.roll;
    h = plot(handles.plotAxes, time,x, time,y, time,z, time,yaw,...
        time,pitch, time,roll,'LineSmoothing','on');
    %     draggable(h);
    set(handles.plotAxes,'Color',[0 0 0]); % change the plot background to black
    set(handles.plotAxes,'XLim',[1 numel(time)+ floor(numel(time)/6.5)]); % change the plot background to black
    set(h,'uicontextmenu',linecmenu);
    clickableLegend(handles.plotAxes, {'X Translation','Y Translation','Z Translation','Yaw','Pitch', 'Roll'}, 'Location', 'east');
else
%     cla(handles.plotAxes);
    delete(allchild(handles.plotAxes))
end
set(handles.plotAxes, 'HandleVisibility' , 'off'); % so that plot is in the plot axes
set(handles.mosaicAxes, 'HandleVisibility' , 'on');

% --- Executes on button press in showSubtractionPlots.
function showSubtractionPlots_Callback(hObject, eventdata, handles)
% hObject    handle to showSubtractionPlots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global playData firstScanLastScanOn currentScan  brightnessContrastChanging;
global showSubtractionPlots;
if (isempty(handles.scanData.data))
    if get(handles.showSubtractionPlots, 'Value')
        msgbox(['A Subtraction Plot is the difference image of two consecutive '...
            'functional scans and is used to assess how much motion occured between '...
            'two consecutive scans. Therefore, it is necessary to have functional data '...
            'available for this option to work. So please first load your functional '...
            'scans by going to File > Import Data > Functional. Once you have done '...
            'that, you can activate this option.'], 'No functional data found', 'warn');
     set(handles.showSubtractionPlots, 'Value', 0);
     guidata(hObject,handles);
    end
    return;
end

if get(hObject,'Value')
    showSubtractionPlots                            = 1;
    firstScanLastScanOn                             = 1;
    brightnessContrastChanging                      = 1;
    tmp = currentScan;
    
    if ~playData & firstScanLastScanOn
        if currentScan==0
            currentScan = currentScan +2;
        end
        handles.displayProperties. startPoint = currentScan-1;
        handles.displayProperties. endPoint = currentScan;
        [mosaicHandle]  = mosaicLoop(handles.scanData.data, handles.m,...
            handles.displayProperties, handles.mosaicAxes);
    end
    
    firstScanLastScanOn                             = 0;
    brightnessContrastChanging                      = 0;
    currentScan                                     = tmp;
else
    showSubtractionPlots                            = 0;
    tmp = currentScan;
    % restore the normal plot if the button is unpressed
    if currentScan == handles.scanData.header.numScans
        currentScan = currentScan -1;
    end
    handles.displayProperties. startPoint = currentScan+1;
    handles.displayProperties. endPoint = currentScan+1 ;
    [mosaicHandle]  = mosaicLoop(handles.scanData.data, handles.m,...
        handles.displayProperties, handles.mosaicAxes);
    currentScan = tmp;    
end
% restore the interactivemouse
if handles.displayProperties.mosaicZoomOn % a hack to Keep interactivemouse on whenevr a button is pressed
    try
    interactivemouse off;
    catch
    end
    interactivemouse on;
end

% Hint: get(hObject,'Value') returns toggle state of showSubtractionPlots


% --- Executes on button press in Abort.
function Abort_Callback(hObject, eventdata, handles)
% hObject    handle to Abort (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in captureRestorePointMosaic.
function captureRestorePointMosaic_Callback(hObject, eventdata, handles)
% hObject    handle to captureRestorePointMosaic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global axesNumber;
axesNumber = 2;
interactivemouse reset;

% --- Executes on button press in detrendBeforeDisplaying.
function detrendBeforeDisplaying_Callback(hObject, eventdata, handles)
% hObject    handle to detrendBeforeDisplaying (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Temporal filtering (niak_brick_time_filter)
% get the user setting for line thickness and width
global lineWidth lineColor;
if ~isempty(findobj(handles.plotAxes, 'Type', 'Line'))
lineColor = get(findobj(handles.plotAxes, 'Type', 'Line'),'Color');
lineWidth = get(findobj(handles.plotAxes, 'Type', 'Line'),'LineWidth');
end

if get(hObject,'Value') == 1
    if isempty(handles.roi.plotData)
        return;
    end
    set(handles.statusString, 'String', 'Status: Busy detrending the data...');
    disp('Runing Temporal High Pass Filtering.......................');
    opt.hp = 0.01; % Apply a high-pass filter at cut-off frequency 0.01Hz (slow time drifts)
    opt.lp = Inf;  % Do not apply low-pass filter. Low-pass filter induce a big loss in degrees of freedom without sgnificantly improving the SNR.
    if isempty(handles.scanData.header.TR) % if no TR info exist then explicitly get it from the user
        prompt = {'Please specify TR in seconds'};
        dlg_title = 'TR';
        num_lines = 1;
        def = {'1.5'};
        opt.tr = str2double(inputdlg(prompt,dlg_title,num_lines,def));
        handles.scanData.header.TR = opt.tr;
    else
        opt.tr                      = handles.scanData.header.TR;
    end
    [plotDataDetrended,extras]      = niak_filter_tseries(double(handles.roi.plotData'),opt);
    plotDataDetrended               = plotDataDetrended';
    plotDataMeanDetrended           = mean(plotDataDetrended,1);
    
    plot(handles.plotAxes, 1:numel(plotDataMeanDetrended), plotDataMeanDetrended,'LineSmoothing','on', 'LineWidth', lineWidth,'Color', lineColor);
    set(handles.plotAxes,'Color',[0 0 0]); % change the plot background to black
  
    handles.roi.plotDataMeanDetrended   = plotDataMeanDetrended;
    handles.roi.plotDataDetrended       = plotDataDetrended;
    handles.roi.maxYDetrended           = max(plotDataMeanDetrended);
    handles.roi.minYDetrended           = min(plotDataMeanDetrended);
    set(handles.plotAxes,'yLim',...
        [handles.roi.minYDetrended handles.roi.maxYDetrended ]); % chngle the y axis limit
    set(handles.plotAxes,'xLim', [1 numel(plotDataMeanDetrended)]); 
    set(handles.statusString, 'String', 'Status: Detrending Done.');
    guidata(hObject,handles);
else
    if ~isempty(handles.roi.plotDataMean)
        plot(handles.plotAxes, 1:numel(handles.roi.plotDataMean),  handles.roi.plotDataMean,'LineSmoothing','on', 'LineWidth', lineWidth,'Color', lineColor);
        set(handles.plotAxes,'Color',[0 0 0]); % change the plot background to black
        set(handles.plotAxes,'yLim',...
            [handles.roi.minY handles.roi.maxY]);
        set(handles.plotAxes,'xLim', [1 numel(handles.roi.plotDataMean)]);         
    end
end

% if the user already input a design matrix, then plot it
if handles.designMatrix.conditionCount   ~= 0
    set(handles.okDesignMatrix, 'Value', 1);
    guidata(hObject, handles);
    hObjectCall = handles.okDesignMatrix;
    dfmri('okDesignMatrix_Callback',hObjectCall,eventdata,guidata(hObjectCall));
end

% Hint: get(hObject,'Value') returns toggle state of detrendBeforeDisplaying


% --------------------------------------------------------------------
function preprocessedDataBuffer_Callback(hObject, eventdata, handles)
% hObject    handle to preprocessedDataBuffer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[data, header]              = readFunctionalRealTimeUntouchedPreproc(1);
data = data * 100;
intializeBrigtnessContrast(handles,eventdata,hObject,data);
% format the data in mosaic and get the slice labels and separators
[data,m]        = prepareMosaicData(data, header);
% Make Mosaic to Scans Mosaic2VoxelsXScansVector vecotr
[handles.scanData.imgSag handles.scanData.imgCor handles.scanData.imgAxial]...
    = mosaic2VoxelsXScansVector(m)
% data is the appended dataset
% m contains the location of annotations
[mosaicHandle]  = mosaicLoop(data, m, handles.displayProperties,...
    handles.mosaicAxes);
% prepare to share the data among gui
handles.scanData.data       = data;
handles.scanData.header     = header;
handles.m                   = m;
handles.mosaicHandle        = mosaicHandle;
%update data
guidata(hObject, handles);

% --- Executes on selection change in mosaicColormap.
function mosaicColormap_Callback(hObject, eventdata, handles)
% hObject    handle to mosaicColormap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns mosaicColormap contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mosaicColormap

global currentScan mosaicColormap;
set(handles.plotAxes, 'HandleVisibility' , 'off');
set(handles.mosaicAxes, 'HandleVisibility' , 'on');
numCbrewerColors = 8;
contents = cellstr(get(hObject,'String'))
cm = contents{get(hObject,'Value')};
tmp = cm;
if strcmp(cm,'IsoL')
    cm = pmkmp(256, 'isol');  
elseif strcmp(cm,'CubicL')
    cm = pmkmp(256);          
elseif strcmp(cm,'Fire')
    cm = fire;          
elseif strcmp(cm, 'Maximally Distinct')
    cm = distinguishable_colors(numCbrewerColors);
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
end
handles.displayProperties.mosaicColormap = cm;
mosaicColormap = cm;
if handles.scanData.header.numScans == 1
    handles.displayProperties.startPoint = 1;
    handles.displayProperties.endPoint = 1;
elseif currentScan == handles.scanData.header.numScans
    handles.displayProperties.startPoint = currentScan;
    handles.displayProperties.endPoint = currentScan;
else
    handles.displayProperties.startPoint = currentScan+1;
    handles.displayProperties.endPoint = currentScan+1;
end
[mosaicHandle]  = mosaicLoop(handles.scanData.data, handles.m,...
    handles.displayProperties, handles.mosaicAxes);
guidata(hObject,handles);
% overlay ROI
refreshROIOverlay(handles);

% invoke trueMaskcolor
if get(handles.overlayMask,'Value') && get(handles.trueColor,'Value')
    set(handles.trueColor, 'Value', 1);
    guidata(hObject, handles);
    hObjectCall = handles.trueColor;
    dfmri('trueColor_Callback',hObjectCall,eventdata,guidata(hObjectCall));
end

% hack to turn on the zoom functionality after this button is pressed
if handles.displayProperties.mosaicZoomOn % a hack to Keep interactivemouse on whenevr the view changes
interactivemouse off;
interactivemouse on;
end
set(handles.statusString, 'String', strcat('Status: Slice color map changed to', {' '''}, tmp,{''''}));

% --- Executes during object creation, after setting all properties.
function mosaicColormap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mosaicColormap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in resetViewMosaic.
function resetViewMosaic_Callback(hObject, eventdata, handles)
% hObject    handle to resetViewMosaic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global viewSwitching;
set(handles.plotAxes, 'HandleVisibility' , 'off');
set(handles.mosaicAxes, 'HandleVisibility' , 'on');
if handles.displayProperties.view == 3 %just a hack to prevent the axes going beserk on pressing the reset button when the view is axial
viewSwitching = 1;
[mosaicHandle]  = mosaicLoop(handles.scanData.data, handles.m,...
        handles.displayProperties, handles.mosaicAxes);
else
axes(handles.mosaicAxes);
interactivemouse RESTORE_ORIG;
end

if handles.displayProperties.mosaicZoomOn % a hack to Keep interactivemouse on whenevr a button is pressed
    try
    interactivemouse off;
    catch
    end
    interactivemouse on;
end

% --- Executes on button press in ResetViewPlot.
function ResetViewPlot_Callback(hObject, eventdata, handles)
% hObject    handle to ResetViewPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global axesNumber;
axesNumber = 1;
% axes(handles.mosaicAxes);
interactivemouse restore_orig;


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in view.
function view_Callback(hObject, eventdata, handles)
% hObject    handle to view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns view contents as cell array
%        contents{get(hObject,'Value')} returns selected item from view
global viewSwitching mask;

contents = cellstr(get(hObject,'String'));
if strcmp(contents{get(hObject,'Value')}, 'Sagittal')
    handles.displayProperties.view = 1;
    viewSwitching = 1;
    [mosaicHandle]  = mosaicLoop(handles.scanData.data, handles.m,...
        handles.displayProperties, handles.mosaicAxes);
elseif strcmp(contents{get(hObject,'Value')}, 'Coronal')
    handles.displayProperties.view = 2;
    viewSwitching = 1;
    [mosaicHandle]  = mosaicLoop(handles.scanData.data, handles.m,...
        handles.displayProperties, handles.mosaicAxes);
elseif strcmp(contents{get(hObject,'Value')}, 'Axial')
    handles.displayProperties.view = 3;
    viewSwitching = 1;
    [mosaicHandle]  = mosaicLoop(handles.scanData.data, handles.m,...
        handles.displayProperties, handles.mosaicAxes);
elseif strcmp(contents{get(hObject,'Value')}, 'Flattened 4D (Scans x Voxels)')
    handles.displayProperties.view = 4;
    viewSwitching = 1;
    [mosaicHandle]  = mosaicLoop(handles.scanData.data, handles.m,...
        handles.displayProperties, handles.mosaicAxes);
elseif strcmp(contents{get(hObject,'Value')}, '3D Orthogonal')
    handles.displayProperties.view = 5;
    viewSwitching = 1;
    [mosaicHandle]  = mosaicLoop(handles.scanData.data, handles.m,...
        handles.displayProperties, handles.mosaicAxes);
else
    handles.displayProperties.view = 6;
    viewSwitching = 1;
    [mosaicHandle]  = mosaicLoop(handles.scanData.data, handles.m,...
        handles.displayProperties,handles.mosaicAxes);
end
guidata(hObject,handles);

% if masked voxels only then 
if get(handles.showMaskedVoxelsOnly, 'Value') == 1
    try
        handles.roi.roiData.imgSag = mask.imgMaskedVoxelsOnlySagittal & handles.roi.roiData.imgSag;
    catch
    end
    try
        handles.roi.roiData.imgCor = mask.imgMaskedVoxelsOnlyCoronal & handles.roi.roiData.imgCor;
    catch
    end
    try
        handles.roi.roiData.imgAxial = mask.imgMaskedVoxelsOnlyAxial & handles.roi.roiData.imgAxial;
    catch
    end
end

% update ROI Data if view switchsa
% if ~isempty(handles.roi.roiData.imgSag) | ~isempty(handles.roi.roiData.imgCor) | ~isempty(handles.roi.roiData.imgAxial)
% colorize ROI
try
    if handles.displayProperties.view == 1
        [posX posY] = find(handles.roi.roiData.imgSag);
        pSag = colorpixel(posY,posX,handles.roi.roiColor);
    elseif handles.displayProperties.view == 2
        [posX posY] = find(handles.roi.roiData.imgCor);
        pCor = colorpixel(posY,posX,handles.roi.roiColor);
    else
        [posX posY] = find(handles.roi.roiData.imgAxial);
        pAxial = colorpixel(posY,posX,handles.roi.roiColor);
    end
catch
end
      if get(handles.trueColor, 'Value') % if true colors is on then
        % invoke trueMaskcolor
        set(handles.trueColor, 'Value', 1);
        hObjectCall = handles.trueColor;
        dfmri('trueColor_Callback',hObjectCall,eventdata,guidata(hObjectCall));
    end  
%     if handles.displayProperties.view == 1
%         if isempty(handles.roi.roiHandle.pSag)
%             handles.roi.roiHandle.pSag = pSag;
%         else
%             handles.roi.roiHandle.pSag = [handles.roi.roiHandle.pSag; reshape(pSag,[],1)];
%         end
%     elseif handles.displayProperties.view == 1
%         if isempty(handles.roi.roiHandle.pCor)
%             handles.roi.roiHandle.pCor = pCor;
%         else
%             handles.roi.roiHandle.pCor = [handles.roi.roiHandle.pCor; reshape(pCor,[],1)];
%         end
%     elseif handles.displayProperties.view == 1
%         if isempty(handles.roi.roiHandle.pAxial)
%             handles.roi.roiHandle.pAxial = pAxial;
%         else
%             handles.roi.roiHandle.pAxial = [handles.roi.roiHandle.pAxial; reshape(pAxial,[],1)];
%         end
%     end
    guidata(hObject,handles);
% end


% hack to turn on the zoom functionality after this button is pressed
if handles.displayProperties.mosaicZoomOn % a hack to Keep interactivemouse on whenevr the view changes
    try
    interactivemouse off;
    catch
    end
    interactivemouse on;
end

% --- Executes during object creation, after setting all properties.
function view_CreateFcn(hObject, eventdata, handles)
% hObject    handle to view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in roiVoxelsSelection.
function roiVoxelsSelection_Callback(hObject, eventdata, handles)
% hObject    handle to roiVoxelsSelection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% make on the mosiac axes visible so that the use can select the voxels in
% the mosaic
global mask lineWidth lineColor;
set(handles.plotAxes, 'HandleVisibility' , 'off');
set(handles.mosaicAxes, 'HandleVisibility' , 'on');

voxelSelectionMethod = 0; 
contents = cellstr(get(hObject,'String'))
method = contents{get(hObject,'Value')}
set( handles.figure1, 'Pointer', 'crosshair' );
if strcmp(method, 'Rectangular')
    set(handles.statusString, 'String', 'Status: Drag a rectangle by clicking the left mouse button, dragging and then releasing the mouse button');
    k = waitforbuttonpress;
    point1 = get(gca,'CurrentPoint');    % button down detected
    set(handles.statusString, 'String', 'Status: Release the left mouse button to end ROI selection.');
    finalRect = rbbox;                   % return figure units
    point2 = get(gca,'CurrentPoint');    % button up detected

    point1 = point1(1,1:2);              % extract x and y
    point2 = point2(1,1:2);
    p1 = min(point1,point2);             % calculate locations
    offset = abs(point1-point2);         % and dimensions
    x = [p1(1) p1(1)+offset(1) p1(1)+offset(1) p1(1) p1(1)]- 0.5; % -0.5 for imagesc start point
    y = [p1(2) p1(2) p1(2)+offset(2) p1(2)+offset(2) p1(2)]- 0.5;
    x = round(x); y = round(y);
    set(handles.statusString, 'String', 'Status: Done');
elseif strcmp(method, 'Polygon')
    set(handles.statusString, 'String', 'Status: Press left mouse button for every edge of the polygon. Press right mouse button to finish the Polygon');
    [x,y] = GETLINE('closed');
    set(handles.statusString, 'String', 'Status: Done')

    x = round(x-0.5); y = round(y-0.5);
else 
    x = [], y =[];
    while ~(strcmp(get(handles.figure1,'SelectionType'), 'alt'))
        set(handles.statusString, 'String', 'Status: Press left mouse button to select a voxel. Press right mouse button to end the selection');
        [x, y] = getpts(handles.mosaicAxes)
    end
    voxelSelectionMethod = 3; 
    set(handles.statusString, 'String', 'Status: Done');
end

set( handles.figure1, 'Pointer', 'arrow' );

%%% plot ROI
if handles.displayProperties.view == 1 | handles.displayProperties.view == 2
    siz = [handles.m.mosaic^2*sqrt(handles.m.xyRes) handles.m.xyRes*sqrt(handles.m.xyRes)];
else
    siz = [handles.m.xyRes*handles.m.mosaic handles.m.xyRes*handles.m.mosaic];
end

% make binary mask
if voxelSelectionMethod == 3;
    posX = round(y(1:end-1)); % ignore the last sample corresponding to the selection END click
    posY = round(x(1:end-1));
    roiMask = logical(zeros(siz(1),siz(2)));
    for j = 1: numel(posX)
        roiMask(posX(j), posY(j)) = 1;
    end    
else
    roiMask = poly2mask(x,y,siz(1),siz(2)); 
end


% OR the masks if there are more than one of them
if  handles.displayProperties.view == 1
    if isempty(handles.roi.roiMaskSag)
        handles.roi.roiMaskSag = roiMask;
    else
        handles.roi.roiMaskSag = handles.roi.roiMaskSag | roiMask;
    end
elseif  handles.displayProperties.view == 2
    if isempty(handles.roi.roiMaskCor)
        handles.roi.roiMaskCor = roiMask;
    else
        handles.roi.roiMaskCor = handles.roi.roiMaskCor | roiMask;        
    end
elseif  handles.displayProperties.view == 3
    if isempty(handles.roi.roiMaskAxial)
        handles.roi.roiMaskAxial = roiMask;
    else
        handles.roi.roiMaskAxial = handles.roi.roiMaskAxial | roiMask;        
    end
end



% convert the mask in all three viewss
[handles.img2Coords.roiMaskSagittal handles.img2Coords.roiMaskCoronal handles.img2Coords.roiMaskAxial] = ...
    mosaic2VoxelsXScansVector(handles.m);
if  handles.displayProperties.view == 1
    roiPositionInData = handles.img2Coords.roiMaskSagittal(find(handles.roi.roiMaskSag));
    
elseif  handles.displayProperties.view == 2
    roiPositionInData = handles.img2Coords.roiMaskCoronal(find(handles.roi.roiMaskCor));
    
else  % handles.displayProperties.view == 3
    roiPositionInData = handles.img2Coords.roiMaskAxial(find(handles.roi.roiMaskAxial));
    
end
numVoxelsIncludingPadding   = (handles.m.xyRes)^2 * (handles.m.mosaic)^2;
ind                         = uint32(zeros(1,numVoxelsIncludingPadding));
ind(roiPositionInData)= 1;
[handles.roi.roiData.imgSag handles.roi.roiData.imgCor handles.roi.roiData.imgAxial] =...
    roiMosaic2VoxelsXScansVector(handles.m, ind);
%update
handles.roi.roiMaskSag = handles.roi.roiData.imgSag;
handles.roi.roiMaskCor = handles.roi.roiData.imgCor;
handles.roi.roiMaskAxial = handles.roi.roiData.imgAxial;

%Or the ROI and anatomical masks
if get(handles.showMaskedVoxelsOnly, 'Value') == 1
    try
        handles.roi.roiData.imgSag = mask.imgMaskedVoxelsOnlySagittal & handles.roi.roiData.imgSag;
    catch
    end
    try
        handles.roi.roiData.imgCor = mask.imgMaskedVoxelsOnlyCoronal & handles.roi.roiData.imgCor;
    catch
    end
    try
        handles.roi.roiData.imgAxial = mask.imgMaskedVoxelsOnlyAxial & handles.roi.roiData.imgAxial;
    catch
    end    
end

% colorize ROI
if handles.displayProperties.view == 1
    [posX posY] = find(handles.roi.roiData.imgSag);
    pSag = colorpixel(posY,posX,handles.roi.roiColor);
elseif handles.displayProperties.view == 2
    [posX posY] = find(handles.roi.roiData.imgCor);
    pCor = colorpixel(posY,posX,handles.roi.roiColor);
else
    [posX posY] = find(handles.roi.roiData.imgAxial);
    pAxial = colorpixel(posY,posX,handles.roi.roiColor);
end


if handles.displayProperties.view == 1
    if isempty(handles.roi.roiHandle.pSag)
        handles.roi.roiHandle.pSag = pSag;
    else
        handles.roi.roiHandle.pSag = [handles.roi.roiHandle.pSag; reshape(pSag,[],1)];
    end
elseif handles.displayProperties.view == 1
    if isempty(handles.roi.roiHandle.pCor)
        handles.roi.roiHandle.pCor = pCor;
    else
        handles.roi.roiHandle.pCor = [handles.roi.roiHandle.pCor; reshape(pCor,[],1)];
    end
elseif handles.displayProperties.view == 1
    if isempty(handles.roi.roiHandle.pAxial)
        handles.roi.roiHandle.pAxial = pAxial;
    else
        handles.roi.roiHandle.pAxial = [handles.roi.roiHandle.pAxial; reshape(pAxial,[],1)];
    end
end
        
guidata(hObject,handles);

%% Call plot 
[handles.img2Coords.sagittal handles.img2Coords.coronal handles.img2Coords.axial] = ...
    mosaic2VoxelsXScansVector(handles.m);

if handles.displayProperties.view == 1
   plotData = handles.scanData.data(handles.img2Coords.sagittal(find(handles.roi.roiData.imgSag)), :); 
   voxelLocation = handles.img2Coords.sagittal(find(handles.roi.roiData.imgSag))
elseif handles.displayProperties.view == 2
   plotData = handles.scanData.data(handles.img2Coords.coronal(find(handles.roi.roiData.imgCor)), :);
   voxelLocation = handles.img2Coords.coronal(find(handles.roi.roiData.imgCor))
else
   plotData = handles.scanData.data(handles.img2Coords.axial(find(handles.roi.roiData.imgAxial)), :);
   voxelLocation = handles.img2Coords.axial(find(handles.roi.roiData.imgAxial))   
end

plotDataMean = mean(plotData,1);
set(handles.plotAxes, 'HandleVisibility' , 'on'); % so that plot is in the plot axes
set(handles.mosaicAxes, 'HandleVisibility' , 'off');

handles.roi.plotDataMean    = plotDataMean;
handles.roi.plotData        = plotData;
handles.roi.maxY        	= max(plotDataMean);
handles.roi.minY            = min(plotDataMean);

xLimitPlot = get(handles.plotAxes, 'XLim'); % get the limits beofre
yLimitPlot = get(handles.plotAxes, 'YLim');

% get the user setting for line thickness and width
if ~isempty(findobj(handles.plotAxes, 'Type', 'Line'))
lineColor = get(findobj(handles.plotAxes, 'Type', 'Line'),'Color');
lineWidth = get(findobj(handles.plotAxes, 'Type', 'Line'),'LineWidth');
end

if ~get(handles.detrendBeforeDisplaying, 'Value') %if the Detrend option is not on then display undetrended data
    h = plot(handles.plotAxes, 1:numel(plotDataMean), plotDataMean,'LineSmoothing','on', 'LineWidth', lineWidth,'Color', lineColor);
    set(handles.plotAxes,'Color',[0 0 0]); % change the plot background to black
    set(h,'uicontextmenu',linecmenu);
    if handles.roi.maxY ~= 0 & handles.roi.minY ~= 0 % avoid error when data is zero
        try
            set(handles.plotAxes,'yLim', [handles.roi.minY handles.roi.maxY]); % change the plot background to black
        catch end
    end
    set(handles.plotAxes,'xLim', [1 numel(plotDataMean)]); % change the plot background to black
else % else display detrended data
    disp('Runing Temporal High Pass Filtering.......................');
    opt.hp = 0.01; % Apply a high-pass filter at cut-off frequency 0.01Hz (slow time drifts)
    opt.lp = Inf;  % Do not apply low-pass filter. Low-pass filter induce a big loss in degrees of freedom without sgnificantly improving the SNR.
    if isempty(handles.scanData.header.TR) % if no TR info exist then explicitly get it from the user
        prompt = {'Please specify TR in seconds'};
        dlg_title = 'TR';
        num_lines = 1;
        def = {'1.5'};
        opt.tr = str2double(inputdlg(prompt,dlg_title,num_lines,def));
        handles.scanData.header.TR = opt.tr;
    else
        opt.tr                      = handles.scanData.header.TR;
    end
    [plotDataDetrended,extras]      = niak_filter_tseries(double(plotData'),opt);
    plotDataDetrended               = plotDataDetrended';
    plotDataMeanDetrended           = mean(plotDataDetrended,1);
    
    plot(handles.plotAxes, 1:numel(plotDataMeanDetrended), plotDataMeanDetrended,'LineSmoothing','on', 'LineWidth', lineWidth,'Color', lineColor);
    set(handles.plotAxes,'Color',[0 0 0]); % change the plot background to black
    
    handles.roi.plotDataMeanDetrended   = plotDataMeanDetrended;
    handles.roi.plotDataDetrended       = plotDataDetrended;
    handles.roi.maxYDetrended           = max(plotDataMeanDetrended);
    handles.roi.minYDetrended           = min(plotDataMeanDetrended);
    set(handles.plotAxes,'yLim',...
        [handles.roi.minYDetrended handles.roi.maxYDetrended ]); % chngle the y axis limit
    set(handles.plotAxes,'xLim', [1 numel(plotDataMeanDetrended)]);
end

set(handles.plotAxes, 'HandleVisibility' , 'off'); % so that control falls back to the mosiac axes
set(handles.mosaicAxes, 'HandleVisibility' , 'on');
guidata(hObject,handles);

% if the user already input a design matrix, then plot it
if handles.designMatrix.conditionCount   ~= 0
    set(handles.okDesignMatrix, 'Value', 1);
    guidata(hObject, handles);
    hObjectCall = handles.okDesignMatrix;
    dfmri('okDesignMatrix_Callback',hObjectCall,eventdata,guidata(hObjectCall));
end

if ~(xLimitPlot(1) == 0 && xLimitPlot(2) == 1)% & ~yLimitPlot == [0 1] %only do it after the zoom has been done
set(handles.plotAxes, 'XLim',xLimitPlot); % get the limits beofre
set(handles.plotAxes, 'YLim',yLimitPlot);
end

% enable the Go again button
set(handles.goAbortRoiSelection,'String', 'Go Again');
set(handles.goAbortRoiSelection,'Visible', 'on');

set(handles.statusString, 'String','Status: Added a new ROI');

function roiVoxelsSelection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to roiVoxelsSelection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in displayDualCursors.
function displayDualCursors_Callback(hObject, eventdata, handles)
% hObject    handle to displayDualCursors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% if no data exists then return
if  isempty(handles.roi.plotData) & isempty(handles.motionRegressors)
    set(handles.displayDualCursors, 'Value', 0);
    msgbox('No data exists to be measured with the dual cursor. First plot the time course of an ROI and then choose this option.', 'OOPS','warn','modal');
    return;
end
set(handles.plotAxes, 'HandleVisibility' , 'on');
set(handles.mosaicAxes, 'HandleVisibility' , 'off');
if get(hObject,'Value') == 1
   dualcursor on;
   [x1x2] = dualcursor(handles.plotAxes);
   dualcursor([4 8],[.05 1.05; .25 1.05],'gs');

else
    dualcursor off;
end
set(handles.plotAxes, 'HandleVisibility' , 'off');
set(handles.mosaicAxes, 'HandleVisibility' , 'on');
guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of displayDualCursors

% --- Executes on button press in plotStandardDeviation.
function plotStandardDeviation_Callback(hObject, eventdata, handles)
% hObject    handle to plotStandardDeviation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of plotStandardDeviation



function zLocation_Callback(hObject, eventdata, handles)
% hObject    handle to zLocation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of zLocation as text
%        str2double(get(hObject,'String')) returns contents of zLocation as a double


% --- Executes during object creation, after setting all properties.
function zLocation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zLocation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yLocation_Callback(hObject, eventdata, handles)
% hObject    handle to yLocation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yLocation as text
%        str2double(get(hObject,'String')) returns contents of yLocation as a double


% --- Executes during object creation, after setting all properties.
function yLocation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yLocation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xLocation_Callback(hObject, eventdata, handles)
% hObject    handle to xLocation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xLocation as text
%        str2double(get(hObject,'String')) returns contents of xLocation as a double


% --- Executes during object creation, after setting all properties.
function xLocation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xLocation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in deleteLastCondition.
function deleteLastCondition_Callback(hObject, eventdata, handles)
% hObject    handle to deleteLastCondition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.plotAxes, 'HandleVisibility' , 'on');
set(handles.mosaicAxes, 'HandleVisibility' , 'off');

if handles.designMatrix.conditionCount == 0
    msgbox('Your highness! There is nothing left to delete. You will crash me if you continue like this.','Warning', 'warn');
    return
end
[x y] = getAxesLimits(handles.plotAxes);

if get(handles.plotMotionRegressors, 'Value') % if motion regressors is on then plot the design matrix over motion regressors
    numScans    = numel(handles.motionRegressors.time);
    x           = [max(handles.motionRegressors.x) min(handles.motionRegressors.x)];
    y           = [max(handles.motionRegressors.y) min(handles.motionRegressors.y)];
    z           = [max(handles.motionRegressors.z) min(handles.motionRegressors.z)];
    maxY        = max([x y z]);
    minY        = min([x y z]);
    makeDesignMatrixBars(numScans,...
        handles.designMatrix.onsets,handles.designMatrix.durations,...
        handles.designMatrix.offset, 0, 1, 0,...
        minY, maxY,...
        handles.designMatrix.colormap, handles.plotAxes,...
        []);
    hold on; % holds the design matrix plot to overlay additional information over it
    % call plot motion regressor again to overlay the motion regressor over
    % the design matrix
    set(handles.plotMotionRegressors, 'Value', 1);
    guidata(hObject, handles);
    hObjectCall = handles.plotMotionRegressors;
    dfmri('plotMotionRegressors_Callback',hObjectCall,eventdata,guidata(hObjectCall));
    hold off;
else
    if handles.designMatrix.conditionCount >= 1
        if get(handles.detrendBeforeDisplaying, 'Value') == 0 % then plot non- detreded data
            makeDesignMatrixBars(handles.scanData.header.numScans,...
                handles.designMatrix.onsets,handles.designMatrix.durations,...
                handles.designMatrix.offset, 0, 1, 0,...
                handles.roi.minY, handles.roi.maxY,...
                handles.designMatrix.colormap, handles.plotAxes,...
                handles.roi.plotData);
        else % otherwise plot detrended data
            makeDesignMatrixBars(handles.scanData.header.numScans,...
                handles.designMatrix.onsets,handles.designMatrix.durations,...
                handles.designMatrix.offset, 0, 1, 0,...
                handles.roi.minYDetrended, handles.roi.maxYDetrended,...
                handles.designMatrix.colormap, handles.plotAxes,...
                handles.roi.plotDataDetrended);
        end
    end
end
% update the data structure as well
handles.designMatrix.onsets(end) = [];
handles.designMatrix.durations(end) = [];
% decrement the condition counter as well
handles.designMatrix.conditionCount = handles.designMatrix.conditionCount -1;
guidata(hObject,handles);
% if zoom is on, keep it on
if get(handles.turnOnZoomAndPanPlot,'Value') == 1
    set(handles.turnOnZoomAndPanPlot, 'Value', 1);
    guidata(hObject, handles);
    hObjectCall = handles.turnOnZoomAndPanPlot;
    dfmri('turnOnZoomAndPanPlot_Callback',hObjectCall,eventdata,guidata(hObjectCall));
end
set(handles.plotAxes, 'HandleVisibility' , 'off');
set(handles.mosaicAxes, 'HandleVisibility' , 'on');
set(handles.statusString, 'String', strcat('Status: ',...
    ' Deleted the last condition. You have a total of ',{' '},...
    num2str(handles.designMatrix.conditionCount), ' condition(s) remaining'));

setAxesLimits(handles.plotAxes, x, y);

% --- Executes on button press in deleteAllConditions.
function deleteAllConditions_Callback(hObject, eventdata, handles)
% hObject    handle to deleteAllConditions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.plotAxes, 'HandleVisibility' , 'on');
set(handles.mosaicAxes, 'HandleVisibility' , 'off');
[x y] = getAxesLimits(handles.plotAxes);
if get(handles.plotMotionRegressors, 'Value') % if motion regressors is on then plot the design matrix over motion regressors
    numScans    = numel(handles.motionRegressors.time);
    x           = [max(handles.motionRegressors.x) min(handles.motionRegressors.x)];
    y           = [max(handles.motionRegressors.y) min(handles.motionRegressors.y)];
    z           = [max(handles.motionRegressors.z) min(handles.motionRegressors.z)];
    maxY        = max([x y z]);
    minY        = min([x y z]);
    makeDesignMatrixBars(numScans,...
        handles.designMatrix.onsets,handles.designMatrix.durations,...
        handles.designMatrix.offset, 0, 0, 1,...
        minY, maxY,...
        handles.designMatrix.colormap, handles.plotAxes,...
        []);
    hold on; % holds the design matrix plot to overlay additional information over it
    % call plot motion regressor again to overlay the motion regressor over
    % the design matrix
    set(handles.plotMotionRegressors, 'Value', 1);
    guidata(hObject, handles);
    hObjectCall = handles.plotMotionRegressors;
    dfmri('plotMotionRegressors_Callback',hObjectCall,eventdata,guidata(hObjectCall));
    hold off;
else
    if get(handles.detrendBeforeDisplaying, 'Value') == 0 % then plot non- detreded data
        makeDesignMatrixBars(handles.scanData.header.numScans,...
            handles.designMatrix.onsets,handles.designMatrix.durations,...
            handles.designMatrix.offset, 0, 0, 1,...
            handles.roi.minY, handles.roi.maxY,...
            handles.designMatrix.colormap, handles.plotAxes,...
            handles.roi.plotData);
    else % otherwise plot detrended data
        makeDesignMatrixBars(handles.scanData.header.numScans,...
            handles.designMatrix.onsets,handles.designMatrix.durations,...
            handles.designMatrix.offset, 0, 0, 1,...
            handles.roi.minYDetrended, handles.roi.maxYDetrended,...
            handles.designMatrix.colormap, handles.plotAxes,...
            handles.roi.plotDataDetrended);
    end
end
% update the data structure as well
    handles.designMatrix.onsets         = [];
    handles.designMatrix.durations      = [];
    handles.designMatrix.conditionCount     = 0;
guidata(hObject,handles);
% if zoom is on, keep it on
if get(handles.turnOnZoomAndPanPlot,'Value') == 1
    set(handles.turnOnZoomAndPanPlot, 'Value', 1);
    guidata(hObject, handles);
    hObjectCall = handles.turnOnZoomAndPanPlot;
    dfmri('turnOnZoomAndPanPlot_Callback',hObjectCall,eventdata,guidata(hObjectCall));
end
set(handles.plotAxes, 'HandleVisibility' , 'off');
set(handles.mosaicAxes, 'HandleVisibility' , 'on');
set(handles.statusString, 'String', strcat('Status: ',...
    ' Deleted all conditions. You have 0 conditions currently defined.'));
setAxesLimits(handles.plotAxes, x, y);

% --- Executes on button press in addANewCondition.
function addANewCondition_Callback(hObject, eventdata, handles)
% hObject    handle to addANewCondition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in okDesignMatrix.
function okDesignMatrix_Callback(hObject, eventdata, handles)
% hObject    handle to okDesignMatrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global lineWidth lineColor;
[x y] = getAxesLimits(handles.plotAxes);
set(handles.plotAxes, 'HandleVisibility' , 'on');
set(handles.mosaicAxes, 'HandleVisibility' , 'off');
onsets      = get(handles.specifyOnsets2,'String');
onsets      = eval(onsets);
durations   = get(handles.specifyDuration,'String');
durations   = eval(durations);

if handles.designMatrix.conditionCount >= 1 % prevents adding a new condition every time an ROI is added: reffresh
    if ~(isequal(onsets,handles.designMatrix.onsets{1,end}) && isequal(durations,handles.designMatrix.durations{1,end}))
        handles.designMatrix.conditionCount     =...
            handles.designMatrix.conditionCount + 1;
        guidata(hObject,handles);
        handles.designMatrix.onsets{1,handles.designMatrix.conditionCount}= onsets;
        handles.designMatrix.durations{1,handles.designMatrix.conditionCount}= durations;
    end
else
    handles.designMatrix.conditionCount     =...
        handles.designMatrix.conditionCount + 1;
    guidata(hObject,handles);
    handles.designMatrix.onsets{1,handles.designMatrix.conditionCount}= onsets;
    handles.designMatrix.durations{1,handles.designMatrix.conditionCount}= durations;
end
guidata(hObject,handles);
% function makeDesignMatrixBars(numScans, onsets, durations, offset, okAddACondition, deleteLastCondition, deleteAllConditions, minY, maxY, colormap,axesHandle)
% handles.designMatrix.maxY = handles.roi.maxY;
% handles.designMatrix.minY = handles.roi.minY;
if get(handles.plotMotionRegressors, 'Value') % if motion regressors is on then plot the design matrix over motion regressors
    numScans    = numel(handles.motionRegressors.time);
    x           = [max(handles.motionRegressors.x) min(handles.motionRegressors.x)];
    y           = [max(handles.motionRegressors.y) min(handles.motionRegressors.y)];
    z           = [max(handles.motionRegressors.z) min(handles.motionRegressors.z)];
    maxY        = max([x y z]);
    minY        = min([x y z]);
    makeDesignMatrixBars(numScans,...
        handles.designMatrix.onsets,handles.designMatrix.durations,...
        handles.designMatrix.offset, 1, 0, 0,...
        minY, maxY,...
        handles.designMatrix.colormap, handles.plotAxes,...
        []);
    hold on; % holds the design matrix plot to overlay additional information over it   
    % call plot motion regressor again to overlay the motion regressor over
    % the design matrix
    set(handles.plotMotionRegressors, 'Value', 1);
    guidata(hObject, handles);
    hObjectCall = handles.plotMotionRegressors;
    dfmri('plotMotionRegressors_Callback',hObjectCall,eventdata,guidata(hObjectCall));
    hold off;
else
% plot design matrix over time courses
    if get(handles.detrendBeforeDisplaying, 'Value') == 0 % then plot non- detreded data
        makeDesignMatrixBars(handles.scanData.header.numScans,...
            handles.designMatrix.onsets,handles.designMatrix.durations,...
            handles.designMatrix.offset, 1, 0, 0,...
            handles.roi.minY, handles.roi.maxY,...
            handles.designMatrix.colormap, handles.plotAxes,...
            handles.roi.plotData);
    else % otherwise plot detrended data
        makeDesignMatrixBars(handles.scanData.header.numScans,...
            handles.designMatrix.onsets,handles.designMatrix.durations,...
            handles.designMatrix.offset, 1, 0, 0,...
            handles.roi.minYDetrended, handles.roi.maxYDetrended,...
            handles.designMatrix.colormap, handles.plotAxes,...
            handles.roi.plotDataDetrended);
    end
end
guidata(hObject, handles);
% if zoom is on, keep it on
if get(handles.turnOnZoomAndPanPlot,'Value') == 1
    set(handles.turnOnZoomAndPanPlot, 'Value', 1);
    guidata(hObject, handles);
    hObjectCall = handles.turnOnZoomAndPanPlot;
    dfmri('turnOnZoomAndPanPlot_Callback',hObjectCall,eventdata,guidata(hObjectCall));
end
set(handles.plotAxes, 'HandleVisibility' , 'off');
set(handles.mosaicAxes, 'HandleVisibility' , 'on');
set(handles.statusString, 'String', strcat('Status: ',...
    ' Added a new condition. You currently have a total of ',{' '},...
    num2str(handles.designMatrix.conditionCount), ' condition(s) defined.'));

setAxesLimits(handles.plotAxes, x,y);



% --- Executes on selection change in listbox5.
function listbox5_Callback(hObject, eventdata, handles)
% hObject    handle to listbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox5


% --- Executes during object creation, after setting all properties.
function listbox5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on listbox5 and none of its controls.
function listbox5_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to listbox5 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



function goToScanNumber_Callback(hObject, eventdata, handles)
% hObject    handle to goToScanNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of goToScanNumber as text
%        str2double(get(hObject,'String')) returns contents of goToScanNumber as a double



% --- Executes during object creation, after setting all properties.
function goToScanNumber_CreateFcn(hObject, eventdata, handles)
% hObject    handle to goToScanNumber (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in jumpToScan.
function jumpToScan_Callback(hObject, eventdata, handles)
% hObject    handle to jumpToScan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global currentScan;
stringEntered = eval(get(handles.goToScanNumber, 'String'));
 handles.displayProperties.startPoint = stringEntered;
  handles.displayProperties.endPoint = stringEntered;
    [mosaicHandle]  = mosaicLoop(handles.scanData.data, handles.m,...
        handles.displayProperties, handles.mosaicAxes);
 currentScan =   stringEntered; 

 % hack to turn on the zoom functionality after this button is pressed
if handles.displayProperties.mosaicZoomOn % a hack to Keep interactivemouse on whenevr a button is pressed
    try
    interactivemouse off;
    catch
    end
    interactivemouse on;
end
guidata(hObject,handles);
 
function offset_Callback(hObject, eventdata, handles)
% hObject    handle to offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function offset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to offset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in addOffset.
function addOffset_Callback(hObject, eventdata, handles)
% hObject    handle to addOffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.plotAxes, 'HandleVisibility' , 'on');
set(handles.mosaicAxes, 'HandleVisibility' , 'off');
[x y] = getAxesLimits(handles.plotAxes);
offset      = get(handles.offset,'String');
offset      = eval(offset);
handles.designMatrix.offset = offset;
guidata(hObject, handles);
if get(handles.plotMotionRegressors, 'Value') % if motion regressors is on then plot the design matrix over motion regressors
    numScans    = numel(handles.motionRegressors.time);
    x           = [max(handles.motionRegressors.x) min(handles.motionRegressors.x)];
    y           = [max(handles.motionRegressors.y) min(handles.motionRegressors.y)];
    z           = [max(handles.motionRegressors.z) min(handles.motionRegressors.z)];
    maxY        = max([x y z]);
    minY        = min([x y z]);
    makeDesignMatrixBars(numScans,...
        handles.designMatrix.onsets,handles.designMatrix.durations,...
        handles.designMatrix.offset, 0, 0, 0,...
        minY, maxY,...
        handles.designMatrix.colormap, handles.plotAxes,...
        []);
    hold on; % holds the design matrix plot to overlay additional information over it
    % call plot motion regressor again to overlay the motion regressor over
    % the design matrix
    set(handles.plotMotionRegressors, 'Value', 1);
    guidata(hObject, handles);
    hObjectCall = handles.plotMotionRegressors;
    dfmri('plotMotionRegressors_Callback',hObjectCall,eventdata,guidata(hObjectCall));
    hold off;
else
if get(handles.detrendBeforeDisplaying, 'Value') == 0 % then plot non- detreded data
    makeDesignMatrixBars(handles.scanData.header.numScans,...
        handles.designMatrix.onsets,handles.designMatrix.durations,...
        handles.designMatrix.offset, 0, 0, 0,...
        handles.roi.minY, handles.roi.maxY,...
        handles.designMatrix.colormap, handles.plotAxes,...
        handles.roi.plotData);
else % otherwise plot detrended data
    makeDesignMatrixBars(handles.scanData.header.numScans,...
        handles.designMatrix.onsets,handles.designMatrix.durations,...
        handles.designMatrix.offset, 0, 0, 0,...
        handles.roi.minYDetrended, handles.roi.maxYDetrended,...
        handles.designMatrix.colormap, handles.plotAxes,...
        handles.roi.plotDataDetrended);
end
end
% if zoom is on, keep it on
if get(handles.turnOnZoomAndPanPlot,'Value') == 1
    set(handles.turnOnZoomAndPanPlot, 'Value', 1);
    guidata(hObject, handles);
    hObjectCall = handles.turnOnZoomAndPanPlot;
    dfmri('turnOnZoomAndPanPlot_Callback',hObjectCall,eventdata,guidata(hObjectCall));
end
set(handles.plotAxes, 'HandleVisibility' , 'off');
set(handles.mosaicAxes, 'HandleVisibility' , 'on');
guidata(hObject,handles);
set(handles.statusString, 'String', strcat('Status: ',...
    ' Shifted ', {' '},...
    num2str(handles.designMatrix.conditionCount), {' '},...
    'condition(s) by an offset of',{' '},...
    num2str(offset)));

setAxesLimits(handles.plotAxes, x, y);

function specifyOnsets2_Callback(hObject, eventdata, handles)
% hObject    handle to specifyOnsets2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% s = get(hObject,'String');
% eval(s)
% handles.designMatirx.onsets{end+1} = eval(s);
% % Hints: get(hObject,'String') returns contents of specifyOnsets2 as text
% %        str2double(get(hObject,'String')) returns contents of specifyOnsets2 as a double
% guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function specifyOnsets2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to specifyOnsets2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function designMatrix_Callback(hObject, eventdata, handles)
% hObject    handle to designMatrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_4_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function saveDesignMatrix_Callback(hObject, eventdata, handles)
% hObject    handle to saveDesignMatrix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in goToCursorLocation.
function goToCursorLocation_Callback(hObject, eventdata, handles)
% hObject    handle to goToCursorLocation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in helpButton.
function helpButton_Callback(hObject, eventdata, handles)
% hObject    handle to helpButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of helpButton


% --------------------------------------------------------------------
function help_Callback(hObject, eventdata, handles)
% hObject    handle to help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function tutorial_Callback(hObject, eventdata, handles)
% hObject    handle to tutorial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function displayHelpWhenIClickAnyting_Callback(hObject, eventdata, handles)
% hObject    handle to displayHelpWhenIClickAnyting (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function detailedDocumentation_Callback(hObject, eventdata, handles)
% hObject    handle to detailedDocumentation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over turnOnZoomAndPanMosaic.
function turnOnZoomAndPanMosaic_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to turnOnZoomAndPanMosaic (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in cap.
function cap_Callback(hObject, eventdata, handles)
% hObject    handle to cap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global axesNumber;
axesNumber = 2;
interactivemouse reset;


% --- Executes on selection change in designMatrixColormap.
function designMatrixColormap_Callback(hObject, eventdata, handles)
% hObject    handle to designMatrixColormap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.plotAxes, 'HandleVisibility' , 'on');
set(handles.mosaicAxes, 'HandleVisibility' , 'off');
[x y] = getAxesLimits(handles.plotAxes);

contents = cellstr(get(hObject,'String'));
cm = contents{get(hObject,'Value')};
handles.designMatrix.colormap = cm;
guidata(hObject,handles);
% function makeDesignMatrixBars(numScans, onsets, durations, offset, okAddACondition, deleteLastCondition, deleteAllConditions, minY, maxY, colormap,axesHandle)
% makeDesignMatrixBars(handles.scanData.header.numScans,...
%     handles.designMatrix.onsets,handles.designMatrix.durations,...
%     handles.designMatrix.offset, 0, 0, 0,...
%     handles.roi.minY, handles.roi.maxY,...
%     handles.designMatrix.colormap, handles.plotAxes, handles.roi.plotData);
if get(handles.plotMotionRegressors, 'Value') % if motion regressors is on then plot the design matrix over motion regressors
    numScans    = numel(handles.motionRegressors.time);
    x           = [max(handles.motionRegressors.x) min(handles.motionRegressors.x)];
    y           = [max(handles.motionRegressors.y) min(handles.motionRegressors.y)];
    z           = [max(handles.motionRegressors.z) min(handles.motionRegressors.z)];
    maxY        = max([x y z]);
    minY        = min([x y z]);
    makeDesignMatrixBars(numScans,...
        handles.designMatrix.onsets,handles.designMatrix.durations,...
        handles.designMatrix.offset, 0, 0, 0,...
        minY, maxY,...
        handles.designMatrix.colormap, handles.plotAxes,...
        []);
    hold on; % holds the design matrix plot to overlay additional information over it
    % call plot motion regressor again to overlay the motion regressor over
    % the design matrix
    set(handles.plotMotionRegressors, 'Value', 1);
    guidata(hObject, handles);
    hObjectCall = handles.plotMotionRegressors;
    dfmri('plotMotionRegressors_Callback',hObjectCall,eventdata,guidata(hObjectCall));
    hold off;
else
if get(handles.detrendBeforeDisplaying, 'Value') == 0 % then plot non- detreded data
    makeDesignMatrixBars(handles.scanData.header.numScans,...
        handles.designMatrix.onsets,handles.designMatrix.durations,...
        handles.designMatrix.offset, 0, 0, 0,...
        handles.roi.minY, handles.roi.maxY,...
        handles.designMatrix.colormap, handles.plotAxes,...
        handles.roi.plotData);
else % otherwise plot detrended data
    makeDesignMatrixBars(handles.scanData.header.numScans,...
        handles.designMatrix.onsets,handles.designMatrix.durations,...
        handles.designMatrix.offset, 0, 0, 0,...
        handles.roi.minYDetrended, handles.roi.maxYDetrended,...
        handles.designMatrix.colormap, handles.plotAxes,...
        handles.roi.plotDataDetrended);
end
end
% if zoom is on, keep it on
if get(handles.turnOnZoomAndPanPlot,'Value') == 1
    set(handles.turnOnZoomAndPanPlot, 'Value', 1);
    guidata(hObject, handles);
    hObjectCall = handles.turnOnZoomAndPanPlot;
    dfmri('turnOnZoomAndPanPlot_Callback',hObjectCall,eventdata,guidata(hObjectCall));
end
set(handles.plotAxes, 'HandleVisibility' , 'off');
set(handles.mosaicAxes, 'HandleVisibility' , 'on');
set(handles.statusString, 'String',...
    strcat('Status: Design matrix color map changed to', {' '''}, handles.designMatrix.colormap,{''''}));
setAxesLimits(handles.plotAxes, x, y);

% --- Executes during object creation, after setting all properties.
function designMatrixColormap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to designMatrixColormap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on mouse press over axes background.
function mosaicAxes_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to mosaicAxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% if plot zoom is on, turn it off

%      import java.awt.*;
%      import java.awt.event.*;
%      rob=Robot;
%      rob.mousePress(InputEvent.BUTTON1_MASK);
%      rob.mouseRelease(InputEvent.BUTTON1_MASK);
% interactivemouse on;

%     set(handles.plotAxes, 'HandleVisibility' , 'off');
%     set(handles.mosaicAxes, 'HandleVisibility' , 'on');
%     guidata(hObject,handles);
%     interactivemouse on ;
%     handles.displayProperties.mosaicZoomOn = 1; % a hack to Keep interactivemouse on whenevr the view changes  

% if get(handles.turnOnZoomAndPanPlot,'Value') == 1
%     set(handles.turnOnZoomAndPanPlot, 'Value', 0);
%     guidata(hObject, handles);
%     hObjectCall = handles.turnOnZoomAndPanPlot;
%     dfmri('turnOnZoomAndPanPlot_Callback',hObjectCall,eventdata,guidata(hObjectCall));
% end
% if plot mosaic is off, turn it on
% if get(handles.turnOnZoomAndPanMosaic,'Value') == 0
%     set(handles.turnOnZoomAndPanMosaic, 'Value', 1);
%     guidata(hObject, handles);
%     hObjectCall = handles.turnOnZoomAndPanMosaic;
%     dfmri('turnOnZoomAndPanMosaic_Callback',hObjectCall,eventdata,guidata(hObjectCall));
% end
% interactivemouse off;

function maskThresholdValue_Callback(hObject, eventdata, handles)
% hObject    handle to maskThresholdValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maskThresholdValue as text
%        str2double(get(hObject,'String')) returns contents of maskThresholdValue as a double
global maskThreshold;
valueEntered = str2double(get(hObject,'String'));
maskThreshold = valueEntered;
hObject = handles.overlayMask;
dfmri('overlayMask_Callback',hObject,eventdata,guidata(hObject));


% --- Executes during object creation, after setting all properties.
function maskThresholdValue_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maskThresholdValue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in goAbortRoiSelection.
function goAbortRoiSelection_Callback(hObject, eventdata, handles)
% hObject    handle to goAbortRoiSelection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selectionMethod = get(handles.roiVoxelsSelection,'Value');
if selectionMethod == 1
    roiVoxelsSelection = 'Rectangular';
elseif selectionMethod == 2
    roiVoxelsSelection = 'Polygon';
else
    roiVoxelsSelection = 'One Voxel at a time';
end

% Turn off plot axes
set(handles.roiVoxelsSelection, 'Value', selectionMethod);
guidata(hObject, handles);
hObjectCall = handles.roiVoxelsSelection;
dfmri('roiVoxelsSelection_Callback',hObjectCall,eventdata,guidata(hObjectCall));

% --- Executes on button press in customizeRoiColor.
function customizeRoiColor_Callback(hObject, eventdata, handles)
% hObject    handle to customizeRoiColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles. statusString, 'String', 'Status: Please pick a color for the ROI.');
roiColor = uicolorpicker;
handles.roi.roiColor = roiColor;

    if handles.displayProperties.view == 1
        [posX posY] = find(handles.roi.roiData.imgSag);
        pSag = colorpixel(posY,posX,handles.roi.roiColor);
    elseif handles.displayProperties.view == 2
        [posX posY] = find(handles.roi.roiData.imgCor);
        pCor = colorpixel(posY,posX,handles.roi.roiColor);
    else
        [posX posY] = find(handles.roi.roiData.imgAxial);
        pAxial = colorpixel(posY,posX,handles.roi.roiColor);
    end
set(handles.roiColorBox, 'BackgroundColor',handles.roi.roiColor);

% if handles.displayProperties.view == 1
%     set(handles.roi.roiHandle.pSag, 'FaceColor', roiColor);
% elseif handles.displayProperties.view == 2
%     set(handles.roi.roiHandle.pCor, 'FaceColor', roiColor);
% else
%     set(handles.roi.roiHandle.pAxial, 'FaceColor', roiColor);
% end

guidata(hObject,handles);
set(handles. statusString, 'String', 'Status: ROI color changed.');

% --------------------------------------------------------------------
function specialMasks_Callback(hObject, eventdata, handles)
% hObject    handle to specialMasks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function aalMask_Callback(hObject, eventdata, handles)
% hObject    handle to aalMask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global maskThreshold;

if isempty(handles.scanData.data) 
    msgbox(['You must have the functional data loaded before you can load '...
        'the mask. So first load the functional data and then load the '...
        'mask data. Only then you will be able to see the mask overlayed ' ...
        'over your functional data. If you only want to view the mask data '...
        'then load it as if it was a functional data. In that case, ' ...
        'just go to the File > Import Data > Functional ...'...
        'and load it like you would do a regular functional scan. '...
        'Pheew !!! That was a big warning.'],...
        'No functional data found', 'warn');
    return;
end
path = mfilename('fullpath');
path = path(1:end-numel('\functions\workHorse\dfmri.m')+2);
pathToAALToolbox = fullfile(path, 'toolboxes', '3aal_for_spm8');
% % Construct a questdlg to ascertain if the data is in MNI space
% choice = questdlg('Is your functional data in MNI sapce?', ...
%     'Functional Data''s space', ...
%     'Yes','No','No');
% % Handle response
% switch choice
%     case 'Yes'
%         [maskData, maskHeader]      = readAALMaskNifti3d(pathToAALToolbox, 'ROI_MNI_V4.nii');
%         
%     case 'No'
set(handles.statusString, 'String', 'Status: Coregistering AAL mask to the functional data. This may take a while...Please be patient');
        coregisterAALMaskToFunctionalData(pathToAALToolbox); pause(0.5);
        [maskData, maskHeader]      = readAALMaskNifti3d(pathToAALToolbox, 'rROI_MNI_V4.nii');        
% end

% format the data in mosaic and get the slice labels and separators
[maskData,maskm]            = prepareMosaicData(maskData, maskHeader);
maskData(find(maskData== 0))= NaN;
% prepare mask in all three views
mask                        = prepareMask(maskData, handles.m);
handles.aalMask             = mask;
guidata(hObject, handles);
% Apply region selection
%prompt the user to slect the regions
set(handles.statusString, 'String', 'Status: Please select anatomical regions to mask.');
regions = selectAnatomicalRegions();
numRegions = numel(regions);
mask.maskAxial = handles.aalMask.maskAxial;
mask.maskSagittal = handles.aalMask.maskSagittal;
mask.maskCoronal = handles.aalMask.maskCoronal;
idxMaskAxial = [];
idxMaskSagittal = [];
idxMaskCoronal = [];
set(handles.statusString, 'String', 'Status: Masking selected anatomical regions....');
% read all the user selected regions and make a mask
for i = 1 : numRegions
        idxAxial = find(mask.maskAxial == regions(i));
        idxSagittal = find(mask.maskSagittal == regions(i));
        idxCoronal = find(mask.maskCoronal == regions(i));
        idxMaskAxial = [idxMaskAxial;  idxAxial];
        idxMaskSagittal = [idxMaskSagittal;  idxSagittal];
        idxMaskCoronal = [idxMaskCoronal;  idxCoronal];
end

maskAxial       = single(nan(size(mask.maskAxial)));
maskSagittal    = single(nan(size(mask.maskSagittal)));
maskCoronal     = single(nan(size(mask.maskCoronal)));

maskAxial(idxMaskAxial)         = mask.maskAxial(idxMaskAxial);
maskSagittal(idxMaskSagittal)   = mask.maskSagittal(idxMaskSagittal);
maskCoronal(idxMaskCoronal)     = mask.maskCoronal(idxMaskCoronal) ;

mask.maskAxial      = maskAxial;
mask.maskSagittal   = maskSagittal;
mask.maskCoronal    = maskCoronal;

% set the controls, disable the threshold slider
maskThreshold                   = 0.0;
set(handles.maskThresholdSlider,'Value', 0);
set(handles.maskThresholdSlider,'Enable', 'inactive');
set(handles.maskThresholdValue,'String', 0);
set(handles.maskThresholdValue,'Enable', 'inactive');
set(handles.selectNewAnatomicalRegions, 'visible', 'on');

handles.maskData.data   = mask;
guidata(hObject, handles);

% invoke overlay mask button
set(handles.overlayMask, 'Value', 1);
guidata(hObject, handles);
hObject = handles.overlayMask;
dfmri('overlayMask_Callback',hObject,eventdata,guidata(hObject));
set(handles.statusString, 'String', 'Status: AAL mask overlayed onto the functional');

% --- Executes on button press in selectNewAnatomicalRegions.
function selectNewAnatomicalRegions_Callback(hObject, eventdata, handles)
% hObject    handle to selectNewAnatomicalRegions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

regions = selectAnatomicalRegions();
numRegions = numel(regions);
mask.maskAxial = handles.aalMask.maskAxial;
mask.maskSagittal = handles.aalMask.maskSagittal;
mask.maskCoronal = handles.aalMask.maskCoronal;
idxMaskAxial = [];
idxMaskSagittal = [];
idxMaskCoronal = [];
% read all the user selected regions and make a mask
for i = 1 : numRegions
        idxAxial = find(mask.maskAxial == regions(i));
        idxSagittal = find(mask.maskSagittal == regions(i));
        idxCoronal = find(mask.maskCoronal == regions(i));
        idxMaskAxial = [idxMaskAxial;  idxAxial];
        idxMaskSagittal = [idxMaskSagittal;  idxSagittal];
        idxMaskCoronal = [idxMaskCoronal;  idxCoronal];
end

maskAxial       = single(nan(size(mask.maskAxial)));
maskSagittal    = single(nan(size(mask.maskSagittal)));
maskCoronal     = single(nan(size(mask.maskCoronal)));

maskAxial(idxMaskAxial)         = mask.maskAxial(idxMaskAxial);
maskSagittal(idxMaskSagittal)   = mask.maskSagittal(idxMaskSagittal);
maskCoronal(idxMaskCoronal)     = mask.maskCoronal(idxMaskCoronal) ;

mask.maskAxial      = maskAxial;
mask.maskSagittal   = maskSagittal;
mask.maskCoronal    = maskCoronal;

handles.maskData.data   = mask;
guidata(hObject, handles);

% invoke overlay mask button
set(handles.overlayMask, 'Value', 1);
guidata(hObject, handles);
hObject = handles.overlayMask;
dfmri('overlayMask_Callback',hObject,eventdata,guidata(hObject));


function intializeBrigtnessContrast(handles,eventdata,hObject,data)
global brightness contrast;
% get brightness contrast value so that the image is always visible
 
brightness = max(max(data));
contrast   = min(min(data));

set(handles.contrastSlider, 'Min', contrast - 100);
set(handles.contrastSlider, 'Max', brightness-1);
set(handles.brightnessSlider, 'Min', brightness);
set(handles.brightnessSlider, 'Max', brightness + 1000);
set(handles.brightnessSlider, 'Value', brightness);
set(handles.contrastSlider, 'Value', contrast);
set(handles.brightnessValue, 'String', num2str(brightness));
set(handles.contrastValue, 'String', num2str(contrast));
guidata(hObject,handles);


% --------------------------------------------------------------------
function Maps_Callback(hObject, eventdata, handles)
% hObject    handle to Maps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global specialData;
specialData                                    = 1;

% --------------------------------------------------------------------
function tmap_Callback(hObject, eventdata, handles)
% hObject    handle to tmap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function tmapNifti3D_Callback(hObject, eventdata, handles)
% hObject    handle to tmapNifti3D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
niftiFunctional3d_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function tmapAnalyze_Callback(hObject, eventdata, handles)
% hObject    handle to tmapAnalyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
analyzeFunctional_Callback(hObject, eventdata, handles)

function refreshROIOverlay(handles)
% overlay ROI
if ~isempty(handles.roi.roiData)
    if handles.displayProperties.view == 1
        [posX posY] = find(handles.roi.roiData.imgSag);
        pSag = colorpixel(posY,posX,handles.roi.roiColor);
    elseif handles.displayProperties.view == 2
        [posX posY] = find(handles.roi.roiData.imgCor);
        pCor = colorpixel(posY,posX,handles.roi.roiColor);
    else
        [posX posY] = find(handles.roi.roiData.imgAxial);
        pAxial = colorpixel(posY,posX,handles.roi.roiColor);
    end
end



% --------------------------------------------------------------------
function saveMask_Callback(hObject, eventdata, handles)
% hObject    handle to saveMask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function saveMaskedFunctionalData_Callback(hObject, eventdata, handles)
% hObject    handle to saveMaskedFunctionalData (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function saveNifti3dDataMasked_Callback(hObject, eventdata, handles)
% hObject    handle to saveNifti3dDataMasked (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function saveAnalyzeDataMasked_Callback(hObject, eventdata, handles)
% hObject    handle to saveAnalyzeDataMasked (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function saveMatlabMatMask_Callback(hObject, eventdata, handles)
% hObject    handle to saveMatlabMatMask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mask maskThreshold;
if isempty(mask)
    msgbox('You must import a mask before you can save it', 'No mask found !', 'warn', 'modal');
    return;
end
set(handles.statusString, 'String', 'Status: ');

% if show maked voxels only is off, then turn it on to get the desired data
% and turn it off later
showMaskedVoxelsOnlyStatus = get(handles.showMaskedVoxelsOnly, 'Value');
if showMaskedVoxelsOnlyStatus == 0
    set(handles.showMaskedVoxelsOnly, 'Value', 1);
    guidata(hObject, handles);
    hObjectCall = handles.showMaskedVoxelsOnly;
    dfmri('showMaskedVoxelsOnly_Callback',hObjectCall,eventdata,guidata(hObjectCall));
end

% convert the mask in the current views in binary
if  handles.displayProperties.view == 1
    binaryMask = mask.imgMaskedVoxelsOnlySagittal;
elseif  handles.displayProperties.view == 2
    binaryMask = mask.imgMaskedVoxelsOnlyCoronal;    
else  % handles.displayProperties.view == 3
    binaryMask = mask.imgMaskedVoxelsOnlyAxial;    
end
    binaryMask(find(binaryMask)) = 1;
    
% pick the ind of the masked voxels
[handles.saveMaskedData.coordsSag handles.saveMaskedData.coordsCor handles.saveMaskedData.coordsAxial] = ...
    mosaic2VoxelsXScansVector(handles.m);
if  handles.displayProperties.view == 1
    idx = handles.saveMaskedData.coordsSag(find(binaryMask));
elseif  handles.displayProperties.view == 2
    idx = handles.saveMaskedData.coordsCor(find(binaryMask));    
else  % handles.displayProperties.view == 3
    idx = handles.saveMaskedData.coordsAxial(find(binaryMask));    
end

% choose masked voxels, set the rest to zero
d.data = single(zeros(numel(binaryMask),1));
d.data(idx,:) = 1;
d.header = handles.scanData.header; 
%discard the zero padding
d.data = d.data(1 : d.header.numSlices * d.header.xRes * d.header.yRes ,:);
% desquarify
if exist('handles.scanData.header.squarified','var')
    if handles.scanData.header.squarified
    d.data = desquarify(handles.scanData.header, d.data);
    end
end
[FileName,PathName,FilterIndex] = uiputfile('*.mat');
set(handles.statusString, 'String', 'Status: Started saving masked ......Please be patient !!!!');


d.mask              = mask;
d.maskThreshold     = maskThreshold;
d.binary_mask       = d.data;  % this is the data user can use later on


% Construct a questdlg with three options
choice = questdlg(['Do you want to save the header information as well ',...
    'alongwith the binary mask? By saving header information, it will be easier '...
    'for you to load the mask again in Analyze4D.'], ...
    'Save options', ...
    'Yes, save the header information too (Recommended)',...
    'No, just save the binary mask. Don''t save the header information',...
    'Yes, save the header information too (Recommended)');
% Handle response
switch choice
    case 'Yes, save the header information too (Recommended)'
        save(fullfile(PathName,FileName),'d');
    case 'No, just save the binary mask. Don''t save the header information'
        binary_mask = d.binary_mask;
        save(fullfile(PathName,FileName),'binary_mask'); 
end


% return the show masked voxels only to its previous position
if showMaskedVoxelsOnlyStatus == 0
    set(handles.showMaskedVoxelsOnly, 'Value', 0);
    guidata(hObject, handles);
    hObjectCall = handles.showMaskedVoxelsOnly;
    dfmri('showMaskedVoxelsOnly_Callback',hObjectCall,eventdata,guidata(hObjectCall));
end
set(handles.statusString, 'String', 'Status: The current mask has been successfully saved. !!!!');

% --------------------------------------------------------------------
function saveNifti3DMask_Callback(hObject, eventdata, handles)
% hObject    handle to saveNifti3DMask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function saveAnalyzeMask_Callback(hObject, eventdata, handles)
% hObject    handle to saveAnalyzeMask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function analyzeMask_Callback(hObject, eventdata, handles)
% hObject    handle to analyzeMask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global maskThreshold;
maskThreshold                   = 0.5;
set(handles.maskThresholdSlider,'Enable', 'on');
set(handles.maskThresholdValue,'Enable', 'on');
set(handles.maskThresholdSlider,'Value', maskThreshold);
set(handles.maskThresholdValue,'String', maskThreshold);
set(handles.selectNewAnatomicalRegions, 'visible', 'off');


if isempty(handles.scanData.data) 
    msgbox(['You must have the functional data loaded before you can load '...
        'the mask. So first load the functional data and then load the '...
        'mask data. Only then you will be able to see the mask overlayed ' ...
        'over your functional data. If you only want to view the mask data '...
        'then load it as if it was a functional data. In that case, ' ...
        'just go to the File > Import Data > Functional ...'...
        'and load it like you would do a regular functional scan. '...
        'Pheew !!! That was a big warning.'],...
        'No functional data found', 'warn');
    return;
end
[maskData, maskHeader]      = readMaskAnalyze(1);
% format the data in mosaic and get the slice labels and separators
[maskData,maskm]            = prepareMosaicData(maskData, maskHeader);
maskData(find(maskData== 0))= NaN;

% prepare mask in all three views
mask                        = prepareMask(maskData, handles.m);
handles.maskData.data       = mask;
% handles.maskData.header     = maskHeader;
% handles.maskm               = maskm;
guidata(hObject, handles);

% invoke overlay mask button
set(handles.overlayMask, 'Value', 1);
guidata(hObject, handles);
hObject = handles.overlayMask;
dfmri('overlayMask_Callback',hObject,eventdata,guidata(hObject));
set(handles.statusString, 'String', 'Status: Mask loaded.');


% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function askAQuestion_Callback(hObject, eventdata, handles)
% hObject    handle to askAQuestion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sendEmail();

% --------------------------------------------------------------------
function reportABug_Callback(hObject, eventdata, handles)
% hObject    handle to reportABug (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
sendEmail();

% --------------------------------------------------------------------
function aboutAnalyze4D_Callback(hObject, eventdata, handles)
% hObject    handle to aboutAnalyze4D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function stats_Callback(hObject, eventdata, handles)
% hObject    handle to stats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function matlabMatRoi_Callback(hObject, eventdata, handles)
% hObject    handle to matlabMatRoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function nifti3dRoi_Callback(hObject, eventdata, handles)
% hObject    handle to nifti3dRoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function analyzeRoi_Callback(hObject, eventdata, handles)
% hObject    handle to analyzeRoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function saveMatabMatRoi_Callback(hObject, eventdata, handles)
% hObject    handle to saveMatabMatRoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function saveNifti3dRoi_Callback(hObject, eventdata, handles)
% hObject    handle to saveNifti3dRoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function saveAnalyzeRoi_Callback(hObject, eventdata, handles)
% hObject    handle to saveAnalyzeRoi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function statistics_Callback(hObject, eventdata, handles)
% hObject    handle to statistics (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global mask maskThreshold;
% ROI stats
numRoiVoxels = 0;
try
    numRoiVoxels = numel(find(handles.roi.roiData.imgSag));
end
try
    numRoiVoxels = numel(find(handles.roi.roiData.imgCor));
end
try
    numRoiVoxels = numel(find(handles.roi.roiData.imgAxial));
end

dispString1 = strcat('Number of voxels in ROI:',{'            '}, num2str(numRoiVoxels));

% Mask stats
numMaskedVoxels = 0;
try
    numMaskedVoxels = numel(find(mask.maskSagittal/max(max(mask.maskSagittal)) > maskThreshold));
end
try
    numMaskedVoxels =     numel(find(mask.maskAxial/max(max(mask.maskAxial)) > maskThreshold));
end
try
    numMaskedVoxels =     numel(find(mask.maskCoronal/max(max(mask.maskCoronal)) > maskThreshold));
end

if get(handles.overlayMask,'Value')
dispString2 = strcat('Number of voxels in Mask:',{'         '}, num2str(numMaskedVoxels));
else
dispString2 = strcat('Number of voxels in Mask:',{'         '}, num2str(numMaskedVoxels),{' '},'(Hidden- Enable Overlay Mask to see the masked voxels)');

end

fullString = [dispString1;dispString2];
statistics(fullString);


% --------------------------------------------------------------------
function checkForUpdates_Callback(hObject, eventdata, handles)
% hObject    handle to checkForUpdates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function requestAFeature_Callback(hObject, eventdata, handles)
% hObject    handle to requestAFeature (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function importReadyMadeAalMask_Callback(hObject, eventdata, handles)
% hObject    handle to importReadyMadeAalMask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global maskThreshold;

path = mfilename('fullpath');
path = path(1:end-numel('\functions\workHorse\dfmri.m')+2);
pathToAALToolbox = fullfile(path, 'toolboxes', '3aal_for_spm8');

        [maskData, maskHeader]      = readMaskNifti3d(1);        
% end

% format the data in mosaic and get the slice labels and separators
[maskData,maskm]            = prepareMosaicData(maskData, maskHeader);
maskData(find(maskData== 0))= NaN;

% prepare mask in all three views
mask                        = prepareMask(maskData, handles.m);
handles.aalMask             = mask;
guidata(hObject, handles);
% Apply region selection
%prompt the user to slect the regions
set(handles.statusString, 'String', 'Status: Please select anatomical regions to mask.');
regions = selectAnatomicalRegions();
numRegions = numel(regions);
mask.maskAxial = handles.aalMask.maskAxial;
mask.maskSagittal = handles.aalMask.maskSagittal;
mask.maskCoronal = handles.aalMask.maskCoronal;
idxMaskAxial = [];
idxMaskSagittal = [];
idxMaskCoronal = [];
set(handles.statusString, 'String', 'Status: Masking selected anatomical regions....');
% read all the user selected regions and make a mask
for i = 1 : numRegions
        idxAxial = find(mask.maskAxial == regions(i));
        idxSagittal = find(mask.maskSagittal == regions(i));
        idxCoronal = find(mask.maskCoronal == regions(i));
        idxMaskAxial = [idxMaskAxial;  idxAxial];
        idxMaskSagittal = [idxMaskSagittal;  idxSagittal];
        idxMaskCoronal = [idxMaskCoronal;  idxCoronal];
end

maskAxial       = single(nan(size(mask.maskAxial)));
maskSagittal    = single(nan(size(mask.maskSagittal)));
maskCoronal     = single(nan(size(mask.maskCoronal)));

maskAxial(idxMaskAxial)         = mask.maskAxial(idxMaskAxial);
maskSagittal(idxMaskSagittal)   = mask.maskSagittal(idxMaskSagittal);
maskCoronal(idxMaskCoronal)     = mask.maskCoronal(idxMaskCoronal) ;

mask.maskAxial      = maskAxial;
mask.maskSagittal   = maskSagittal;
mask.maskCoronal    = maskCoronal;

% set the controls, disable the threshold slider
maskThreshold                   = 0.0;
set(handles.maskThresholdSlider,'Value', 0);
set(handles.maskThresholdSlider,'Enable', 'inactive');
set(handles.maskThresholdValue,'String', 0);
set(handles.maskThresholdValue,'Enable', 'inactive');
set(handles.selectNewAnatomicalRegions, 'visible', 'on');

handles.maskData.data   = mask;
guidata(hObject, handles);

% invoke overlay mask button
set(handles.overlayMask, 'Value', 1);
guidata(hObject, handles);
hObject = handles.overlayMask;
dfmri('overlayMask_Callback',hObject,eventdata,guidata(hObject));
set(handles.statusString, 'String', 'Status: AAL mask overlayed onto the functional');


% --------------------------------------------------------------------
function aalMaskSlowMethod_Callback(hObject, eventdata, handles)
% hObject    handle to aalMaskSlowMethod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global maskThreshold;

if isempty(handles.scanData.data) 
    msgbox(['You must have the functional data loaded before you can load '...
        'the mask. So first load the functional data and then load the '...
        'mask data. Only then you will be able to see the mask overlayed ' ...
        'over your functional data. If you only want to view the mask data '...
        'then load it as if it was a functional data. In that case, ' ...
        'just go to the File > Import Data > Functional ...'...
        'and load it like you would do a regular functional scan. '...
        'Pheew !!! That was a big warning.'],...
        'No functional data found', 'warn');
    return;
end
path = mfilename('fullpath');
path = path(1:end-numel('\functions\workHorse\dfmri.m')+2);
pathToAALToolbox = fullfile(path, 'toolboxes', '3aal_for_spm8');

pathstr = realignAalMaskSlowMethod(pathToAALToolbox); pause(0.5);
[maskData, maskHeader]      = readAALMaskNifti3d(pathToAALToolbox, 'wwROI_MNI_V4.nii');        
% end

% format the data in mosaic and get the slice labels and separators
[maskData,maskm]            = prepareMosaicData(maskData, maskHeader);
maskData(find(maskData== 0))= NaN;
% prepare mask in all three views
mask                        = prepareMask(maskData, handles.m);
handles.aalMask             = mask;
guidata(hObject, handles);
% Apply region selection
%prompt the user to slect the regions
set(handles.statusString, 'String', 'Status: Please select anatomical regions to mask.');
regions = selectAnatomicalRegions();
numRegions = numel(regions);
mask.maskAxial = handles.aalMask.maskAxial;
mask.maskSagittal = handles.aalMask.maskSagittal;
mask.maskCoronal = handles.aalMask.maskCoronal;
idxMaskAxial = [];
idxMaskSagittal = [];
idxMaskCoronal = [];
set(handles.statusString, 'String', 'Status: Masking selected anatomical regions....');
% read all the user selected regions and make a mask
for i = 1 : numRegions
        idxAxial = find(mask.maskAxial == regions(i));
        idxSagittal = find(mask.maskSagittal == regions(i));
        idxCoronal = find(mask.maskCoronal == regions(i));
        idxMaskAxial = [idxMaskAxial;  idxAxial];
        idxMaskSagittal = [idxMaskSagittal;  idxSagittal];
        idxMaskCoronal = [idxMaskCoronal;  idxCoronal];
end

maskAxial       = single(nan(size(mask.maskAxial)));
maskSagittal    = single(nan(size(mask.maskSagittal)));
maskCoronal     = single(nan(size(mask.maskCoronal)));

maskAxial(idxMaskAxial)         = mask.maskAxial(idxMaskAxial);
maskSagittal(idxMaskSagittal)   = mask.maskSagittal(idxMaskSagittal);
maskCoronal(idxMaskCoronal)     = mask.maskCoronal(idxMaskCoronal) ;

mask.maskAxial      = maskAxial;
mask.maskSagittal   = maskSagittal;
mask.maskCoronal    = maskCoronal;

% set the controls, disable the threshold slider
maskThreshold                   = 0.0;
set(handles.maskThresholdSlider,'Value', 0);
set(handles.maskThresholdSlider,'Enable', 'inactive');
set(handles.maskThresholdValue,'String', 0);
set(handles.maskThresholdValue,'Enable', 'inactive');
set(handles.selectNewAnatomicalRegions, 'visible', 'on');

handles.maskData.data   = mask;
guidata(hObject, handles);

% invoke overlay mask button
set(handles.overlayMask, 'Value', 1);
guidata(hObject, handles);
hObject = handles.overlayMask;
dfmri('overlayMask_Callback',hObject,eventdata,guidata(hObject));
set(handles.statusString, 'String', 'Status: AAL mask overlayed onto the functional');


% --------------------------------------------------------------------
function convertDicomsToNIFTI3d_Callback(hObject, eventdata, handles)
% hObject    handle to convertDicomsToNIFTI3d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function convertDicomsIMAToNIFTI3d_Callback(hObject, eventdata, handles)
% hObject    handle to convertDicomsIMAToNIFTI3d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function saveTimeCourseFigure_Callback(hObject, eventdata, handles)
% hObject    handle to saveTimeCourseFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = figure;
set(h, 'Name', 'Time Course Figure');
set(h, 'NumberTitle', 'off');
% copy axes into the new figure
newax = copyobj(handles.plotAxes,h); 
legendHandle = findobj(handles.figure1, 'tag','legend');
newax = copyobj(legendHandle,h);
            
arg = {h;'Time Course Figure'};
saveFig(arg);


% --------------------------------------------------------------------
function saveMosaicFigure_Callback(hObject, eventdata, handles)
% hObject    handle to saveMosaicFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% create a new figure for saving and printing
set(handles.mosaicAxes, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.00 .00] , ...
  'XMinorTick'  , 'off'      , ...
  'YMinorTick'  , 'off'      , ...
  'YGrid'       , 'off'      , ...
  'XColor'      , [.3 .3 .3], ...
  'YColor'      , [.3 .3 .3], ...
  'LineWidth'   , 1         );
axis(handles.mosaicAxes,'off'); % so that axis is not printed
% axis image;
h = figure;
set(h, 'Name', 'Mosaic Figure');

set(h, 'NumberTitle', 'off');
% copy axes into the new figure
newax = copyobj(handles.mosaicAxes,h); 
axis(newax,'image'); % so that axis is not printed

arg = {h;'Mosaic Figure'};
saveFig(arg);
set(handles.mosaicAxes, ...
  'XColor'      , [0 0 0], ...
  'YColor'      , [0 0 0], ...
  'LineWidth'   , 1         );
axis(handles.mosaicAxes,'on');
% axis square;
% --------------------------------------------------------------------
function saveMosaicFigure_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to saveMosaicFigure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function todo

% TODO
% what if user load multiple masks, currently we dont handle it
% AAL mask coregisters only to NIFTI reference scan-- add support for other
% formats as well
% the export figure for time course does not import legends
% the export figure crashes if the interactive zzoom is on.
% in plot zoom is on and you try to chnage mask color, the mosaic is drawn
% on the plot axes

% if you add a new roi, a new condition gets added chaging the color of the
% design matrix

% the autoscaling of plot axis does not work if the new roi is out of the
% previous axes limits

% the linecmeu- the plot color and line thickneess changes everytime a new
% roi is added
% the .mat file are created in c drive matlab driectory. if permisssion are
% not there, these files cannot be writtend and hence generate an error

% make high resolution favicon for macs
% the path cannot be saved on macs because of operating system restrictions
% add the read header function ffrom working filedtrip[

% the mask voxel location is not correct. it displays the wrong location
function [x y] = getAxesLimits(axesHandle)
x = get(axesHandle, 'XLim');
y = get(axesHandle, 'YLim');

function setAxesLimits(axesHandle, x, y)
set(axesHandle, 'XLim', x);
set(axesHandle, 'YLim', y);


% --- Executes on button press in checkbox17.
function checkbox17_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox17


% --- Executes on button press in trueColor.
function trueColor_Callback(hObject, eventdata, handles)
% hObject    handle to trueColor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global maskThreshold;

if get(handles.trueColor, 'Value')
    tic
    % turn the trueColor buttons on
    if strcmp(get(handles.colormapTrueColorsStaticText, 'visible'), 'off')
        set(handles.colormapTrueColorsStaticText, 'visible', 'on');
        set(handles.colormapTrueColors, 'visible', 'on');
        set(handles.customizeMaskColor, 'visible', 'off');
        set(handles.maskColorBox, 'visible', 'off');
    end
    
    % turn off the mask overlay
    set(handles.overlayMask, 'Value', 0);
    guidata(hObject, handles);
    hObject = handles.overlayMask;
    dfmri('overlayMask_Callback',hObject,eventdata,guidata(hObject));
    set(handles.overlayMask, 'Value', 1); % jsut show that overlaying is on
    
    % find index
    idxAxial        = find(~isnan(handles.maskData.data.maskAxial));
    idxSagittal     = find(~isnan(handles.maskData.data.maskSagittal));
    idxCoronal      = find(~isnan(handles.maskData.data.maskCoronal));
    
    % Find voxel values 
    maskVoxelValuesAxial    = handles.maskData.data.maskAxial(idxAxial);
    maskVoxelValuesSagittal = handles.maskData.data.maskSagittal(idxSagittal);
    maskVoxelValuesCoronal  = handles.maskData.data.maskCoronal(idxCoronal);
    
    %find x y coords
    [axialY axialX]             = find(~isnan(handles.maskData.data.maskAxial));
    [sagittalY sagittalX]       = find(~isnan(handles.maskData.data.maskSagittal));
    [coronalY  coronalX]        = find(~isnan(handles.maskData.data.maskCoronal));
    
    %map colorn
    minValue = min(maskVoxelValuesAxial);
    maxValue = max(maskVoxelValuesAxial);
    numSteps = 256;% chnage it to 256
    chosenMap   = handles.mask.chosenTruecolorColormap;
    if strcmp(chosenMap,'None')
        return;
    elseif strcmp(chosenMap,'Hot')
        cm = hot(numSteps);
    elseif strcmp(chosenMap,'Fire')
        cm = fire(numSteps);
    elseif strcmp(chosenMap,'Jet')
        cm = jet(numSteps);
    elseif strcmp(chosenMap,'Bone')
        cm = bone(numSteps);
    elseif strcmp(chosenMap,'Winter')
        cm = winter(numSteps);
    elseif strcmp(chosenMap,'Cool')
        cm = cool(numSteps);
    elseif strcmp(chosenMap,'Maximally Distinct')
%         prompt = 'define name'
%         dlg_title = 'Input file name';
%         num_lines = 1;
%         def = {'01'};
%         answer = inputdlg(prompt,dlg_title,num_lines,def);
%         answer = str2double(answer{1,1});
cm =[];
cm(end+1,:) =[ 1     0     0];
cm(end+1,:) =[1.0000    0.4039    0.4039];
cm(end+1,:) =[0.0824    0.0824    0.6431];
cm(end+1,:) =[0.4824    0.4824    0.9961];
cm(end+1,:) =[ 0     1     0];
cm(end+1,:) =[ 0.4706    0.9804    0.4706];
cm(end+1,:) =[ 0.7569    0.1647    0.8510];
cm(end+1,:) =[ 1.0000    0.8000         0];
cm(end+1,:) =[ 0.9882    0.9882    0.4196];

    else
        cm = hot(numSteps);
    end
    range = linspace(minValue, maxValue, numSteps); 
    
    
    
    
    
    
    maxSagittal = max(max(handles.maskData.data.maskSagittal));
    maxCoronal = max(max(handles.maskData.data.maskCoronal));
    maxAxial = max(max(handles.maskData.data.maskAxial));

    trueColorHandleFull = [];
    set(handles.statusString, 'String', 'Status: Calculating true color for the mask....please be patient!');
    pause(0.1);
    toc
    tic
    for i = 1 : numel(idxAxial)
        if handles.displayProperties.view == 1
            if  handles.maskData.data.maskSagittal(idxSagittal(i))/maxSagittal < maskThreshold
                continue;
            else
                maskVoxelValueSagittal = handles.maskData.data.maskSagittal(idxSagittal(i));
                if ~strcmp(chosenMap,'Maximally Distinct')
                    [r,c,V] = findnearest(maskVoxelValueSagittal,range,-1);
                    trueColorHandle =  colorpixel(sagittalX(i),sagittalY(i),cm(c,:));
                else
                    colorVector = calcualteUniqueColor(maskVoxelValueSagittal,cm);
                    trueColorHandle =  colorpixel(sagittalX(i),sagittalY(i), colorVector);
                end
                trueColorHandleFull = [trueColorHandleFull trueColorHandle];
            end
        elseif handles.displayProperties.view == 2
            if  handles.maskData.data.maskCoronal(idxCoronal(i))/maxCoronal < maskThreshold
                continue;
            else
                maskVoxelValueCoronal = handles.maskData.data.maskCoronal(idxCoronal(i));
                if ~strcmp(chosenMap,'Maximally Distinct')
                    [r,c,V] = findnearest(maskVoxelValueCoronal,range,-1);
                    trueColorHandle =  colorpixel(coronalX(i),coronalY(i),cm(c,:));
                else
                    colorVector = calcualteUniqueColor(maskVoxelValueCoronal,cm);                    
                    trueColorHandle =  colorpixel(coronalX(i),coronalY(i),colorVector);
                end
                trueColorHandleFull = [trueColorHandleFull trueColorHandle];
            end
        elseif handles.displayProperties.view == 3
            if  handles.maskData.data.maskAxial(idxAxial(i))/maxAxial < maskThreshold
                continue;
            else
                maskVoxelValueAxial = handles.maskData.data.maskAxial(idxAxial(i));
                if  ~strcmp(chosenMap,'Maximally Distinct')
                    [r,c,V] = findnearest(maskVoxelValueAxial,range,-1);
                    trueColorHandle =  colorpixel(axialX(i),axialY(i),cm(c,:));
                else
                    colorVector = calcualteUniqueColor(maskVoxelValueAxial,cm);                    
                    trueColorHandle =  colorpixel(axialX(i),axialY(i),colorVector);
                end
                trueColorHandleFull = [trueColorHandleFull trueColorHandle];
            end
        end
        handles.trueColorHandleFull = trueColorHandleFull; %save the handles
        guidata(hObject,handles);
    end
    set(handles.statusString, 'String', 'Status: Mask has been colored to true colors!');
    toc
else %clear all the handles
    for i = 1 : numel(handles.trueColorHandleFull)
        delete(handles.trueColorHandleFull(i));
    end
    set(handles.colormapTrueColorsStaticText, 'visible', 'off');
    set(handles.colormapTrueColors, 'visible', 'off');
    set(handles.customizeMaskColor, 'visible', 'on');
    set(handles.maskColorBox, 'visible', 'on');
    clear handles.trueColorHandleFull;
    guidata(hObject,handles);
    
        % turn on the mask overlay
    set(handles.overlayMask, 'Value', 1);
    guidata(hObject, handles);
    hObject = handles.overlayMask;
    dfmri('overlayMask_Callback',hObject,eventdata,guidata(hObject));
end
% Hint: get(hObject,'Value') returns toggle state of trueColor

 function colorVector = calcualteUniqueColor(maskValue,cm)
if maskValue == 55
    colorVector = cm(1,:);
elseif maskValue == 56
    colorVector = cm(2,:);
elseif maskValue == 47
    colorVector = cm(3,:);
elseif maskValue == 48
    colorVector = cm(4,:);
elseif maskValue == 53
    colorVector = cm(5,:);
elseif maskValue == 54
    colorVector = cm(6,:);
elseif maskValue == 40
    colorVector = cm(7,:);
elseif maskValue == 86
    colorVector = cm(8,:);
elseif maskValue == 82
    colorVector = cm(9,:);
end   
     
% --- Executes on selection change in colormapTrueColors.
function colormapTrueColors_Callback(hObject, eventdata, handles)
% hObject    handle to colormapTrueColors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns colormapTrueColors contents as cell array
%        contents{get(hObject,'Value')} returns selected item from colormapTrueColors

% first delete the handles to previous colormaped pixels
try
    for i = 1 : numel(handles.trueColorHandleFull)
        delete(handles.trueColorHandleFull(i));
    end
    guidata(hObject,handles);
end  
    
contents = cellstr(get(hObject,'String'));
handles.mask.chosenTruecolorColormap = contents{get(hObject,'Value')};
guidata(hObject,handles);
% invoke trueMaskcolor
hObjectCall = handles.trueColor;
dfmri('trueColor_Callback',hObjectCall,eventdata,guidata(hObjectCall));
set(handles.statusString, 'String', 'Status: Colormap for the mask changed!');

% --- Executes during object creation, after setting all properties.
function colormapTrueColors_CreateFcn(hObject, eventdata, handles)
% hObject    handle to colormapTrueColors (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function saveAALMask_Callback(hObject, eventdata, handles)
% hObject    handle to saveAALMask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
path = mfilename('fullpath');
path = path(1:end-numel('\functions\workHorse\dfmri.m')+2);
pathToAALMaskSlowMethod = fullfile(path, 'toolboxes', '3aal_for_spm8','wwROI_MNI_V4.nii');
pathToAALLabelsSlowMethod = fullfile(path, 'toolboxes', '3aal_for_spm8','labels.mat');

X       = load_untouch_nii(pathToAALMaskSlowMethod);
aalMask = reshape(X.img, [], 1);
path = pickDirUsingJFileChooser();
prompt = {'Enter file name:'};
dlg_title = 'Input file name';
num_lines = 1;
def = {'aalMask'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
copyfile(pathToAALMaskSlowMethod,path);
copyfile(pathToAALLabelsSlowMethod,path);
copyfile(pathToAALMaskSlowMethod, fullfile(path, strcat(answer{1,1},'.nii')),'f');
delete(fullfile(path, 'wwROI_MNI_V4.nii'));
save(fullfile(path, strcat(answer{1,1},'.mat')), 'aalMask');


% --------------------------------------------------------------------
function analyzeToNifti_Callback(hObject, eventdata, handles)
% hObject    handle to analyzeToNifti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function ConvertPreprocBufferDataToNifti_Callback(hObject, eventdata, handles)
% hObject    handle to ConvertPreprocBufferDataToNifti (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[data, header]              = readFunctionalRealTimeUntouchedPreprocAndSaveNifiti(1);


% --------------------------------------------------------------------
function niftiToAnalyze_Callback(hObject, eventdata, handles)
% hObject    handle to niftiToAnalyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filePaths = uipickfiles('Type' , {'*.nii', 'NIFTI'},  'Prompt', 'Please select the Nifti file(s)');
for i = 1:numel(filePaths)
    path = filePaths{1,i};
nii = load_untouch_nii(path);
savePath = strcat(path(1:end-numel('nii')), 'hdr');
save_untouch_nii(nii, savePath);
end