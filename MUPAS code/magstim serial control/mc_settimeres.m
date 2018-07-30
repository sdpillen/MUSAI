%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MagStim control via serial port
% mc_settimeres.m
% set high vs. low resolution time setting mode (BiStim only)
%
% Use as 
%   mc_setimeres(<s>,<res>)
% where
%   <s> is an instrument object array of length 1
%   <res> is a string indicating whether high ('hr') or low ('lr') resolution mode shal be activated,
%         with 'hr' allowing ISI values from 1 ms to 10 ms in 0.1 ms steps
%         and  'lr' allowing ISI values from 1 ms to 999 ms in 1 ms steps
%
% by Til Ole Bergmann (mail@tobergmann.de)
% last edited 2016/06/14 by TOB
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function mc_settimeres(s, res)

% % clear serial buffer 
% if s.BytesAvailable
%     out = fread(s, s.BytesAvailable);
% end

switch res
    case 'hr'
        fprintf(s, 'Y@f'); % enable high resolution time setting mode       
        display('BiStim set to high resolution time mode.');
    case 'lr'
        fprintf(s, 'Z@e'); % enable high resolution time setting mode       
        display('BiStim set to low resolution time mode.');
end
% 
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

end % of function