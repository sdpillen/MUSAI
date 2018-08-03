%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MUPAS
% [results, data, MEP] = MUPAS_EEGtriggeredPAS(tg,info)
% by Til Ole Bergmann (mail@tobergmann.de)
% last edited 2018/01/28 by TOB
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [results, data_emg, data_eeg, MEP, EEG] = MUPAS_EEGtriggeredPAS(tg,info)
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set individual values here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define trials and timing
ITImin = 3/info.speedupfactor; % minimal ITI betwen two pulses (no matter which stimulator)
ITIreplay = 0; % reset

% define experimental conditions
switch info.condition % (1) open loop, (2) low power random phase, (3) mid power random phase, (4) mid power peak, (5) mid power trough, (6) randomized mid power peak and trough 
    case 1 % open loop,
        phaseCond = 0; %  (0) random phase, (1) rising flank, (2) peak, (3) falling flank, (4) trough 
        powerCond = 0; % (0) random power, (1) low power, (2) mid power, (3) high power   
        ITIreplay = 1; % (1) do ITI replay!

        % read ISI from EEG data
        display(['Loading ISI from ' info.replayfile ' ...']);
        markers = module_read_neurone_events(info.replayfile, 5000);
        display([num2str(length(markers.time)) ' markers found. Preparing ISI vector for replay...']);
        ITIreplayVec = diff(markers.time);
        diffLength = info.numTrialCond-length(ITIreplayVec);
        if diffLength > 0            
            ITIreplayVec(end+1:end+diffLength) = ITIreplayVec(1:diffLength);
        elseif diffLength < 0            
            ITIreplayVec = ITIreplayVec(1:info.numTrialCond);
        end
        display(['ISI replay vector with ' num2str(length(ITIreplayVec)) ' elements prepared.']);            
                       
    case 2 % low power random phase
        phaseCond = 0;   
        powerCond = 1; 
    case 3 % mid power random phase
        phaseCond = 0;   
        powerCond = 2; 
    case 4 % mid power peak
        phaseCond = 2;   
        powerCond = 2;         
    case 5 % mid power trough
        phaseCond = 4;   
        powerCond = 2;       
    case 6 % randomized high power peak and trough 
        phaseCond = [2 4];
        phaseCondVec = [];
        for iIter = 1:info.numTrialCond
            phaseCondVec = [phaseCondVec, phaseCond(randperm(2))];
        end
        powerCond = 2;   
end
TMSCond = 1; % (1) single pulse, (2) paired pulse
numCond = numel(powerCond) * numel(phaseCond) * numel(TMSCond);
lableCond = {'Replay', 'LowRandom', 'MidRandom', 'MidPeak', 'MidTrough','MidPeakAndTrough'};
% plotOrder = [1 2 3 4 5]; % order in which the above conditions are plotted into 2x5 subplot figure

% settings for MEP online analysis
EMGchan = [1 2]; % channels containing EMG data for MEP analyses
prepostdatawin = [-0.05 0.1]; % data time window pre and post TMS pulse (as set in simulink model)
dataArraySize_emg = int32([numel(EMGchan),sum(abs(prepostdatawin))*info.simulinksamplerate]); % size of data array received from Simulink
dataArraySize_eeg = int32([4 2000]); % size of EEG data array received from Simulink
MEP.win = [0.02 0.05] + info.ISI/1000; % post-TMS window for MEP analysis in s
MEP.searchwin = int32((abs(prepostdatawin(1)) + MEP.win) * info.simulinksamplerate); % searchwindow to determine MEP peak-to-peak amplitude
EMGdataTime = prepostdatawin(1):1/info.simulinksamplerate:prepostdatawin(2)-1/1/info.simulinksamplerate; % times for EMG window

% settings for EEG online analysis
EEGchan = [1:4]; % channels containing EEG data for EEG analyses
prepostdatawin_eeg = [-1 1]; % data time window pre and post TMS pulse (as set in simulink model)
dataArraySize = int32([numel(EEGchan),sum(abs(prepostdatawin_eeg))*info.simulinksamplerate]); % size of data array received from Simulink
EEG.win = [-0.5 0]; % post-TMS window for EEG analysis in s
EEG.searchwin = int32((abs(prepostdatawin_eeg(1)) + EEG.win) * info.simulinksamplerate); % searchwindow to determine EEG power
EEGdataTime = prepostdatawin_eeg(1)+1/info.simulinksamplerate:1/info.simulinksamplerate:prepostdatawin_eeg(2); % times for EEG window

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% prepare protocol
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% configure setup 
% info.portnames = {'COM3', 'COM4', 'COM5', 'COM6'}; % name of COM port (default {'COM1'})
if info.development_flag == 1
    info.portnames = {'COM1'}; % for debugging at office pc only    
	load(fullfile(info.pathMatlabScripts,'MEPexample.mat'));    
end

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
% RUN SICI curve protocol
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% preparation
results = [];

% create fieldtrip compatible data structures
data_emg.trial = {};
data_emg.label = info.EMGchanLabels;
data_emg.fsample = info.simulinksamplerate;

data_eeg.trial = {};
data_eeg.label = {'RawTargetSignal','FilteredTargetSignal', 'ForcastedTargetSignal' 'PowerTargetSignal'};
data_eeg.fsample = info.simulinksamplerate;

data_ampthreshold.trial = {};
data_ampthreshold.label = {'ampthreshold'};
data_ampthreshold.fsample = info.simulinksamplerate;


% setup MEP average arrays
MEP.waveavg = cell(1,numCond); % initialize cell array for incremental MEP waveform average for all conditions
MEP.p2pAll = cell(1,numCond); % initialize array for ALL MEP p2p values for all conditions
for j = 1:numCond % initialize all condition cells with zeros
    MEP.p2pAll{j} = zeros(numel(EMGchan),1);
    MEP.waveavg{j} = zeros(numel(EMGchan),dataArraySize_emg(2));
end
MEP.p2pavg = zeros(numel(EMGchan),numCond); % initialize array for incremental MEP p2p average for all conditions

% setup EEG average arrays
EEG.waveavg = cell(1,numCond); % initialize cell array for incremental EEG waveform average for all conditions
plotdata = {};
EEG.p2pAll = cell(1,numCond); % initialize array for ALL EEG p2p values for all conditions
for j = 1:numCond % initialize all condition cells with zeros
    EEG.p2pAll{j} = zeros(numel(EEGchan),1);
    EEG.waveavg{j} = zeros(numel(EEGchan),dataArraySize(2));
end
EEG.p2pavg = zeros(numel(EEGchan),numCond); % initialize array for incremental EEG p2p average for all conditions

% setup figure
h = figure;
set(h,'Name',[info.subjectCode '_' info.timestamp '_EEGtriggeredPAS.mat']);
for j = 1:4
    subplot(2,2,j);
end

% set intensities for 1st trial
mc_setintensity(s(1:2), [info.SI info.SI]); % intensity values (trial 1) for stimulator pair 1+2
display(' ');
mc_pause(5);

%% actual trial loop
display(' ');
% wait for key press to start
display('(Stop and) START EEG recording!!!');
display('Not yet arm stimulators - wait until T-10s!');
display('Press Pos1 to start EEG-triggered PAS experiment.');
[keyIsDown,secs, keyCode] = KbCheck;
while ~keyCode(startKey);
    [keyIsDown,secs, keyCode] = KbCheck;
    mc_pause(0.09);
end

display('Instruct participant to relax and fixate!');
mc_pause(5);  
for iTrial = info.waitbeforestart:-1:1
    mc_pause(1);    
    display(['Starting experiment (in ' num2str(iTrial) ' seconds)...']);
    if iTrial == 10
        display(' ');
        display('Arm stimulators 1 and 2 (top) manually!');
        display(' ');
    end 
end
mc_pause(1);    
display('Starting experiment now!');

startRunTime = clock;
startTrialTime = startRunTime;
elapsedRunTime = 0;
for iTrial = 1:info.numTrialCond % loop over trials   
    display(['TrialStart: ' num2str(clock)]);
    tic;
    % loopControl
    [keyIsDown,secs, keyCode] = KbCheck;
    %      if ~mod(iTrial-1,info.trialspercondtopause * numCond) && iTrial > 1 % this is the next trial after another x completed
    %          keyCode(pauseKey) = 1; % pretend pause key as been struk
    %      end
    if keyCode(escapeKey)
        display('Experiment canceled.');
        mc_arm(s,0); % arm (1) / disarm (0) stimulator
        mc_close(); % close serial ports
        return
    elseif keyCode(pauseKey)
        display(['Pause after ' num2str(iTrial-1) 'trials. Press PRINTSCREEN to continue or ESCAPE to cancel.']);
        display('Disarm and arm all stimulators before you continue!');
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
    
    %% prepare trigger ports and times
    if mod(iTrial,2) % odd trials       
        stimulators = [3 1]; % 3 is MNS
    elseif ~mod(iTrial,2) % even trials
        stimulators = [3 2]; % 3 is MNS
    end
    
    times = [0 info.ISI/1000];
    
    %% prepare EEG amplitude detection parameters
    if powerCond == 0 % RANDOM amplitude
        amplitudes = [0 100000]; % full range (zero to sufficiently high number)
        amplitudePercentiles = [0 1]; % full range
    elseif powerCond == 1 % LOW amplitude
        amplitudes = [info.lowAmpLim info.lowAmpThresh];
        amplitudePercentiles = [info.lowAmpLimCrit info.lowAmpCrit];
    elseif powerCond == 2 % MID amplitude
        amplitudes = [info.midAmpThresh info.midAmpLim];
        amplitudePercentiles = [info.midAmpCrit info.midAmpLimCrit];
    elseif powerCond == 3 % HIGH amplitude
        amplitudes = [info.highAmpThresh info.highAmpLim];
        amplitudePercentiles = [info.highAmpCrit info.highAmpLimCrit];        
    end
    
    % prepare phase detection parameter
    if info.condition == 6
        whichphase = phaseCondVec(iTrial);
        phaseCond = phaseCondVec(iTrial);
    else
        whichphase = phaseCond;
    end
    % prepare marker for NeuroOne
     if info.condition == 6
        marker = phaseCondVec(iTrial);
     else
        marker = 1; 
    end
    
    % prepare forcast offset
    forecast_offset = info.ISI;
preTMS = toc;
display(['preTMS: ' num2str(preTMS )]);
display(['TriggerStart: ' num2str(clock)]);
    %% TRIGGER STIMULATOR & RECORD DATA
    if info.development_flag == 0
        startTrialTime_old = startTrialTime;
        startTrialTime = clock; % get trial time (TRIAL STARTS WITH TMS PULSE!)
        [data_emg.trial{iTrial}, data_eeg.trial{iTrial}, data_ampthreshold.trial{iTrial}] = mc_EEGtriggerandrecordEXG(tg,amplitudes,amplitudePercentiles,whichphase,forecast_offset,times,stimulators,marker); % trigger stimultor(s) and receive data                        
        display(['TMS: ' num2str(startTrialTime)]);
        data_emg.time{iTrial} = (1/data_emg.fsample:1/data_emg.fsample:double(dataArraySize_emg(2))/data_emg.fsample);
        data_eeg.time{iTrial} = (1/data_eeg.fsample:1/data_eeg.fsample:double(dataArraySize_eeg(2))/data_eeg.fsample);
        data_ampthreshold.time{iTrial} = (1/data_ampthreshold.fsample:1/data_ampthreshold.fsample:double(dataArraySize_eeg(2))/data_ampthreshold.fsample);
    elseif info.development_flag == 1 % no simulink
        display(['Would have triggered stimulators ' num2str(stimulators) ' at times ' num2str(times) '...']);
        startTrialTime_old = startTrialTime;
        startTrialTime = clock; % get trial time (TRIAL STARTS WITH TMS PULSE!)        
        dat = repmat(MEPexample,numel(EMGchan),1) .* (rand(1,1)+0.5);
        data_emg.trial{iTrial} = dat - repmat(mean(dat(:,1:abs(prepostdatawin(1)*info.simulinksamplerate)),2),1,dataArraySize_emg(2));        
        data_emg.time{iTrial} = (1/data_emg.fsample:1/data_emg.fsample:double(dataArraySize_emg(2))/data_emg.fsample);        
%         data_eeg.trial{iTrial} = rand(dataArraySize_eeg)*10-5 .* repmat(sin(single([[1:1:dataArraySize_eeg(2)]*pi*1/10+rand(1,1)*2*pi])),4,1); % random signal (10 Hz + noise)    
        data_eeg.trial{iTrial} = rand(dataArraySize_eeg)*10-5 .* repmat(sin(single([[1:1:double(dataArraySize_eeg(2))]*pi*1/10+rand(1,1)*2*pi])),dataArraySize_eeg(1),1) ; % random signal (10 Hz + noise)            
        data_eeg.time{iTrial} = (1/data_eeg.fsample:1/data_eeg.fsample:double(dataArraySize_eeg(2))/data_eeg.fsample);
    end
  
	%% check timing
    elapsedRunTime_old = elapsedRunTime; % from last trial
    elapsedRunTime = etime(startTrialTime, startRunTime); % how much time elapsed already within this RUN
    ITI = etime(startTrialTime, startTrialTime_old);    
        
    %% collect results
    results(iTrial,:) = [iTrial, elapsedRunTime, ITI, info.ISI, info.MNSI, info.SI, stimulators, powerCond, phaseCond, info.condition];
    data_emg.trialinfo(iTrial,:) = results(iTrial,:);
    
    display(' ');
    display(['Trial ' num2str(iTrial) '/' num2str(info.numTrialCond) ', time = ' num2str(elapsedRunTime) 's, ITI = ' num2str(ITI), 's, Amplitude ' num2str(powerCond) ', phase = ' num2str(phaseCond) ', condition = ' lableCond{info.condition} ' (' num2str(info.condition) ')']);
    display(' ');    
   display(['MEPAnalyzeStart: ' num2str(clock)]); 
    %% analyze MEP data
    if info.condition ==6
        if phaseCond == 2
            condID = 1;
        elseif phaseCond == 4
            condID = 2;
        end
    else
        condID = 1;  % fake condition 
    end
    thisCond = data_emg.trial(results(:,11)==info.condition & results(:,10)==phaseCond); % current trials in this condition         
    MEP.p2pAll{condID}(:,numel(thisCond)) = abs(max(data_emg.trial{iTrial}(:,MEP.searchwin(1):MEP.searchwin(2)),[],2)) + abs(min(data_emg.trial{iTrial}(:,MEP.searchwin(1):MEP.searchwin(2)),[],2));
    MEP.p2pavg(:,condID) = MEP.p2pavg(:,condID) * (numel(thisCond)-1)/numel(thisCond) + MEP.p2pAll{condID}(:,numel(thisCond)) * 1/numel(thisCond);    
    MEP.waveavg{condID} = MEP.waveavg{condID} * (numel(thisCond)-1)/numel(thisCond) + data_emg.trial{iTrial} * 1/numel(thisCond); % incremental averaging          
    
    %% analyze EEG data
    thisCond_eeg = data_eeg.trial(results(:,11)==info.condition & results(:,10)==phaseCond); % current trials in this condition                   
    
    %% plot data  
    figure(h);
    
    % plot current EEG data
    subplot(2,2,1);
    EEGchans = [1:3];
    baselinewindow = [500:1000];
    bldata = data_eeg.trial{iTrial}(EEGchans,baselinewindow);
    plotdata{iTrial} = data_eeg.trial{iTrial}(EEGchans,:) - repmat(mean(bldata,2),1,size(data_eeg.trial{iTrial},2)); % basline-correct
    plot(EEGdataTime,plotdata{iTrial}(1,:),'r','LineWidth',1); % raw target signal
    hold on;
    plot(EEGdataTime,plotdata{iTrial}(2,:),'m','LineWidth',2); % filtered target signal
    plot(EEGdataTime,plotdata{iTrial}(3,:),'g','LineWidth',2); % forcasted target signal
    hold off;
    line([0 0], get(gca,'ylim'), 'Color', 'k', 'LineWidth', 1, 'LineStyle', '-');
    line([times(2) times(2)], get(gca,'ylim'), 'Color', 'k', 'LineWidth', 1, 'LineStyle', '-');
    xlabel('time (s) relative to TMS');
    ylabel('EEG (µV)');
    title(['EEG: ' lableCond{info.condition} ' (Trial ' num2str(numel(thisCond)) '/' num2str(info.numTrialCond) ')']);
    temp = [plotdata{:}];
    %     maxylim = max(abs(ceil(max(max(temp(1:3,:))))), abs(floor(min(min(temp(1:3,:))))));
    %     ylim([-maxylim maxylim]);
    xlim([-0.1 0.1]);
    drawnow;
    
    % plot average EEG data
    if condID == 1
        subplot(2,2,2);
        EEG.waveavg{condID} = EEG.waveavg{condID} * (numel(thisCond_eeg)-1)/numel(thisCond_eeg) + [plotdata{iTrial};data_eeg.trial{iTrial}(4,:)] * 1/numel(thisCond_eeg); % incremental averaging
        plot(EEGdataTime,EEG.waveavg{condID}(1,:),'b','LineWidth',1); % raw target signal
        hold on;
        plot(EEGdataTime,EEG.waveavg{condID}(2,:),'m','LineWidth',2); % filtered target signal
        plot(EEGdataTime,EEG.waveavg{condID}(3,:),'g','LineWidth',2); % forcasted target signal
        hold off;
        line([0 0], get(gca,'ylim'), 'Color', 'k', 'LineWidth', 1, 'LineStyle', '-');
        line([times(2) times(2)], get(gca,'ylim'), 'Color', 'k', 'LineWidth', 1, 'LineStyle', '-');        
        xlabel('time (s) relative to TMS');
        ylabel('EEG (µV)');
        if info.condition == 6
            title(['EEG: ' lableCond{info.condition}  ' PEAK (Trial ' num2str(numel(thisCond)) '/' num2str(info.numTrialCond) ')']);
        else
            title(['EEG: ' lableCond{info.condition}  ' (Trial ' num2str(numel(thisCond)) '/' num2str(info.numTrialCond) ')']);
        end
        temp = [EEG.waveavg{:}];
        maxylim = max(abs(ceil(max(max(temp(1:3,:))))), abs(floor(min(min(temp(1:3,:))))));
        ylim([-maxylim maxylim]);
        xlim([-0.1 0.1]);
        drawnow;
    end
    
    % plot EMG data
    subplot(2,2,3);
    plot(EMGdataTime,data_emg.trial{iTrial}(info.targetEMGchan,:),'k','LineWidth',1);
    hold on;
    if iTrial > 1
        plot(EMGdataTime,MEP.waveavg{1}(info.targetEMGchan,:),'b','LineWidth',2);
        if info.condition ==6
            plot(EMGdataTime,MEP.waveavg{2}(info.targetEMGchan,:),'r','LineWidth',2);
        end
    end
    hold off;
    line([0 0], get(gca,'ylim'), 'Color', 'k', 'LineWidth', 1, 'LineStyle', '-');
    line([MEP.win(1) MEP.win(1)], get(gca,'ylim'), 'Color', 'm', 'LineWidth', 1, 'LineStyle', '--');
    line([MEP.win(2) MEP.win(2)], get(gca,'ylim'), 'Color', 'm', 'LineWidth', 1, 'LineStyle', '--');
    xlabel('time (s) relative to TMS');
    ylabel('EMG (µV)');
    if info.condition ==6
        limFac = (max(abs(mean([MEP.waveavg{1}(info.targetEMGchan,:);MEP.waveavg{2}(info.targetEMGchan,:)]))))*1.5;
    else
        limFac = (max(abs([MEP.waveavg{1}(info.targetEMGchan,:)])))*1.5;
    end
    ylim([-limFac limFac]);
% 	ylim([-2000 2000]);
    title(['MEP: ' lableCond{info.condition}  ' (Trial ' num2str(numel(thisCond)) '/' num2str(info.numTrialCond) ')']);
    if info.condition == 6
        legend({'single-trial','PeakAvg','TroughAvg'},'location','west');
    end
    
    % plot average EEG data
    if condID == 2
        subplot(2,2,4);
        EEG.waveavg{condID} = EEG.waveavg{condID} * (numel(thisCond_eeg)-1)/numel(thisCond_eeg) + [plotdata{iTrial};data_eeg.trial{iTrial}(4,:)] * 1/numel(thisCond_eeg); % incremental averaging
        plot(EEGdataTime,EEG.waveavg{condID}(1,:),'b','LineWidth',1); % raw target signal
        hold on;
        plot(EEGdataTime,EEG.waveavg{condID}(2,:),'m','LineWidth',2); % filtered target signal
        plot(EEGdataTime,EEG.waveavg{condID}(3,:),'g','LineWidth',2); % forcasted target signal
        hold off;
        line([0 0], get(gca,'ylim'), 'Color', 'k', 'LineWidth', 1, 'LineStyle', '-');
        line([times(2) times(2)], get(gca,'ylim'), 'Color', 'k', 'LineWidth', 1, 'LineStyle', '-');
        xlabel('time (s) relative to TMS');
        ylabel('EEG (µV)');
        title(['EEG: ' lableCond{info.condition}  ' TROUGH (Trial ' num2str(numel(thisCond)) '/' num2str(info.numTrialCond) ')']);
        temp = [EEG.waveavg{:}];
        maxylim = max(abs(ceil(max(max(temp(1:3,:))))), abs(floor(min(min(temp(1:3,:))))));
        ylim([-maxylim maxylim]);
        xlim([-0.1 0.1]);
        drawnow;
    end
    
%     % update results with ITI imformation
%     elapsedRunTime = etime(clock, startRunTime); % how much time elapsed already within this RUN
%     ITI = elapsedRunTime - elapsedRunTime_old; 
%     results(iTrial,:) = [iTrial, elapsedRunTime, ITI, info.ISI, info.MNSI, info.SI, stimulators, powerCond, phaseCond, info.condition];
%     
    % every 10 trials save updated results file and figure
    if ~mod(numel(data_emg.trial),10)                        
        % save interim results file and figure
        save(fullfile(info.resultsPath,[info.subjectCode '_' info.timestamp '_EEGtriggeredPAS.mat']),'results','data_emg','data_eeg','MEP', 'EEG', 'info');
        saveas(gcf,fullfile(info.resultsPath,[info.subjectCode '_' info.timestamp '_EEGtriggeredPAS.fig']));        
    end        
   display(['PauseStart: ' num2str(clock)]);  
    %% wait for rest of ITI 
    elapsedTrialTime = etime(clock, startTrialTime); % how much time elapsed already within this trial
    % display(['elapsedTrialTime: ' num2str(elapsedTrialTime)]);
    % display(['ITIreplayVec(' num2str(iTrial) '): ' num2str(ITIreplayVec(iTrial))]);
    
    if ITIreplay
        mc_pause(ITIreplayVec(iTrial)-elapsedTrialTime); % wait for remaining time of current ITI from replay vector
        display(['pause: ' num2str(ITIreplayVec(iTrial)-elapsedTrialTime)]);
    else
        mc_pause(ITImin-elapsedTrialTime); % wait for remaining time of minmal ITI
    end
%     elapsedRunTime = etime(clock, startRunTime); % how much time elapsed already within this RUN
%     ITI = elapsedRunTime - elapsedRunTime_old; 
%     results(iTrial,:) = [iTrial, elapsedRunTime, ITI, info.ISI, info.MNSI, info.SI, stimulators, powerCond, phaseCond, info.condition];
       
    display(['TrialEnd: ' num2str(clock)]);  
end % of loop over trials
   
% save final results file and figure
save(fullfile(info.resultsPath,[info.subjectCode '_' info.timestamp '_EEGtriggeredPAS.mat']),'results','data_emg','data_eeg','MEP', 'EEG','info');
saveas(gcf,fullfile(info.resultsPath,[info.subjectCode '_' info.timestamp '_EEGtriggeredPAS.fig']));        

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