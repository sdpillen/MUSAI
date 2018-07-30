%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MagStim control via serial port
% mc_EEGtriggerandrecordEMG.m
% trigger EEG collection via SIMULINK
%
% Use as 
%   mc_triggerSL(<s>)
% where
%   <s> is an instrument object array of length 1
%       NOTE that not more than one stimulator is alowed tobe triggered
%       simultaneously for safety reasons (as it would crash the Magstim 4-into-1 unit)!
%
% by Til Ole Bergmann (mail@tobergmann.de)
% last edited 2017/06/02 by TOB
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [data data_ampthreshold] = mc_EEGtriggerandrecordEMG(tg, amplitudes, amplitudePercentiles, whichphase, times, stimulators, marker)

% safety check
if min(diff(times)) < 0.001
    display('It is not allowed to trigger faster than with 1 ms delay!');
    return;
end

sc_emg = tg.getscope(11); % get host scope (ensure HOST scope ID is 11 when re-compiling model)
sc_ampthreshold = tg.getscope(10);

% change paremeters
tg.setparam(tg.getparamid('', 'marker_id'), marker);
tg.setparam(tg.getparamid('', 'closedloopmode'), 1);
tg.setparam(tg.getparamid('', 'timeinsecondsandtriggerchannel'), [times',stimulators']);
tg.setparam(tg.getparamid('', 'phasecondition'), whichphase);
tg.setparam(tg.getparamid('', 'amplitudeinterval'), amplitudes);
tg.setparam(tg.getparamid('', 'amplitudeinterval_percentiles'), amplitudePercentiles);

% reset trigger submodel
tg.setparam(tg.getparamid('', 'reset'), 1); % "disarm" detection
sc_emg.start; % start scope
while ~strcmp(sc_emg.Status, 'Ready for being Triggered') % wait for scope to be ready for being triggered
%     mc_pause(0.09);    
    mc_pause(0.25);   
end
display(sc_emg.Status);
tg.setparam(tg.getparamid('', 'reset'), 0); % "arm" detection
display(['amp: ' num2str(amplitudes) ' phase:' num2str(whichphase) ' times:' num2str(times) ' stimulators:' num2str(stimulators)]);

% read in data
while ~strcmp(sc_emg.Status, 'Finished')  % wait for scope to be finished
%     mc_pause(0.09);    
    mc_pause(0.25);   
end
display(sc_emg.Status);
if strcmp(sc_emg.Status, 'Finished')
    data = sc_emg.Data'; % the data from the signals in scope 11
    data_ampthreshold = sc_ampthreshold.Data(end,:)';
else
    data = [];
    data_ampthreshold = [];
end

display(['Stimulators ' num2str(stimulators) ' have been triggered.']);

end % of function