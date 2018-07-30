%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MagStim control via serial port
% mc_setintensitybistim.m
% set stimulation intensity for BiStim setup
%
% Use as 
%   mc_setintensitybistim(<s>,<si>)
% where
%   <s> is an instrument object array of length 1
%   <si> is a vector of length 2, containing integer values between 0 and 100 (% maximum stimulator output, %MSO),
%        i.e., for Stimualtor A and B of the BiStim setup, respectively
%
% by Til Ole Bergmann (mail@tobergmann.de)
% last edited 2016/06/14 by TOB
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function mc_setintensitybistim(s, si)

intensityA = si(1);
intensityB = si(2);        

% set intensity of STIMULATOR A
commandA = {'40'}; % command to set intensity of stimulator A in hex
icharA = sprintf('%03d',intensityA); % convert intensity to char
parameterA = {sprintf('%x',icharA(1)) sprintf('%x',icharA(2)) sprintf('%x',icharA(3))}; % parameters must be cell array of hex values
codestemA = [commandA,parameterA]; % codestem without checksum
hexcodeA = mc_crc(codestemA); % calculate and add checksum (CRC)
codeA = char(sscanf(hexcodeA,'%2X')'); % convert hexcode to ASCII
fprintf(s, codeA); % send code to set itensity of stimulator A

% set intensity of STIMULATOR B
commandB = {'41'}; % command to set intensity of stimulator B in hex
icharB = sprintf('%03d',intensityB); % convert intensity to char
parameterB = {sprintf('%x',icharB(1)) sprintf('%x',icharB(2)) sprintf('%x',icharB(3))}; % parameters must be cell array of hex values
codestemB = [commandB,parameterB]; % codestem without checksum
hexcodeB = mc_crc(codestemB); % calculate and add checksum (CRC)
codeB = char(sscanf(hexcodeB,'%2X')'); % convert hexcode to ASCII
fprintf(s,codeB); % send code to set itensity of stimulator B

display(['Stimulation intensites are set to ' num2str(intensityA) ' % MSO (STIMULATOR A) and ' num2str(intensityB) ' % MSO (STIMULATOR B), respectively.']);


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