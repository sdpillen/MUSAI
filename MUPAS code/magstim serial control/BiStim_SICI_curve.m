%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MagStim remote configuration via serial port
% BiStim_SICI_curve script
% by Til Ole Bergmann (mail@tobergmann.de)
% last edited 2016/05/30 by TOB
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           MagStim BiStim²                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
try
    
clear all;close all; clc;   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set individual values here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subjectCode = 'Test'; % <-- ENTER subject-specific code
resultsPath = 'm:\Setup 2016-06 (Quadripulse)\magstim serial control'; % <-- ENTER path for results to be saved
RMT = 45; % <-- ENTER subject-specific resting motor threshold (RMT) RMT here as % MSO
MEP1mV = 66; % <-- ENTER subject-specific 1mV_MEP threshold here as % MSO
CSvec = [0 70:10:130]; % <-- ENTER vector of CS intensities as % RMT (!) to test
numTrialCond = 24; % <-- ENTER number of trials per CS intensity condition
ITIrange = [4.1 6.1]; % <-- ENTER range within which ITI shall be jittered (! overwrites ITIjitter if not [] ! ) 
ITI = 5.1; % <-- ENTER inter-trial interval (ITI), minimum is 4 s for MagStim 200² and BiStim²
ITIjitter = 20; % <-- ENTER jitter of ITI as +/- % of ITI (e.g. 20 % jitter with an ITI of 5 s means ITI between 4 and 6 s)
% ISI = 2.0; % inter stimulus interval (ISI) in ms (only for BiStim² mode). Always provide in ms, no matter which time resolution mode!
ISI = 2.0; % inter stimulus interval (ISI) in ms (only for BiStim² mode). Always provide in ms, no matter which time resolution mode!

% randomization procedure 
% 'semirandom' (all conditions once per block permuted in order within blocks)
% 'blockwise' (blocks of n trials of same condition with n depending on number of Blocks (numBlocks))
randomProc = 'blockwise'; 
numBlocks = 3; % number of blocks per CS intensity condition, only relevant for 'blockwise'
IBI = 12; % inter block interval (IBI), i.e. ITI between last trial of a block and first trial of next block

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% prepare protocol
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% configure setup 
portnames = {'COM1'}; % name of COM port (default {'COM1'})
stimulatorType = 'BiStim' ; % '200','BiStim', 'SuperRapid'
intensityB = MEP1mV; % <-- set TS (Test stimulus) intensity to % MSO that produices 1mV MEP 
intensityA = round(RMT * 0.8); % set CS (conditioning stimulus) intensity to 80% of RMT as default

% calculae ITIrange if not preset
if ~exist('ITIrange','var') || (exist('ITIrange','var') && isempty(ITIrange))
    ITIrange = [ITI-ITI*ITIjitter/100 ITI+ITI*ITIjitter/100];
end

CSvecMSO = round(CSvec.*RMT/100); % transform % RMT to % MSO


switch randomProc         
    case 'semirandom'
        % create pseudorandomized vector permuting the order of all CS conditions within concatenated blocks, each containing every CS condition once
       CSvecRand = [];
        for i = 1:numTrialCond
            CSvecRand = [CSvecRand CSvecMSO(randperm(length(CSvecMSO)))];
        end
        
        % create ITIvecRand
        ITIvecRand = rand(1,length(CSvecRand))*diff(ITIrange)+ITIrange(1);
              
    case 'blockwise'
        CSvecRand = [];
        ITIvecRand = [];
        blockSize = numTrialCond/numBlocks;
        for i = 1:numBlocks
            rj = randperm(numel(CSvec));
            for j = rj
                CSvecRand = [CSvecRand repmat(CSvecMSO(j),1,blockSize)];                
                ITIvecRand = [ITIvecRand rand(1,blockSize-1)*diff(ITIrange)+ITIrange(1) IBI]; % create ITIvecRand
            end
            
        end
end

% create intensityMat
intensityMat = [CSvecRand;repmat(MEP1mV,1,length(CSvecRand))];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% connect and initialize stimultors
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% open COM port (and start mc_maintain callback function) 
s = mc_open(portnames); % open serial port and give back port object
mc_pause(0.5);

%% set inter-stimulus interval (ISI) (BiStim only)
mc_setisi(s,ISI);
mc_pause(0.5);

%% set intensity of both stimulators in BiStim setup
mc_setintensitybistim(s, [intensityA intensityB]); % first intensity value for stimulator A, second value for Stimulator B
mc_pause(0.5);

%% arm stimulator % disarms automatically after 60 s
mc_arm(s,1); % arm (1) / disarm (0) stimulator
mc_pause(3);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RUN SICI curve protocol
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% set intensity of both stimulators in BiStim setup for 1st trial
results = [];

display(' ');
mc_setintensitybistim(s, [intensityMat(1,1) intensityMat(2,1)]); % first intensity value for stimulator A, second value for Stimulator B
mc_pause(10);

results = [];
startRunTime = clock;
for i = 1:length(CSvecRand) % loop over trials   
    startTrialTime = clock;
    
    %% trigger stimulator (!!!)
    mc_trigger(s); % trigger stimulator for THIS trial i
    elapsedRunTime = etime(clock, startRunTime); % how much time elapsed already within this RUN
    display(['Trial ' num2str(i) '/' num2str(length(CSvecRand)) ', time = ' num2str(elapsedRunTime) 's , ISI ' num2str(ISI) ' ms, CS = ' num2str(CSvecRand(i)) '% MSO, TS = ' num2str(MEP1mV) '% MSO, ITI = ' num2str(ITIvecRand(i)) 's']);
    display(' ');
    
    % save updated results file
    results(i,:) = [i, elapsedRunTime, ISI,CSvecRand(i), MEP1mV, ITIvecRand(i)];
    save(fullfile(resultsPath,[subjectCode '_results.mat']),'results'); 
    
    mc_pause(3);
    
    % set intensity for NEXT trial i+1
    if i < length(CSvecRand) % but not for last trial
        %% set intensity of both stimulators in BiStim setup
        mc_setintensity(s, intensityMat(1,i+1), intensityMat(2,i+1)); % first intensity value for stimulator A, second value for Stimulator B
        elapsedTrialTime = etime(clock, startTrialTime); % how much time elapsed already within this trial
        mc_pause(ITIvecRand(i)-elapsedTrialTime); % wait for remaining time of current ITI
    end

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
%% catch errors and close serial port
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
catch EM
    display('An error occurred. All ports will be closed.');
	mc_close(); % close serial port    
end % of catch
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%