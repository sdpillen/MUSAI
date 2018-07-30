%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MagStim control via serial port
% mc_trigger.m
% trigger stimulator
%
% Use as 
%   mc_trigger(<s>)
% where
%   <s> is an instrument object array of length 1
%       NOTE that not more than one stimulator is alowed tobe triggered
%       simultaneously for safety reasons (as it would crash the Magstim 4-into-1 unit)!
%
% by Til Ole Bergmann (mail@tobergmann.de)
% last edited 2016/05/18 by TOB
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function mc_trigger(s)

if length(s) > 1
    display('It is not allowed to trigger more than one stimulator at once!');
    return;
end

% % clear serial buffer 
% if s.BytesAvailable
%     out = fread(s, s.BytesAvailable);
% end

%     binaryVec = [0 1 0 0 1 0 0 0]; % 'Trigger stimulator' 
%     command = {'45'}; % % command to set base mode in hex
%     parameter = {binaryVectorToHex(binaryVec)}; % parameters need to be cell array of hex values
%     codestem = [command,parameter]; % codestem without checksum
%     hexcode = mc_crc(codestem); % calculate and add checksum (CRC)
%     code = char(sscanf(hexcode,'%2X')'); % convert hexcode to ASCII
%     fprintf(s, code); % trigger stimulator
    fprintf(s(1), 'EHr'); % trigger stimulator
	display(['Stimulator ' s(1).name ' has been triggered.']);  
    
%     % Wait for the response from the stimulator for max 1 s or otherwise ignore it.
%     tic; elapsed = 0.0;
%     while ~s.BytesAvailable && elapsed < 1
%         elapsed = toc;
%     end
%     
% % Read the response from the stimulator if any
% if s.BytesAvailable > 0
%     out = fread(s, s.BytesAvailable); % read bytes from serial buffer    
%     settings = mc_readsettings(out,0); % 
% else
%     settings = [];
%     display('No response received from stimulator.');
% end

end % of function