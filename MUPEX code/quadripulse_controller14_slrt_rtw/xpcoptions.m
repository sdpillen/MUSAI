
function info=xpcoptions
info.objname='tg';
info.xpcObjCom=0;
  info.SampleTimes(1).PeriodAndOffset = [0.001 0.0];
  info.SampleTimes(1).PriorityAssigned = 'yes';
    info.SampleTimes(1).Priority = 40;
  info.SampleTimes(1).TID = 0;
  info.SampleTimes(2).PeriodAndOffset = [0.01 0.0];
  info.SampleTimes(2).PriorityAssigned = 'yes';
    info.SampleTimes(2).Priority = 41;
  info.SampleTimes(2).TID = 1;
  info.SampleTimes(3).PeriodAndOffset = [0.1 0.0];
  info.SampleTimes(3).PriorityAssigned = 'yes';
    info.SampleTimes(3).Priority = 42;
  info.SampleTimes(3).TID = 2;
  info.SampleTimes(4).PeriodAndOffset = [0.5 0.0];
  info.SampleTimes(4).PriorityAssigned = 'yes';
    info.SampleTimes(4).Priority = 43;
  info.SampleTimes(4).TID = 3;

