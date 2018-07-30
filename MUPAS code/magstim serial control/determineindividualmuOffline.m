%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% determine individual mu Offline
%
% by Til Ole Bergmann (mail@tobergmann.de)
%
% last edited 2017/01/23 by TOB 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; clc; 

% determine operating system 
if strcmp(filesep,'/')
    filesystem='linux';
    my_drive='/gpfs01/born/tbergmann';
    home_drive='/home';
elseif strcmp(filesep,'\')
    filesystem='windows';
    my_drive='X:';
else
    filesystem='unknown';
    display('Unknown filesystem!');
end

% add matlab paths
addpath(fullfile(my_drive,'Projects','ICAtest'));
addpath(fullfile(my_drive,'Projects','PIP','SICI','Analyses'));
addpath(fullfile(my_drive,'MATLAB','fieldtrip'));
addpath(fullfile(my_drive,'MATLAB','neurone_tools_for_matlab_1.1.3.10'));

ft_defaults;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% settings
trialSegmentationType = 'splittrial'; % 'fulltrial' (one trial including activeand rest) or 'splittrial' (separate active and rest trials)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% load data
cfg = [];
% cfg.filepath = '/gpfs01/born/tbergmann/Projects/ICAtest/FistClenchingCZ/2017-01-07T134625/1';
% cfg.filepath = '/gpfs01/born/tbergmann/Projects/PIP/SICI2/Data/PIP2_P01/2017-01-24T113100/6';
[markers data] = neurone2fieldtrip(cfg);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% preprocess data

%% re-referencing and montages
%EEG
cfg = [];
cfg.channel= {'eeg'};
cfg.reref = 'yes';
cfg.implicitref = 'FCz';
cfg.refchannel = {'eeg'}; %{'all' '-FDIr', '-APBr'};
cfg.precision = 'single'; % to reduce data size (if not done before)
cfg.hpfilter = 'yes';
cfg.hpfilttype = 'but';
cfg.hpfiltord = 4;
cfg.hpfreq = 1;
cfg.hpinstabilityfix = 'reduce';
EEG_data = ft_preprocessing(cfg,data);

% EMG
cfg = [];
cfg.channel= {'FDIr','APBr'};
cfg.precision = 'single'; % to reduce data size (if not done before)
cfg.hpfilter = 'yes';
cfg.hpfilttype = 'but';
cfg.hpfiltord = 4;
cfg.hpfreq = 30;
cfg.hpinstabilityfix = 'reduce';
% cfg.bsfilter = 'yes';
% cfg.bsfilttype = 'but';
% cfg.bsfiltord = 4;
% cfg.bsfreq = [49 51];
% cfg.bsinstabilityfix = 'reduce';
EMG_data = ft_preprocessing(cfg,data);

% % EMG rectification
% cfg = [];
% cfg.rectify = 'yes';
% EMG_data_rect = ft_preprocessing(cfg,EMG_data);
% for i = 1:length(EMG_data_rect.label)
%     EMG_data_rect.label{i} = [EMG_data_rect.label{i} '_rect'];
% end
% 
% % EMG hilbert
% cfg = [];
% cfg.hilbert = 'abs';
% EMG_data_hilbert = ft_preprocessing(cfg,EMG_data);
% for i = 1:length(EMG_data_hilbert.label)
%     EMG_data_hilbert.label{i} = [EMG_data_hilbert.label{i} '_hilb'];
% end

%% merge data
% data = ft_appenddata([],EEG_data, EMG_data, EMG_data_rect, EMG_data_hilbert);
data = ft_appenddata([],EEG_data, EMG_data);
% clear EEG_data EMG_data EMG_data_rect EMG_data_hilbert;
clear EEG_data EMG_data;

%% check data
% cfg = [];
% cfg.viewmode = 'vertical';
% cfg.plotlabels = 'yes';
% ft_databrowser(cfg,data);

%% detect movement onsets from EMG
emgchan = find(strcmp('FDIr', data.label));
emg = data.trial{1}(emgchan,:);

% apply hilbert transformation and boxcar convolution (for smoothing)
emghlb      = abs(hilbert(emg')');                     % hilbert transform
emgcnv      = conv2([1], ones(1,data.fsample), emghlb, 'same'); % smooth using convolution
emgstd      = ft_preproc_standardize(emgcnv, 2);          % z-transform, i.e. mean=0 and stdev=1
emgtrl      = emgstd>0;                                   % detect the muscle activity
emgtrl      = diff(emgtrl, [], 2); 
emgon       = find(emgtrl(:)== 1);
emgoff      = find(emgtrl(:)==-1);

%% create trial structure
clear trl;
trl(:,1) = emgon(:) + data.fsample*0.44;  % as a consequence of the convolution with a one-second boxcar
trl(:,2) = emgoff(:) - data.fsample*0.38;  % as a consequence of the convolution with a one-second boxcar
trl(:,3) = 0;
 
figure; hold on;
plot(data.time{1},emg);
plot(data.time{1},emghlb,'r');
% plot(data.time{1},emgcnv,'m');
% plot(data.time{1},emgstd,'g');
% plot(data.time{1},[0 emgtrl]*100000,'c');
trlbeg = zeros(size(data.time{1}));
trlbeg(trl(:,1)) = 1;
trlend = zeros(size(data.time{1}));
trlend(trl(:,2)) = -1;
plot(data.time{1},trlbeg * 5000,'k');
plot(data.time{1},trlend * 5000,'k');
hold off;

%% segmentation
switch trialSegmentationType
    case 'fulltrial'
        % segement into trials (full trial timelocked to EMG movement onset)
        cfg = [];
        cfg.trl(:,1) = trl(3:end-2,1) - 2 * data.fsample;
        cfg.trl(:,2) = trl(3:end-2,1) + 2 * data.fsample;
        cfg.trl(:,3) = repmat(2 * data.fsample,length(cfg.trl),1);
        data = ft_redefinetrial(cfg,data);
        
    case 'splittrial'
        % segement into trials (split trial to EMG movement phase and rest phase)
        activetrl(:,1) = trl(3:end-2,1);
        activetrl(:,2) = trl(3:end-2,2);
        activetrl(:,3) = 0;
        activetrl(:,4) = 1; % active
        resttrl(:,1) = trl(2:end-3,2);
        resttrl(:,2) = trl(3:end-2,1);
        resttrl(:,3) = 0;
        resttrl(:,4) = 2; % rest
        alltrl = [activetrl; resttrl];
        sortedalltrl = sortrows(alltrl,1);
        newtrllen = 0.5; % in s
        
        cfg = [];
        cfg.trl(:,1) = sortedalltrl(:,1);
        cfg.trl(:,2) = sortedalltrl(:,1) + newtrllen*data.fsample;
        cfg.trl(:,3) = 0;
        cfg.trl(:,4) = sortedalltrl(:,4);
        data = ft_redefinetrial(cfg,data);
        
end % of switch

%% check segmented data
cfg = [];
cfg.viewmode = 'vertical';
cfg.plotlabels = 'yes';
ft_databrowser(cfg,data);

% downsample
cfg = [];
cfg.resamplefs = 1000;
cfg.demean = 'yes';
cfg.detrend = 'yes';
data = ft_resampledata(cfg,data);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% extract rhythms with ICA

cfg = [];
cfg.channel = 'eeg';
data = ft_selectdata(cfg, data);

% ICA
cfg = [];
cfg.method = 'runica';   
comp = ft_componentanalysis(cfg,data);

% % plot unmixing and topo matrices
% absmax_unmix = [-max([abs(min(min(comp.unmixing))) abs(max(max(comp.unmixing)))]) max([abs(min(min(comp.unmixing))) abs(max(max(comp.unmixing)))])];
% absmax_topo = [-max([abs(min(min(comp.topo))) abs(max(max(comp.topo)))]) max([abs(min(min(comp.topo))) abs(max(max(comp.topo)))])];
% figure;
% subplot(1,2,1);
% imagesc(comp.unmixing,absmax_unmix); 
% title('unmixing');
% colorbar;
% subplot(1,2,2);
% imagesc(comp.topo,absmax_topo); 
% title('topo');
% colorbar;

switch trialSegmentationType
    case 'fulltrial'
        % evaluate components
        cfg = [];
        cfg.layout = 'EEG1005.lay';
        cfg.timelock = 'yes';
        badcomp = evaluatecomponents(cfg, comp);
        
    case 'splittrial'
        % NEW evaluate components
        cfg = [];
        cfg.layout = 'EEG1005.lay';
        cfg.timelock = 'yes';
        cfg.cond.labels = {'active', 'rest'};
        cfg.cond.codes = [1 2];
        cfg.cond.colors = [1 0 0; 0 0 1];
        cfg.cond.lines = {'-', '-'};
        badcomp = evaluatecomponents(cfg, comp);
        
end % of switch


% sort components to mu and alpha
allComp = 1:length(comp.label);
muICAComp= [11]; % MaKo 8; SeRo 11;
alphaICAComp= [4]; % MaKo 11; SeRo 4;

% % remove V/HEOG components
% cfg = [];
% cfg.component = badcomp; % bad components to remove
% data = ft_rejectcomponent(cfg, comp, data);


% % extract left mu rhythm
% cfg = [];
% keepComp = muComp;
% cfg.component = allComp(~ismember(allComp,keepComp)); % bad components to remove
% mu_data = ft_rejectcomponent(cfg, comp, data);
% 
% % extract alpha rhythm
% cfg = [];
% keepComp = alphaComp;
% cfg.component = allComp(~ismember(allComp,keepComp)); % bad components to remove
% alpha_data = ft_rejectcomponent(cfg, comp, data);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% extract rhythms with GEiD

% bandpassfilter
cfg =  [];
cfg.bpfilter = 'yes';
cfg.bpfreq = [11 13]; % [10 12]
cfg.bpfilttype = 'fir';
cfg.bpfiltord = uint32(1/cfg.bpfreq(1)*3*data.fsample);
mufiltdata = ft_preprocessing(cfg,data);

% calculate covariance matrix for filtered data
cfg = [];
switch trialSegmentationType
    case 'fulltrial'
        cfg.trials = 'all';
    case 'splittrial'
%         cfg.trials = find(data.trialinfo == cond(2)); % 'rest only
        cfg.trials = 'all';
end
cfg.covariance = 'yes';
cfg.covariancewindow = 'all'; % []
cfg.removemean = 'yes';
mu = ft_timelockanalysis(cfg,mufiltdata);
% mu = ft_timelockanalysis(cfg,data);
MU = mu.cov;

% calculate covariance matrix for broadband data
cfg = [];
% cfg.trials = find(data.trialinfo == cond(1)); % 'active only
cfg.trials = 'all';
cfg.covariance = 'yes';
cfg.covariancewindow = 'all'; % []
cfg.removemean = 'yes';
bb = ft_timelockanalysis(cfg,data);
% bb = ft_timelockanalysis(cfg,mufiltdata);
BB = bb.cov;

% % plot covariance matrices
% absmax_bb = [-max([abs(min(min(BB))) abs(max(max(BB)))]) max([abs(min(min(BB))) abs(max(max(BB)))])];
% absmax_mu = [-max([abs(min(min(MU))) abs(max(max(MU)))]) max([abs(min(min(MU))) abs(max(max(MU)))])];
% figure;
% subplot(1,2,1);
% imagesc(MU,absmax_mu); 
% title('mu');
% colorbar;
% subplot(1,2,2);
% imagesc(BB,absmax_bb); 
% title('broadband');
% colorbar;

% generalized eigenvalue decomposition
% [V,D] = eig(A,B) returns diagonal matrix D of generalized eigenvalues and full matrix V whose columns are the corresponding right eigenvectors, so that A*V = B*V*D.
% each column of V is a principal component and each row stores the weights (aka component loadings) of each electrode
[V,D] = eig(MU,BB); 
percexplvar = diag(D)/sum(diag(D))*100; % percent of explained variance (sums up to 1)

% filter data with all components
muEigData = data;
for j = 1:length(muEigData.label)
    muEigData.label{j} = sprintf('eigvec_%i_(%.2f%%)',j,percexplvar(j));
end
for i = 1:length(muEigData.trial)
    muEigData.trial{i} = V' * data.trial{i};    
end

% % browse components
% find(muEigData.trialinfo == 192) % rest
% find(muEigData.trialinfo == 224) % active
% ft_databrowser([],muEigData)

% build fake comp strucure
ecomp = comp;
ecomp.label = muEigData.label;
ecomp.trial = muEigData.trial;
ecomp.topo = V;

% % browse eigenvectors 
% figure;
% cfg =[];
% cfg.layout = 'EEG1005.lay';
% cfg.viewmode = 'component';
% ft_databrowser(cfg,ecomp);

switch trialSegmentationType
    case 'fulltrial'
        % evaluate components
        cfg = [];
        cfg.layout = 'EEG1005.lay';
        cfg.timelock = 'yes';
        badcomp = evaluatecomponents(cfg, ecomp);
        
    case 'splittrial'
        % NEW evaluate components
        cfg = [];
        cfg.layout = 'EEG1005.lay';
        cfg.timelock = 'yes';
        cfg.cond.labels = {'active', 'rest'};
        cfg.cond.codes = [1 2];
        cfg.cond.colors = [1 0 0; 0 0 1];
        cfg.cond.lines = {'-', '-'};
        badcomp = evaluatecomponents(cfg, ecomp);
        
end % of switch

keyboard;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% calculate difference between conditions
gcfg.layout = 'EEG1005.lay';
gcfg.timelock = 'yes';
gcfg.cond.labels = {'active', 'rest'};
gcfg.cond.codes = [1 2];
gcfg.cond.colors = [1 0 0; 0 0 1];
gcfg.cond.lines = {'-', '-'};
for cond = 1:length(gcfg.cond.labels) % loop over conditons
    
    % FFT
    cfg = [];
    cfg.keeptrials = 'no';
    cfg.method = 'mtmfft';
    cfg.output = 'pow';
    cfg.trials = find(data.trialinfo == gcfg.cond.codes(cond));
    freqsteps = max(1/(size(data.trial{1},2)/data.fsample),0.1); % smallest possible frequency steps (but not smapper than 0.1 Hz)
    cfg.foi = [1:freqsteps:100]; 
    cfg.pad = 1;
    cfg.padtype = 'zero';
    cfg.taper = 'hanning';
    FFT{cond} = ft_freqanalysis(cfg,data);
    FFT{cond}.powspctrm(:,:) = FFT{cond}.powspctrm(:,:) .* repmat(FFT{cond}.freq,size(FFT{cond}.powspctrm,1),1);
    
    % TFR
    cfg = [];
    cfg.keeptrials = 'no';
    cfg.method = 'mtmconvol';
    cfg.taper = 'hanning';
    cfg.output = 'pow';
    cfg.trials = find(data.trialinfo == gcfg.cond.codes(cond));
    datalength = size(data.trial{1},2)/data.fsample;
    cfg.toi = [data.time{1}(1):0.01:data.time{1}(end)];
    cfg.foi = [ceil(3/datalength):1:35];
    cfg.pad = ceil(datalength);
    cfg.padtype = 'zero';
    cfg.t_ftimwin = 1./cfg.foi*3;
    tfr{cond} = ft_freqanalysis(cfg,data);
    
    % timelocked avgerage
    cfg = [];
    cfg.trials = find(data.trialinfo == gcfg.cond.codes(cond));
    timelockdata{cond} = ft_timelockanalysis(cfg, data);
    
end % of loop over conditions

cfg = [];
cfg.parameter = 'powspctrm';
cfg.operation = 'x2-x1';
diff_tfr = ft_math(cfg, tfr{1}, tfr{2});

%% plotting
h = figure;
plotchan = find(strcmp(FFT{1}.label,'POz'));
for cond = 1:length(gcfg.cond.labels) % loop over conditons
       
    % TFR
    subplot(2,length(gcfg.cond.labels),cond);
    cfg = [];
    cfg.channel = tfr{cond}.label(plotchan);
    cfg.zlim = 'maxabs';
    %         cfg.zlim = [-1 1];
    ft_singleplotTFR(cfg,tfr{cond});
    title(['TFR ' gcfg.cond.labels{cond} ' ' tfr{cond}.label(plotchan)],'Interpreter','none');
    xlabel('time (ms)'); ylabel('Hz');
    
end % of loop over conditions

% diff TFR
subplot(2,length(gcfg.cond.labels),3);
cfg = [];
cfg.channel = tfr{cond}.label(plotchan);
cfg.zlim = 'maxabs';
ft_singleplotTFR(cfg,diff_tfr);
title(['Diff TFR '],'Interpreter','none');
xlabel('time (ms)'); ylabel('Hz');

% FFT
subplot(2,length(gcfg.cond.labels),4);
cla; hold on;
for cond = 1:length(gcfg.cond.labels) % loop over conditions
    cfg = [];
    cfg.xlim = [1 100];
    plot(FFT{cond}.freq, FFT{cond}.powspctrm(plotchan,:),'Color',gcfg.cond.colors(cond,:),'LineStyle',gcfg.cond.lines{cond},'LineWidth',2)
    xlim([cfg.xlim]);
end
title(['FFT for ' FFT{cond}.label(plotchan)],'Interpreter','none');
xlabel('Hz'); ylabel('power (a.u.)');
legend(gcfg.cond.labels{:});
hold off;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% add mu component and Hjorth transform to dataset for comparison
muEigData = data;
muEigData.label = {'mu_eig'};
for i = 1:length(muEigData.trial)
    muEigData.trial{i} = V(:,end)' * data.trial{i};    
end
muEigData2 = data;
muEigData2.label = {'mu_eig2'};
for i = 1:length(muEigData2.trial)
    muEigData2.trial{i} = V(:,end-1)' * data.trial{i};    
end
muEigData3 = data;
muEigData3.label = {'mu_eig3'};
for i = 1:length(muEigData3.trial)
    muEigData3.trial{i} = V(:,end-2)' * data.trial{i};    
end
muICAData = data;
muICAData.label = {'mu_ica'};
for i = 1:length(muICAData.trial)
    muICAData.trial{i} = comp.topo(:,muICAComp)' * data.trial{i} * 1/100;    
end
montage.labelorg = {'C3','C1','C5','FC3','CP3'};
montage.labelnew = {'C3Hjorth'};
montage.tra = [1 -0.25 -0.25 -0.25 -0.25];
C3Hjorth_data = ft_apply_montage(data,montage);
cfg = [];
cfg.channel = {'C3','POz'};
odata = ft_selectdata(cfg,data);
cfg = [];
% comparedata = ft_appenddata(cfg,odata,C3Hjorth_data,muEigData,muICAData);
comparedata = ft_appenddata(cfg,odata,C3Hjorth_data,muEigData,muEigData2,muEigData3,muICAData);

% browse data for comparison
find(muEigData.trialinfo == 128) % resting eyesClosed
find(muEigData.trialinfo == 160) % active eyesClosed
find(muEigData.trialinfo == 192) % resting eyesOpen
find(muEigData.trialinfo == 224) % active eyesOpen
cfg = [];
cfg.viewmode = 'vertical';
cfg.plotlabels = 'yes';
ft_databrowser(cfg,comparedata)


keyboard;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% analyze data

%% FFT of components
freqwin = [5 35];
for i = 1:length(cond)
    cfg = [];
    cfg.keeptrials = 'no';
    cfg.method = 'mtmfft';
    cfg.output = 'pow';
    cfg.foi = [5:0.25:35];
    cfg.taper = 'hanning';    
    cfg.trials = find(data.trialinfo == cond(i));
    cfg.channel = {comp.label{muComp},comp.label{alphaComp}};
    power{i} = ft_freqanalysis(cfg,comp);
end

fft_h = figure;
powmax = [];
for i = 1:length(cond)
    powmax = [powmax max(max(power{i}.powspctrm(:,power{i}.freq >= freqwin(1) & power{i}.freq <= freqwin(2))))];
end
avgpowmax = max(powmax);
for i = 1:length(cond)
    subplot(2,2,i);
    plot(power{i}.freq,power{i}.powspctrm(find(strcmp(power{i}.label(1),cfg.channel)),:)','r');
    hold on;
    plot(power{i}.freq,power{i}.powspctrm(find(strcmp(power{i}.label(2),cfg.channel)),:)','b')
    hold off;
    xlim(freqwin);
    ylim([0 avgpowmax*1.1]);
    title(condLabel{i});
end



%% FFT of channels 

cond = unique(data.trialinfo);
freqwin = [8 14];
condLabel = {'resting eyesClosed', 'active eyesClosed', 'resting eyesOpen', 'active eyesOpen'};
ffttopo_h = figure;
for i = 1:length(cond)
    subplot(2,2,i);
    cfg = [];
    cfg.keeptrials = 'no';
    cfg.method = 'mtmfft';
    cfg.output = 'pow';
    cfg.foi = [8:0.5:14];
    cfg.taper = 'hanning';
    cfg.trials = find(data.trialinfo == cond(i));    
    cfg.channel = 'all';
    pow{i} = ft_freqanalysis(cfg,data);       
    
    cfg = [];
    cfg.ylim = [8:14];
    cfg.zlim = 'maxabs';
    cfg.layout = 'EEG1005.lay';    
    ft_topoplotTFR(cfg,pow{i})
    title(condLabel{i});
end

%%  FFT differences
cfg = [];
cfg.parameter = 'powspctrm';
cfg.operation = 'x1-x2';
muClosed = ft_math(cfg,pow{1},pow{2});

cfg = [];
cfg.parameter = 'powspctrm';
cfg.operation = 'x1-x2';
muOpen = ft_math(cfg,pow{3},pow{4});

cfg = [];
cfg.parameter = 'powspctrm';
cfg.operation = 'x1-x2';
alphaRest = ft_math(cfg,pow{1},pow{3});

cfg = [];
cfg.parameter = 'powspctrm';
cfg.operation = 'x1-x2';
alphaActive = ft_math(cfg,pow{2},pow{4});

% plot
fftdiff_h = figure;

subplot(2,2,1);
cfg = [];
cfg.ylim = [8:14];
cfg.zlim = 'maxabs';
cfg.layout = 'EEG1005.lay';
ft_topoplotTFR(cfg,muClosed)
title('mu (rest-active) eyesClosed');
    
subplot(2,2,2);
cfg = [];
cfg.ylim = [8:14];
cfg.zlim = 'maxabs';
cfg.layout = 'EEG1005.lay';
ft_topoplotTFR(cfg,muOpen)
title('mu (rest-active) eyesOpen');

subplot(2,2,3);
cfg = [];
cfg.ylim = [8:14];
cfg.zlim = 'maxabs';
cfg.layout = 'EEG1005.lay';
ft_topoplotTFR(cfg,alphaRest)
title('alpha (closed-open) rest');

subplot(2,2,4);
cfg = [];
cfg.ylim = [8:14];
cfg.zlim = 'maxabs';
cfg.layout = 'EEG1005.lay';
ft_topoplotTFR(cfg,alphaRest)
title('alpha (closed-open) active');


%% save extraced data
save('-V7.3',fullfile('mudata.mat'), 'mudata');    














