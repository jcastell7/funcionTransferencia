function varargout = LugarGeometrico(varargin)
% LugarGeometrico MATLAB code for LugarGeometrico.fig
%      LugarGeometrico, by itself, creates a new LugarGeometrico or raises the existing
%      singleton*.
%
%      H = LugarGeometrico returns the handle to a new LugarGeometrico or the handle to
%      the existing singleton*.
%
%      LugarGeometrico('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LugarGeometrico.M with the given input arguments.
%
%      LugarGeometrico('Property','Value',...) creates a new LugarGeometrico or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the LugarGeometrico before LugarGeometrico_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LugarGeometrico_OpeningFcn via varargin.
%
%      *See LugarGeometrico Options on GUIDE's Tools menu.  Choose "LugarGeometrico allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LugarGeometrico

% Last Modified by GUIDE v2.5 13-Nov-2018 00:38:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LugarGeometrico_OpeningFcn, ...
                   'gui_OutputFcn',  @LugarGeometrico_OutputFcn, ...
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


% --- Executes just before LugarGeometrico is made visible.
function LugarGeometrico_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LugarGeometrico (see VARARGIN)

% Choose default command line output for LugarGeometrico
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LugarGeometrico wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LugarGeometrico_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function txtY_Callback(hObject, eventdata, handles)
% hObject    handle to txtY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtY as text
%        str2double(get(hObject,'String')) returns contents of txtY as a double


% --- Executes during object creation, after setting all properties.
function txtY_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtY (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnEntradaSalida.
function btnEntradaSalida_Callback(hObject, eventdata, handles)
% hObject    handle to btnEntradaSalida (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%function
syms y;
syms u;
num = get(handles.txtY,'string');
den = get(handles.txtU,'string');
symNum = evalin(symengine, num);
symDen = evalin(symengine, den);
Ys = sym2poly(symNum);
Us = sym2poly(symDen);
G = tf (Us,Ys);
gprint = evalc ('G');
set (handles.lblEq, 'string', gprint);
[polos, ceros] = pzmap(Us,Ys);
ramas = size(polos, 1);
numceros = size(ceros,1);
strPolos = mat2str(polos);
strCeros = mat2str(ceros);
strRamas = mat2str(ramas);
NumCeros =(ramas-numceros);
absoluto = abs(NumCeros);
set (handles.lblPolo, 'string',strPolos);
set (handles.lblCero, 'string',strCeros);
set (handles.lblRamas, 'string',strRamas);
set (handles.lblNumCeros, 'string',absoluto);


pzmap(Us,Ys);





%end: function



function txtU_Callback(hObject, eventdata, handles)
% hObject    handle to txtU (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txtU as text
%        str2double(get(hObject,'String')) returns contents of txtU as a double


% --- Executes during object creation, after setting all properties.
function txtU_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txtU (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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



function lblRamas_Callback(hObject, eventdata, handles)
% hObject    handle to lblRamas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lblRamas as text
%        str2double(get(hObject,'String')) returns contents of lblRamas as a double


% --- Executes during object creation, after setting all properties.
function lblRamas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lblRamas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
