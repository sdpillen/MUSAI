%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MUPAS
% [results, data, EEG] = MUPAS_EEGtriggerTest(tg,info)
% by Til Ole Bergmann (mail@tobergmann.de)
% last edited 2017/08/21 by TOB
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [results, data, EEG] = MUPAS_EEGtriggerTest(tg,info)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set individual values here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define trials and timing
ITImin = 2.1/info.speedupfactor; % minimal ITI betwen two pulses (no matter which stimulator)
ISI = 25; % inter stimulus interval (ISI) in ms. Always provide in ms, no matter which time resolution mode!

% define experimental conditions
phaseCond = [0 1 2 3 4]; %  (0) low mu amplitude (1) rising flank, (2) peak, (3) falling flank, (4) trough 
TMSCond = [1 2]; % (1) single pulse, (2) paired pulse
numCond = numel(phaseCond)*numel(TMSCond);
lableCond = {'LowRandomSingle', 'LowRandomPaired', 'HighRisingSingle', 'HighRisingPaired', 'HighPeakSingle', 'HighPeakPaired','HighFallingSingle', 'HighFallingPaired', 'HighTroughSingle', 'HighTroughPaired'};
plotOrder = [1 3 5 7 9 2 4 6 8 10]; % order in which the above conditions are plotted into 2x5 subplot figure

% settings for EEG online analysis
EEGchan = [1:4]; % channels containing EEG data for EEG analyses
prepostdatawin = [-1 1]; % data time window pre and post TMS pulse (as set in simulink model)
dataArraySize = int32([numel(EEGchan),sum(abs(prepostdatawin))*info.simulinksamplerate]); % size of data array received from Simulink
EEG.win = [-0.5 0]; % post-TMS window for EEG analysis in s
EEG.searchwin = int32((abs(prepostdatawin(1)) + EEG.win) * info.simulinksamplerate); % searchwindow to determine EEG power
EEGdataTime = prepostdatawin(1)+1/info.simulinksamplerate:1/info.simulinksamplerate:prepostdatawin(2); % times for EEG window


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% prepare protocol
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% configure setup 
% info.portnames = {'COM3', 'COM4', 'COM5', 'COM6'}; % name of COM port (default {'COM1'})
if info.development_flag == 1
    info.portnames = {'COM1'}; % for debugging at office pc only    
end

%% randomization of trial order
% phaseCondVec = repmat(sort(repmat(phaseCond,1,numel(TMSCond))),1,numel(ampCond))';
phaseCondVec = sort(repmat(phaseCond,1,numel(TMSCond)))';
TMSCondVec = repmat(TMSCond,1,numel(phaseCond))';
condMat = [phaseCondVec, TMSCondVec,[1:numCond]'];

randCondMat = []; %zeros(numTrialCond*size(condMat,1),3);
for i = 1:info.numTrialCond % loop over subblocks  
	randCondMat = [randCondMat; condMat(randperm(size(condMat,1)),:)];    
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

% create fieldtrip compatible data structure
data.trial = {};
data.label = {'RawTargetSignal','FilteredTargetSignal', 'ForcastedTargetSignal' 'PowerTargetSignal'};
data.fsample = info.simulinksamplerate;

% setup EEG average arrays
EEG.waveavg = cell(1,numCond); % initialize cell array for incremental EEG waveform average for all conditions
plotdata = {};
EEG.p2pAll = cell(1,numCond); % initialize array for ALL EEG p2p values for all conditions
for j = 1:numCond % initialize all condition cells with zeros
    EEG.p2pAll{j} = zeros(numel(EEGchan),1);
    EEG.waveavg{j} = zeros(numel(EEGchan),dataArraySize(2));
end
EEG.p2pavg = zeros(numel(EEGchan),numCond); % initialize array for incremental EEG p2p average for all conditions

% setup figures
h_phase = figure;
set(h_phase,'Name',[info.subjectCode '_' info.timestamp '_EEGtriggered_timelock.mat']);
for j = 1:numCond
    subplot(2,5,j);
end
h_power = figure;
set(h_power,'Name',[info.subjectCode '_' info.timestamp '_EEGtriggered_Power.mat']);
for j = 1:numCond
    subplot(2,5,j);
end


% set intensities for 1st trial 
mc_setintensity(s(1:2), [info.CS info.TS]); % first intensity values (trial 1) for stimulator pair 1+2
mc_setintensity(s(3:4), [info.CS info.TS]); % first intensity values (trial 2) for stimulator pair 3+4
display(' ');
mc_pause(5);

%% actual trial loop
display(' ');
% wait for key press to start
display('(Stop and) START EEG recording!!!');
display('THEN press Pos1 to start EEG-trigger Test.');
[keyIsDown,secs, keyCode] = KbCheck;
while ~keyCode(startKey);
    [keyIsDown,secs, keyCode] = KbCheck;
    mc_pause(0.09);
end

display('Instruct participant to relax and fixate!');
mc_pause(5);  
for i = info.waitbeforestart:-1:1
    mc_pause(1);    
    display(['Starting experiment (in ' num2str(i) ' seconds)...']);
end
mc_pause(1);    
display('Starting experiment now!');

startRunTime = clock;
elapsedRunTime = 0;
for i = 1:size(randCondMat) % loop over trials   
    
    % loopControl
     [keyIsDown,secs, keyCode] = KbCheck;    
     if ~mod(i-1,info.trialspercondtopause * numCond) && i > 1 % this is the next trial after another 15 completed
         keyCode(pauseKey) = 1; % pretend pause key as been struk
     end     
        if keyCode(escapeKey)
            display('Experiment canceled.');
            mc_arm(s,0); % arm (1) / disarm (0) stimulator
            mc_close(); % close serial ports
            return
        elseif keyCode(pauseKey)
            display(['Pause after ' num2str(i-1) 'trials. Press PRINTSCREEN to continue or ESCAPE to cancel.']);
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
       
    %% prepare trigger
    if ~mod(i,2) % odd trials       
        if randCondMat(i,2) == 1 % TS alone
            times = [0 ISI/1000];
            stimulators = [0 0];            
        elseif randCondMat(i,2) == 2 % CS+TS
            times = [0 ISI/1000];
            stimulators = [0 0];            
        end
    elseif mod(i,2) % even trials
        if randCondMat(i,2) == 1 % TS alone
            times = [0 ISI/1000];
            stimulators = [0 0];
        elseif randCondMat(i,2) == 2 % CS+TS
            times = [0 ISI/1000];
            stimulators = [0 0];            
        end       
    end
   
%     %% add phase jitter for LowRandom condition
%     if randCondMat(i,1) == 0 % LowRandom condition
%         times = times + round((rand(1) * (1/info.mufreq))*1000)/1000; % add random jitter of a fraction of individual µ frequency period        
%     end
       
    %% prepare EEG amplitude detection parameters
    if randCondMat(i,1) == 0 % LOW amplitude 
        amplitudes = [info.lowAmpLim info.lowAmpThresh];
        amplitudePercentiles = [info.lowAmpLimCrit info.lowAmpCrit];        
    elseif randCondMat(i,3) >= 1 % HIGH amplitude
        amplitudes = [info.highAmpThresh info.highAmpLim];
        amplitudePercentiles = [info.highAmpCrit info.highAmpLimCrit];        
    end    
    whichphase = randCondMat(i,1);
    
    % prepare marker for NeuroOne
    marker = randCondMat(i,3); 
        
    %% TRIGGER STIMULATOR & RECORD DATA
    if info.development_flag == 0
        data.trial{i} = mc_EEGtriggerandrecordEEG(tg,amplitudes,amplitudePercentiles,whichphase,times,stimulators,marker); % trigger stimultor(s) and receive data
        data.time{i} = EEGdataTime;
    elseif info.development_flag == 1 % no simulink
        display(['Would have triggered stimulators ' num2str(stimulators) ' at times ' num2str(times) '...']);
%         dat = repmat(EEGexample,numel(EEGchan),1) .* (rand(1,1)+0.5-randCondMat(i,4)/100);
%         data.trial{i} = dat - repmat(mean(dat(:,1:abs(prepostdatawin(1)*info.simulinksamplerate)),2),1,dataArraySize(2));        
        data.trial{i} = rand(dataArraySize)*10-5 .* repmat(sin([[1:1:double(dataArraySize(2))]*pi*1/10+rand(1,1)*2*pi]),dataArraySize(1),1) ; % random signal (10 Hz + noise)    
        data.time{i} = EEGdataTime;
    end
    
    % get trial time
    startTrialTime = clock;
    
	%% check timing
    elapsedRunTime_old = elapsedRunTime;
    elapsedRunTime = etime(clock, startRunTime); % how much time elapsed already within this RUN
    ITI = elapsedRunTime - elapsedRunTime_old; 
    display(['Trial ' num2str(i) '/' num2str(size(randCondMat,1)) ', time = ' num2str(elapsedRunTime) 's, ITI = ' num2str(ITI), 's, Amplitude ' num2str(randCondMat(i,1)) ', phase = ' num2str(num2str(randCondMat(i,2))) ', pulse = ' num2str(num2str(randCondMat(i,3))), ' condition = ' lableCond{randCondMat(i,3)} ' (' num2str(randCondMat(i,3)) ')']);
    display(' ');
    
    %% collect results
    results(i,:) = [i, elapsedRunTime, ISI, randCondMat(i,:),info.CS, info.TS];                 
    data.trialinfo(i,:) = results(i,:);
    
    %% analyze EEG data
    j = randCondMat(i,3); % condition j
    thisCond = data.trial(results(:,6)==randCondMat(i,3)); % current trials in this condition         
       
    %% plot EEG timelock data  
    figure(h_phase);
    subplot(2,5,find(plotOrder==j));
    
    EEGchans = [1:3];
    baselinewindow = [500:1000];
    bldata = data.trial{i}(EEGchans,baselinewindow);    
    plotdata{i} = data.trial{i}(EEGchans,:) - repmat(mean(bldata,2),1,size(data.trial{i},2)); % basline-correct
    
    EEG.waveavg{j} = EEG.waveavg{j} * (numel(thisCond)-1)/numel(thisCond) + [plotdata{i};data.trial{i}(4,:)] * 1/numel(thisCond); % incremental averaging          
    
%     plot(EEGdataTime,plotdata{i},'r','LineWidth',1);        

    plot(EEGdataTime,EEG.waveavg{j}(1,:),'b','LineWidth',1); % raw target signal       
	hold on;
    plot(EEGdataTime,EEG.waveavg{j}(2,:),'m','LineWidth',2); % filtered target signal 
    plot(EEGdataTime,EEG.waveavg{j}(3,:),'g','LineWidth',2); % forcasted target signal 
    hold off;
%     xlim([-0.5 0.2]);
%     ylim([-40 40]);
%     ylim([-max([abs(max(max(EEG.waveavg{j}(EEGchans,:)))) abs(min(min(EEG.waveavg{j}(EEGchans,:))))])*1.1,  max([abs(max(max(EEG.waveavg{j}(EEGchans,:)))) abs(min(min(EEG.waveavg{j}(EEGchans,:))))])*1.1]);
    line([0 0], get(gca,'ylim'), 'Color', 'k', 'LineWidth', 1, 'LineStyle', '-');
    if find(plotOrder==j) > 5 && find(plotOrder==j) < 11
        xlabel('time in s relative to TS');
    end
    ylabel('µV EEG');     
    title([lableCond{j}  ' (Trial ' num2str(numel(thisCond)) '/' num2str(info.numTrialCond) ')']);    
    
    temp = [EEG.waveavg{:}];
    maxylim = max(abs(ceil(max(max(temp(1:3,:))))), abs(floor(min(min(temp(1:3,:))))));
    for kk = 1:10
        subplot(2,5,kk);
        ylim([-maxylim maxylim]);
        xlim([-0.1 0.1]);
    end
    drawnow;
	display(['Redrawing the figure took ' num2str(toc) ' s.']);
    
    
	% update power results every block
    if ~mod(numel(data.trial),numCond) % a block is full

        % resize trials
        cfg = [];
        cfg.begsample = EEG.searchwin(1);
        cfg.endsample = EEG.searchwin(2)-1;
        shortdata = ft_redefinetrial(cfg,data);
               
        % calculate FFT
        for k = 1:numel(lableCond)
            cfg = [];
            cfg.trials = data.trialinfo(:,6) == k;
            cfg.keeptrials = 'no';
            cfg.method = 'mtmfft';
            cfg.output = 'pow';
            cfg.channel = 'all';
            cfg.foi = [2:2:30];
            cfg.taper = 'hanning';
            cfg.pad = 1;
            cfg.padtype = 'zero';
            freq{k} = ft_freqanalysis(cfg,shortdata);
            maxpow(k) = max(max(freq{k}.powspctrm));            
        end
        display(maxpow);

        % plot EEG Power data
        figure(h_power);
        for k = 1:numel(lableCond)
            subplot(2,5,find(plotOrder==k));            
            cfg = [];
            cfg.channel = {'RawTargetSignal'};
            cfg.ylim = [0 max(maxpow)*1.1];            
            display(['cfg.ylim for ' num2str(k)]); display(cfg.ylim);
            cfg.xlim = [2 30];
            plot(freq{k}.freq,freq{k}.powspctrm(find(strcmp(freq{k}.label,cfg.channel)),:)');
            xlim(cfg.xlim);
            ylim(cfg.ylim);
            if find(plotOrder==k) > 5 && find(plotOrder==k) < 11
                xlabel('frequency (Hz)');
            end
            ylabel('power (a.u.)');
            title(lableCond{k});
        end
        drawnow;

%         % for rescaling on demand
%         for k = 1:10
%             subplot(2,5,k);            
%             xlim([2 30]);
%             ylim([0 1]);
%           
%         end
        
        
        % save updated results file and figure
        save(fullfile(info.resultsPath,[info.subjectCode '_' info.timestamp '_EEGtriggerTest.mat']),'results','data','EEG','info');
        saveas(h_phase,fullfile(info.resultsPath,[info.subjectCode '_' info.timestamp '_EEGtriggerTest_phase.fig']));
        saveas(h_power,fullfile(info.resultsPath,[info.subjectCode '_' info.timestamp '_EEGtriggerTest_power.fig']));
        display(['Saving took ' num2str(toc) ' s.']);                
       
    end
    
    %% wait for rest of ITI    
    elapsedTrialTime = etime(clock, startTrialTime); % how much time elapsed already within this trial
    display(['Waiting for ' num2str(ITImin-elapsedTrialTime)]);
    mc_pause(ITImin-elapsedTrialTime); % wait for remaining time of minmal ITI             
    
end % of loop over trials
   

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