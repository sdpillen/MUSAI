% if target is not running, simulink realtime environment must be bootet on
% target, see "boot.m" script, then reboot target.

env = SimulinkRealTime.getTargetSettings('TargetBNP2');
setAsDefaultTarget(env);

%% set variables in workspace before compiling (if necessary)
timeinsecondsandtriggerchannel = [0,1;0.1,2];
phasecondition = 1;
amplitudeinterval = [0 10000];
reset = 0
closedloopmode = 0
marker_id = 0

%%

tg = xpc % get target
load(tg, 'quadripulse_controller6') % load the application onto target
sc = tg.getscope(11) % get host scope (make sure HOST scope ID is 11 when compiling model)
tg.setparam(tg.getparamid('', 'timeinsecondsandtriggerchannel'), [0,1;0.1,2])
tg.start % start target
%wait until sc.Status == 'Finished'
sc.Data % the data from first two channels


%%

tg.setparam(tg.getparamid('', 'closedloopmode'), 1)
tg.setparam(tg.getparamid('', 'phasecondition'), 1)
tg.setparam(tg.getparamid('', 'amplitudeinterval'), [0 10000])
tg.setparam(tg.getparamid('', 'timeinsecondsandtriggerchannel'), [0,1;0.1,2])
% start
tg.setparam(tg.getparamid('', 'reset'), 1)
sc.start
tg.setparam(tg.getparamid('', 'reset'), 0)

while ~strcmp(sc.Status, 'Finished')
    pause(0.1) % waiting for condition to be met
end
plot(sc.Data)
% now can read out scopes

%%

tg.setparam(tg.getparamid('', 'closedloopmode'), 0)
tg.setparam(tg.getparamid('', 'timeinsecondsandtriggerchannel'), [0,3;0.1,4])

tg.setparam(tg.getparamid('', 'reset'), 1)
pause(0.25)
tg.setparam(tg.getparamid('', 'reset'), 0)

%% Load file scope data

% Attach to the target computer file system.
f=SimulinkRealTime.fileSystem(tg);

% Open the file, read the data, close the file.
h=fopen(f,'pip_data.dat');
data=fread(f,h);
f.fclose(h);

% Unpack the data.
x=SimulinkRealTime.utils.getFileScopeData(data);

% Plot 1 second of the data.
figure; plot(x.data(:,21),x.data(:,1:20));
set(gca,'XLim',[0 1]); grid on;
xlabel('Time (sec)'); ylabel('Amplitude');
