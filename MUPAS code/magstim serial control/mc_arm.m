%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MagStim control via serial port
% mc_arm.m
% arm/disarm stimulator
%
% Use as 
%   mc_arm(<s>,<onoff>)
% where
%   <s> is an instrument object array
%   <onoff> is a binary value (1 = arm, 0 = disarm)
% 
% by Til Ole Bergmann (mail@tobergmann.de)
% last edited 2016/06/27 by TOB
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function mc_arm(s, onoff)

% clear serial buffer 
% if s.BytesAvailable
%     out = fread(s, s.BytesAvailable);
% end

switch onoff
    case 1 % on
    for i = 1:length(s) % loop over COM  ports
        fprintf(s(i), 'EBx'); % arm stimulator
%         display(['Stimulator ' s(i).name ' is armed.']);
    end
     
    case 0 % off
    for i = 1:length(s) % loop over COM  ports
        fprintf(s(i), 'EAy'); % disarm stimulator
%         display(['Stimulator ' s(i).name ' is disarmed.']);
    end
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
%     switch onoff
%         case 1
%             display('Stimulator is armed.');
%         case 0
%             display('Stimulator is disarmed.');
%     end
% else
%     settings = [];
%     display('No response received from stimulator.');
% end


end % of function