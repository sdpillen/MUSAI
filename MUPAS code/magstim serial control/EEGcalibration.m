%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Pulsed Inhibition Project (PIP)
% [EEG] = PIP_EEGamplitudecalibration(tg,info)
% by Til Ole Bergmann (mail@tobergmann.de)
% last edited 2017/11/13 by TOB
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [results, data, EEG] = EEGcalibration(tg,info)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set individual values here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% settings for EEG online analysis
EEGsegmentlength = 3; % recorded window length in s
EEGchan = [1 2]; % channels containing EEG data for amplitude analyses
prepostdatawin = [-EEGsegmentlength/2  EEGsegmentlength/2]; % data time window pre and post TMS pulse (as set in simulink model)
dataArraySize = int32([numel(EEGchan),sum(abs(prepostdatawin))*info.simulinksamplerate]);
ITImin = EEGsegmentlength; % ???
% timewin = [1 4]; % <-- ENTER time limits to analyze (relative to beginning of data segment)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% prepare protocol
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% configure setup 
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

%% arm stimulator % disarms automatically after 60 s
mc_setintensity(s, repmat(30,size(s,2),1)); % as default

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RUN SICI curve protocol
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% preparation
results = [];
EEG.lowAmpThresh = [];
EEG.highAmpThresh = [];

% create fieldtrip compatiple data structure
data.trial = {};
data.label = {'RawTargetSignal','FilteredTargetSignal', 'ForcastedTargetSignal' 'PowerTargetSignal'};
data.fsample = info.simulinksamplerate;


%% actual trial loop
display(' ');
% wait for key press to start
display('(Stop and) START EEG recording!!!');
display('Press Pos1 to start EEG Calibration experiment');
[keyIsDown,secs, keyCode] = KbCheck;
while ~keyCode(startKey);
    [keyIsDown,secs, keyCode] = KbCheck;
    mc_pause(0.09);
end
display('Starting experiment...');
display(' ');

startRunTime = clock;
for i = 1:info.numEpochs % loop over trials   
    
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
    
    % prepare stimulation parameters
    stimulators = [0 0];
    times = [0 0.002];
    marker = 1; 
    
    % prepare hostscope ID for mc_triggerandrecordEEG()
    hostscope = 12;

    %% TRIGGER STIMULATOR & RECORD DATA
    if info.development_flag == 0
        data.trial{i} = mc_triggerandrecordEEG(tg,times,stimulators,marker,hostscope); % trigger stimultor(s) and receive data
%         data.time{i} = (elapsedRunTime-double(dataArraySize(2)/data.fsample)+1/data.fsample:1/data.fsample:elapsedRunTime)';
        data.time{i} = (1/data.fsample:1/data.fsample:double(dataArraySize(2))/data.fsample);
    elseif info.development_flag == 1 % no simulink
        display(['Would have triggered stimulators ' num2str(stimulators) ' at times ' num2str(times) '...']);
        data.trial{i} = abs(rand([4 dataArraySize(2)])*10-5 .* repmat(sin(double([[1:1:dataArraySize(2)]*pi*1/10+rand(1,1)*2*pi])),4,1)); % random signal (10 Hz + noise)    
        data.time{i} = (1/data.fsample:1/data.fsample:double(dataArraySize(2))/data.fsample); 
%         data.time{i} = (elapsedRunTime-double(dataArraySize(2)/data.fsample)+1/data.fsample:1/data.fsample:elapsedRunTime)'; 
    end
    
    %% check timing
    elapsedRunTime = etime(clock, startRunTime); % how much time elapsed already within this RUN
    display(['Epoch ' num2str(i) '/' num2str(info.numEpochs) ', time = ' num2str(elapsedRunTime) ' s' ]);
    display(' ');
    
    %% collect results
    results(i,:) = [i, elapsedRunTime];                 
    data.trialinfo(i,:) = results(i,:);
    
    %% wait for rest of ITI    
    elapsedTrialTime = etime(clock, startTrialTime); % how much time elapsed already within this trial
    display(['Waiting for ' num2str(ITImin-elapsedTrialTime)]);
    mc_pause(ITImin-elapsedTrialTime); % wait for remaining time of minmal ITI                 

end % of loop over trials
   
%% analyze EEG data
%   data.time = num2cell(repmat(elapsedRunTime-double(dataArraySize(2)/data.fsample)+1/data.fsample:1/data.fsample:elapsedRunTime,size(data.trial,2),1),2)';
data.trialinfo = results;

% get instantaneous amplitude of all values
for j = 1:numel(data.trial)
    EEG.amp(j,:) = data.trial{j}(4,:);
end

% evaluate epoch average over time of instantaneous amplitude
EEG.ampEpochAvg(:) = mean(EEG.amp,2);

% histogram
transAmp = EEG.amp';
concatAmp = transAmp(:)';
EEG.binranges = [0:max(EEG.amp(:))/200:max(EEG.amp(:))];
[EEG.bincounts,ind]= histc(concatAmp,EEG.binranges);

% power analysis
cfg = [];
cfg.method = 'mtmfft';
cfg.output = 'pow';
cfg.channel = 'RawTargetSignal';
cfg.foi = 1:30;
cfg.taper = 'hanning';
freq = ft_freqanalysis(cfg,data);

%% plot EEG data
h = figure;
set(h,'Name',[info.subjectCode '_' info.timestamp '_EEGcalibration.mat']);

% spectral power distribution
subplot(2,4,1:2);
plot(cfg.foi,freq.powspctrm);
line([info.freqwin(1) info.freqwin(1)], [0 max(get(gca,'YLim'))], 'Color', 'r', 'LineWidth', 1, 'LineStyle', '--');
line([info.freqwin(2) info.freqwin(2)], [0 max(get(gca,'YLim'))], 'Color', 'r', 'LineWidth', 1, 'LineStyle', '--');
xlabel('frequency (Hz)');
ylabel('Power (mV?)');
set(gca,'XTick',[cfg.foi]);
title('PowerTargetSignal');

% 1/f corrected spectral power distribution
subplot(2,4,3:4);
powcor2 = freq.powspctrm.* cfg.foi.^2;
[maxIdx maxVal] = max(powcor2(cfg.foi >= info.freqwin(1) & cfg.foi <= info.freqwin(2)));
EEG.mufreq = info.freqwin(1)-1 + maxVal;
plot(cfg.foi,powcor2,'g');
line([info.freqwin(1) info.freqwin(1)], [0 max(get(gca,'YLim'))], 'Color', 'r', 'LineWidth', 1, 'LineStyle', '--');
line([info.freqwin(2) info.freqwin(2)], [0 max(get(gca,'YLim'))], 'Color', 'r', 'LineWidth', 1, 'LineStyle', '--');
xlabel('frequency (Hz)');
ylabel('Power (mV?)');
set(gca,'XTick',[cfg.foi]);
title({'1/f corrected (power*f^2) PowerTargetSignal', ['Individual ? peak frequency: ' num2str(EEG.mufreq) ' Hz']});

% calculate cumulative density function
EEG.ampSorted = sort(EEG.amp(:));
nVal = length(EEG.ampSorted);
lowAmpLimIdx = max(round(nVal*info.lowAmpLimCrit),1);
lowAmpThreshIdx = max(round(nVal*info.lowAmpCrit),1);
midAmpThreshIdx = min(round(nVal*info.midAmpCrit),nVal);
midAmpLimIdx = min(round(nVal*info.midAmpLimCrit),nVal);
highAmpThreshIdx = min(round(nVal*info.highAmpCrit),nVal);
highAmpLimIdx = min(round(nVal*info.highAmpLimCrit),nVal);
EEG.lowAmpLim = EEG.ampSorted(lowAmpLimIdx); % low amp lower threshold
EEG.lowAmpThresh = EEG.ampSorted(lowAmpThreshIdx); % low amp upper  threshold
EEG.midAmpThresh = EEG.ampSorted(midAmpThreshIdx); % mid amp lower threshold
EEG.midAmpLim = EEG.ampSorted(midAmpLimIdx); % mid amp upper threshold
EEG.highAmpThresh = EEG.ampSorted(highAmpThreshIdx); % high amp lower threshold
EEG.highAmpLim = EEG.ampSorted(highAmpLimIdx); % high amp upper threshold

% power value disribution
subplot(2,4,5);
bar(EEG.binranges,EEG.bincounts/sum(EEG.bincounts));
xlim([EEG.binranges(1) EEG.binranges(end)]);
line([EEG.lowAmpLim EEG.lowAmpLim], [0 max(get(gca,'YLim'))], 'Color', 'r', 'LineWidth', 1, 'LineStyle', ':');
line([EEG.lowAmpThresh EEG.lowAmpThresh], [0 max(get(gca,'YLim'))], 'Color', 'r', 'LineWidth', 1, 'LineStyle', '-');
line([EEG.midAmpThresh EEG.midAmpThresh], [0 max(get(gca,'YLim'))], 'Color', 'b', 'LineWidth', 1, 'LineStyle', '-');
line([EEG.midAmpLim EEG.midAmpLim], [0 max(get(gca,'YLim'))], 'Color', 'b', 'LineWidth', 1, 'LineStyle', ':');
line([EEG.highAmpThresh EEG.highAmpThresh], [0 max(get(gca,'YLim'))], 'Color', 'g', 'LineWidth', 1, 'LineStyle', '-');
line([EEG.highAmpLim EEG.highAmpLim], [0 max(get(gca,'YLim'))], 'Color', 'g', 'LineWidth', 1, 'LineStyle', ':');
text(EEG.lowAmpLim, max(ylim)*0.9,['Lower limit = ' num2str(EEG.lowAmpLim)],'Color','r');
text(EEG.lowAmpThresh, max(ylim)*0.8,['Low threshold = ' num2str(EEG.lowAmpThresh)],'Color','r');
text(EEG.midAmpThresh, max(ylim)*0.7,['Mid threshold = ' num2str(EEG.midAmpThresh)],'Color','b');
text(EEG.midAmpLim, max(ylim)*0.6,['Mid limit = ' num2str(EEG.midAmpLim)],'Color','b');
text(EEG.highAmpThresh, max(ylim)*0.7,['High threshold = ' num2str(EEG.highAmpThresh)],'Color','g');
text(EEG.highAmpLim, max(ylim)*0.6,['Upper limit = ' num2str(EEG.highAmpLim)],'Color','g');
title({'Distribution of power values',' for target signal'});

% cumulative density function
subplot(2,4,6);
plot(EEG.ampSorted,'b','LineWidth',2);
line([lowAmpLimIdx lowAmpLimIdx], [0 max(get(gca,'YLim'))], 'Color', 'r', 'LineWidth', 1, 'LineStyle', ':');
line([lowAmpThreshIdx lowAmpThreshIdx], [0 max(get(gca,'YLim'))], 'Color', 'r', 'LineWidth', 1, 'LineStyle', '-');
line([midAmpThreshIdx midAmpThreshIdx], [0 max(get(gca,'YLim'))], 'Color', 'b', 'LineWidth', 1, 'LineStyle', '-');
line([midAmpLimIdx midAmpLimIdx], [0 max(get(gca,'YLim'))], 'Color', 'b', 'LineWidth', 1, 'LineStyle', ':');
line([highAmpThreshIdx highAmpThreshIdx], [0 max(get(gca,'YLim'))], 'Color', 'g', 'LineWidth', 1, 'LineStyle', '-');
line([highAmpLimIdx highAmpLimIdx], [0 max(get(gca,'YLim'))], 'Color', 'g', 'LineWidth', 1, 'LineStyle', ':');
text(lowAmpLimIdx, max(ylim)*0.9,['Lower limit = ' num2str(EEG.lowAmpLim)],'Color','r');
text(lowAmpThreshIdx, max(ylim)*0.8,['Low threshold = ' num2str(EEG.lowAmpThresh)],'Color','r');
text(midAmpThreshIdx, max(ylim)*0.7,['High threshold = ' num2str(EEG.midAmpThresh)],'Color','b');
text(midAmpLimIdx, max(ylim)*0.6,['Upper limit = ' num2str(EEG.midAmpLim)],'Color','b');
text(highAmpThreshIdx, max(ylim)*0.7,['High threshold = ' num2str(EEG.highAmpThresh)],'Color','g');
text(highAmpLimIdx, max(ylim)*0.6,['Upper limit = ' num2str(EEG.highAmpLim)],'Color','g');
title({'Cumulative density function of power values',' for target signal'});

% power value time course
subplot(2,4,7:8);
plot(concatAmp);
line([0 max(xlim)],[EEG.lowAmpLim EEG.lowAmpLim], 'Color', 'r', 'LineWidth', 1, 'LineStyle', ':')
line([0 max(xlim)],[EEG.lowAmpThresh EEG.lowAmpThresh], 'Color', 'r', 'LineWidth', 1, 'LineStyle', '-')
line([0 max(xlim)],[EEG.midAmpThresh EEG.midAmpThresh], 'Color', 'b', 'LineWidth', 1, 'LineStyle', '-')
line([0 max(xlim)],[EEG.midAmpLim EEG.midAmpLim], 'Color', 'b', 'LineWidth', 1, 'LineStyle', ':')
line([0 max(xlim)],[EEG.highAmpThresh EEG.highAmpThresh], 'Color', 'g', 'LineWidth', 1, 'LineStyle', '-')
line([0 max(xlim)],[EEG.highAmpLim EEG.highAmpLim], 'Color', 'g', 'LineWidth', 1, 'LineStyle', ':')
hold on;
highconcatAmp = concatAmp;
midconcatAmp = concatAmp;
lowconcatAmp = concatAmp;
highconcatAmp(concatAmp < EEG.highAmpThresh | concatAmp > EEG.highAmpLim) = nan;
midconcatAmp(concatAmp < EEG.midAmpThresh | concatAmp > EEG.midAmpLim) = nan;
lowconcatAmp(concatAmp > EEG.lowAmpThresh | concatAmp < EEG.lowAmpLim) = nan;
plot(highconcatAmp,'g');
plot(midconcatAmp,'b');
plot(lowconcatAmp,'r');
hold off;

%% save results file
save(fullfile(info.resultsPath,[info.subjectCode '_' info.timestamp '_EEGcalibration.mat']),'results','data','EEG','info');

% save figure
saveas(gcf,fullfile(info.resultsPath,[info.subjectCode '_' info.timestamp '_EEGcalibration.fig']));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% stop and disconnect stimulators
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% close COM ports 
mc_close(); % close serial ports
pause(0.2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end % of function
