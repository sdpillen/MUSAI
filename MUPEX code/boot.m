%% BNP2
env = SimulinkRealTime.getTargetSettings('TargetPC1');
setAsDefaultTarget(env);
env.TargetBoot='NetworkBoot'
env.TcpIpTargetAddress='10.10.10.2'
env.TargetMACAddress='00:01:29:57:d5:b7'
env.MultiCoreSupport = 'off'
env.UsBSupport='off'
SimulinkRealTime.createBootImage