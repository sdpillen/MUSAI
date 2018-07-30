%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MagStim control via serial port
% mc_pause.m
% pause matlab while maintaining communication via serial COM port(s)
%
% Use as 
%   mc_pause(<delay>)
% where
%   <delay> is a double scalar stating the pause in seconds
% 
% by Til Ole Bergmann (mail@tobergmann.de)
% last edited 2016/06/28 by TOB
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function mc_pause(delay)

s = instrfindall('Type', 'serial');

nextHundredth = 0;
tic; elapsed = 0.0;
while elapsed <= delay
    elapsed = toc;
    if ceil(elapsed / 0.1) > nextHundredth % ceil instead of floor guarantees execution on first iteration and thus also for pauses < 0.1 s
        for i = 1:length(s) % loop over COM  ports
            fprintf(s(i), 'Q@n'); % enable remote control
%             fprintf(s(i), 'EBx'); % arm stimulator
%             display(['elapsed: ' num2str(elapsed)]);
        end
        nextHundredth = nextHundredth + 1;
    end
end

end % of function
