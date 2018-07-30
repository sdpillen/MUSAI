%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MagStim remote configuration via serial port
% by Til Ole Bergmann (mail@tobergmann.de)
% last edited 2016/05/18 by TOB
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           MagStim 200²                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
try
    
clear all;close all; clc;

%% configure setup 
portname = 'COM1'; % name of COM port (default 'COM1')
stimulatorType = '200' ; % '200','BiStim', 'SuperRapid'
intensity = 50; % stimulation intensity for Stimulator A in % maximum stimulator output (% MSO)

%% open COM port (and start mc_maintain callback function) 
s = mc_open(portname); % open serial port and give back port object
mc_pause(s,0.5);

%% set intensity of a single stimulator 
mc_setintensity(s, intensity); % intensity value for single stimulator        
mc_pause(s,0.1);

%% arm stimulator % disarms automatically after 60 s
mc_arm(s,1); % arm (1) / disarm (0) stimulator
mc_pause(s,2);

%% trigger stimulator (!!!)
mc_trigger(s); % trigger stimulator
mc_pause(s,4.0);

%% disarm stimulator 
mc_arm(s,0); % arm (1) / disarm (0) stimulator
mc_pause(s,0.250);

%% close COM port 
mc_close(s); % close serial port
mc_pause(s,0.2);

%% catch errors and close serial port
catch EM
    display('An error occurred. All ports will be closed.');
    mc_close(s); % close serial port
end % of catch


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           MagStim BiStim²                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
try
    
clear all;close all; clc;

%% configure setup 
portname = 'COM1'; % name of COM port (default 'COM1')
stimulatorType = 'BiStim' ; % '200','BiStim', 'SuperRapid'
intensityA = 50; % stimulation intensity for Stimulator A in % maximum stimulator output (% MSO)
intensityB = 80; % stimulation intensity for Stimulator B (only for BiStim² mode) in % maximum stimulator output (% MSO)
ISI = 2.0; % inter stimulus interval (ISI) in ms (only for BiStim² mode). Always provide in ms, no matter which time resolution mode!

%% open COM port (and start mc_maintain callback function) 
s = mc_open(portname); % open serial port and give back port object
mc_pause(s,0.5);

%% set intensity of a single stimulator or of both stimulators in a BiStim setup
mc_setintensity(s, intensityA, intensityB); % first intensity value for stimulator A, second vale for Stimulator B
mc_pause(s,0.5);

%% set inter-stimulus interval (ISI) (BiStim only)
mc_setisi(s,ISI);
mc_pause(s,0.5);

%% arm stimulator % disarms automatically after 60 s
mc_arm(s,1); % arm (1) / disarm (0) stimulator
mc_pause(s,3);

%% trigger stimulator (!!!)
for i = 15:500
    mc_trigger(s); % trigger stimulator
    mc_pause(s,4.1);
    display(num2str(i));
end
%% disarm stimulator 
mc_arm(s,0); % arm (1) / disarm (0) stimulator
mc_pause(s,0.250);

%% close COM port 
mc_close(s); % close serial port
pause(0.2);

%% catch errors and close serial port
catch EM
    display('An error occurred. All ports will be closed.');
    if exist('s','var')
        mc_close(s); % close serial port
    else
        delete(instrfind); % in case the serial port object got lost        
    end
end % of catch


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% additional function currently not in use or called by other functions

%% get current parameter settings from stimulator
settings = mc_getsettings(s);

%% enable remote control 
settings = mc_remote(s,1); % 1 for on, 0 for off

%% disable remote control 
settings = mc_remote(s,0); % 1 for on, 0 for off

%% set base mode
mode = 'stop'; % 'stop', 'arm', 'trigger'
settings = mc_setbasemode(s,mode);

%% set time resolution (BiStim only) 
switch stimulatorType    
    case 'BiStim'
        res = 'lr'; % high ('hr') / low ('lr') resolution time setting mode for BiStim
        settings = mc_settimeres(s,res); % set time setting mode for BiStim
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%