function varargout = errorEstadoEstable(varargin)
% ERRORESTADOESTABLE MATLAB code for errorEstadoEstable.fig
%      ERRORESTADOESTABLE, by itself, creates a new ERRORESTADOESTABLE or raises the existing
%      singleton*.
%
%      H = ERRORESTADOESTABLE returns the handle to a new ERRORESTADOESTABLE or the handle to
%      the existing singleton*.
%
%      ERRORESTADOESTABLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ERRORESTADOESTABLE.M with the given input arguments.
%
%      ERRORESTADOESTABLE('Property','Value',...) creates a new ERRORESTADOESTABLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before errorEstadoEstable_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to errorEstadoEstable_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help errorEstadoEstable

% Last Modified by GUIDE v2.5 14-Nov-2018 00:00:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @errorEstadoEstable_OpeningFcn, ...
                   'gui_OutputFcn',  @errorEstadoEstable_OutputFcn, ...
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


% --- Executes just before errorEstadoEstable is made visible.
function errorEstadoEstable_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to errorEstadoEstable (see VARARGIN)

% Choose default command line output for errorEstadoEstable
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes errorEstadoEstable wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = errorEstadoEstable_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
tipoSistema(handles);

function cons = cambiarArray(array)
x = array;
B = size(x);
syms s;
for k = 1:B(2)
    if isequaln(1/s,x(k))
    x(k)=0;
    end
end
cons =x;

function cons = sumaArray(array)
s = 0;
x = cambiarArray(array);
B = size(x);
cons = 0;
for i = 1:B(2)
    cons = cons +subs(x(i));
end

function tipoSistema(handles)
G = getappdata(0,'G');
syms s;
[Num,Den] = tfdata(G);
symG = poly2sym(cell2mat(Num),s)/poly2sym(cell2mat(Den),s);
x = factor(symG);
cont = 0;
B = size(x);
for k = 1:B(2)
    if isequaln(1/s,x(k))
       cont = cont+1;
    end
end
syms k;
constante = k*sumaArray(x);
error = constante^(-1);
if cont == 0
    error = 1/(1+constante);
    set (handles.lblEscalonC, 'string', char(constante));
    set (handles.lblRampaC , 'string', '0');
    set (handles.lblParabolaC , 'string', '0');
    set (handles.lblEscalonE, 'string', char(error));
    set (handles.lblRampaE , 'string', 'Inf');
    set (handles.lblParabolaE , 'string', 'Inf');
elseif cont ==1
    set (handles.lblEscalonC , 'string', 'Inf');
    set (handles.lblRampaC, 'string', char(constante));
    set (handles.lblParabolaC , 'string', '0');
    set (handles.lblEscalonE , 'string', '0');
    set (handles.lblRampaE, 'string', char(error));
    set (handles.lblParabolaE, 'string', 'Inf');
elseif cont ==2
    set (handles.lblEscalonC , 'string', 'Inf');
    set (handles.lblRampaC, 'string', 'Inf');
    set (handles.lblParabolaC, 'string', char(constante));
    set (handles.lblEscalonE , 'string', '0');
    set (handles.lblRampaE, 'string', '0');
    set (handles.lblParabolaE, 'string', char(error));
elseif cont > 2
    set (handles.lblEscalonC , 'string', 'Inf');
    set (handles.lblRampaC, 'string', 'Inf');
    set (handles.lblParabolaC, 'string', 'Inf');
    set (handles.lblEscalonE , 'string', '0');
    set (handles.lblRampaE, 'string', '0');
    set (handles.lblParabolaE, 'string', '0');
end
