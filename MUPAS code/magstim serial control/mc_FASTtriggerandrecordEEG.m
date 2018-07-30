%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MagStim control via serial port
% mc_FASTtriggerandrecordEEG
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
% last edited 2017/09/08 by TOB
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function data = mc_FASTtriggerandrecordEEG(tg,times,stimulators,marker,hostscope)

% safety check
if min(diff(times)) < 0.001
    display('It is not allowed to trigger faster than with 1 ms delay!');
    return;
end

if ~exist('hostscope','var')
    hostscope = 12; % set default value for host scope
end

sc = tg.getscope(hostscope); % get host scope (ensure HOST scope ID for EEG is 12 when re-compiling model)

% change paremeters
tg.setparam(tg.getparamid('', 'marker_id'), marker);
tg.setparam(tg.getparamid('', 'closedloopmode'), 0);
tg.setparam(tg.getparamid('', 'forecast_offset_ms'), 0);
tg.setparam(tg.getparamid('', 'timeinsecondsandtriggerchannel'), [times',stimulators']); % set parameters

% reset trigger submodel
tg.setparam(tg.getparamid('', 'reset'), 1);
sc.start; % start scope
while ~strcmp(sc.Status, 'Ready for being Triggered') % wait for scope to be ready for being triggered
%     mc_pause(0.9);    
    mc_pause(0.05);    
end
tg.setparam(tg.getparamid('', 'reset'), 0);
% display(sc.Status);
display(['Triggered stimulators: ' num2str(stimulators(1)) ' & ' num2str(stimulators(2)) ' at times: ' num2str(times(1)) ' & ' num2str(times(2))]);

% read in data
while ~strcmp (sc.Status, 'Finished') % wait for scope to be finished
%     mc_pause(0.09);
    mc_pause(0.05);
end
display(sc.Status);
if strcmp(sc.Status, 'Finished')
    data = sc.Data'; % the EEG data of the target EEG signal (Hjort)
else
    data = [];
end

end % of function