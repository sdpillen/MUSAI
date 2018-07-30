%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MagStim control via serial port
% mc_readsettings.m
% read current parameter settings from hex value stimulator response
%
% Use as 
%   <settings> = mc_readsettings(<out><showSettings>)
% where
%   <out> is a hex value output from the stimulator to be intrepreted
%   <showSettings> is a binary flag indicating whether (1) or not (0) to
%   display the retrievad parameters (may currently not be functional!)
%
% by Til Ole Bergmann (mail@tobergmann.de)
% last edited 2016/06/14 by TOB
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function settings = mc_readsettings(out,showSettings)

hexout= sprintf('%x', char(out)'); % convert to hex
hexcell = cellstr(reshape(hexout,2,[])')'; % break up in two-digit cells

% command acknowledged
if strcmp(hexcell{1},'4a')
    settings.commandAcknowledged = 1;
end

% instrument status
settings.status.code = fliplr(hexToBinaryVector(hexcell{2})); % convert instrument status hex to binary vector (flip to have LSB first!)
settings.status.standby = settings.status.code(1);
settings.status.armed = settings.status.code(2);
settings.status.ready = settings.status.code(3);
settings.status.coilPresent = settings.status.code(4);
settings.status.replaceCoil = settings.status.code(5);
settings.status.ErrorPresent = settings.status.code(6);
settings.status.FatalErrorPresent = settings.status.code(7);
settings.status.remoteControlStatus = settings.status.code(8);

% % read intensity and ISI settings
% if numel(hexcell) > 4
%     % intensity settings
%     settings.intensityA = regexprep([char(sscanf(hexcell{3}, '%x')), char(sscanf(hexcell{4}, '%x')), char(sscanf(hexcell{5}, '%x'))],'^0*','');
%     settings.intensityB = regexprep([char(sscanf(hexcell{6}, '%x')), char(sscanf(hexcell{7}, '%x')), char(sscanf(hexcell{8}, '%x'))],'^0*','');
%     
%     % ISI settings
%     settings.isi = regexprep([char(sscanf(hexcell{9}, '%x')), char(sscanf(hexcell{10}, '%x')), char(sscanf(hexcell{11}, '%x'))],'^0*','');
% end
% 
% display settings
if showSettings
    settings.status % display instrument status
    display(['Stimulation intensites are currently ' num2str(settings.intensityA) ' % MSO (STIMULATOR A) and ' num2str(settings.intensityB) ' % MSO (STIMULATOR B), respectively.']);
    display(['ISI is currently ' num2str(settings.isi) ' ms.']);
end

end % of function