%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MUPAS
%
% by Til Ole Bergmann (mail@tobergmann.de)
% last edited 2018/03/27 by TOB
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% cd('M:\dicom2nifti')
% dicm2nii
% cd('M:\Experiment 2017-09 MUPAS\magstim serial control');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% boot; % boot simulink target
  
dbstop if error;
clear all;close all; clc; 

%% ENTER subject-specific information here
info = [];
info.subjectCode = 'MUSAI_DELETEME'; % <-- ENTER subject code as 'MUPAS_S##_1', e.g., 'MUPAS_S01_1' or 'MUPAS_S02_3'
info.mufreq = [11]; % <-- ENTER subject-specific Mu frequency!!! 
info.ST = [2.66]; % <-- ENTER subject-specific sensory threshold!!!
info.N20_latency = [18]; % <-- ENTER subject-specific N20 latency!!!
info.experimentalcondition = [1];  %  <-- ENTER experimental condition code: (1) open loop, (2) low power random phase, (3) mid power random phase, (4) mid power peak, (5) mid power trough, (6) randomized high power peak and trough 
% info.replayfile = 'C:\ProgramData\Mega Electronics Ltd\NeurOne64\SessionData\NeurOneUser\MUPAS_S16_1\2018-05-16T162633\5';
info.MEP1mV = [69]; % <-- ENTER subject-specific MEP1mV from 1st session!!!
info.MNSImanual = [7.98]; % <-- ENTER 3*info.ST, subject-specific median nerve stimulation intensity (3x sensory perceptual threshold)
info.development_flag = 1; % SET whether running experiments in lab (0) or devlopment in office without simulink (1)
info.simulinksamplerate = 1000; % sample rate of Simulink model
info.EMGchanLabels = {'APB','FDI'}; % EMG channel names
info.targetEMGchan = 1; % which EMG channel to plot online (1 = APB, 2 = FDI)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% configure simulink (target pc)
switch info.development_flag 
    case 0
        info.SimulinkScripts = 'M:\Experiment 2017-09 MUPAS'; 
        info.pathMatlabScripts = 'M:\Experiment 2017-09 MUPAS\magstim serial control';
        info.resultsPath = ['M:\Experiment 2017-09 MUPAS\MUPAS_data\' info.subjectCode]; % <-- ENTER path for results to be saved
        info.fieldtripPath = 'C:\Matlab\fieldtrip';
%         info.neuroneToolsPath = 'M:\Experiment 2017-09 MUPAS\neurone_tools_for_matlab_1.1.3.10';
%         info.portnames = {'COM1', 'COM2','COM10', 'COM11'}; % names of 4 COM ports abailable at your computer        
        info.portnames = {'COM3', 'COM4','COM5', 'COM6'}; % names of 4 COM ports abailable at your computer        
        tg = xpc; % get target
        cd(info.SimulinkScripts); % needs to be in path to load simulink model
        load(tg, 'quadripulse_controller16'); % load the application onto target     
%         load(tg, 'quadripulse_controller18'); % load the application onto target (median filter implemented, 27.03.2018)     
        tg.start; % start target (simulink model)
        cd(info.pathMatlabScripts); % go back to path contining Matlab scripts
        info.speedupfactor = 1;        
    case 1
        info.pathMatlabScripts = 'C:\Users\Steven\Desktop\MUSAI code\MUPAS code\magstim serial control';
        info.resultsPath = ['C:\Users\Steven\Desktop\MUSAI code\MUPAS code\magstim serial control\' info.subjectCode];
        info.fieldtripPath = 'X:\MATLAB\fieldtrip';
%         info.neuroneToolsPath = 'E:\Dropbox\Projects\MUPAS_Miriam\Experiment 2017-09 MUPAS\neurone_tools_for_matlab_1.1.3.10';
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
%% (1) initial ?-rhythm calibration (~3 min)
%% initial ?-rhythm calibration (~3 min)
info.timestamp = datestr(now,30); % set current timestamp
info.numEpochs = 60; % <-- ENTER number of 3s EEG epochs to analyze (60 --> 3 min)
info.freqwin = [8 14]; % frequency window to search for ?-peak frequency 
info.lowAmpLimCrit = 0.00; % lower limit percentile (0.05 = lowest 5%)
info.lowAmpCrit = 0.25; % lower x % above minimum value 
info.midAmpLimCrit = 0.75; 
info.midAmpCrit = 0.25; 
info.highAmpLimCrit = 1.00; % upper limit percentile (0.95 = highest 5%)
info.highAmpCrit = 0.75; % upper x % below upper limit 
[EEGcalibration_results, EEG_calibration_data, EEG_calibration_EEG] = EEGcalibration(tg,info); %RUN
% STOP EEG


%% (2) apply individual parameters (? peak frequency for filter parameters and FFT bin extraction and spatial filter)
% info.mufreq = 11; % manual entry if necessary
info.mufreq = EEG_calibration_EEG.mufreq; % get individual mu peak frequency
info.fft_bin_indices_zero_based = [info.mufreq-1 info.mufreq+1]; % calculate FFT bins to extract
tg.setparam('fft_bin_indices_zero_based', info.fft_bin_indices_zero_based); % apply FFT bins to extract
info.fir_filter_coefficients = get(design(fdesign.bandpass('n,fst1,fp1,fp2,fst2', 128, info.mufreq-6, info.mufreq-2, info.mufreq+2, info.mufreq+6, 1000), 'firls', 'FilterStructure', 'dffirt'), 'Numerator'); % calculate frequency filter settings 
tg.setparam('fir_filter_coefficients',info.fir_filter_coefficients); % apply frequency filter settings
% narrow Hjorth filter if necessary
info.N = 65; % number of channels
info.chan_center = 5; % channel number of center channel for Hjorth transform
info.chan_surround = [21 23 25 27]; % channel numbers of surrounding channels for Hjorth transform
info.spatial_filter = zeros(1,info.N); info.spatial_filter(info.chan_center) = 1; info.spatial_filter(info.chan_surround) = -1/length(info.chan_surround); % calculate "wide Hjorth" spatial filter
tg.setparam('spatial_filter', info.spatial_filter); % apply spatial filter settings

% START EEG (Run first without stimulators armed! And save EEG separately!)
%% (3) sneak preview for EEG-triggered peak-vs-trough effect (5 min)
%TODO: make modular for Phase, Power, and SAI conditions

info.condition = [6]; %  (1) open loop, (2) low power random phase, (3) high power random phase, (4) high power peak, (5) high power trough, (6) randomized high power peak and trough 
info.timestamp = datestr(now,30); % set current timestamp
info.numTrialCond = 40; % number of trials PER experimental (amplitude+phase x pulse) CONDITION (n = 150)
% info.trialspercondtopause = 225; % numner of trials per experimental condition until break
info.waitbeforestart = 60; % seconds to wait before experiment starts to allow online threshold to adapt
info.MNSI = 0; % subject-specific median nerve stimulation intensity (3x sensory perceptual threshold)
info.SI = 0; % subject-specific SI (1mV_MEP threshold) here as % MSO
info.ISI = info.N20_latency + 2; % set ISI to N20 + 2 ms
info.lowAmpLim = 0;
info.lowAmpThresh = 10000;
info.midAmpThresh = 0;
info.midAmpLim = 10000;
info.highAmpThresh = 0;
info.highAmpLim = 1000;
[EEGtriggeredPAS.results, EEGtriggeredPAS.data_emg, EEGtriggeredPAS.data_eeg, EEGtriggeredPAS.MEP, EEGtriggeredPAS.EEG] = EEGtriggeredPAS(tg,info); % RUN
% STOP EEG

%% (4) MEP hotspot search (as long as it takes...)
info.timestamp = datestr(now,30); % set current timestamp
info.numTrial = 1000; % number of trials 
[hotspot_results, hotspot_data, hotspot_MEP] = hotspotsearch(tg,info);


%% (5) MEP resting motor threshold (RMT) determination by means of SA-PEST procedure (~2 min)
info.timestamp = datestr(now,30); % set current timestamp
info.numTrial = 40; % number of trials 
info.SIstart = 30; % <-- ENTER default stimulation intensity (SI) in % MSO to start with
info.decisionRule = 'binary'; % whether hit/miss decision is based on above/below rule ('binary') or running average ('runningaverage')
info.runAvgLen = 20; % number of trials included in running average 
info.thresholdCriterion = 50; % threshold criterion in ?V (e.g., 50 ?V for RMT and 1000 for 1 mV MEP)
info.initialstepsize = 2; % initial step size for SA-PEST in % MSO 
info.stepsizelimits = [1 8]; % [minimal maximal] step size for SA-PEST in % MSO   
info.SIlimits = [10 80]; % [minimal maximal] stimulation intensity allowed in % MSO 
[RMThunting_results, RMThunting_data, RMThunting_MEP] = thresholdhunting(tg,info); % RUN
info.RMT = round(mean(RMThunting_MEP.SI(end-19:end))); % subject-specific resting motor threshold (RMT) RMT here as % MSO


%% (6) MEP 1mV-MEP threshold (MEP1mv) determination by means of SA-PEST procedure (~2 min)
info.timestamp = datestr(now,30); % set current timestamp
info.numTrial = 40; % number of trials 
info.SIstart = info.RMT; % <-- ENTER default stimulation intensity (SI) in % MSO to start with
info.decisionRule = 'binary'; % whether hit/miss decision is based on above/below rule ('binary') or running average ('runningaverage')
info.runAvgLen = 20; % info.number of trials included in running average 
info.thresholdCriterion = 1000; % threshold criterion in ?V (e.g., 50 ?V for RMT and 1000 for 1 mV MEP)
info.initialstepsize = 2; % initial step size for SA-PEST in % MSO
info.stepsizelimits = [1 8]; % [minimal maximal] step size for SA-PEST in % MSO
info.SIlimits = [10 80]; % [minimal maximal] stimulation intensity allowed in % MSO 
[MEP1mVhunting_results, MEP1mVhunting_data, MEP1mVhunting_MEP] = thresholdhunting(tg,info); % RUN
info.MEP1mV = round(mean(MEP1mVhunting_MEP.SI(end-19:end))); % subject-specific 1mV_MEP threshold here as % MSO
% STOP EEG


%**************************************************************************
% START of Main Experiment
%**************************************************************************

% START EEG
%% (7) EEG-triggered PAS (15 min)
info.condition = info.experimentalcondition; %   %  (1) open loop, (2) low power random phase, (3) high power random phase, (4) high power peak, (5) high power trough, (6) randomized high power peak and trough 
info.timestamp = datestr(now,30); % set current timestamp
info.numTrialCond = 225; % number of trials PER experimental (amplitude+phase x pulse) CONDITION (n = 150)
% info.trialspercondtopause = 225; % numner of trials per experimental condition until break
info.waitbeforestart = 60; % seconds to wait before experiment starts to allow online threshold to adapt
info.MNSI = info.MNSImanual; % subject-specific median nerve stimulation intensity (3x sensory perceptual threshold)
info.SI = info.MEP1mV; % subject-specific SI (1mV_MEP threshold) here as % MSO
info.ISI = info.N20_latency + 2; % set ISI to N20 + 2 ms
info.lowAmpLim = EEG_calibration_EEG.lowAmpLim;
info.lowAmpThresh = EEG_calibration_EEG.lowAmpThresh;
info.midAmpThresh = EEG_calibration_EEG.midAmpThresh;
info.midAmpLim = EEG_calibration_EEG.midAmpLim;
info.highAmpThresh = EEG_calibration_EEG.highAmpThresh;
info.highAmpLim = EEG_calibration_EEG.highAmpLim;
[EEGtriggeredPAS.results, EEGtriggeredPAS.data_emg, EEGtriggeredPAS.data_eeg, EEGtriggeredPAS.MEP, EEGtriggeredPAS.EEG] = EEGtriggeredPAS(tg,info); % RUN
% STOP EEG

%**************************************************************************
% END of Main Experiment
%**************************************************************************


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% stop simulink model
if info.development_flag == 0
    tg.stop; % stop target (simulink model)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%