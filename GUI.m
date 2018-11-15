function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 11-Nov-2018 21:30:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
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
symNum = str2sym(num);
symDen = str2sym(den);
Ys = sym2poly(symNum);
Us = sym2poly(symDen);
G = tf (Us,Ys);
gprint = evalc ('G');
set (handles.lblEq, 'string', gprint);
[z,gain] = zero(G);
ganancia = num2str(gain);
[polos, ceros] = pzmap(Us,Ys);
strPolos = mat2str(polos);
strCeros = mat2str(ceros);
stable = isstable(G);
if stable
    set (handles.lblEstabilidad ,'string' , 'El sistema es estable')
else
    set (handles.lblEstabilidad ,'string' , 'El sistema es inestable')
end
set (handles.lblPolo, 'string',strPolos);
set (handles.lblCero, 'string',strCeros);
set (handles.lblGanancia, 'string',ganancia);
tipoAmortiguamiento(Ys,handles);
setappdata(0,'Us',Us);
setappdata(0,'Ys',Ys);
PolosYCeros();
setappdata(0,'G',G);
Escalon();
Rampa();
errorEstadoEstable();
stability = rhc(G);
set(handles.lblKEstable,'string',stability);
%end: function
    
function tipoAmortiguamiento(Ys,handles)
salida = Ys;

if salida~=1
    salida1 = salida/salida(1);
else
    salida1 = salida;
end
Wn=sqrt(salida1(3));
Z=(salida1(2)/(2*Wn));
Ts = 0;
Sp = 0;
if (Z<0)
    amort = 'El Sistema Presenta Amortiguamiento Negativo';
else
    if (Z==0)
        amort = 'El Sistema No Presenta Amortiguamiento';
    else
        if (Z==1)
            amort = 'El Sistema Tiene un Amortiguamiento Critico';
        else
            if (Z>1)
                amort = 'El Sistema es Sobreamortiguado';
            else
                if (0<=Z<=1)
                    amort = 'El Sistema es Subamortiguado';
                    
                    %Tiempo de Asentamiento
                    if (0<Z<0.69)
                        Ts=((3.2)/(Z*Wn));
                    end
                    
                    if (Z>0.69)
                        Ts=((4.53)/(Wn));
                    end
                    %Sobrepaso Porcentual
                    Sp=((100)*(exp((-pi*Z)/(sqrt(1-Z^2)))));

                end
            end
        end
    end
end
set (handles.lblAmortiguamiento, 'string',amort);
strTs = num2str(Ts);
set (handles.lblAsentamiento, 'string',strTs);
strSp = num2str(Sp);
set (handles.lblSobrepaso, 'string',strSp);

function routh = rhc(G)
res =[];
count = 1;
for k = -999:999
Gs = k*G;
Ts = feedback(Gs,1);   
    if isstable(Ts)
      res(count)=k;
      count = count + 1;
    end
end
routh = [res(1),res(end)];



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
