%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MagStim control via serial port
% mc_setbasemode.m
% set base mode
%
% Use as 
%   mc_setbasemode(<s>,<mode>)
% where
%   <s> is an instrument object array of length 1
%   <mode> is a string indicating the base mode ('stop', 'arm', 'trigger')
%
% by Til Ole Bergmann (mail@tobergmann.de)
% last edited 2016/06/14 by TOB
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function settings = mc_setbasemode(s, mode)

switch mode
    case 'stop' % Set stimulator in Stopped mode
        binaryVec = [0 1 0 0 0 0 0 1];
    case 'arm' % Set stimulator in Armed mode
        binaryVec = [0 1 0 0 0 0 1 0];        
    case 'trigger' % Trigger stimulator
        binaryVec = [0 1 0 0 1 0 0 0]; % or [0 1 0 0 1 0 1 0] as it need to stay armed?
end

for i = 1:length(s) % loop over COM  ports
    command = {'45'}; % command to set base mode in hex
    parameter = {binaryVectorToHex(binaryVec)}; % parameters need to be cell array of hex values
    codestem = [command,parameter]; % codestem without checksum
    hexcode = mc_crc(codestem); % calculate and add checksum (CRC)
    code = char(sscanf(hexcode,'%2X')'); % convert hexcode to ASCII
    fprintf(s(i),code); % set base mode
    display(['Base mode of ' s(i).name ' set to ' mode '.']);
end

% % Wait for the response from the stimulator for max 1 s or otherwise ignore it.
% tic; elapsed = 0.0;
% while ~s.BytesAvailable && elapsed < 1
%     elapsed = toc;
% end
% 
% % Read the response from the stimulator if any
% if s.BytesAvailable > 0
%     out = fread(s, s.BytesAvailable);
% 	settings = mc_readsettings(out,0);
% else
%     settings = [];
%     display('No response received from stimulator.');
% end

end % of function