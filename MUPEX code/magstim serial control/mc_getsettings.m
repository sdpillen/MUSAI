%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MagStim control via serial port
% mc_getsettings.m
% get current parameter settings from stimulator
%
% Use as 
%   <settings> = mc_getsettings(<s>)
% where
%   <s> is an instrument object array
%   <settings> is a onedimensional structure array containing information retrieved from
%   the stimulators
%
% by Til Ole Bergmann (mail@tobergmann.de)
% last edited 2016/06/14 by TOB
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function settings = mc_getsettings(s)

display('Get urrent parameter settings...');

for i = 1:length(s) % loop over COM  ports
    % clear serial buffer
    if s(i).BytesAvailable
        out = fread(s(i), s(i).BytesAvailable);
    end
    
    fprintf(s(i),'J@u'); % get current parameter settings
    
    % Wait for the response from the stimulator for max 1 s or otherwise ignore it.
    tic; elapsed = 0.0;
    while ~s(i).BytesAvailable && elapsed < 1
        elapsed = toc;
    end
    
    % Read the response from the stimulator if any
    if s(i).BytesAvailable > 0
        out = fread(s(i), s(i).BytesAvailable); % read bytes from serial buffer
        settings(i) = mc_readsettings(out,1); %
    else
        settings(i) = [];
        display('No response received from stimulator ' s(i).name '.');
    end
end % of loop over COM ports

end % of function