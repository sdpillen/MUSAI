%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% MagStim control via serial port
% mc_crc
% add checksum (CRC, cyclic redundancy check) to code
%
% Use as 
%   <code> = crc(<codestem>)
% where
%   <codestem> is the hex code without checksum
%   <code> is the hex code with checksum
%
% by Til Ole Bergmann (mail@tobergmann.de)
% last edited 2016/06/14 by TOB
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function code = mc_crc(codestem)
   
% one's complement of sum of command and parameters (bit invert result of addition)
crc = dec2hex(bitcmp(uint8(sum(hex2dec(codestem))),'uint8')); 
code = [codestem{:}, crc]; % code has to be char (and codestem is cell)

end % of function