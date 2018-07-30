%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MagStim control via serial port
% mc_setisi.m
% set intter-stimulus intervel (ISI) for paired-pulse TMS (BiStim only)
%
% Use as 
%   mc_setisi(<s>,<isi>)
% where
%   <s> is an instrument object array of length 1
%   <isi> is a double scalar indicating the interstimulus interval (ISI) in ms
%
% by Til Ole Bergmann (mail@tobergmann.de)
% last edited 2016/06/14 by TOB
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function mc_setisi(s,isi)

% % clear serial buffer 
% if s.BytesAvailable
%     out = fread(s, s.BytesAvailable);
% end

% switch res
%     case 'lr'
%         isichar = sprintf('%03d',isi); % 
%     case 'hr'
%         isichar = sprintf('%03d',isi*10); % 
% end


if isi >= 10  
    res = 'lr';
    isichar = sprintf('%03d',isi); %
elseif isi < 10 % 'high resolution mode'
    res = 'hr';
    isichar = sprintf('%03d',isi*10); %
end


mc_settimeres(s,res); % set time resolution mode    

command = {'43'}; % command to set ISI
parameter = {sprintf('%x',isichar(1)) sprintf('%x',isichar(2)) sprintf('%x',isichar(3))}; % parameters must be cell array of hex values
codestem = [command,parameter]; % codestem without checksum
hexcode = mc_crc(codestem); % calculate and add checksum (CRC)
code = char(sscanf(hexcode,'%2X')'); % convert hexcode to ASCII
fprintf(s, code); % send code to set isi

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
% else
%     settings = [];
%     display('No response received from stimulator.');
% end

display(['ISI is set to ' num2str(isi) ' ms.']);

end % of function