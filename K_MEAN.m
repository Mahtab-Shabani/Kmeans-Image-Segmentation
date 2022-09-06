function varargout = K_MEAN(varargin)
% K_MEAN M-file for K_MEAN.fig
%      K_MEAN, by itself, creates a new K_MEAN or raises the existing
%      singleton*.
%
%      H = K_MEAN returns the handle to a new K_MEAN or the handle to
%      the existing singleton*.
%
%      K_MEAN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in K_MEAN.M with the given input arguments.
%
%      K_MEAN('Property','Value',...) creates a new K_MEAN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before K_MEAN_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to K_MEAN_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help K_MEAN

% Last Modified by GUIDE v2.5 27-May-2015 00:22:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @K_MEAN_OpeningFcn, ...
                   'gui_OutputFcn',  @K_MEAN_OutputFcn, ...
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


% --- Executes just before K_MEAN is made visible.
function K_MEAN_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to K_MEAN (see VARARGIN)

% Choose default command line output for K_MEAN
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes K_MEAN wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = K_MEAN_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in getpic_pushbtn.
function getpic_pushbtn_Callback(hObject, eventdata, handles)
% hObject    handle to getpic_pushbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename , pathname] = uigetfile(('*.jpg;*.png;*.gif;*.tif;*.bmp'),'Select a pic');
handles.im=imread([pathname filename]);

[handles.m handles.n handles.d]=size(handles.im);
if handles.d==2
    disp('error');
end
if handles.d==3
    handles.i=rgb2gray(handles.im);
end
% Guidata(hObject,handles);
guidata(hObject,handles);
imagesc(handles.im,'Parent',handles.axes1);
title('Orginal image');
colormap('gray');


function numcluster_edittxt_Callback(hObject, eventdata, handles)
% hObject    handle to numcluster_edittxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numcluster_edittxt as text
%        str2double(get(hObject,'String')) returns contents of numcluster_edittxt as a double


% --- Executes during object creation, after setting all properties.
function numcluster_edittxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numcluster_edittxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Custering_pushbtn.
function Custering_pushbtn_Callback(hObject, eventdata, handles)
% hObject    handle to Custering_pushbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
num=get(handles.numcluster_edittxt,'String');
num=str2num(num);
handles.x=reshape(handles.i,[],1);
handles.k=kmeans(double(handles.x),num);
handles.i2=reshape(handles.k,handles.m,handles.n);
% Guidata(hObject,handles);
guidata(hObject,handles);    % MATLAB 2014a

imagesc(handles.i2,'Parent',handles.axes2);
colormap('gray');
title('Clustering');
