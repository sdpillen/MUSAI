%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MUPAS_SCREENING
%
% by Til Ole Bergmann (mail@tobergmann.de)
% last edited 2018/03/27 by TOB
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% IN CASE OF EMERGENCY (#it-crowd) %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% unccomment and run this code if Simulink Network Boot Sever is not running 
% (e.g., *after* restarting the HOST PC) and *before* restarting the TARGET PC:
% 
%  cd('M:\Experiment 2017-09 MUPAS');
%  boot;  boot simulink TARGET PC
%
%
%   
% or better: run script "boot.m" separately (in its entirety)
% Simulink down: turn on Host PC. Then turn on Target PC. run "boot.m". Restart Target PC. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    dbstop if error;
    clear all;close all; clc; 

    %% ENTER subject-specific information here
    info = [];
    info.subjectCode = 'MUPAS_Screening_S52'; % <-- ENTER subject code as 'PIP2_S##', e.g., 'PIP2_S01' or 'PIP2_P29'
%     info.subjectCode = 'MUPAS_SCREENING_TEST'; % <-- ENTER subject code
    info.development_flag = 0; % SET whether running experiments in lab (0) or devlopment in office without simulink (1)
    info.simulinksamplerate = 1000; % sample rate of Simulink model
    info.EMGchanLabels = {'APB','FDI'}; % EMG channel names
    info.targetEMGchan = 1; % which EMG channel to plot online (1 = APB, 2 = FDI)
        
    % % EEG channel definition
    % info.EEGchanNum.N = 65; % number of channels % 8 for SCREEN
    % info.EEGchanNum.C3 = 5; % 1 for SCREEN
    % info.EEGchanNum.FC1 = 21; % 3 for SCREEN
    % info.EEGchanNum.FC5 = 25; % 5 for SCREEN
    % info.EEGchanNum.CP1 = 23; % 4 for SCREEN
    % info.EEGchanNum.CP5 = 27; % 6 for SCREEN
    % info.EEGchanNum.Fz = 18; % 2 for SCREEN
    % info.EEGchanNum.CP3 = 43; % 43! NOT 51! % 7 SCREEN

    % EEG channel definition
    info.EEGchanNum.N = 8; % number of channels % 8 for SCREEN
    info.EEGchanNum.C3 = 1; % 1 for SCREEN
    info.EEGchanNum.FC1 = 3; % 3 for SCREEN
    info.EEGchanNum.FC5 = 5; % 5 for SCREEN
    info.EEGchanNum.CP1 = 4; % 4 for SCREEN
    info.EEGchanNum.CP5 = 6; % 6 for SCREEN
    info.EEGchanNum.Fz = 2; % 2 for SCREEN
    info.EEGchanNum.CP3 = 7; % 43! NOT 51! % 7 SCREEN

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% configure simulink (target pc)
    switch info.development_flag 
        case 0
            info.SimulinkScripts = 'M:\Experiment 2017-09 MUPAS'; 
            info.pathMatlabScripts = 'M:\Experiment 2017-09 MUPAS\magstim serial control';
            info.resultsPath = ['M:\Experiment 2017-09 MUPAS\MUPAS_data\' info.subjectCode]; % <-- ENTER path for results to be saved
            info.fieldtripPath = 'C:\Matlab\fieldtrip';
    %         info.portnames = {'COM1', 'COM2','COM10', 'COM11'}; % names of 4 COM ports abailable at your computer        
            info.portnames = {'COM3', 'COM4','COM5', 'COM6'}; % names of 4 COM ports abailable at your computer        
            tg = xpc; % get target
            cd(info.SimulinkScripts); % needs to be in path to load simulink model    
            load(tg, 'quadripulse_controller17'); % for SCREEN   
%             load(tg, 'quadripulse_controller18_screen'); % for SCREEN   
            tg.start; % start target (simulink model)
            cd(info.pathMatlabScripts); % go back to path contining Matlab scripts
            info.speedupfactor = 1;        
        case 1
            info.pathMatlabScripts = 'E:\Dropbox\Projects\MUPAS_Miriam\Experiment 2017-09 MUPAS\magstim serial control';
            info.resultsPath = ['E:\Dropbox\Projects\MUPAS_Miriam\Experiment 2017-09 MUPAS\MUPAS_data\' info.subjectCode];
            info.fieldtripPath = 'X:\MATLAB\fieldtrip';
            info.portnames = {'COM1', 'COM2','COM3', 'COM4'}; % the names of 4 COM ports abailable at your computer
            load(fullfile(info.pathMatlabScripts,'MEPexample.mat'));
            info.speedupfactor = 20;
            cd(info.pathMatlabScripts); % go back to path contining Matlab scripts
            tg = [];
    end
    if ~exist(info.resultsPath,'file')
        mkdir(info.resultsPath,'file')
    end

    addpath(genpath(info.pathMatlabScripts));
    addpath(info.fieldtripPath);
    % addpath(genpath('C:\Matlab\Psychtoolbox'));

    %% setup default toolbox parameters
    PsychDefaultSetup(1); % Setup PTB with some default values
    ft_defaults; % set fieldtrip defaults

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SUBEXPERIMENTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% START EEG !!!
%% (1) initial µ-rhythm calibration (~3 min)
info.timestamp = datestr(now,30); % set current timestamp
info.numEpochs = 60; % <-- ENTER number of 3s EEG epochs to analyze (60 --> 3 min)
info.freqwin = [8 14]; % frequency window to search for µ-peak frequency 
info.lowAmpLimCrit = 0.00; % lower limit percentile (0.05 = lowest 5%)
info.lowAmpCrit = 0.25; % lower x % above minimum value 
info.midAmpCrit = 0.25; 
info.midAmpLimCrit = 0.75; 
% info.midAmpCrit = 0.5; 
% info.midAmpLimCrit = 0.9; 
info.highAmpCrit = 0.75; % upper x % below upper limit 
info.highAmpLimCrit = 1.00; % upper limit percentile (0.95 = highest 5%)
[EEGcalibration_results, EEG_calibration_data, EEG_calibration_EEG] = MUPAS_EEGcalibration(tg,info); %RUN
% STOP EEG

%% (2) apply individual parameters (µ peak frequency for filter parameters and FFT bin extraction and spatial filter)
% info.mufreq = 11; % manual entry if necessary
info.mufreq = EEG_calibration_EEG.mufreq; % get individual mu peak frequency
info.fft_bin_indices_zero_based = [info.mufreq-1 info.mufreq+1]; % calculate FFT bins to extract
tg.setparam('fft_bin_indices_zero_based', info.fft_bin_indices_zero_based); % apply FFT bins to extract
info.fir_filter_coefficients = get(design(fdesign.bandpass('n,fst1,fp1,fp2,fst2', 128, info.mufreq-6, info.mufreq-2, info.mufreq+2, info.mufreq+6, 1000), 'firls', 'FilterStructure', 'dffirt'), 'Numerator'); % calculate frequency filter settings 
tg.setparam('fir_filter_coefficients',info.fir_filter_coefficients); % apply frequency filter settings
% apply Hjorth filter 
info.N = info.EEGchanNum.N; % number of channels
info.chan_center = info.EEGchanNum.C3; % channel number of center channel for Hjorth transform
info.chan_surround = [info.EEGchanNum.FC1 info.EEGchanNum.FC5 info.EEGchanNum.CP1 info.EEGchanNum.CP5]; % channel numbers of surrounding channels for Hjorth transform
info.spatial_filter = zeros(1,info.N); info.spatial_filter(info.chan_center) = 1; info.spatial_filter(info.chan_surround) = -1/length(info.chan_surround); % calculate "wide Hjorth" spatial filter
tg.setparam('spatial_filter', info.spatial_filter); % apply spatial filter settings

% START EEG (Run first without stimulators armed! And save EEG separately!)
%% (3) sneak preview for EEG-triggered peak-vs-trough effect (5 min)
info.N = info.EEGchanNum.N; %number of channels
info.chan_center = info.EEGchanNum.C3; % channel number of center channel for Hjorth transform
info.chan_surround = [info.EEGchanNum.FC1 info.EEGchanNum.FC5 info.EEGchanNum.CP1 info.EEGchanNum.CP5]; % channel numbers of surrounding channels for Hjorth transform
info.spatial_filter = zeros(1,info.N); info.spatial_filter(info.chan_center) = 1; info.spatial_filter(info.chan_surround) = -1/length(info.chan_surround); % calculate "wide Hjorth" spatial filter
tg.setparam('spatial_filter', info.spatial_filter); % apply spatial filter settings
info.condition = [6]; %  (1) open loop, (2) low power random phase, (3) high power random phase, (4) high power peak, (5) high power trough, (6) randomized high power peak and trough 
info.timestamp = datestr(now,30); % set current timestamp
info.numTrialCond = 100; % number of trials PER experimental (amplitude+phase x pulse) CONDITION (n = 150)
% info.trialspercondtopause = 225; % numner of trials per experimental condition until break
info.waitbeforestart = 60; % seconds to wait before experiment starts to allow online threshold to adapt
info.MNSI = 0; % subject-specific median nerve stimulation intensity (3x sensory perceptual threshold)
info.SI = 0; % subject-specific SI (1mV_MEP threshold) here as % MSO
info.ISI = 2; % set ISI to N20 + 2 ms
info.lowAmpLim = 0;
info.lowAmpThresh = 10000;
info.midAmpThresh = 0;
info.midAmpLim = 10000;
info.highAmpThresh = 0;
info.highAmpLim = 1000;
[EEGtriggeredPAS.results, EEGtriggeredPAS.data_emg, EEGtriggeredPAS.data_eeg, EEGtriggeredPAS.MEP, EEGtriggeredPAS.EEG] = MUPAS_EEGtriggeredPAS(tg,info); % RUN
% STOP EEG
% RUN   

%% (4) MEP hotspot search (as long as it takes...)
info.timestamp = datestr(now,30); % set current timestamp
info.numTrial = 1000; % number of trials 
[hotspot_results, hotspot_data, hotspot_MEP] = MUPAS_hotspotsearch(tg,info);

%% (5) MEP resting motor threshold (RMT) determination by means of SA-PEST procedure (~2 min)
info.timestamp = datestr(now,30); % set current timestamp
info.numTrial = 40; % number of trials 
info.SIstart = 30; % <-- ENTER default stimulation intensity (SI) in % MSO to start with
info.decisionRule = 'binary'; % whether hit/miss decision is based on above/below rule ('binary') or running average ('runningaverage')
info.runAvgLen = 20; % number of trials included in running average 
info.thresholdCriterion = 50; % threshold criterion in µV (e.g., 50 µV for RMT and 1000 for 1 mV MEP)
info.initialstepsize = 2; % initial step size for SA-PEST in % MSO 
info.stepsizelimits = [1 8]; % [minimal maximal] step size for SA-PEST in % MSO   
info.SIlimits = [10 80]; % [minimal maximal] stimulation intensity allowed in % MSO 
[RMThunting_results, RMThunting_data, RMThunting_MEP] = MUPAS_thresholdhunting(tg,info); % RUN
info.RMT = round(mean(RMThunting_MEP.SI(end-19:end))); % subject-specific resting motor threshold (RMT) RMT here as % MSO[RMThunting_results, RMThunting_data, RMThunting_MEP] = MUPAS_thresholdhunting(tg,info); % RUN


%% (6) MEP 1mV-MEP threshold (MEP1mv) determination by means of SA-PEST procedure (~2 min)
info.timestamp = datestr(now,30); % set current timestamp
info.numTrial = 40; % number of trials 
info.SIstart = info.RMT; % <-- ENTER default stimulation intensity (SI) in % MSO to start with
info.decisionRule = 'binary'; % whether hit/miss decision is based on above/below rule ('binary') or running average ('runningaverage')
info.runAvgLen = 20; % number of trials included in running average 
info.thresholdCriterion = 500; % threshold criterion in µV (e.g., 50 µV for RMT and 1000 for 1 mV MEP)
info.initialstepsize = 2; % initial step size for SA-PEST in % MSO
info.stepsizelimits = [1 8]; % [minimal maximal] step size for SA-PEST in % MSO
info.SIlimits = [10 80]; % [minimal maximal] stimulation intensity allowed in % MSO 
[MEP1mVhunting_results, MEP1mVhunting_data, MEP1mVhunting_MEP] = MUPAS_thresholdhunting(tg,info); % RUN
info.MEP1mV = round(mean(MEP1mVhunting_MEP.SI(end-19:end))); % subject-specific 1mV_MEP threshold here as % MSO
% STOP EEG


%% (7) Sensory threshold determination for electrical median nerve stimulation
% MANUELL :-(
info.ST = 4.40; % <-- ENTER determined sensory threshold to save information 


% START EEG!!
info.spatial_filter = zeros(1,info.EEGchanNum.N); 
info.spatial_filter(info.EEGchanNum.CP3) = 1; % 
info.spatial_filter(info.EEGchanNum.Fz) = -1; % 
tg.setparam('spatial_filter', info.spatial_filter); % apply spatial filter settings
info.timestamp = datestr(now,30); % set current timestamp
info.numTrial = 500; % number of trials (oder 500?)
info.MNSI = 3 * info.ST; % <-- ALSO SET MANUALLY AT STIMULATOR!!
info.runAvgLen = info.numTrial; % number of trials %% (8) Somatosensory evoked potentials (SEP) (2-3 min)included in running average 
[SEP_results, SEP_data, SEP_SEP] = MUPAS_SEP(tg,info);
info.N20_latency = SEP_SEP.N20_latency; % get N20 latency


% START EEG (Run first without stimulators armed! And save EEG separately!)
%% (9) check EEG-triggered peak-vs-trough effect (20 min)
info.N = info.EEGchanNum.N; % number of channels
info.chan_center = info.EEGchanNum.C3; % channel number of center channel for Hjorth transform
info.chan_surround = [info.EEGchanNum.FC1 info.EEGchanNum.FC5 info.EEGchanNum.CP1 info.EEGchanNum.CP5]; % channel numbers of surrounding channels for Hjorth transform
info.spatial_filter = zeros(1,info.N); info.spatial_filter(info.chan_center) = 1; info.spatial_filter(info.chan_surround) = -1/length(info.chan_surround); % calculate "wide Hjorth" spatial filter
tg.setparam('spatial_filter', info.spatial_filter); % apply spatial filter settings
info.condition = [6]; %  (1) open loop, (2) low power random phase, (3) high power random phase, (4) high power peak, (5) high power trough, (6) randomized high power peak and trough 
info.timestamp = datestr(now,30); % set current timestamp
info.numTrialCond = 400; % number of trials PER experimental (amplitude+phase x pulse) CONDITION (n = 150)
% info.trialspercondtopause = 225; % numner of trials per experimental condition until break
info.waitbeforestart = 60; % seconds to wait before experiment starts to allow online threshold to adapt
info.MNSI = 3*info.ST; % subject-specific median nerve stimulation intensity (3x sensory perceptual threshold)
info.SI = round(1.1*info.RMT); % subject-specific SI (1mV_MEP threshold) here as % MSO
info.ISI = (info.N20_latency + 0.002)*info.simulinksamplerate; % set ISI to N20 + 2 ms
info.lowAmpLim = EEG_calibration_EEG.lowAmpLim;
info.lowAmpThresh = EEG_calibration_EEG.lowAmpThresh;
info.midAmpThresh = EEG_calibration_EEG.midAmpThresh;
info.midAmpLim = EEG_calibration_EEG.midAmpLim;
info.highAmpThresh = EEG_calibration_EEG.highAmpThresh;
info.highAmpLim = EEG_calibration_EEG.highAmpLim;
[EEGtriggeredPAS.results, EEGtriggeredPAS.data_emg, EEGtriggeredPAS.data_eeg, EEGtriggeredPAS.MEP, EEGtriggeredPAS.EEG] = MUPAS_EEGtriggeredPAS(tg,info); % RUN
% STOP EEG


% START EEG !!!
%% (10) mu functional localizer 
% FINGER MOVEMENT TASK (100 repetitions every 2-3 s), eyes on fixation
% cross, other fingers as releaxed as possible, palm upwards
% STOP EEG !!!


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EEGcalibration_results = load('PIP_S08_20160824T090033_EEGcalibration.mat','EEG');
% EEG_calibration_data = load('PIP_S08_20160824T090033_EEGcalibration.mat','data');
% EEG_calibration_EEG = load('PIP_S08_20160824T090033_EEGcalibration.mat','results');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% stop simulink model
if info.development_flag == 0
    tg.stop; % stop target (simulink model)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%