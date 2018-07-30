%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MagStim control via serial port
% mc_close.m
% close serial COM port(s)
%
% Use as 
%   mc_close(<s>)
% where
%   <s> is an instrument object array
%
% If no <s> is specified, all serial port objets will be closed by default.
% 
% by Til Ole Bergmann (mail@tobergmann.de)
% last edited 2016/06/14 by TOB
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function mc_close(varargin)

s = instrfindall('Type', 'serial');
if isempty(s)
    display('No COM ports are open that could be closed.');
    clear s;
    return
end

if nargin < 1  % no port specified --> close all!
        s = instrfindall('Type', 'serial');
        fclose(s);
        delete(s);    
        display('All serial ports have been closed, deleted and cleared.');       
elseif nargin > 0 % one or more ports specified --> close only those!
        s = varargin;
        fclose(s);
        delete(s);
       for i = length(s)
           display([s(i).Name ' has been closed, deleted and cleared.']);
       end
end
clear s;

end % of function

