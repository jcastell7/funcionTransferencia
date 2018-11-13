function varargout = Rampa(varargin)
% RAMPA MATLAB code for Rampa.fig
%      RAMPA, by itself, creates a new RAMPA or raises the existing
%      singleton*.
%
%      H = RAMPA returns the handle to a new RAMPA or the handle to
%      the existing singleton*.
%
%      RAMPA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RAMPA.M with the given input arguments.
%
%      RAMPA('Property','Value',...) creates a new RAMPA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Rampa_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Rampa_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Rampa

% Last Modified by GUIDE v2.5 12-Nov-2018 23:15:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Rampa_OpeningFcn, ...
                   'gui_OutputFcn',  @Rampa_OutputFcn, ...
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


% --- Executes just before Rampa is made visible.
function Rampa_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Rampa (see VARARGIN)

% Choose default command line output for Rampa
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Rampa wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Rampa_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
Us = getappdata(0,'Us');
Ys = getappdata(0, 'Ys');
axes(handles.grpRamp);
t = (0:.3:15);
ramp = t;
y = lsim (Us,Ys,ramp,t);
plot (t,y,t,ramp);
title('Ramp response');
