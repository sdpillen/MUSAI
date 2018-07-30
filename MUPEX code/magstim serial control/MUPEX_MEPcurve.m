%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MUPEX
% [results, data, MEP] = MUPEX_MEPcurve(tg,info)
% by Til Ole Bergmann (mail@tobergmann.de)
% last edited 2017/10/05 by TOB
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preparation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
function [results, data, MEP] = MUPEX_MEPcurve(tg,info)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set individual values here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define trials and timing
ITIrange = [2.1 3.9]/info.speedupfactor; % <-- ENTER range within which ITI shall be jittered (! overwrites ITIjitter if not [] ! ) 
ITI = 2.6; % <-- ENTER inter-trial interval (ITI), minimum is 4 s for MagStim 200² and BiStim²
ITIjitter = 20; % <-- ENTER jitter of ITI as +/- % of ITI (e.g. 20 % jitter with an ITI of 5 s means ITI between 4 and 6 s)

% settings for MEP online analysis
EMGchan = [1 2]; % channels containing EMG data for MEP analyses
prepostdatawin = [-0.05 0.1]; % data time window pre and post TMS pulse (as set in simulink model)
dataArraySize = int32([numel(EMGchan),sum(abs(prepostdatawin))*info.simulinksamplerate]); % size of data array received from Simulink
MEP = [];
MEP.win = [0.02 0.05]; % post-TMS window for MEP analysis in s
MEP.searchwin = int32((abs(prepostdatawin(1)) + MEP.win) * info.simulinksamplerate); % searchwindow to determine MEP peak-to-peak amplitude
EMGdataTime = prepostdatawin(1):1/info.simulinksamplerate:prepostdatawin(2)-1/1/info.simulinksamplerate; % times for EMG window

% randomization procedure 
% 'semirandom' (all conditions once per block permuted in order within blocks)
% 'blockwise' (blocks of n trials of same condition with n depending on number of Blocks (numBlocks))
randomProc = 'semirandom'; 
numBlocks = 3; % number of blocks per TS intensity condition, only relevant for 'blockwise'
IBI = 12; % inter block interval (IBI), i.e. ITI between last trial of a block and first trial of next block


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% prepare protocol
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% configure setup 
if info.development_flag == 1
    info.portnames = {'COM1'}; % for debugging at office pc only    
    load(fullfile(info.pathMatlabScripts,'MEPexample.mat'));
end

% calculate ITIrange if not preset
if ~exist('ITIrange','var') || (exist('ITIrange','var') && isempty(ITIrange))
    ITIrange = [ITI-ITI*ITIjitter/100 ITI+ITI*ITIjitter/100];
end

info.SIvecMSO = info.SIvec; % keep % MSO

switch randomProc         
    case 'semirandom'
        % create pseudorandomized vector permuting the order of all TS conditions within concatenated blocks, each containing every TS condition once
       info.SIvecRand = [];
        for i = 1:info.numTrialCond
            info.SIvecRand = [info.SIvecRand info.SIvecMSO(randperm(length(info.SIvecMSO)))];
        end
        
        % create ITIvecRand
        ITIvecRand = rand(1,length(info.SIvecRand))*diff(ITIrange)+ITIrange(1);

    case 'blockwise'
        info.SIvecRand = [];
        ITIvecRand = [];
        blockSize = info.numTrialCond/numBlocks;
        for i = 1:numBlocks
            rj = randperm(numel(info.SIvec));
            for j = rj
                info.SIvecRand = [info.SIvecRand repmat(info.SIvecMSO(j),1,blockSize)];                
                ITIvecRand = [ITIvecRand rand(1,blockSize-1)*diff(ITIrange)+ITIrange(1) IBI]; % create ITIvecRand
            end            
        end
end

% create intensityMat
% intensityMat = [info.SIvecRand;repmat(info.MEP1mV,1,length(info.SIvecRand))];
intensityMat = [info.SIvecRand; info.SIvecRand];

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

%% set intensities
mc_setintensity(s, repmat(30,size(s,2),1)); % as default

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RUN MEP curve protocol
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% preparation
results = [];

% create fieldtrip compatible data structure
data.trial = {};
data.label = info.EMGchanLabels;
data.fsample = info.simulinksamplerate;

% setup MEP average arrays
MEP.waveavg = cell(1,numel(info.SIvecMSO)); % initialize cell array for incremental MEP waveform average for all conditions
MEP.p2pAll = cell(1,numel(info.SIvecMSO)); % initialize array for ALL MEP p2p values for all conditions
for j = 1:numel(info.SIvecMSO) % initialize all condition cells with zeros
    MEP.p2pAll{j} = zeros(numel(EMGchan),1);
    MEP.waveavg{j} = zeros(numel(EMGchan),dataArraySize(2));
end
MEP.p2pavg = zeros(numel(EMGchan),numel(info.SIvecMSO)); % initialize array for incremental MEP p2p average for all conditions

% setup figure
h = figure;
set(h,'Name',[info.subjectCode '_' info.timestamp '_MEPcurve.mat']);
for j = 1:numel(info.SIvecMSO)
    subplot(3,5,j);
end

% set intensities for 1st trial 
mc_setintensity(s(1), intensityMat(1,1)); % first intensity values (trial 1) for stimulator pair 1
mc_setintensity(s(2), intensityMat(2,2)); % first intensity values (trial 2) for stimulator pair 2
display(' ');


%% actual trial loop
display(' ');
% wait for key press to start
display('(Stop and) START EEG recording!!!');
display('Please FIRST arm all stimulators manually!');
display('THEN press Pos1 to start MEP Curve experiment.');
[keyIsDown,secs, keyCode] = KbCheck;
while ~keyCode(startKey);
    [keyIsDown,secs, keyCode] = KbCheck;    
    mc_pause(0.09);
end

display('Instruct participant to relax and fixate!');
display(['Starting experiment (in ' num2str(info.waitbeforestart) ' seconds)...']);
mc_pause(1);  
for i = info.waitbeforestart:-1:1
    mc_pause(1);    
    display(['Starting experiment (in ' num2str(i) ' seconds)...']);
end
mc_pause(1);    
display('Starting experiment now!');

startRunTime = clock;
elapsedRunTime = 0;
for i = 1:length(info.SIvecRand) % loop over trials   
  
    % loopControl
     [keyIsDown,secs, keyCode] = KbCheck;    
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
        
	% get trial time
    startTrialTime = clock;
    
    %% prepare trigger
    if mod(i,2) % odd trials              
        times = [0 0.002];
        stimulators = [1 0];
    elseif ~mod(i,2) % even trials
        times = [0 0.002];
        stimulators = [2 0];
    end
    
    % prepare marker for NeuroOne
    marker = find(info.SIvecMSO == intensityMat(1,i)); % coding TS conditions
    
    %% TRIGGER STIMULATOR & RECORD DATA
    if info.development_flag == 0
        data.trial{i} = mc_triggerandrecordEMG(tg,times,stimulators,marker); % trigger stimultor(s) and receive data
        data.time{i} = (1/data.fsample:1/data.fsample:double(dataArraySize(2))/data.fsample);
    elseif info.development_flag == 1 % no simulink
        display(['Would have triggered stimulators ' num2str(stimulators) ' at times ' num2str(times) '...']);
%         data.trial{i} = rand(dataArraySize)*10-5 .* repmat(sin(double([[1:1:dataArraySize(2)]*pi*1/10+rand(1,1)*2*pi])),2,1) * curveVec(cond); % random signal (10 Hz + noise)    
        dat = repmat(MEPexample,numel(EMGchan),1) .* (rand(1,1)+0.5+intensityMat(1,i)/10);
        data.trial{i} = dat - repmat(mean(dat(:,1:abs(prepostdatawin(1)*info.simulinksamplerate)),2),1,dataArraySize(2));        
        data.time{i} = (1/data.fsample:1/data.fsample:double(dataArraySize(2))/data.fsample);
    end
    
    % check timing
    elapsedRunTime_old = elapsedRunTime;
    elapsedRunTime = etime(clock, startRunTime); % how much time elapsed already within this RUN
    thisITI = elapsedRunTime - elapsedRunTime_old;
    display(['Trial ' num2str(i) '/' num2str(length(info.SIvecRand)) ', time = ' num2str(elapsedRunTime) 's, ITI = ' num2str(thisITI) 's']);        
    display(' ');
    
    %% collect results
    results(i,:) = [i, elapsedRunTime, thisITI, stimulators(1), info.SIvecRand(i), ITIvecRand(i)];   
	data.trialinfo(i,:) = results(i,:);        
     
    %% set intensity for  ! NEXT ! trial i+1
    if i < length(info.SIvecRand) - 1 % but not for last two trials (which are already set)
        %% set intensity of both stimulators in BiStim setup        
        if mod(i,2) % this trial was odd --> next trial is even
            mc_setintensity(s(1), intensityMat(1,i+2)); % set intensity values for NEXT _odd_ trial for stimulator 2
        elseif ~mod(i,2) % this trial was even --> next trial is odd
            mc_setintensity(s(2), intensityMat(2,i+2)); % set intensity values for NEXT _even_ trial for stimulator 1
        end
        elapsedTrialTime = etime(clock, startTrialTime); % how much time elapsed already within this trial
        mc_pause(ITIvecRand(i)-elapsedTrialTime); % wait for remaining time of current ITI
        display(' ');
    end     
    
    %% analyze MEP data
    j = find(info.SIvecMSO == intensityMat(1,i)); % condition j
    thisCond = data.trial(results(:,5) == info.SIvecMSO(j)); % current trials in this condition     
    MEP.p2pAll{j}(:,numel(thisCond)) = abs(max(data.trial{i}(:,MEP.searchwin(1):MEP.searchwin(2)),[],2)) + abs(min(data.trial{i}(:,MEP.searchwin(1):MEP.searchwin(2)),[],2));
    MEP.p2pavg(:,j) = MEP.p2pavg(:,j) * (numel(thisCond)-1)/numel(thisCond) + MEP.p2pAll{j}(:,numel(thisCond)) * 1/numel(thisCond);    
    MEP.waveavg{j} = MEP.waveavg{j} * (numel(thisCond)-1)/numel(thisCond) + data.trial{i} * 1/numel(thisCond); % incremental averaging          
    
    %% plot MEP data    
    
    figure(h);
    subplot(3,5,j);
    plot(EMGdataTime, data.trial{i}(info.targetEMGchan,:),'r','LineWidth',1);        
    hold on;
    plot(EMGdataTime, MEP.waveavg{j}(info.targetEMGchan,:),'b','LineWidth',2);
    hold off;
    line([0 0], get(gca,'ylim'), 'Color', 'k', 'LineWidth', 1, 'LineStyle', '-');
    line([MEP.win(1) MEP.win(1)], get(gca,'ylim'), 'Color', 'm', 'LineWidth', 1, 'LineStyle', '--');
    line([MEP.win(2) MEP.win(2)], get(gca,'ylim'), 'Color', 'm', 'LineWidth', 1, 'LineStyle', '--');
    ylim([-1000 1000]);
    xlabel('time in s relative to TMS');    
    ylabel(['µV EMG for ' data.label{info.targetEMGchan}]);    
	title([num2str(info.SIvecMSO(j)) ' %MSO  (Trial ' num2str(numel(thisCond)) '/' num2str(info.numTrialCond) ')']);

    drawnow;
	
        
    % update MEP curve every block
    if mod(numel(data.trial),numel(info.SIvecMSO)) == 0 % a block is full
       
         % calculate MEP results
        MEP.curve = [zeros(size(MEP.p2pavg))];
        for k = 1:length(info.SIvec)        
            MEP.curve(:,k) = MEP.p2pavg(:,k);
            ts = tinv([0.025  0.975],length(MEP.p2pAll{k}(info.targetEMGchan,:)-1));
            MEP_SD(k) = std(MEP.p2pAll{k}(info.targetEMGchan,:));
            MEP_SEM(k) = MEP_SD(k)/sqrt(length(MEP.p2pAll{k}(info.targetEMGchan,:)));
            MEP_CI(:,k) = MEP.curve(k) + ts * MEP_SEM(k);             
        end
        
        % plot MEP curve
        subplot(3,5,14:15);cla;
        plot(info.SIvec,MEP.curve(info.targetEMGchan,:),'g-o');
        hold on;
        errorbar(info.SIvec,MEP.curve(info.targetEMGchan,:),MEP_CI(1,:),MEP_CI(2,:));
        hold off;
%         xlim([info.SIvec(1)-5 info.SIvec(end)+5]);
%         set(gca,'XTickLabel',[info.SIvec]);
        xlabel('% MSO');
        ylabel('MEP amplitude in µV');
        title(['MEP curve (Trial ' num2str(numel(thisCond)) '/' num2str(info.numTrialCond) ')']);
        
        % evaluate MEP curve
        MEP.min = min(MEP.curve,[],2);
        MEP.max = max(MEP.curve,[],2);
        MEP.at50percofrange = MEP.min+((MEP.max-MEP.min)/2);
        line([info.SIvec(1) info.SIvec(end)], [MEP.at50percofrange(info.targetEMGchan) MEP.at50percofrange(info.targetEMGchan)], 'Color', 'm', 'LineWidth', 1, 'LineStyle', '-');
        P = InterX([MEP.curve(info.targetEMGchan,:);info.SIvec(1:end)],[repmat(MEP.at50percofrange(info.targetEMGchan),1,length(info.SIvec(1:end)));info.SIvec(1:end)]);
        if size(P,2) == 0            
            line([info.SIvec(1) info.SIvec(end)], [max(MEP.curve(info.targetEMGchan,:)) max(MEP.curve(info.targetEMGchan,:))], 'Color', 'm', 'LineWidth', 1, 'LineStyle', ':');
            P = InterX([MEP.curve(info.targetEMGchan,:);info.SIvec(1:end)],[repmat(max(MEP.curve(info.targetEMGchan,:)),1,length(info.SIvec(1:end)));info.SIvec(1:end)]);            
            display('No intensity produces MEP <= 50 % of MEP range. Selecting the intensity for smallest MEP.');                        
        end
        if size(P,2) == 1
            MEP.at50percofrange_MSO = round(P(2));
        elseif size(P,2) > 1
            MEP.at50percofrange_MSO = round(max(P(2,:)));       
            display('50 % of  MEP range is not an unambigous value! Selecting the higher intensity.');                        
        end
        line([MEP.at50percofrange_MSO MEP.at50percofrange_MSO], get(gca,'ylim'), 'Color', 'g', 'LineWidth', 1, 'LineStyle', '-');
        text(MEP.at50percofrange_MSO,MEP.at50percofrange(info.targetEMGchan),[num2str(MEP.at50percofrange_MSO) ' % MSO'],'Color','r');
    
        % save updated results file and figure
        tic;
        save(fullfile(info.resultsPath,[info.subjectCode '_' info.timestamp '_MEPcurve.mat']),'results','data','MEP','info');
        saveas(gcf,fullfile(info.resultsPath,[info.subjectCode '_' info.timestamp '_MEPcurve.fig']));
        display(['Saving took ' num2str(toc) ' s.']);
    
    end        
    
    %% wait for rest of ITI        
    elapsedTrialTime = etime(clock, startTrialTime); % how much time elapsed already within this trial
    mc_pause(ITIvecRand(i)-elapsedTrialTime); % wait for remaining time of current ITI           
    
end % of loop over trials
display(' ');
display(['MEP at 50% of MEP range is achieved with ' num2str(MEP.at50percofrange_MSO) ' % MSO.']);
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