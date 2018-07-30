%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MUPEX
% [results, data, MEP] = MUPEX_EEGtriggeredMEP(tg,info)
% by Til Ole Bergmann (mail@tobergmann.de)
% last edited 2017/10/04 by TOB
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [results, data, MEP] = MUPEX_EEGtriggeredMEP(tg,info)
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set individual values here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define trials and timing
ITImin = 3.0/info.speedupfactor; % minimal ITI betwen two pulses (no matter which stimulator)

% define experimental conditions
phaseCond = [0]; %  (0) low mu amplitude (1) rising flank, (2) peak, (3) falling flank, (4) trough 
powerCond = [1 10; 11 20; 21 30; 31 40; 41 50; 51 60;61 70; 71 80; 81 90; 91 100] / 100; % percentiles (values between 0 and 1)
TMSCond = [1]; % (1) single pulse, (2) paired pulse
numCond = numel(phaseCond)*size(powerCond,1)*numel(TMSCond);
lableCond = {'1-10%', '11-20%', '21-30%', '31-40%', '41-50%', '51-60%','61-70%', '71-80%', '81-90%', '91-100%'};
plotOrder = [1:10]; % order in which the above conditions are plotted into 2x5 subplot figure

% settings for MEP online analysis
EMGchan = [1 2]; % channels containing EMG data for MEP analyses
prepostdatawin = [-0.05 0.1]; % data time window pre and post TMS pulse (as set in simulink model)
dataArraySize = int32([numel(EMGchan),sum(abs(prepostdatawin))*info.simulinksamplerate]); % size of data array received from Simulink
MEP.win = [0.02 0.05]; % post-TMS window for MEP analysis in s
MEP.searchwin = int32((abs(prepostdatawin(1)) + MEP.win) * info.simulinksamplerate); % searchwindow to determine MEP peak-to-peak amplitude
EMGdataTime = prepostdatawin(1):1/info.simulinksamplerate:prepostdatawin(2)-1/1/info.simulinksamplerate; % times for EMG window

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% prepare protocol
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% configure setup 
% info.portnames = {'COM3', 'COM4', 'COM5', 'COM6'}; % name of COM port (default {'COM1'})
if info.development_flag == 1
    info.portnames = {'COM1'}; % for debugging at office pc only    
    load(fullfile(info.pathMatlabScripts,'MEPexample.mat')); 
end

%% randomization of trial order
% phaseCondVec = repmat(sort(repmat(phaseCond,1,numel(TMSCond))),1,numel(ampCond))';
phaseCondVec = sort(repmat(phaseCond,1,numCond))';
powerCondMat = powerCond;
TMSCondVec = repmat(TMSCond,1,numCond)';
condMat = [phaseCondVec, powerCondMat, TMSCondVec,[1:numCond]'];

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
% RUN EEG-triggered MEP protocol
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% preparation
results = [];

% create fieldtrip compatible data structure
data.trial = {};
data.label = info.EMGchanLabels;
data.fsample = info.simulinksamplerate;


% setup MEP average arrays
MEP.waveavg = cell(1,numCond); % initialize cell array for incremental MEP waveform average for all conditions
MEP.p2pAll = cell(1,numCond); % initialize array for ALL MEP p2p values for all conditions
for j = 1:numCond % initialize all condition cells with zeros
    MEP.p2pAll{j} = zeros(numel(EMGchan),1);
    MEP.waveavg{j} = zeros(numel(EMGchan),dataArraySize(2));
end
MEP.p2pavg = zeros(numel(EMGchan),numCond); % initialize array for incremental MEP p2p average for all conditions

% setup figure
h = figure;
set(h,'Name',[info.subjectCode '_' info.timestamp '_EEGtriggered_MEP.mat']);
for j = 1:numCond
    subplot(3,5,j);
end

% set intensities for 1st trial 
mc_setintensity(s(1:2), [info.TS info.TS]); % first intensity values (trial 1) for stimulator pair 1+2
display(' ');
mc_pause(5);

%% actual trial loop
display(' ');
% wait for key press to start
display('(Stop and) START EEG recording!!!');
display('Not yet arm stimulators - wait until T-10s!');
display('Press Pos1 to start EEG-triggered MEP experiment.');
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
    if i == 10
        display(' ');
        display('Arm all stimulators manually!');
        display(' ');
    end 
end
mc_pause(1);    
display('Starting experiment now!');

startRunTime = clock;
elapsedRunTime = 0;
for i = 1:size(randCondMat,1) % loop over trials   
    
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
       
	%% prepare trigger ports 
    if mod(i,2) % odd trials       
        stimulators = [1 0]; 
    elseif ~mod(i,2) % even trials
        stimulators = [2 0]; 
    end
    
    %% prepare tirgger times
    times = [0 0.002]; % second value is dummy
    
    %% prepare EEG amplitude detection parameters   
    amplitudes = [0 100000]; % full range (zero to sufficiently high number)
%     amplitudePercentiles = [0 100]; % full range
    amplitudePercentiles = [randCondMat(i,2:3)]; % 
    
    % prepare phase detection parameter
    whichphase = 0;
    
    % prepare marker for NeuroOne
    marker = randCondMat(i,5); 
    
    %% TRIGGER STIMULATOR & RECORD DATA
    if info.development_flag == 0
        [data.trial{i} data.ampthreshold{i}] = mc_EEGtriggerandrecordEMG(tg,amplitudes,amplitudePercentiles,whichphase,times,stimulators,marker); % trigger stimultor(s) and receive data        
        data.time{i} = (1/data.fsample:1/data.fsample:double(dataArraySize(2))/data.fsample);
    elseif info.development_flag == 1 % no simulink
        display(['Would have triggered stimulators ' num2str(stimulators) ' at times ' num2str(times) '...']);
        dat = repmat(MEPexample,numel(EMGchan),1) .* (rand(1,1)+0.5-randCondMat(i,5)/10);
        data.trial{i} = dat - repmat(mean(dat(:,1:abs(prepostdatawin(1)*info.simulinksamplerate)),2),1,dataArraySize(2));        
%         data.trial{i} = rand(dataArraySize)*10-5 .* repmat(sin([[1:1:dataArraySize(2)]*pi*1/10+rand(1,1)*2*pi]),2,1) ; % random signal (10 Hz + noise)    
        data.time{i} = (1/data.fsample:1/data.fsample:double(dataArraySize(2))/data.fsample);
    end
    
    % get trial time
    startTrialTime = clock;
    
	%% check timing
    elapsedRunTime_old = elapsedRunTime;
    elapsedRunTime = etime(clock, startRunTime); % how much time elapsed already within this RUN
    ITI = elapsedRunTime - elapsedRunTime_old; 
    display(' ');
    display(['Trial ' num2str(i) '/' num2str(size(randCondMat,1)) ', time = ' num2str(elapsedRunTime) 's, ITI = ' num2str(ITI), 's, condition = ' lableCond{randCondMat(i,5)} ' (' num2str(randCondMat(i,5)) ')']);
    display(' ');    
    
    %% collect results
    results(i,:) = [i, elapsedRunTime, ITI, randCondMat(i,:), info.TS, stimulators];                 
    data.trialinfo(i,:) = results(i,:);
    
    %% analyze MEP data
    j = randCondMat(i,5); % condition j
    thisCond = data.trial(results(:,8)==randCondMat(i,5)); % current trials in this condition         
    MEP.p2pAll{j}(:,numel(thisCond)) = abs(max(data.trial{i}(:,MEP.searchwin(1):MEP.searchwin(2)),[],2)) + abs(min(data.trial{i}(:,MEP.searchwin(1):MEP.searchwin(2)),[],2));
    MEP.p2pavg(:,j) = MEP.p2pavg(:,j) * (numel(thisCond)-1)/numel(thisCond) + MEP.p2pAll{j}(:,numel(thisCond)) * 1/numel(thisCond);    
    MEP.waveavg{j} = MEP.waveavg{j} * (numel(thisCond)-1)/numel(thisCond) + data.trial{i} * 1/numel(thisCond); % incremental averaging          
    
    %% plot MEP data  
    figure(h);
    subplot(3,5,find(plotOrder==j));
    plot(EMGdataTime,data.trial{i}(info.targetEMGchan,:),'r','LineWidth',1);        
    hold on;
    plot(EMGdataTime,MEP.waveavg{j}(info.targetEMGchan,:),'b','LineWidth',2);    
    hold off;
    ylim([-1000 1000]);
    line([0 0], get(gca,'ylim'), 'Color', 'k', 'LineWidth', 1, 'LineStyle', '-');
    line([MEP.win(1) MEP.win(1)], get(gca,'ylim'), 'Color', 'm', 'LineWidth', 1, 'LineStyle', '--');
    line([MEP.win(2) MEP.win(2)], get(gca,'ylim'), 'Color', 'm', 'LineWidth', 1, 'LineStyle', '--');    
    if find(plotOrder==j) > 12 && find(plotOrder==j) < 17
        xlabel('time in s relative to TS');
    end
    ylabel('µV EMG');     
    title([lableCond{j}  ' (Trial ' num2str(numel(thisCond)) '/' num2str(info.numTrialCond) ')']);
    drawnow;
    
	% update power-MEP results every block
    if mod(numel(data.trial),numCond) == 0 % a block is full
        
        % calculate MEP results
        MEP_TS = [];
        for k = 1:numCond        
            MEP_TS(k) = MEP.p2pavg(info.targetEMGchan,k);
            ts = tinv([0.025  0.975],length(MEP.p2pAll{k}(info.targetEMGchan,:)-1));
            MEP_SD(k) = std(MEP.p2pAll{k}(info.targetEMGchan,:));
            MEP_SEM(k) = MEP_SD(k)/sqrt(length(MEP.p2pAll{k}(info.targetEMGchan,:)));
            MEP_CI(:,k) = MEP_TS(k) + ts * MEP_SEM(k);
%             x = randi(50, 1, 100);                      % Create Data
%             SEM = std(x)/sqrt(length(x));               % Standard Error
%             ts = tinv([0.025  0.975],length(x)-1);      % T-Score
%             CI = mean(x) + ts*SEM;                      % Confidence Intervals
             
        end

        % plot TS MEP results
        subplot(3,5,11:15);cla;
        plot(1:numCond,MEP_TS,'g-o');
        hold on;
        errorbar(1:numCond,MEP_TS,MEP_CI(1,:),MEP_CI(2,:));
        hold off;
        set(gca,'XTickLabel',lableCond)
        ylabel('MEP amplitude in µV');
                     
        % save updated results file and figure
        save(fullfile(info.resultsPath,[info.subjectCode '_' info.timestamp '_EEGtriggered_MEP.mat']),'results','data','MEP','info');
        saveas(gcf,fullfile(info.resultsPath,[info.subjectCode '_' info.timestamp '_EEGtriggered_MEP.fig']));
        
    end
        
    
    %% wait for rest of ITI    
    elapsedTrialTime = etime(clock, startTrialTime); % how much time elapsed already within this trial
%     display(['Waiting for ' num2str(ITImin-elapsedTrialTime)]);
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