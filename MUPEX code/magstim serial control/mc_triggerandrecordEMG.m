%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MagStim control via serial port
% mc_triggerandrecordEMG.m
% trigger stimulator via SIMULINK
%
% Use as 
%   mc_triggerSL(<s>)
% where
%   <s> is an instrument object array of length 1
%       NOTE that not more than one stimulator is alowed tobe triggered
%       simultaneously for safety reasons (as it would crash the Magstim 4-into-1 unit)!
%
% by Til Ole Bergmann (mail@tobergmann.de)
% last edited 2016/08/21 by TOB
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function data = mc_triggerandrecordEMG(tg,times,stimulators,marker)

% safety check
if min(diff(times)) < 0.001
    display('It is not allowed to trigger faster than with 1 ms delay!');
    return;
end

sc = tg.getscope(11); % get host scope (ensure HOST scope ID for EMG is 11 when re-compiling model)

% change paremeters
tg.setparam(tg.getparamid('', 'marker_id'), marker);
tg.setparam(tg.getparamid('', 'closedloopmode'), 0);
tg.setparam(tg.getparamid('', 'timeinsecondsandtriggerchannel'), [times',stimulators']); % set parameters

% reset trigger submodel
tg.setparam(tg.getparamid('', 'reset'), 1);
sc.start; % start scope
while ~strcmp(sc.Status, 'Ready for being Triggered') % wait for scope to be ready for being triggered
    mc_pause(0.9);    
end
tg.setparam(tg.getparamid('', 'reset'), 0);
% display(sc.Status);
display(['Triggered stimulators: ' num2str(stimulators(1)) ' & ' num2str(stimulators(2)) ' at times: ' num2str(times(1)) ' & ' num2str(times(2))]);

% read in data
while ~strcmp (sc.Status, 'Finished') % wait for scope to be finished
    mc_pause(0.09);
end
% display(sc.Status);
if strcmp(sc.Status, 'Finished')
    data = sc.Data'; % the data from first two channels
else
    data = [];
end

end % of function