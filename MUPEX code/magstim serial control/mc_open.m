%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MagStim control via serial port
% mc_open.m
% open serial COM port
%
% Use as 
%   <s> = mc_open(<portnames>)
% where
%   <portnames> is a cell array containing all portnames, e.g., {'COM1','COM2'}
%   <s> is an instrument object array
%
% If no <portnames> are specified, {'COM1'} will be used by default.
% 
% by Til Ole Bergmann (mail@tobergmann.de)
% last edited 2016/06/24 by TOB
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function s = mc_open(varargin)

if nargin < 1
    portnames = {'COM1'};
    display('No COM port specified. Opening COM1 (default)');    
elseif nargin >0
    portnames = varargin{1};
end

portsalreadydefined = instrfindall('Type', 'serial'); % find all defined serial ports
portsalreadyopen = instrfindall('Type', 'serial', 'Status', 'open'); % find all open serial ports

    for i = 1:length(portnames) % loop over COM  ports
        
        if ~isempty(portsalreadydefined) && any(strcmp(portnames{i}, portsalreadydefined(:).port))
            definedportindex = find(strcmp(portnames{i}, portsalreadydefined(:).port));
            display([portsalreadydefined(definedportindex).Name ' is already defined.']);
            continue % go to next iteration of loop over COM ports
        end
        
        % set parameters of serial port
        s(i) = serial(portnames{i});
        s(i).BaudRate = 9600;
        s(i).DataBits = 8;
        s(i).Parity = 'none';
        s(i).StopBits = 1;
        s(i).FlowControl = 'none';
        s(i).Terminator ='?';
        s(i).TimerPeriod = 0.5;
        s(i).TimerFcn = {'mc_maintain'};
        
        % s(i).InputBufferSize= 12; % ?
        % s(i).OutputBufferSize= 10; % ?
        % NOTE: s(i).TimerPeriod = 0.5 did not work with 0.5 before, maybe because callback function itself had a wait for 0.5. (0.9 worked, but now wait of callback is removed)
        % NOTE: s(i).TimerFcn gives serial object s as first argument and some other stuff in a cell array as second argument to mc_maintain by default
        % NOTE: s(i).TimerFcn = {'mc_maintain',x,y}; % can be called with additional arguments where x and y would be additional 3rd and 4th arguments
        
%         display([s(i).Name ' has been opened.']);
    end
    
if exist('s','var')
    fopen(s) % open serial port(s)
end

s = instrfindall('Type', 'serial') % update s by finding all open serial ports
    
end % of function

