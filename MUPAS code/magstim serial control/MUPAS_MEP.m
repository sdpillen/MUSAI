%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MUPAS
% [results, data, MEP] = MUPAS_MEP(tg,info)
% by Til Ole Bergmann (mail@tobergmann.de)
% last edited 2017/08/21 by TOB
%
% measures MEP with a fixed intensity
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preparation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
function [results, data, MEP] = MUPAS_MEP(tg,info)

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
MEP.SI = info.SI;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% prepare protocol
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% configure setup 
% info.portnames = {'COM3', 'COM4', 'COM5', 'COM6'}; % name of COM port (default {'COM1'})
if info.development_flag == 1
    info.portnames = {'COM1'}; % for debugging at office pc only    
	load(fullfile(info.pathMatlabScripts,'MEPexample.mat'));
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
% RUN MEP measurement
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% preparation
results = [];
grey = [0.8,0.8,0.8];

% create fieldtrip compatible data structure
data.trial = {};
data.label = info.EMGchanLabels;
data.fsample = info.simulinksamplerate;

% set stimulation intensities for first trial
mc_setintensity(s, repmat(MEP.SI,1,4)); % intensity values for all stimulators 

% setup figure
h = figure;
set(h,'Name',[info.subjectCode '_' info.timestamp '_MEP' num2str(info.MEPRunNo) '.mat']);

%% actual trial loop
display(' ');
% wait for key press to start
display('Please FIRST arm all stimulators manually!');
display('THEN press Pos1 to start MEP measurement.');
[keyIsDown,secs, keyCode] = KbCheck;
while ~keyCode(startKey);
    [keyIsDown,secs, keyCode] = KbCheck;
    mc_pause(0.09);
end
display('Starting experiment (in 10 seconds)...');
% mc_arm(s,1); % arm (1) / disarm (0) stimulator
mc_pause(10);
display(' ');

startRunTime = clock;
for i = 1:info.numTrial % loop over trials   

    % get trial time
    startTrialTime = clock;
    
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
       
        %% prepare trigger 
    if ~mod(i,2) % even
        stimulators = [1 0]; % second value is dummy   
    elseif mod(i,2) % odd
        stimulators = [2 0]; % second value is dummy           
    end
	times = [0 0.05]; % second value is dummy       
      
    % prepare marker for NeuroOne
    marker = 1; % no conditions to code for but marker needs to be present
    
    
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
    
    %% collect results
    results(i,:) = [i, elapsedRunTime, MEP.SI, ITIvecRand(i), stimulators(1)];                 
	data.trialinfo(i,:) = results(i,:);
        
    %% analyze MEP data
    MEP.p2pAll(:,i) = abs(max(data.trial{i}(:,MEP.searchwin(1):MEP.searchwin(2)),[],2)) + abs(min(data.trial{i}(:,MEP.searchwin(1):MEP.searchwin(2)),[],2));

    %% calculate running average MEP amplitude
    runAvgStart = max(i-info.runAvgLen+1,1);
    runAVGAmp(:,i) = mean(MEP.p2pAll(:,runAvgStart:i),2);       
  
    % display trial info
    display(['Trial ' num2str(i) '/' num2str(info.numTrial) ', SI: ' num2str(MEP.SI) ', stimulator: ' num2str(stimulators(1)) ', last MEP: ' num2str(MEP.p2pAll(info.targetEMGchan,i)/1000) ' mV, average MEP:' num2str(runAVGAmp(info.targetEMGchan,i)/1000) ' mV']);
        
    %% plot MEP data
    figure(h);
    chanPlotLoc = 1:2:numel(EMGchan)*2;
    for k = EMGchan
        subplot(numel(EMGchan),2,chanPlotLoc(k)); % EMG channel k
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
        ylim([-3000 3000]);
        title({[data.label{k} ' at ' num2str(MEP.SI) ' %MSO  (Trial ' num2str(i) '/' num2str(info.numTrial) ')'], ['running average MEP (last ' num2str(info.runAvgLen) ' trials): ' num2str(runAVGAmp(k,i)/1000) ' mV']});        
    end % of if this is not the last trial

    subplot(numel(EMGchan),2,2:2:numel(EMGchan)*2); % MEP trace
    title(['MEP trace for ' data.label{info.targetEMGchan}]);
    xlabel('Trial #');
    ylabel('MEP amplitude (µV)');
    hold on;
    plot(1:i,MEP.p2pAll(info.targetEMGchan,:),'r'); % current MEP amplitude
    plot(1:i,runAVGAmp(info.targetEMGchan,:),'b'); % average MEP amplitude
    hold off;
    set(gca,'XTick',[1:info.numTrial], 'XLim', [0 info.numTrial]);
    set(gca,'YTick',[0:100:3000], 'YLim', [0 3000]);
           
    %% wait for rest of ITI    
    drawnow;
    elapsedTrialTime = etime(clock, startTrialTime); % how much time elapsed already within this trial
    mc_pause(ITIvecRand(i)-elapsedTrialTime); % wait for remaining time of current ITI    
    elapsedRunTime = etime(clock, startRunTime); % how much time elapsed already within this RUN
    results(i,:) = [i, elapsedRunTime, MEP.SI, ITIvecRand(i), stimulators(1)];                 
    
end % of loop over trials


%% save updated results file and figure
save(fullfile(info.resultsPath,[info.subjectCode '_MEP_' num2str(info.MEPRunNo) '.mat']),'results','data','MEP','info');
saveas(gcf,fullfile(info.resultsPath,[info.subjectCode '_MEP_' num2str(info.MEPRunNo) '.fig']));

display(' ');
display(['Average MEP amplitude (average of last ' num2str(info.runAvgLen) ' trials) is ' num2str(runAVGAmp(info.targetEMGchan,end)/1000) ' mV']);
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