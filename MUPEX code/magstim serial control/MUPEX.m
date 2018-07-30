%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Linking Mu Power to motor EXcitability (MUPEX)
%
% by Til Ole Bergmann (mail@tobergmann.de)
% last edited 2017/10/05 by TOB
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% boot; % boot simulink target
  
dbstop if error;
clear all;close all; clc; 

%% ENTER subject-specific information here
info = [];
info.subjectCode = 'MUPEX_S18'; % <-- ENTER subject code as 'MUPEX_S##', e.g., 'MUPEX_S01'
% info.subjectCode = 'MUPEX_Test'; % <-- ENTER subject code
info.development_flag = 0; % SET whether running experiments in lab (0) or devlopment in office without simulink (1)
info.simulinksamplerate = 1000; % sample rate of Simulink model
info.EMGchanLabels = {'APB','FDI'}; % EMG channel names
info.targetEMGchan = 2; % which EMG channel to plot online (1 = APB, 2 = FDI)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% configure simulink (target pc)
switch info.development_flag 
    case 0
        info.SimulinkScripts = 'M:\Experiment 2017-10 MUPEX'; 
        info.pathMatlabScripts = 'M:\Experiment 2017-10 MUPEX\magstim serial control';
        info.resultsPath = ['M:\Experiment 2017-10 MUPEX\MUPEX_data\' info.subjectCode]; % <-- ENTER path for results to be saved
        info.fieldtripPath = 'C:\Matlab\fieldtrip';
%         info.portnames = {'COM1', 'COM2','COM10', 'COM11'}; % names of 4 COM ports abailable at your computer        
        info.portnames = {'COM3', 'COM4','COM5', 'COM6'}; % names of 4 COM ports abailable at your computer        
        tg = xpc; % get target
        cd(info.SimulinkScripts); % needs to be in path to load simulink model
        load(tg, 'quadripulse_controller14'); % load the application onto target     
        tg.start; % start target (simulink model)
        cd(info.pathMatlabScripts); % go back to path contining Matlab scripts
        info.speedupfactor = 1;        
    case 1
        info.pathMatlabScripts = 'E:\Dropbox\Projects\MUPEX_Miriam\Experiment 2017-10 MUPEX\magstim serial control';
        info.resultsPath = ['E:\Dropbox\Projects\MUPEX_Miriam\Experiment 2017-10 MUPEX\MUPEX_data\' info.subjectCode];
        info.fieldtripPath = 'X:\MATLAB\fieldtrip';
        info.portnames = {'COM1', 'COM2','COM3', 'COM4'}; % the names of 4 COM ports abailable at your computer
        load(fullfile(info.pathMatlabScripts,'MEPexample.mat'));
        info.speedupfactor = 50;
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

% START EEG
%% initial µ-rhythm calibration (~3 min)
info.timestamp = datestr(now,30); % set current timestamp
info.numEpochs = 60; % <-- ENTER number of 3s EEG epochs to analyze (60 --> 3 min)
info.freqwin = [8 14]; % frequency window to search for µ-peak frequency 
info.lowAmpLimCrit = 0; % lower limit percentile (0.05 = lowest 5%)
info.lowAmpCrit = info.lowAmpLimCrit + 0.2; % lower x % above minimum value 
info.highAmpLimCrit = 0.99; % upper limit percentile (0.95 = highest 5%)
info.highAmpCrit = info.highAmpLimCrit - 0.2; % upper x % below upper limit 
[EEGcalibration_results, EEG_calibration_data, EEG_calibration_EEG] = MUPEX_EEGcalibration(tg,info); %RUN
% STOP EEG


%% apply individual parameters (µ peak frequency for filter parameters and FFT bin extraction and spatial filter)
% info.mufreq = 11; % manual entry if necessary
info.mufreq = EEG_calibration_EEG.mufreq; % get individual mu peak frequency
info.fft_bin_indices_zero_based = [info.mufreq-1 info.mufreq+1]; % calculate FFT bins to extract
tg.setparam('fft_bin_indices_zero_based', info.fft_bin_indices_zero_based); % apply FFT bins to extract
info.fir_filter_coefficients = get(design(fdesign.bandpass('n,fst1,fp1,fp2,fst2', 128, info.mufreq-6, info.mufreq-2, info.mufreq+2, info.mufreq+6, 1000), 'firls', 'FilterStructure', 'dffirt'), 'Numerator'); % calculate frequency filter settings 
tg.setparam('fir_filter_coefficients',info.fir_filter_coefficients); % apply frequency filter settings

% wide Hjorth filter if necessary
info.N = 65; % number of channels
info.chan_center = 5; % channel number of center channel for Hjorth transform
info.chan_surround = [21 23 25 27]; % channel numbers of surrounding channels for Hjorth transform
info.spatial_filter = zeros(1,info.N); info.spatial_filter(info.chan_center) = 1; info.spatial_filter(info.chan_surround) = -1/length(info.chan_surround); % calculate "wide Hjorth" spatial filter
tg.setparam('spatial_filter', info.spatial_filter); % apply spatial filter settings

% % spatial filter from component analysis
% info.spatial_filter = muComp.spatial_filter;
% tg.setparam('spatial_filter', info.spatial_filter); % apply spatial filter settings


%% Test EEG trigger !
% info.timestamp = datestr(now,30); % set current timestamp
% info.numTrialCond = 10; % number of trials PER experimental (amplitude x phase x pulse) CONDITION (n = 150)
% info.trialspercondtopause = 15; % numner of trials per experimental condition until break
% info.waitbeforestart = 60; % seconds to wait before experiment starts to allow online threshold to adapt
% info.CS = 0; % subject-specific CS that results in 50 % of max SICCI
% info.TS = 0; % subject-specific TS (1mV_MEP threshold) here as % MSO
% info.lowAmpLim = EEG_calibration_EEG.lowAmpLim;
% info.lowAmpThresh = EEG_calibration_EEG.lowAmpThresh;
% info.highAmpThresh = EEG_calibration_EEG.highAmpThresh;
% info.highAmpLim = EEG_calibration_EEG.highAmpLim;
% [EEGtriggerTest.results, EEGtriggerTest.data, EEGtriggerTest.EEG] = MUPEX_EEGtriggerTest(tg,info); % RUN


%% MEP hotspot search (as long as it takes...)
info.timestamp = datestr(now,30); % set current timestamp
info.numTrial = 1000; % number of trials 
[hotspot_results, hotspot_data, hotspot_MEP] = MUPEX_hotspotsearch(tg,info); % RUN     


%% MEP resting motor threshold (RMT) determination by means of SA-PEST procedure (~2 min)
info.timestamp = datestr(now,30); % set current timestamp
info.waitbeforestart = 15; % seconds to wait before experiment starts to allow online threshold to adapt
info.numTrial = 40; % number of trials 
info.SIstart = 30; % <-- ENTER default stimulation intensity (SI) in % MSO to start with
info.decisionRule = 'binary'; % whether hit/miss decision is based on above/below rule ('binary') or running average ('runningaverage')
info.runAvgLen = 20; % number of trials included in running average 
info.thresholdCriterion = 50; % threshold criterion in µV (e.g., 50 µV for RMT and 1000 for 1 mV MEP)
info.initialstepsize = 2; % initial step size for SA-PEST in % MSO 
info.stepsizelimits = [1 8]; % [minimal maximal] step size for SA-PEST in % MSO   
info.SIlimits = [10 80]; % [minimal maximal] stimulation intensity allowed in % MSO 
[RMThunting_results, RMThunting_data, RMThunting_MEP] = MUPEX_thresholdhunting(tg,info); % RUN
info.RMT = round(mean(RMThunting_MEP.SI(end-19:end))); % subject-specific resting motor threshold (RMT) RMT here as % MSO
% info.RMT = 30;

%% MEP 1mV-MEP threshold (MEP1mv) determination by means of SA-PEST procedure (~2 min)
info.timestamp = datestr(now,30); % set current timestamp
info.waitbeforestart = 15; % seconds to wait before experiment starts to allow online threshold to adapt
info.numTrial = 40; % number of trials 
info.SIstart = info.RMT; % <-- ENTER default stimulation intensity (SI) in % MSO to start with
info.decisionRule = 'binary'; % whether hit/miss decision is based on above/below rule ('binary') or running average ('runningaverage')
info.runAvgLen = 20; % number of trials included in running average 
info.thresholdCriterion = 1000; % threshold criterion in µV (e.g., 50 µV for RMT and 1000 for 1 mV MEP)
info.initialstepsize = 2; % initial step size for SA-PEST in % MSO
info.stepsizelimits = [1 8]; % [minimal maximal] step size for SA-PEST in % MSO
info.SIlimits = [10 80]; % [minimal maximal] stimulation intensity allowed in % MSO 
[MEP1mVhunting_results, MEP1mVhunting_data, MEP1mVhunting_MEP] = MUPEX_thresholdhunting(tg,info); % RUN
info.MEP1mV = round(mean(MEP1mVhunting_MEP.SI(end-19:end))); % subject-specific 1mV_MEP threshold here as % MSO
% info.MEP1mV = 50;

% START EEG
%% MEP curve determination (~7 min)
info.timestamp = datestr(now,30); % set current timestamp
info.waitbeforestart = 15; % seconds to wait before experiment starts to allow online threshold to adapt
info.numTrialCond = 10; % number of trials PER CS intensity CONDITION 
info.SIvec = [30:5:90]; % <-- ENTER vector of TS intensities as % MSO (!) to test (currently ist must be 13 values!)
[MEPcurve.results, MEPcurve.data, MEPcurve.MEP] = MUPEX_MEPcurve(tg,info); % RUN
% STOP EEG

%**************************************************************************

% START EEG
%% EEG-triggered MEP [Main Experiment] (very long... ca. 1.5h?)
info.SIvec = [30:5:90]; % <-- ENTER vector of TS intensities as % MSO (!) to test%% EEG-triggered MEP [Main Experiment] (very long... ca. 1.5h?)
info.timestamp = datestr(now,30); % set current timestamp
info.numTrialCond = 25;% 25; % number of trials PER experimental (amplitude+phase x pulse) CONDITION (n = 150)
info.trialspercondtopause = 10000; % numner of trials per experimental condition until break
info.waitbeforestart = 60; % seconds to wait before experiment starts to allow online threshold to adapt
info.TS = MEPcurve.MEP.at50percofrange_MSO; % info.MEP1mV; % subject-specific TS (1mV_MEP threshold) here as % MSO
[EEGtriggeredMEP.results, EEGtriggeredMEP.data, EEGtriggeredMEP.MEP] = MUPEX_EEGtriggeredMEP(tg,info); % RUN
% STOP EEG

%**************************************************************************


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EEGcalibration_results = load('MUPEX_S08_20160824T090033_EEGcalibration.mat','EEG');
% EEG_calibration_data = load('MUPEX_S08_20160824T090033_EEGcalibration.mat','data');
% EEG_calibration_EEG = load('MUPEX_S08_20160824T090033_EEGcalibration.mat','results');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% stop simulink model
if info.development_flag == 0
    tg.stop; % stop target (simulink model)
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%