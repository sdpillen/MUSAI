%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MUPEX
% [results, data, MEP] = MUPEX_thresholdhunting(tg,info)
% by Til Ole Bergmann (mail@tobergmann.de)
% last edited 2017/10/04 by TOB
%
% Uses a Simple Adaptive Parameter Estimation by Sequential Testing (SA-PEST)procedure,
% originally proposed by Taylor and Creelman [32] and 
% adapted and implemented for TMS motor threshold assessment by Borckhardt 
% (free software available at http://www.clinicalresearcher.org). 
%
% REFERENCES:
% Awiszus FBJ. TMS Motor Threshold Assessment Tool (MTAT 2.0). 2006. cited
% 2014; Available from: http://www.clinicalresearcher.org/software.htm.
%
% Borckardt JJ, Nahas Z, Koola J, George MS. Estimating resting motor thresholds
% in transcranial magnetic stimulation research and practice: a computer
% simulation evaluation of best methods. J ECT 2006;22(3):169e75.
% 
% Taylor MM, Creelman CD. PEST: ef?cient estimates on probability functions.
% J Am Stat Assoc 1967;41:782e7.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Preparation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
function [results, data, MEP] = MUPEX_thresholdhunting(tg,info)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set individual values here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% define trials and timing
ITIrange = [2.1 3.1]/info.speedupfactor; % <-- ENTER range within which ITI shall be jittered (! overwrites ITIjitter if not [] ! ) 
% ITI = 5.1; % <-- ENTER inter-trial interval (ITI), minimum is 4 s for MagStim 200² and BiStim²
% ITIjitter = 20; % <-- ENTER jitter of ITI as +/- % of ITI (e.g. 20 % jitter with an ITI of 5 s means ITI between 4 and 6 s)

% settings for MEP online analysis
EMGchan = [1 2]; % channels containing EMG data for MEP analyses
prepostdatawin = [-0.05 0.1]; % data time window pre and post TMS pulse (as set in simulink model)
dataArraySize = int32([numel(EMGchan),sum(abs(prepostdatawin))*info.simulinksamplerate]); % size of data array received from Simulink
MEP.win = [0.02 0.05]; % post-TMS window for MEP analysis in s
MEP.searchwin = (abs(prepostdatawin(1)) + MEP.win) * info.simulinksamplerate; % searchwindow to determine MEP peak-to-peak amplitude
EMGdataTime = prepostdatawin(1):1/info.simulinksamplerate:prepostdatawin(2)-1/1/info.simulinksamplerate; % times for EMG window
MEP.SI = info.SIstart;


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
% connect and initialize stimultors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% open COM port (and start mc_maintain callback function) 
s = mc_open(info.portnames); % open serial port and give back port object
mc_pause(0.5);
if info.development_flag == 1
    s = [s s s s];
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RUN threshold hunting protocol
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% preparation
results = [];
grey = [0.8,0.8,0.8];

% create fieldtrip compatible data structure
data.trial = {};
data.label = info.EMGchanLabels;
data.fsample = info.simulinksamplerate;

% initalize threshold hunting structure
hunt.hit = 0;
hunt.reversal = 0;
hunt.stepsize = info.initialstepsize;
hunt.direction = 1;
hunt.doubling = 0;
stimshiftcounter = 0;

%% set intensities for 1st trial 
% prediction of potential stimulationintensities 
MEP.SIstepSame = max(info.SIlimits(1),min([MEP.SI(1) + hunt.stepsize(1) * hunt.direction, info.SIlimits(2)])); % same step size, same direction
MEP.SIstepHalfReversal = max(info.SIlimits(1),min([MEP.SI(1) + hunt.stepsize(1) * hunt.direction*-1, info.SIlimits(2)])); % same step size, other directon (only for first trial!)
MEP.SIstepDouble = max(info.SIlimits(1),min([MEP.SI(1) + hunt.stepsize(1) * 2 * hunt.direction, info.SIlimits(2)])); % double, step size same direction
MEP.SIpredicted(1,:) = [MEP.SI(1) MEP.SIstepSame MEP.SIstepHalfReversal MEP.SIstepDouble]; % predicted intensities for first 
MEP.stimulatorID = 1; % stimulator to use for first trial

% set stimulation intensities for first trial
mc_setintensity(s, MEP.SIpredicted(1,:)); % first intensity values (trial 1) for all stimulators 

% setup figure
h = figure;
set(h,'Name',[info.subjectCode '_' info.timestamp '_ThreshCrit' num2str(info.thresholdCriterion) '_thresholdhunting.mat']);

%% actual trial loop
display(' ');
% wait for key press to start
display('Please FIRST arm ALL stimulators manually!');
display('THEN press Pos1 to start Threshold Hunting experiment.');
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
for i = 1:info.numTrial % loop over trials   

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
	times = [0 0.05]; % second value is dummy   
    stimulators = [MEP.stimulatorID(i) 0]; % second value is dummy   
  
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
    results(i,:) = [i, elapsedRunTime, MEP.SI(i), ITIvecRand(i)];                 
	data.trialinfo(i,:) = results(i,:);
        
    %% analyze MEP data
    MEP.p2pAll(:,i) = abs(max(data.trial{i}(:,MEP.searchwin(1):MEP.searchwin(2)),[],2)) + abs(min(data.trial{i}(:,MEP.searchwin(1):MEP.searchwin(2)),[],2));

    %% calculate running average MEP amplitude
    runAvgStart = max(i-info.runAvgLen+1,1);
    runAVGAmp(:,i) = mean(MEP.p2pAll(:,runAvgStart:i),2);       
    
    %% calculate new stimulation intensity (simple adaptive PEST algorithm)
    % Rules according to Taylor & Creelman, J Am Stat Assoc 1967
    % 1. On every reversal of step direction, halve the step size. 
    % 2. The second step in a given direction, if called for, is the  same  size  as  the  first. 
    % 3.  The fourth and subsequent steps in a given direction are each double their predecessor  (except that, as 
    % noted above, large steps may be disturbing to a human observer and an upper limit  on permissible step size may be needed). 
    % 4. Whether a third successive  step in a given direction is the same as or double the second depends on the sequence of steps 
    % leading to the most recent reversal. If the step immediately preceding that reversal resulted froin a  doubling, 
    % then the third step is not doubled, while if the step leading to the most recent reversal was not  the result of a  doubling, 
    % then this third step is double the second. 
    
    % determine direction of next step    
    switch info.decisionRule
        case 'binary'
            if MEP.p2pAll(info.targetEMGchan,i) >= info.thresholdCriterion % response above threshold criterion
                hunt.hit(i) = 1; % hit (suprathreshold = above threshold criterion)
                hunt.direction(i) = -1; % decrease SI
            elseif MEP.p2pAll(info.targetEMGchan,i) < info.thresholdCriterion % response below threshold criterion
                hunt.hit(i) = 0; % miss (subthreshold = below threshold criterion)
                hunt.direction(i) = 1; % increase SI
            end
        case 'runningaverage'
            if runAVGAmp(info.targetEMGchan,i) >= info.thresholdCriterion % response above threshold criterion
                hunt.hit(i) = 1; % hit (suprathreshold = above threshold criterion)
                hunt.direction(i) = -1; % decrease SI
            elseif runAVGAmp(info.targetEMGchan,i) < info.thresholdCriterion % response below threshold criterion
                hunt.hit(i) = 0; % miss (subthreshold = below threshold criterion)
                hunt.direction(i) = 1; % increase SI
            end            
    end
    
    % determine reversal
    if i>1 && hunt.direction(i) == hunt.direction(i-1) % reversal of direction
        hunt.reversal(i) = 0;
    elseif i>1 && hunt.direction(i) ~= hunt.direction(i-1) % no reversal of direction
        hunt.reversal(i) = 1;
    elseif i==1
        hunt.reversal(i) = 0;
    end    
    
    % determine step size of next step (based on THE FOUR RULES)   
    hunt.doubling(i) = 0; % register default (no doubling) which may be changed into 1 below...    
    if i>1 && hunt.reversal(i) == 1 % REVERSAL (this is the FIRST step in the SAME DIRECTION)        
        hunt.stepsize(i) = round(hunt.stepsize(i-1)/2); % % next step shall be HALF the SIZE of last step         
    elseif i>1 && hunt.reversal(i) == 0 % NO REVERSAL
        if abs(sum(hunt.direction(i-1:i))) == 2 % this is the SECOND step in the SAME DIRECTION         
            hunt.stepsize(i) = hunt.stepsize(i-1); % next step shall be the SAME SIZE as last step size
        end
        if i>2 && abs(sum(hunt.direction(i-2:i))) == 3 % this is the THIRD step in the SAME DIRECTION 
            if hunt.doubling(find(hunt.reversal,1,'last')-1) % step leading to last reversal DID resulted from a doubling
                hunt.stepsize(i) = hunt.stepsize(i-1); % next step shall be the SAME SIZE as last step size                
            else % step leading to last reversal DID NOT result from a doubling
                hunt.stepsize(i) = max(info.stepsizelimits(1), min([hunt.stepsize(i-1)*2, info.stepsizelimits(2)])); % next step shall be DOUBLE the SIZE as last step size (within the specified limits)            
                hunt.doubling(i) = 1; % register this doubling
            end            
        end
        if i>3 && abs(sum(hunt.direction(i-3:i))) == 4 % this is the FOURTH step in the SAME DIRECTION             
            hunt.stepsize(i) = max(info.stepsizelimits(1), min([hunt.stepsize(i-1)*2, info.stepsizelimits(2)])); % next step shall be DOUBLE the SIZE as last step size (within the specified limits)            
            hunt.doubling(i) = 1; % register this doubling
        end     
    elseif i==1 % NO REVERSAL because of 1st trial  
        hunt.stepsize(i) = info.initialstepsize;
    end
    
    % display trial info
    display(['Trial ' num2str(i) '/' num2str(info.numTrial) ', SI:' num2str(MEP.SI(i)) ', suprathreshold:' num2str(hunt.hit(i)) ', triggers reversal:' num2str(hunt.reversal(i)) ', new direction:' num2str(hunt.direction(i)) ', new step size:' num2str(hunt.stepsize(i)) ', doubling:' num2str(hunt.doubling(i)) ', stimulator: ' num2str(MEP.stimulatorID(i))]);
 
    if i < info.numTrial % this is not the last trial
        %% calculate SI for next trial (i+1)
        if i < info.numTrial % this is not the last trial
            MEP.SI(i+1) = max(info.SIlimits(1),min([MEP.SI(i) + hunt.stepsize(i) * hunt.direction(i), info.SIlimits(2)])); % new stimulation intensity (within the specified limits)           
        end         
        
        % prediction of potential intensities for i+1 and i+2 already
        MEP.SIstepSame = max(info.SIlimits(1),min([MEP.SI(i+1) + hunt.stepsize(i) * hunt.direction(i), info.SIlimits(2)])); % same step size, same direction
        MEP.SIstepHalfReversal = max(info.SIlimits(1),min([MEP.SI(i+1) + max(info.stepsizelimits(1), min([hunt.stepsize(i)/2, info.stepsizelimits(2)])) * hunt.direction(i)*-1, info.SIlimits(2)])); % half step size, other directon
        MEP.SIstepDouble = max(info.SIlimits(1),min([MEP.SI(i+1) + max(info.stepsizelimits(1), min([hunt.stepsize(i)*2 info.stepsizelimits(2)])) * hunt.direction(i), info.SIlimits(2)])); % double, step size same direction
        
%         if i == 8, keyboard; end
        %% determine MEP.stimulatorID for NEXT trial (i+1)
        if sum(MEP.SIpredicted(i,:) == MEP.SI(i+1)) == 1 % SI value is unique
            MEP.stimulatorID(i+1) = find(MEP.SIpredicted(i,:) == MEP.SI(i+1)); % find the stimualtor for NEXT trial with the respective SI prepared already
            
            %% map intensities to stimulators
            theothers = ones(1,4);
            theothers(MEP.stimulatorID(i+1)) = 0;
            MEP.SIpredicted(i+1,MEP.stimulatorID(i+1)) =  MEP.SIpredicted(i,MEP.stimulatorID(i+1)); % intensity for stimulator used in next trial (i+1) stays as is
            MEP.SIpredicted(i+1,logical(theothers)) = [MEP.SIstepSame MEP.SIstepHalfReversal MEP.SIstepDouble]; % potential intensities for other stimulators
            
        elseif sum(MEP.SIpredicted(i,:) == MEP.SI(i+1)) > 1 % SI value is NOT unique
            if stimshiftcounter < 4
                stimshiftcounter = stimshiftcounter + 1;
            elseif stimshiftcounter == 4
                stimshiftcounter  = 1;
            end
%             display(['stimshiftcounter:' num2str(stimshiftcounter)]);
            notthecurrentStimulator = find([1 2 3 4] ~= MEP.stimulatorID(i));
            correctintensityStimulator = find(MEP.SIpredicted(i,:) == MEP.SI(i+1)); 
            potentialStimulators = notthecurrentStimulator(ismember(notthecurrentStimulator,correctintensityStimulator));
            recencyIdx = [];
            for k = 1:numel(potentialStimulators)
                recencyIdx(k) = find([1 ismember(MEP.stimulatorID,potentialStimulators(k))],1,'last');
            end
            MEP.stimulatorID(i+1) = potentialStimulators(find(recencyIdx==min(recencyIdx))); % select the stimulator that was not triggered the longest
%             MEP.stimulatorID(i+1) = potentialStimulators(ceil(rand(1,1)*numel(potentialStimulators))); % randomly draw unique Stimulator ID
            
            %% map intensities to stimulators
            theothers = ones(1,4);
            theothers(MEP.stimulatorID(i+1)) = 0;
            MEP.SIpredicted(i+1,MEP.stimulatorID(i+1)) =  MEP.SIpredicted(i,MEP.stimulatorID(i+1)); % intensity for stimulator used in next trial (i+1) stays as is
            MEP.SIpredicted(i+1,logical(theothers)) = circshift([MEP.SIstepSame MEP.SIstepHalfReversal MEP.SIstepDouble],1,stimshiftcounter); % potential intensities for other stimulators

        end               
          
        
        %% set stimulation intensities for NEXT trial (i+1)
        mc_setintensity(s, MEP.SIpredicted(i+1,:)); % set intensity value for next trial
    end
    
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
        ylim([info.thresholdCriterion * -2.5, info.thresholdCriterion * +2.5,]);
        title({[data.label{k} ' at ' num2str(MEP.SI(i)) ' %MSO  (Trial ' num2str(i) '/' num2str(info.numTrial) ')'], ['running average MEP (last ' num2str(info.runAvgLen) ' trials): ' num2str(runAVGAmp(k,i)/1000) ' mV']});        
    end % of if this is not the last trial
    
    subplot(numel(EMGchan),2,2:2:numel(EMGchan)*2); % threshold hunting trace
    plot(1:i,MEP.SI(1:i),'r');
    set(gca,'XTick',[1:info.numTrial], 'XLim', [0 info.numTrial]);
%     set(gca,'YTick',[info.SIlimits(1):5:info.SIlimits(2)], 'YLim', info.SIlimits);
    set(gca,'YTick',[0:5:100], 'YLim', [0 100]);
    xlabel('Trial #');
    ylabel('SI (%MSO)');
    title(['Threshold hunting trace for ' data.label{info.targetEMGchan} ' with threshold criterion ' num2str(info.thresholdCriterion) ' µV']);
           
    %% wait for rest of ITI    
    drawnow;
    elapsedTrialTime = etime(clock, startTrialTime); % how much time elapsed already within this trial
    mc_pause(ITIvecRand(i)-elapsedTrialTime); % wait for remaining time of current ITI    
    
end % of loop over trials


%% save updated results file and figure
save(fullfile(info.resultsPath,[info.subjectCode '_' info.timestamp '_ThreshCrit' num2str(info.thresholdCriterion) '_thresholdhunting.mat']),'results','data','MEP','info');
saveas(gcf,fullfile(info.resultsPath,[info.subjectCode '_' info.timestamp '_ThreshCrit' num2str(info.thresholdCriterion) '_thresholdhunting.fig']));

display(' ');
display(['Final threshold estimate (average of last ' num2str(info.runAvgLen) ' trials) is ' num2str(round(mean(MEP.SI(end-(info.runAvgLen-1):end)))) ' % MSO']);
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