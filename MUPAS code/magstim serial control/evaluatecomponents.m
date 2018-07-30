%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% evaluatecomponents
%
% by Til Ole Bergmann (mail@tobergmann.de)
%
% last edited 2016/10/14 by TOB 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [badcomponents] = evaluatecomponents(gcfg,comp)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% calculate parameters
display('Calculating parameters...');
badcomponents = [];

% prepare dummy values if no conditions were defined
if ~isfield(gcfg,'cond')
    gcfg.cond.labels = {'all trials'};
    gcfg.cond.codes = [1];
    gcfg.cond.colors = [0 0 0];
    gcfg.cond.lines = {'-'};
    comp.trialinfo = ones(length(comp.trial),1);
end

for cond = 1:length(gcfg.cond.labels) % loop over conditons
    
    % FFT
    cfg = [];
    cfg.keeptrials = 'no';
    cfg.method = 'mtmfft';
    cfg.output = 'pow';
    cfg.trials = find(comp.trialinfo == gcfg.cond.codes(cond));
    freqsteps = max(1/(size(comp.trial{1},2)/comp.fsample),0.1); % smallest possible frequency steps (but not smapper than 0.1 Hz)
    cfg.foi = [1:freqsteps:100]; 
    cfg.taper = 'hanning';
    icapow{cond} = ft_freqanalysis(cfg,comp);
    
    if strcmp(gcfg.timelock,'yes')
        % TFR
        cfg = [];
        cfg.keeptrials = 'no';
        cfg.method = 'mtmconvol';
        cfg.taper = 'hanning';
        cfg.output = 'pow';
        cfg.trials = find(comp.trialinfo == gcfg.cond.codes(cond));
        datalength = size(comp.trial{1},2)/comp.fsample;
        cfg.toi = [comp.time{1}(1):0.01:comp.time{1}(end)];
        cfg.foi = [ceil(3/datalength):1:35];
        cfg.pad = ceil(datalength);
        cfg.padtype = 'zero';
        cfg.t_ftimwin = 1./cfg.foi*3;
        tfr{cond} = ft_freqanalysis(cfg,comp);
        
        % timelocked avgerage
        cfg = [];
        cfg.trials = find(comp.trialinfo == gcfg.cond.codes(cond));
        timelockcomp{cond} = ft_timelockanalysis(cfg, comp);
    end
    
end % of loop over conditions

% reorganize trial array
comptrial = zeros(length(comp.label),length(comp.trial),length(comp.trial{1}));
for i = 1:length(comp.label)
    for j = 1:length(comp.trial)
        comptrial(i,j,:) = comp.trial{j}(i,:);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set parameters
% plotchannels = find(ismember(eventdata.label, gcfg.browsechannel))';
plotcomponents = 1:length(comp.label);
sliderMin = 0;
sliderMax = length(plotcomponents); 
sliderStep = [1,1] / (sliderMax - sliderMin);


% generate figure with callback function
h = figure('Name','evaluate components','units','normalized','outerposition',[0 0 1 1]);

opt = [];
opt.compPos = 1;
opt.rejected = zeros(1,length(comp.label));
opt.findrejected = [];
setappdata(h,'opt', opt);

set(h,'units','pixels');
figSize = get(h, 'Position');
set(h, 'CloseRequestFcn', @cleanup);
hb_quit = uicontrol('Parent', h, 'Style','pushbutton','Position',[figSize(1)+10 10 50 20], 'String', 'quit', 'Callback',@cleanup); 
hb_text = uicontrol('Parent', h, 'Style','text','Position',[20 35 180 20], 'String', 'Rejected components: '); 
hb_rejected = uicontrol('Parent', h, 'Style','edit','Position',[200 40 figSize(3)-220 20], 'String', 'none', 'Callback',@rejectedComponents); 
hb_reject = uicontrol('Parent', h, 'Style','pushbutton','Position',[figSize(3)-570 10 100 20], 'String', 'reject all', 'Callback',@rejectAllComponents); 
hb_keep = uicontrol('Parent', h, 'Style','pushbutton','Position',[figSize(3)-690 10 100 20], 'String', 'keep all', 'Callback',@keepAllComponents); 
hb = uicontrol('Parent', h, 'Style','slider','Position',[figSize(3)-450 10 300 20],'Callback',@componentSlider);
set(hb, 'Min', sliderMin, 'Max', sliderMax, 'SliderStep', sliderStep, 'Value', sliderMin); 
hb_reject = uicontrol('Parent', h, 'Style','pushbutton','Position',[figSize(3)-70 10 50 20], 'String', 'reject', 'Callback',@rejectComponent); 
hb_keep = uicontrol('Parent', h, 'Style','pushbutton','Position',[figSize(3)-140 10 50 20], 'String', 'keep', 'Callback',@keepComponent); 

while ishandle(h)
    uiwait(h);  
end

% plot results
display(['rejected component filter: ' num2str(opt.rejected)]);
display(['rejected component numbers: ' num2str(opt.findrejected)]);
badcomponents = opt.findrejected; % hand over function output


%% subfunctions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% nested function componentSlider
function componentSlider(hObject,eventinput,handles)
    opt = getappdata(h,'opt');
    
    cstep = round(get(hObject,'Value'));
    if cstep <= 1
        cstep = 1;
    elseif cstep >= length(plotcomponents); 
        cstep = length(plotcomponents);
    end
    display(['Evaluating component ' num2str(cstep)]);
    opt.compPos = cstep;    
    event = plotcomponents(cstep);
       
    %% topoplot
    sphandle = subplot(3,3,1);
    cla;
    cfg =[];
    cfg.component = cstep;
    cfg.layout = 'EEG1005.lay';
    cfg.comment = 'no';
    ft_topoplotIC(cfg,comp);
    title(['topography of weights for ' icapow{cond}.label(cstep)],'Interpreter','none');  
     
	%% spectral power distribution
    sphandle = subplot(3,3,4);
    cla; hold on;
    for cond = 1:length(gcfg.cond.labels) % loop over conditions
        cfg = [];
        cfg.xlim = [1 100];
%         freqfilt = icapow{cond}.freq >= cfg.xlim(1) & icapow{cond}.freq <= cfg.xlim(2); 
        plot(icapow{cond}.freq,icapow{cond}.powspctrm(cstep,:)','Color',gcfg.cond.colors(cond,:),'LineStyle',gcfg.cond.lines{cond},'LineWidth',2)
        xlim([cfg.xlim]);
    end
    title(['FFT for ' icapow{cond}.label(cstep)],'Interpreter','none');
    xlabel('Hz'); ylabel('power (a.u.)');
    legend(gcfg.cond.labels{:});
    hold off;
    sphandle = subplot(3,3,7);
    cla; hold on;
    for cond = 1:length(gcfg.cond.labels) % loop over conditions
        cfg = [];
        cfg.xlim = [5 25];
        plot(icapow{cond}.freq,icapow{cond}.powspctrm(cstep,:)','Color',gcfg.cond.colors(cond,:),'LineStyle',gcfg.cond.lines{cond},'LineWidth',2)
        xlim([cfg.xlim]);
    end
    title(['FFT for ' icapow{cond}.label(cstep)],'Interpreter','none');
    xlabel('Hz'); ylabel('power (a.u.)');
    legend(gcfg.cond.labels{:});
    hold off;
    
	%% multitrialplot
    if strcmp(gcfg.timelock,'yes')
        sphandle = subplot(3,3,2:3);
    else
        sphandle = subplot(3,3,[2:3,5:6,8:9]);
    end
    cla;
    cfg = [];
    cfg.clim = [-max([abs(min(min(squeeze(comptrial(cstep,:,:))))) abs(max(max(squeeze(comptrial(cstep,:,:)))))]) max([abs(min(min(squeeze(comptrial(cstep,:,:))))) abs(max(max(squeeze(comptrial(cstep,:,:)))))])];
    colormap jet;
    imagesc(squeeze(comptrial(cstep,:,:)),cfg.clim); 
    colorbar('eastoutside');
    title(['multitrialplot for ' icapow{cond}.label(cstep)],'Interpreter','none');
    xlabel('time (ms)'); ylabel('trial number');
    set(gca,'ytick',[0:5:size(comptrial,2)]);
    if strcmp(gcfg.timelock,'yes')
        %% timelocked components
        sphandle = subplot(3,3,5:6);
        cla;
        cfg = [];
        cfg.channel = cstep;
        ft_singleplotER(cfg,timelockcomp{cond});
        title(['timelocked ' icapow{cond}.label(cstep)],'Interpreter','none');        
        xlabel('time (ms)'); ylabel('voltage (a.u.)');
        pos = get(sphandle,'position');
        pos(3) = pos(3)*0.91;
        set(sphandle, 'position', pos);
        
        %% TFR
        sphandle = subplot(3,3,8:9);
        cla;
        cfg = [];
        cfg.channel = cstep;
%         blwinlength = 0.5;
%         cfg.baseline = [tfr{cond}.time(1) min([tfr{cond}.time(1)+blwinlength tfr{cond}.time(end)])];
%         cfg.baseline = [-1 -0.5];        
%         cfg.baselinetype = 'relchange';
%         cfg.zlim = 'maxabs';
%         cfg.zlim = [-1 1];
        ft_singleplotTFR(cfg,tfr{cond});
        title(['TFR ' icapow{cond}.label(cstep)],'Interpreter','none');
        xlabel('time (ms)'); ylabel('Hz');
    end
    setappdata(h,'opt', opt);
    
end % of slider function


%% nested function rejectComponent
function rejectComponent(hObject, eventdata, handles, varargin)
    opt = getappdata(h,'opt'); 
    
%     button_state = get(hObject,'Value');    
    opt.rejected(opt.compPos) = 1;
    opt.findrejected = find(opt.rejected);
    set(hb_rejected,'String', num2str(opt.findrejected));
    
    setappdata(h,'opt', opt);  
end % of rejectComponent function

%% nested function keepComponent
function keepComponent(hObject, eventdata, handles, varargin)
    opt = getappdata(h,'opt'); 
    
%     button_state = get(hObject,'Value');    
    opt.rejected(opt.compPos) = 0;
    opt.findrejected = find(opt.rejected);
    set(hb_rejected,'String', num2str(opt.findrejected));
    
    setappdata(h,'opt', opt);  
end % of keepComponent function

%% nested function rejectComponents
function rejectAllComponents(hObject, eventdata, handles, varargin)
    opt = getappdata(h,'opt'); 
    
    opt.rejected(:) = 1;
    opt.findrejected = find(opt.rejected);
    set(hb_rejected,'String', num2str(opt.findrejected));
    
    setappdata(h,'opt', opt);  
end % of rejectAllComponents function

%% nested function keepAllComponents
function keepAllComponents(hObject, eventdata, handles, varargin)
    opt = getappdata(h,'opt'); 
    
    opt.rejected(:) = 0;
    opt.findrejected = find(opt.rejected);
    set(hb_rejected,'String', num2str(opt.findrejected));
    
    setappdata(h,'opt', opt);  
end % of keepAllComponents function

%% nested function rejectedComponents
function rejectedComponents(hObject, eventdata, handles, varargin)
    opt = getappdata(h,'opt'); 

    currentcomponents  = get(hObject,'String');        
	opt.findrejected = str2num(str2mat(currentcomponents));            
    opt.rejected(:) = 0;
    opt.rejected(opt.findrejected) = 1;
    
    setappdata(h,'opt', opt);  
end % of rejectedComponents function

%% nested function cleanup
function varargout = cleanup(hObject, eventdata, handles, varargin)
    opt = getappdata(h,'opt'); 
    delete(h);    
    uiresume;
end

end % of main function