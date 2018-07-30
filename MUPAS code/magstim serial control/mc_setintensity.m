%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MagStim control via serial port
% mc_setintensity.m
% set stimulation intensity
%
% Use as 
%   mc_setintensity(<s>,<si>)
% where
%   <s> is an instrument object array
%   <si> is a vector of the same length as <s> containing integer values between 0 and 100 (% maximum stimulator output, %MSO)
% 
% by Til Ole Bergmann (mail@tobergmann.de)
% last edited 2016/06/29 by TOB
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function mc_setintensity(s,si)

for i = 1:length(s) % loop over COM  ports
    
    % set intensity
    command = {'40'}; % command to set intensity of stimulator i in hex
    ichar = sprintf('%03d',si(i)); % convert intensity to char
    parameter = {sprintf('%x',ichar(1)) sprintf('%x',ichar(2)) sprintf('%x',ichar(3))}; % parameters must be cell array of hex values
    codestem = [command,parameter]; % codestem without checksum
    hexcode = mc_crc(codestem); % calculate and add checksum (CRC)
    code = char(sscanf(hexcode,'%2X')'); % convert hexcode to ASCII
    fprintf(s(i), code); % send code to set itensity of stimulator i
    
%     display(['Stimulation intensity for ' s(i).name ' set to ' num2str(si(i)) ' % MSO.']);

end

% % Wait for the response from the stimulator for max 1 s or otherwise ignore it.
% tic; elapsed = 0.0;
% while ~s.BytesAvailable && elapsed < 1
%     elapsed = toc;
% end
% 
% % Read the response from the stimulator if any
% if s.BytesAvailable > 0
%     out = fread(s, s.BytesAvailable); % read bytes from serial buffer    
%     settings = mc_readsettings(out,0); % 
%     switch nargin
%         case 2
%             display(['Stimulation intensity set to ' num2str(intensity) ' % MSO.']);
%         case 3
%             display(['Stimulation intensites are set to ' num2str(intensityA) ' % MSO (STIMULATOR A) and ' num2str(intensityB) ' % MSO (STIMULATOR B), respectively.']);
%     end
% else
%     settings = [];
%     display('No response received from stimulator.');
% end
   
end % of function