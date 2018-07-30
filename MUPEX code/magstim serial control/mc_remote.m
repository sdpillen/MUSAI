%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MagStim control via serial port
% mc_remote.m
% enable / disable remote control
%
% by Til Ole Bergmann (mail@tobergmann.de)
% last edited 2016/05/18 by TOB
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function settins = mc_remote(s, onoff)

% clear serial buffer 
if s.BytesAvailable
    out = fread(s, s.BytesAvailable);
end

switch onoff
    case 1
        fprintf(s,'Q@n'); % enable remote control 
        msg = 'Remote control enabled.';
        display(msg);
    case 0
        fprintf(s,'RQm'); % disable remote control 
        msg = 'Remote control disabled.';
        display(msg);
end

% Wait for the response from the stimulator for max 1 s or otherwise ignore it.
tic; elapsed = 0.0;
while ~s.BytesAvailable && elapsed < 1
    elapsed = toc;
end

% Read the response from the stimulator if any
if s.BytesAvailable > 0
    out = fread(s, s.BytesAvailable); % read bytes from serial buffer    
    settings = mc_readsettings(out,0); % 
else
    settings = [];
    display('No response received from stimulator.');
end

end % of function