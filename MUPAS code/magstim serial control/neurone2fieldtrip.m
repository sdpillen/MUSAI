%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% neurone2firldtrip
% by Til Ole Bergmann 2017
% last modified 2017/01/23 by TOB
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% imports MEGA NeuroOne EEG/EMG data into Matlab fieldTrip format
%
%
% cfg = [];
% cfg.filepath = string providing full path to neuroOne data file (1'.bin'); if not specified, a dialogue is opened 
% cfg.channel = Nx1 cell array with selection of channels (default = 'all'), see ft_channelselection for details
%
% [markers data] = neurone2fieldtrip(cfg,data);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [markers data] = neurone2fieldtrip(gcfg)


%% check and adjust config
if ~isfield(gcfg,'filepath'), gcfg.filepath = uigetdir; end
if ~isfield(gcfg,'channel'), gcfg.channel = {'all'}; end

if isempty(which('module_read_neurone.m'))
    warning('Cannot find module_read_neurone.m. Make sure neurone_tools_for_matlab are installed and the path is entered in Matlab. ')
end

%% read header and select phases and inputs to read
[fileToRead, phaseToRead, ext] = fileparts(gcfg.filepath);
phaseToRead = str2double(phaseToRead); 

display('Loading raw data from neurOne...');
tic;
% read the selected NeurOne data from all directories and sessions that shall be merged
display(['Reading file ' fileToRead ', session ' num2str(phaseToRead) '...']);
header = module_read_neurone(fileToRead, 1, true);
channelNames = {header.Protocol.TableInput(:).Name};
inputsToRead = channelNames; % select and reorder inputs to read
clear header;
recording = module_read_neurone(fileToRead, phaseToRead, false, 0, 0, inputsToRead);
display('Data loaded.');
toc

% create fieldtrip data structure of continous data
data = struct;
data.label = fieldnames(recording.signal);
data.fsample = recording.properties.samplingRate;
fields = fieldnames(recording.signal);
data.trial = {};
data.time = {};
for j = 1:numel(fields)
    display(['Reading in channel ' fields{j} '...']);
    data.trial{1}(j,:) = ft_struct2single(recording.signal.(fields{j}).data); % convert to single precision to save memory
end
data.time{1} = 1/data.fsample:1/data.fsample:recording.properties.length;
data.sampleinfo = [1 recording.properties.length*data.fsample];
markers = [recording.markers.index str2double(recording.markers.type)];
recording = rmfield(recording,'signal'); % delete data from recording structure to prevent memory issues
display('Data converted to fieldtrip format.');
end % of function