%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MagStim control via serial port
% mc_maintain.m
% maintain communication via serial COM port(s)
%
% Use as 
%   mc_maintain(<s>)
% where
%   <s> is an instrument object array
%
% by Til Ole Bergmann (mail@tobergmann.de)
% last edited 2016/06/28 by TOB
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function mc_maintain(s,event)

for i = 1:length(s) % loop over COM  ports
    fprintf(s(i), 'Q@n'); % enable remote control  
%     display(num2str(clock))
end

end % of function