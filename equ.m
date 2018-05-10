function varargout = equ(varargin)
% EQU MATLAB code for equ.fig
%      EQU, by itself, creates a new EQU or raises the existing
%      singleton*.
%
%      H = EQU returns the handle to a new EQU or the handle to
%      the existing singleton*.
%
%      EQU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EQU.M with the given input arguments.
%
%      EQU('Property','Value',...) creates a new EQU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before equ_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to equ_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help equ

% Last Modified by GUIDE v2.5 02-May-2018 17:59:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @equ_OpeningFcn, ...
                   'gui_OutputFcn',  @equ_OutputFcn, ...
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

% --- Executes just before equ is made visible.
function equ_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to equ (see VARARGIN)

% Choose default command line output for equ
handles.output = hObject;
setGlobalcurrentSample(0);
set(handles.save, 'Enable','off');
set(handles.play,'Enable','off');
set(handles.pause,'Enable','off');
set(handles.stop,'Enable','off');
set(handles.volume,'Enable','off');
set(handles.slider32,'Enable','off');
set(handles.slider64,'Enable','off');
set(handles.slider125,'Enable','off');
set(handles.slider250,'Enable','off');
set(handles.slider750,'Enable','off');
set(handles.slider500,'Enable','off');
set(handles.slider1k,'Enable','off');
set(handles.slider2k,'Enable','off');
set(handles.slider3k,'Enable','off');
set(handles.slider4k,'Enable','off');
set(handles.rock,'Enable','off');
set(handles.metal,'Enable','off');
set(handles.rnb,'Enable','off');
set(handles.pop,'Enable','off');
set(handles.jazz,'Enable','off');
set(handles.classical,'Enable','off');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes equ wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = equ_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in search.
function search_Callback(hObject, eventdata, handles)
% hObject    handle to search (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global y;
global Fs;
global player;
[filename pathname] = uigetfile({'*.wav;*.flac;*.mp3;*.m4a'}, 'File Selector');
handles.fullpathname = strcat(pathname, filename);
set(handles.address, 'String', handles.fullpathname)
if isempty(handles.fullpathname) == false
    set(handles.save, 'Enable','on');
    set(handles.play,'Enable','on');
    set(handles.pause,'Enable','off');
    set(handles.stop,'Enable','off');
    set(handles.volume,'Enable','on');
    set(handles.slider32,'Enable','on');
    set(handles.slider64,'Enable','on');
    set(handles.slider125,'Enable','on');
    set(handles.slider250,'Enable','on');
    set(handles.slider750,'Enable','on');
    set(handles.slider500,'Enable','on');
    set(handles.slider1k,'Enable','on');
    set(handles.slider2k,'Enable','on');
    set(handles.slider3k,'Enable','on');
    set(handles.slider4k,'Enable','on');
    set(handles.rock,'Enable','on');
    set(handles.metal,'Enable','on');
    set(handles.rnb,'Enable','on');
    set(handles.classical,'Enable','on');
    set(handles.pop,'Enable','on');
    set(handles.jazz,'Enable','on');
    set(handles.slider32,'value',0);
    set(handles.slider64,'value',0);
    set(handles.slider125,'value',0);
    set(handles.slider250,'value',0);
    set(handles.slider500,'value',0);
    set(handles.slider750,'value',0);
    set(handles.slider1k,'value',0);
    set(handles.slider2k,'value',0);
    set(handles.slider3k,'value',0);
    set(handles.slider4k,'value',0);
    setGlobalcurrentSample(0);
    [y,Fs] = audioread(handles.fullpathname);
    subplot(2,1,1);
    plot(y, 'color', [51/255,102/255,255/255]);
    handles.Volume=get(handles.volume,'value');
    player = audioplayer(handles.Volume*y, Fs);
end
guidata(hObject, handles)


function setGlobalcurrentSample(val)
global currentSample
currentSample = val;

function r = getGlobalcurrentSample
global currentSample
r = currentSample;

function filterSound(hObject, eventdata, handles)
global Fs;
global player;
global y;
freqArray = [32, 64, 125, 250, 500, 750, 1000, 2000, 3000, 4000];

[y,Fs] = audioread(handles.fullpathname);
handles.Volume=get(handles.volume,'value');
G = 0;
Q = 0;
resume = 0;


for idx = 1:numel(freqArray) % [32,64,...,4000]
    if isequal(freqArray(idx), 32)
        G = get(handles.slider32,'value');
        Q = 0.1;
    elseif isequal(freqArray(idx), 64)
        G = get(handles.slider64,'value');
        Q = 0.2;
    elseif isequal(freqArray(idx), 125)
        G = get(handles.slider125,'value');
        Q = 0.4;
    elseif isequal(freqArray(idx), 250)
        G = get(handles.slider250,'value');
        Q = 0.8;
    elseif isequal(freqArray(idx), 500)
        G = get(handles.slider500,'value');
        Q = 1.6;
    elseif isequal(freqArray(idx), 750)
        G = get(handles.slider750,'value');
        Q = 3;
    elseif isequal(freqArray(idx), 1000)
        G = get(handles.slider1k,'value');
        Q = 6;
    elseif isequal(freqArray(idx), 2000)
        G = get(handles.slider2k,'value');
        Q = 12;
    elseif isequal(freqArray(idx), 3000)
        G = get(handles.slider3k,'value');
        Q = 24;
    elseif isequal(freqArray(idx), 4000)
        G = get(handles.slider4k,'value');
        Q = 48;
    end
    if isplaying(player)
        setGlobalcurrentSample(player.CurrentSample);
        resume = 1;
        player = audioplayer(handles.Volume*y, Fs);
        stop(player);
    end
    if (G ~= 0)
        [b a] = shelving(G, freqArray(idx), Fs, Q);
        yb = filter(b,a,y);
        subplot(2,1,2);
        plot(yb, 'color', [1,153/255,51/255]);
        y = yb;
    end
    if isequal(resume, 1) && isequal(idx,10)
        player = audioplayer(handles.Volume*y, Fs);
        play(player, getGlobalcurrentSample)
    end
end



% --- Executes on button press in play.
function play_Callback(hObject, eventdata, handles)
% hObject    handle to play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player;
global y;
global Fs;
handles.Volume=get(handles.volume,'value');
player = audioplayer(handles.Volume*y, Fs);
play(player, getGlobalcurrentSample);
set(handles.play,'Enable','off');
set(handles.pause,'Enable','on');
set(handles.stop,'Enable','on');
guidata(hObject, handles)

% --- Executes on button press in pause.
function pause_Callback(hObject, eventdata, handles)
% hObject    handle to pause (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player;
global y;
global Fs;
setGlobalcurrentSample(player.CurrentSample);
handles.Volume=get(handles.volume,'value');
player = audioplayer(handles.Volume*y, Fs);
stop(player);
set(handles.play,'Enable','on');
set(handles.pause,'Enable','off');
set(handles.stop,'Enable','on');
guidata(hObject, handles)

% --- Executes on button press in stop.
function stop_Callback(hObject, eventdata, handles)
% hObject    handle to stop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global player;
global y;
global Fs;
handles.Volume=get(handles.volume,'value');
player = audioplayer(handles.Volume*y, Fs);
stop(player);
setGlobalcurrentSample(0);
set(handles.play,'Enable','on');
set(handles.pause,'Enable','off');
set(handles.stop,'Enable','off');
guidata(hObject, handles)



% --- Executes on slider movement.
function volume_Callback(hObject, eventdata, handles)
% hObject    handle to volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global player;
global y;
global Fs;

handles.Volume=get(handles.volume,'value');
guidata(hObject,handles)
if isplaying(player)
    setGlobalcurrentSample(player.CurrentSample);
    stop(player);
    player = audioplayer(handles.Volume*y, Fs);
    play(player, getGlobalcurrentSample);
    guidata(hObject, handles)
else
    player = audioplayer(handles.Volume*y, Fs);
    guidata(hObject, handles)
end

% --- Executes during object creation, after setting all handles.slider32properties.
function volume_CreateFcn(hObject, eventdata, handles)
% hObject    handle to volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes on slider movement.
function slider32_Callback(hObject, eventdata, handles)
% hObject    handle to slider32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
filterSound(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function slider32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider64_Callback(hObject, eventdata, handles)
% hObject    handle to slider32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
filterSound(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function slider64_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider125_Callback(hObject, eventdata, handles)
% hObject    handle to slider125 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
filterSound(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function slider125_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider125 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider250_Callback(hObject, eventdata, handles)
% hObject    handle to slider250 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
filterSound(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function slider250_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider250 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider500_Callback(hObject, eventdata, handles)
% hObject    handle to slider500 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
filterSound(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function slider500_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider500 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider750_Callback(hObject, eventdata, handles)
% hObject    handle to slider750 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
filterSound(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function slider750_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider750 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider1k_Callback(hObject, eventdata, handles)
% hObject    handle to slider1k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
filterSound(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function slider1k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider2k_Callback(hObject, eventdata, handles)
% hObject    handle to slider2k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
filterSound(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function slider2k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider3k_Callback(hObject, eventdata, handles)
% hObject    handle to slider3k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
filterSound(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function slider3k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider4k_Callback(hObject, eventdata, handles)
% hObject    handle to slider4k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
filterSound(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function slider4k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in rock.
function rock_Callback(hObject, eventdata, handles)
% hObject    handle to rock (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
g1 = 3; % 32
g2 = 2; % 64
g3 = 1; % 125
g4 = 0.5; % 250
g5 = -0.2; % 500
g6 = -0.3; % 750
g7 = -0.5; % 1k
g8 = 0; % 2k
g9 = 1; % 3k
g10 = 2; % 4k
set(handles.slider32,'value',g1);
set(handles.slider64,'value',g2);
set(handles.slider125,'value',g3);
set(handles.slider250,'value',g4);
set(handles.slider500,'value',g5);
set(handles.slider750,'value',g6);
set(handles.slider1k,'value',g7);
set(handles.slider2k,'value',g8);
set(handles.slider3k,'value',g9);
set(handles.slider4k,'value',g10);
filterSound(hObject, eventdata, handles)

% --- Executes on button press in metal.
function metal_Callback(hObject, eventdata, handles)
% hObject    handle to metal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
g1 = 7; % 32
g2 = 5; % 64
g3 = 0; % 125
g4 = 3; % 250
g5 = 0; % 500
g6 = 0; % 750
g7 = 0; % 1k
g8 = 3; % 2k
g9 = 1.5; % 3k
g10 = 1; % 4k
set(handles.slider32,'value',g1);
set(handles.slider64,'value',g2);
set(handles.slider125,'value',g3);
set(handles.slider250,'value',g4);
set(handles.slider500,'value',g5);
set(handles.slider750,'value',g6);
set(handles.slider1k,'value',g7);
set(handles.slider2k,'value',g8);
set(handles.slider3k,'value',g9);
set(handles.slider4k,'value',g10);
filterSound(hObject, eventdata, handles)

% --- Executes on button press in rnb.
function rnb_Callback(hObject, eventdata, handles)
% hObject    handle to rnb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
g1 = 1; % 32
g2 = 5; % 64
g3 = 4; % 125
g4 = 0.5; % 250
g5 = -1.5; % 500
g6 = -1; % 750
g7 = -0.5; % 1k
g8 = 1; % 2k
g9 = 1.5; % 3k
g10 = 2; % 4k
set(handles.slider32,'value',g1);
set(handles.slider64,'value',g2);
set(handles.slider125,'value',g3);
set(handles.slider250,'value',g4);
set(handles.slider500,'value',g5);
set(handles.slider750,'value',g6);
set(handles.slider1k,'value',g7);
set(handles.slider2k,'value',g8);
set(handles.slider3k,'value',g9);
set(handles.slider4k,'value',g10);
filterSound(hObject, eventdata, handles)

% --- Executes on button press in pop.
function pop_Callback(hObject, eventdata, handles)
% hObject    handle to pop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
g1 = -1.5; % 32
g2 = -1; % 64
g3 = 0; % 125
g4 = 2; % 250
g5 = 4.5; % 500
g6 = 3; % 750
g7 = 2; % 1k
g8 = 2; % 2k
g9 = 1; % 3k
g10 = 0; % 4k
set(handles.slider32,'value',g1);
set(handles.slider64,'value',g2);
set(handles.slider125,'value',g3);
set(handles.slider250,'value',g4);
set(handles.slider500,'value',g5);
set(handles.slider750,'value',g6);
set(handles.slider1k,'value',g7);
set(handles.slider2k,'value',g8);
set(handles.slider3k,'value',g9);
set(handles.slider4k,'value',g10);
filterSound(hObject, eventdata, handles)

% --- Executes on button press in classical.
function classical_Callback(hObject, eventdata, handles)
% hObject    handle to classical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
g1 = 4; % 32
g2 = 3; % 64
g3 = 2; % 125
g4 = 2; % 250
g5 = -1; % 500
g6 = -1; % 750
g7 = -1; % 1k
g8 = 0; % 2k
g9 = 1.5; % 3k
g10 = 2.5; % 4k
set(handles.slider32,'value',g1);
set(handles.slider64,'value',g2);
set(handles.slider125,'value',g3);
set(handles.slider250,'value',g4);
set(handles.slider500,'value',g5);
set(handles.slider750,'value',g6);
set(handles.slider1k,'value',g7);
set(handles.slider2k,'value',g8);
set(handles.slider3k,'value',g9);
set(handles.slider4k,'value',g10);
filterSound(hObject, eventdata, handles)

% --- Executes on button press in jazz.
function jazz_Callback(hObject, eventdata, handles)
% hObject    handle to jazz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
g1 = 4; % 32
g2 = 3; % 64
g3 = 1; % 125
g4 = 2; % 250
g5 = -1; % 500
g6 = -1; % 750
g7 = -1; % 1k
g8 = 0; % 2k
g9 = 0.5; % 3k
g10 = 1; % 4k
set(handles.slider32,'value',g1);
set(handles.slider64,'value',g2);
set(handles.slider125,'value',g3);
set(handles.slider250,'value',g4);
set(handles.slider500,'value',g5);
set(handles.slider750,'value',g6);
set(handles.slider1k,'value',g7);
set(handles.slider2k,'value',g8);
set(handles.slider3k,'value',g9);
set(handles.slider4k,'value',g10);
filterSound(hObject, eventdata, handles)

% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global y;
global Fs;
filename = inputdlg({'Filename'});
disp('File saved');
filename = strcat(char(filename), '.wav');
audiowrite(filename, y, Fs);

function pushbutton12_callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function uipanel3_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to uipanel3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
