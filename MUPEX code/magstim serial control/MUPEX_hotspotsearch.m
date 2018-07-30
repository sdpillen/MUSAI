%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MUPEX
% [results, data, MEP] = MUPEX_hotspotsearch(info)
% by Til Ole Bergmann (mail@tobergmann.de)
% last edited 2017/10/04 by TOB
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preparation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
function [results, data, MEP] = PIP_hotspotsearch(tg,info)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set individual values here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define trials and timing
ITIrange = [3.5 4.5]/info.speedupfactor; % <-- ENTER range within which ITI shall be jittered (! overwrites ITIjitter if not [] ! ) 
% ITI = 5.1; % <-- ENTER inter-trial interval (ITI), minimum is 4 s for MagStim 200² and BiStim²
% ITIjitter = 20; % <-- ENTER jitter of ITI as +/- % of ITI (e.g. 20 % jitter with an ITI of 5 s means ITI between 4 and 6 s)

% settings for MEP online analysis
EMGchan = [1 2]; % channels containing EMG data for MEP analyses
prepostdatawin = [-0.05 0.1]; % data time window pre and post TMS pulse (as set in simulink model)
dataArraySize = int32([numel(EMGchan),sum(abs(prepostdatawin))*info.simulinksamplerate]); % size of data array received from Simulink
MEP.win = [0.02 0.05]; % post-TMS window for MEP analysis in s
MEP.searchwin = (abs(prepostdatawin(1)) + MEP.win) * info.simulinksamplerate; % searchwindow to determine MEP peak-to-peak amplitude
EMGdataTime = prepostdatawin(1):1/info.simulinksamplerate:prepostdatawin(2)-1/1/info.simulinksamplerate; % times for EMG window


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% prepare protocol
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% configure setup 
% info.portnames = {'COM3', 'COM4', 'COM5', 'COM6'}; % name of COM port (default {'COM1'})
if info.development_flag == 1
    info.portnames = {'COM1'}; % for debugging at office pc only    
     load(fullfile(info.resultsPath,'MEPexample.mat'));
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
% RUN threshold hunting protocol
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% preparation
results = [];
grey = [0.8,0.8,0.8];

% create fieldtrip compatiple data structure
data.trial = {};
data.label = info.EMGchanLabels;
data.fsample = info.simulinksamplerate;

% setup figure
h = figure;
set(h,'Name',[info.subjectCode '_' info.timestamp '_hotspotsearch.fig']);

%% actual trial loop
display(' ');
% wait for key press to start
display('Please FIRST arm stimulators 1 and 2 manually and set stimulation instensity to start with!');
display('THEN press Pos1 to start Motor Hostspot Search.');
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

	% loopControl
     [keyIsDown,secs, keyCode] = KbCheck;
        if keyCode(escapeKey)
            display('Experiment canceled.');             
            return
        elseif keyCode(pauseKey)
            display(['Pause after ' num2str(i-1) 'trials. Press PRINTSCREEN to continue or ESCAPE to cancel.']);
            while ~keyCode(resumeKey) && ~keyCode(escapeKey) 
                [keyIsDown,secs, keyCode] = KbCheck;
                mc_pause(0.09);
            end
            if keyCode(escapeKey)
                display('Experiment canceled.');
                return
            end
            display('Resume...!');
        end
    
    % get trial time
    startTrialTime = clock;
    
    %% prepare trigger 
    if ~mod(i,2) % even
        stimulators = [1 0]; % second value is dummy   
    elseif mod(i,2) % odd
        stimulators = [2 0]; % second value is dummy           
    end
        times = [0 0.05]; % second value is dummy       
    
    % prepare marker for NeuroOne
    marker = 1; % no conditions to code for bt marker needs to be present
    
    %% TRIGGER STIMULATOR & RECORD DATA
    if info.development_flag == 0
        data.trial{i} = mc_triggerandrecordEMG(tg,times,stimulators,marker); % trigger stimultor(s) and receive data
        data.time{i} = (1/data.fsample:1/data.fsample:double(dataArraySize(2))/data.fsample);    
    elseif info.development_flag == 1 % no simulink
%         display(['Would have triggered stimulators ' num2str(stimulators) ' at times ' num2str(times) '...']);
        decFun = flip(([info.numTrial:-1:1].^2+500)/1000);
        dat = repmat(MEPexample,numel(EMGchan),1) .* (rand(1,1)+0.5) * decFun(i);
        data.trial{i} = dat - repmat(mean(dat(:,1:abs(prepostdatawin(1)*info.simulinksamplerate)),2),1,dataArraySize(2));
        data.time{i} = (1/data.fsample:1/data.fsample:double(dataArraySize(2))/data.fsample);
    end    
    
    %% check timing
    elapsedRunTime = etime(clock, startRunTime); % how much time elapsed already within this RUN
%     display(['Trial ' num2str(i) '/' num2str(info.numTrial) ', time = ' num2str(elapsedRunTime) 's , current threshold estimate = ' num2str(MEP.SI(i)) '% MSO']);           
    
    %% collect results
    results(i,:) = [i, elapsedRunTime, ITIvecRand(i)];                 
    data.trialinfo(i,:) = results(i,:);       
    
    %% analyze MEP data
    MEP.p2pAll(:,i) = abs(max(data.trial{i}(:,MEP.searchwin(1):MEP.searchwin(2)),[],2)) + abs(min(data.trial{i}(:,MEP.searchwin(1):MEP.searchwin(2)),[],2)); 
    
    %% plot MEP data
    figure(h);
    for k = EMGchan
        subplot(1,numel(EMGchan),k); % EMG channel k
        hold on;
        if i > 1 % not for first trial
            plot(EMGdataTime, data.trial{i-1}(EMGchan(k),:),'Color',grey,'LineWidth',1);
        end
        plot(EMGdataTime, data.trial{i}(EMGchan(k),:),'r','LineWidth',1);
        hold off;
        line([0 0], get(gca,'ylim'), 'Color', 'k', 'LineWidth', 1, 'LineStyle', '-');
        line([MEP.win(1) MEP.win(1)], get(gca,'ylim'), 'Color', 'm', 'LineWidth', 1, 'LineStyle', '--');
        line([MEP.win(2) MEP.win(2)], get(gca,'ylim'), 'Color', 'm', 'LineWidth', 1, 'LineStyle', '--');
        xlabel('time in s relative to TS');
        ylabel('µV EMG');
        ylim([-2500 2500]);
% ylim([-250 250]);
        title([data.label{k} ' (Trial ' num2str(i) '/' num2str(info.numTrial) ')']);
    end % of if this is nto the laat trial
    
    %% wait for rest of ITI    
    drawnow;
    elapsedTrialTime = etime(clock, startTrialTime); % how much time elapsed already within this trial
    mc_pause(ITIvecRand(i)-elapsedTrialTime); % wait for remaining time of current ITI    
    
end % of loop over trials
    
%% save updated results file and figure
save(fullfile(info.resultsPath,[info.subjectCode '_' info.timestamp '_hotspotsearch.mat']),'results','data','MEP','info');
saveas(gcf,fullfile(info.resultsPath,[info.subjectCode '_' info.timestamp '_hotspotsearch.fig']));
    


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end % of function