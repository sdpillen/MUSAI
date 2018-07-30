function mc_loopControl(hlc, varargin)
    
%     global loopControlSignal; 
%     loopControlSignal = EventData;
lc = get(hlc, 'UserData');
display(['UserData was ' lc]);
set(hlc, 'UserData', lc, 'string', 'cancel');
    
end