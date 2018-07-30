%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MagStim control via serial port
% mc_EEGtriggerandrecordEEG.m
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

function data = mc_EEGtriggerandrecordEEG(tg, amplitudes,amplitudePercentiles, whichphase, times, stimulators, marker)

% safety check
if min(diff(times)) < 0.001
    display('It is not allowed to trigger faster than with 1 ms delay!');
    return;
end

sc = tg.getscope(13); % get host scope (ensure HOST scope ID is 13 when re-compiling model)

% change paremeters
tg.setparam(tg.getparamid('', 'marker_id'), marker);
tg.setparam(tg.getparamid('', 'closedloopmode'), 1);
tg.setparam(tg.getparamid('', 'timeinsecondsandtriggerchannel'), [times',stimulators']);
tg.setparam(tg.getparamid('', 'phasecondition'), whichphase);
tg.setparam(tg.getparamid('', 'forecast_offset_ms'), 0);
tg.setparam(tg.getparamid('', 'amplitudeinterval'), amplitudes);
tg.setparam(tg.getparamid('', 'amplitudeinterval_percentiles'), amplitudePercentiles);

% reset trigger submodel
tg.setparam(tg.getparamid('', 'reset'), 1); % "disarm" detection
sc.start; % start scope
while ~strcmp(sc.Status, 'Ready for being Triggered') % wait for scope to be ready for being triggered
%     mc_pause(0.09);    
    mc_pause(0.25);   
end
display(sc.Status);
tg.setparam(tg.getparamid('', 'reset'), 0); % "arm" detection
display(['amp: ' num2str(amplitudes) ' phase:' num2str(whichphase) ' times:' num2str(times) ' stimulators:' num2str(stimulators)]);

% read in data
while ~strcmp(sc.Status, 'Finished')  % wait for scope to be finished
%     mc_pause(0.09);    
    mc_pause(0.25);   
end
display(sc.Status);
if strcmp(sc.Status, 'Finished')
    data = sc.Data'; % the data from the signals in scope 13 
else
    data = [];
end

display(['Stimulators ' num2str(stimulators) ' have been triggered.']);

end % of function