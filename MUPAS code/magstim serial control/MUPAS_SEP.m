%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MUPAS
% [results, data, SEP] = MUPAS_SEP(tg,info)
% by Til Ole Bergmann (mail@tobergmann.de)
% last edited 2017/11/22 by TOB
%
% measures SEP with a fixed intensity
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preparation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
function [results, data, SEP] = MUPAS_SEP(tg,info)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set individual values here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define trials and timing
ITIrange = [1/5 1/3]/info.speedupfactor; % <-- ENTER range within which ITI shall be jittered (! overwrites ITIjitter if not [] ! ) 
% ITIrange = [1/3 1/2]/info.speedupfactor; % <-- ENTER range within which ITI shall be jittered (! overwrites ITIjitter if not [] ! ) 
% ITI = 1/3; % <-- ENTER inter-trial interval (ITI), minimum is 4 s for MagStim 200² and BiStim²
% ITIjitter = 20; % <-- ENTER jitter of ITI as +/- % of ITI (e.g. 20 % jitter with an ITI of 5 s means ITI between 4 and 6 s)

% settings for SEP online analysis
EMGchan = [1 2]; % channels containing EMG data for SEP analyses
prepostdatawin = [-0.05 0.1]; % data time window pre and post TMS pulse (as set in simulink model)
dataArraySize = int32([numel(EMGchan),sum(abs(prepostdatawin))*info.simulinksamplerate]); % size of data array received from Simulink
SEP.win = [0.015 0.025]; % post-TMS window for SEP analysis in s
SEP.searchwin = int32((abs(prepostdatawin(1)) + SEP.win) * info.simulinksamplerate); % searchwindow to determine SEP peak-to-peak amplitude
SEP.searchwin = SEP.searchwin + 4; % to correct for delay of DIGITIMER relative to trigger
EMGdataTime = prepostdatawin(1):1/info.simulinksamplerate:prepostdatawin(2)-1/1/info.simulinksamplerate; % times for EMG window
SEP.SI = info.MNSI;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% prepare protocol
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% configure setup 
% info.portnames = {'COM3', 'COM4', 'COM5', 'COM6'}; % name of COM port (default {'COM1'})
if info.development_flag == 1
    info.portnames = {'COM1'}; % for debugging at office pc only    
	load(fullfile(info.pathMatlabScripts,'SEPexample.mat'));
end

% calculate ITIrange if not preset
if ~exist('ITIrange','var') || (exist('ITIrange','var') && isempty(ITIrange))
    ITIrange = [ITI-ITI*ITIjitter/100 ITI+ITI*ITIjitter/100];
end

% create ITIvecRand
ITIvecRand = rand(1,info.numTrial)*diff(ITIrange)+ITIrange(1);

%% setup PsychToolbox parameters
PsychDefaultSetup(1); % Setup PTB with some default values

% Define the keyboard keys
KbName('UnifyKeyNames');
startKey = KbName('Home');
pauseKey = KbName('Pause');
resumeKey = KbName('PrintScreen');
escapeKey = KbName('ESCAPE');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% connect and initialize stimultors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% open COM port (and start mc_maintain callback function) 
s = mc_open(info.portnames); % open serial port and give back port object
mc_pause(0.5);
if info.development_flag == 1
    s = [s s s s];
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RUN SEP measurement
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% preparation
results = [];
grey = [0.8,0.8,0.8];

% create fieldtrip compatible data structure
data.trial = {};
data.label = {'RawTargetSignal','FilteredTargetSignal', 'ForcastedTargetSignal' 'PowerTargetSignal'};
data.fsample = info.simulinksamplerate;

% set stimulation intensities for first trial
mc_setintensity(s, repmat(SEP.SI,1,4)); % intensity values for all stimulators 

% initialize variables
runAvgSEPWav =[];

%% actual trial loop
display(' ');
% wait for key press to start
display('Please FIRST arm Digitimer DS7A electric stimulator manually!');
display('THEN press Pos1 to start SEP measurement.');
[keyIsDown,secs, keyCode] = KbCheck;
while ~keyCode(startKey);
    [keyIsDown,secs, keyCode] = KbCheck;
    mc_pause(0.09);
end
display('Starting experiment (in 5 seconds)...');
% mc_arm(s,1); % arm (1) / disarm (0) stimulator
mc_pause(5);
display(' ');

startRunTime = clock;
for i = 1:info.numTrial % loop over trials   
    xt = tic;
    % loopControl
     [keyIsDown,secs, keyCode] = KbCheck;    
        if keyCode(escapeKey)
            display('Experiment canceled.');
            mc_arm(s,0); % arm (1) / disarm (0) stimulator
            mc_close(); % close serial ports
            return
        elseif keyCode(pauseKey)
            display(['Pause after ' num2str(i-1) 'trials. Press PRINTSCREEN to continue or ESCAPE to cancel.']);
            while ~keyCode(resumeKey) && ~keyCode(escapeKey) 
                [keyIsDown,secs, keyCode] = KbCheck;
                mc_pause(0.09);
            end
            if keyCode(escapeKey)
                display('Experiment canceled.');
                mc_arm(s,0); % arm (1) / disarm (0) stimulator
                mc_close(); % close serial ports                
                return
            end
            display('Resume...!');
        end
    
    % get trial time
    startTrialTime = clock;
    
    %% prepare trigger
    stimulators = [3 0]; % second value is dummy
    times = [0 0.002]; % second value is dummy
       
    % prepare marker for NeuroOne
    marker = 1; % no conditions to code for but marker needs to be present
    
    % prepare hostscope ID for mc_triggerandrecordEEG()
    hostscope = 14;

    %% TRIGGER STIMULATOR & RECORD DATA
    if info.development_flag == 0
        data.trial{i} = mc_FASTtriggerandrecordEEG(tg,times,stimulators,marker,hostscope); % trigger stimultor(s) and receive data
        data.time{i} = (prepostdatawin(1)+1/data.fsample:1/data.fsample:prepostdatawin(2));
    elseif info.development_flag == 1 % no simulink
%         display(['Would have triggered stimulators ' num2str(stimulators) ' at times ' num2str(times) '...']);
        decFun = flip(([info.numTrial:-1:1].^2+500)/1000);
        dat = repmat(SEPexample,numel(EMGchan),1) .* (rand(1,1)+0.5) * decFun(i);
        data.trial{i} = dat - repmat(mean(dat(:,1:abs(prepostdatawin(1)*info.simulinksamplerate)),2),1,dataArraySize(2));
        data.time{i} = (prepostdatawin(1)+1/data.fsample:1/data.fsample:prepostdatawin(2));
    end
    
   
    %% check timing
    elapsedRunTime = etime(clock, startRunTime); % how much time elapsed already within this RUN
    
    %% collect results
    results(i,:) = [i, elapsedRunTime, SEP.SI, ITIvecRand(i), stimulators(1)];                 
	data.trialinfo(i,:) = results(i,:);
       
    %% average SEP waveform
    runAvgSEPWav = mean([runAvgSEPWav; data.trial{i}(1,:) * 1/(i-1)],1);    % incorrect!
    
    %% analyze SEP data
    SEP.p2pAll(:,i) = abs(max(data.trial{i}(:,SEP.searchwin(1):SEP.searchwin(2)),[],2)) + abs(min(data.trial{i}(:,SEP.searchwin(1):SEP.searchwin(2)),[],2));

    %% calculate running average SEP amplitude
    runAvgStart = max(i-info.runAvgLen+1,1);
    runAVGAmp(:,i) = mean(SEP.p2pAll(:,runAvgStart:i),2);       
  
    % display trial info
    display(['Trial ' num2str(i) '/' num2str(info.numTrial) ', SI: ' num2str(SEP.SI) ', stimulator: ' num2str(stimulators(1)) ', last SEP: ' num2str(SEP.p2pAll(info.targetEMGchan,i)/1000) ' mV, average SEP:' num2str(runAVGAmp(info.targetEMGchan,i)/1000) ' mV']);
        
    %% plot SEP data
%     figure(h);
%     cla;
%     title('SEP curren trial (red) and running average (blue)');
%     hold on;    
%     plot(data.time{i},data.trial{i}(1,:),'r'); % current SEP amplitude
%     plot(data.time{i},runAvgSEPWav,'b', 'LineWidth', 2); % average SEP amplitude
%     hold off;
%     set(gca,'XTick',[1:info.numTrial], 'XLim', [0 info.numTrial]);
%     set(gca,'YTick',[0:100:3000], 'YLim', [0 3000]);

    %% wait for rest of ITI    
    drawnow;
    elapsedTrialTime = etime(clock, startTrialTime); % how much time elapsed already within this trial
    mc_pause(ITIvecRand(i)-elapsedTrialTime); % wait for remaining time of current ITI    
    display(['trialtime = ' num2str(toc(xt))]);
end % of loop over trials


%% determine SEP N20 latency
% setup figure
h = figure;
set(h,'Name',[info.subjectCode '_' info.timestamp '_SEP.mat']);
title(['Average SEP of ' num2str(i) ' trials']);
cfg = [];
SEP_timelock = ft_timelockanalysis(cfg,data);
figure;plot(SEP_timelock.time,SEP_timelock.avg(1,:)');
[pks,locs] = findpeaks(SEP_timelock.avg(1,SEP.searchwin(1):SEP.searchwin(2))*-1);
[maxval, maxpos] = max(pks);
locations = locs + double((SEP.searchwin(1) - abs(prepostdatawin(1)) * info.simulinksamplerate));
SEP.N20_latency = locations(maxpos)/info.simulinksamplerate - 0.005; % to correct for 4 ms Digitimer trigger delay
ylimvec = ylim;
ylim([-max(abs(ylimvec)),max(abs(ylimvec))]);
line([SEP.N20_latency SEP.N20_latency] + 0.004, [-max(abs(ylimvec)),max(abs(ylimvec))], 'Color', 'r', 'LineWidth', 1, 'LineStyle', '--');
text(SEP.N20_latency+0.01, max(ylim)*0.8,['N20 latency = ' num2str(SEP.N20_latency) ' s'],'Color','r');

%% save updated results file and figure
save(fullfile(info.resultsPath,[info.subjectCode '_SEP.mat']),'results','data','SEP','info');
saveas(gcf,fullfile(info.resultsPath,[info.subjectCode '_SEP.fig']));

display(' ');
display(['Average SEP latency is ' num2str(SEP.N20_latency) ' and amplitude is ' num2str(maxval) ' µV']);
display(' ');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% stop and disconnect stimulators
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% disarm stimulator
mc_arm(s,0); % arm (1) / disarm (0) stimulator
mc_pause(0.25);

%% close COM ports 
mc_close(); % close serial ports
pause(0.2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end % of function