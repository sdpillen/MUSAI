%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MUPEX
% [results, data] = MUPEX_muLocalizer(tg,info)
% by Til Ole Bergmann (mail@tobergmann.de)
% last edited 2017/10/04 by TOB
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [results, data, EEG] = MUPEX_muLocalizer(tg,info)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set individual values here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% settings for EEG online analysis
EEGchan = [1:64]; % channels containing EEG data for EEG analyses
prepostdatawin = [-1 1]; % data time window pre and post TMS pulse (as set in simulink model)
dataArraySize = int32([numel(EEGchan),sum(abs(prepostdatawin))*info.simulinksamplerate]); % size of data array received from Simulink
EEG.win = [-0.5 0]; % window for EEG analysis in s relative to finger movement detected in EMG
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
data = [];
data.trial = {};
data.label = cellstr(num2str([EEGchan]'))';
data.fsample = info.simulinksamplerate;



% setup EEG average arrays
EEG.waveavg = cell(1,numCond); % initialize cell array for incremental MEP waveform average for all conditions
plotdata = {};
EEG.p2pAll = cell(1,numCond); % initialize array for ALL MEP p2p values for all conditions
for j = 1:numCond % initialize all condition cells with zeros
    EEG.p2pAll{j} = zeros(numel(EEGchan),1);
    EEG.waveavg{j} = zeros(numel(EEGchan),dataArraySize(2));
end
EEG.p2pavg = zeros(numel(EEGchan),numCond); % initialize array for incremental MEP p2p average for all conditions

% setup figures
h = figure;
set(h,'Name',[info.subjectCode '_' info.timestamp '_EEGtriggered_timelock.mat']);
for j = 1:numCond
    subplot(2,5,j);
end
h2 = figure;
set(h2,'Name',[info.subjectCode '_' info.timestamp '_EEGtriggered_Power.mat']);
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
display('THEN press Pos1 to start the Mu-Localizer experiment.');
[keyIsDown,secs, keyCode] = KbCheck;
while ~keyCode(startKey);
    [keyIsDown,secs, keyCode] = KbCheck;
    mc_pause(0.09);
end
display('Starting experiment (in 5 seconds)...');
% mc_arm(s,1); % arm (1) / disarm (0) stimulator
mc_pause(5);

startRunTime = clock;
for i = 1:info.numTrial % loop over trials   
    
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
    times = [0 0.1];
    stimulators = [0 0];
       
    %% prepare EEG amplitude detection parameters
    EMGamplitude = info.EMGthresh;

    % prepare marker for NeuroOne
    marker = 1; 
    
    %% TRIGGER STIMULATOR & RECORD DATA
    if info.development_flag == 0
        data.trial{i} = mc_EMGtriggerandrecordEEG(tg,EMGamplitude,times,stimulators,marker); % trigger stimultor(s) and receive data
        data.time{i} = EEGdataTime;
    elseif info.development_flag == 1 % no simulink
        display(['Would have triggered stimulators ' num2str(stimulators) ' at times ' num2str(times) '...']);
%         dat = repmat(MEPexample,numel(EEGchan),1) .* (rand(1,1)+0.5-randCondMat(i,4)/100);
%         data.trial{i} = dat - repmat(mean(dat(:,1:abs(prepostdatawin(1)*info.simulinksamplerate)),2),1,dataArraySize(2));        
        data.trial{i} = rand(dataArraySize)*10-5 .* repmat(sin([[1:1:double(dataArraySize(2))]*pi*1/10+rand(1,1)*2*pi]),dataArraySize(1),1) ; % random signal (10 Hz + noise)    
        data.time{i} = EEGdataTime;
    end
    
    % get trial time
    startTrialTime = clock;
    
	%% check timing
    elapsedRunTime = etime(clock, startRunTime); % how much time elapsed already within this RUN
    display(['Trial ' num2str(i) '/' num2str(size(randCondMat,1)) ', time = ' num2str(elapsedRunTime) 's , Amplitude ' num2str(randCondMat(i,1)) ', phase = ' num2str(num2str(randCondMat(i,2))) ', pulse = ' num2str(num2str(randCondMat(i,3))), ' condition = ' lableCond{randCondMat(i,3)} ' (' num2str(randCondMat(i,3)) ')']);
    display(' ');
    
    %% collect results
    results(i,:) = [i, elapsedRunTime];                 
    data.trialinfo(i,:) = results(i,:);
    
    %% analyze EEG data
    
       
    %% plot EEG timelock data  
    figure(h);
    subplot(2,5,find(plotOrder==j));
    
    EEGchans = [1:3];
    baselinewindow = [500:1000];
    bldata = data.trial{i}(EEGchans,baselinewindow);    
    plotdata{i} = data.trial{i}(EEGchans,:) - repmat(mean(bldata,2),1,size(data.trial{i},2)); % basline-correct
    
    EEG.waveavg{j} = EEG.waveavg{j} * (numel(thisCond)-1)/numel(thisCond) + [plotdata{i};data.trial{i}(4,:)] * 1/numel(thisCond); % incremental averaging          
    
%     plot(EEGdataTime,plotdata{i},'r','LineWidth',1);        

    plot(EEGdataTime,EEG.waveavg{j}(1,:),'b','LineWidth',1);    
    hold on;
    plot(EEGdataTime,EEG.waveavg{j}(2,:),'m','LineWidth',2);  
    plot(EEGdataTime,EEG.waveavg{j}(3,:),'g','LineWidth',2);  
    hold off;
    xlim([-0.5 0.5]);
    ylim([-50 50]);
%     ylim([-max([abs(max(max(EEG.waveavg{j}(EEGchans,:)))) abs(min(min(EEG.waveavg{j}(EEGchans,:))))])*1.1,  max([abs(max(max(EEG.waveavg{j}(EEGchans,:)))) abs(min(min(EEG.waveavg{j}(EEGchans,:))))])*1.1]);
    line([0 0], get(gca,'ylim'), 'Color', 'k', 'LineWidth', 1, 'LineStyle', '-');
    if find(plotOrder==j) > 5 && find(plotOrder==j) < 11
        xlabel('time in s relative to TS');
    end
    ylabel('µV EEG');     
    title([lableCond{j}  ' (Trial ' num2str(numel(thisCond)) '/' num2str(info.numTrialCond) ')']);
    drawnow;
	display(['Redrawing the figure took ' num2str(toc) ' s.']);
    
    for kk = 1:10
        subplot(2,5,kk);
        ylim([-40 40]);
        xlim([-1 0.25]);
    end
    
    
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

        % plot EEG Power data
        figure(h2);
        for k = 1:numel(lableCond)
            subplot(2,5,find(plotOrder==k));
            
            cfg = [];
            cfg.channel = {'RawHjorth'};
            cfg.ylim = [0 max(maxpow)*1.1];            
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