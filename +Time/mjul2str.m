function strout = mjul2str(MJD, varargin)
% Convert a modified Julian day to a Matlab datestr style string 
%
% DESCRIPTION
%   Convert a modified Julian day to a Matlab datestr style string 
%
% INPUT
%    MJD    = modified Julian day
%    Format = [optical] date format, .e.g 'yyyy-mm-dd HH:MM:SS'
%
% OUTPUT
%    strout = Matlab datestr style string 
%               .e.g '2000-03-01 15:45:17'
%
% EXAMPLE USAGE
%    S = MJUL2STR(time, 'yyyy-mm-dd HH:MM:SS')
%
% Author(s)
%    li12242 (Tianjin University)
%
%==========================================================================


mjul2matlab = 678942; %difference between modified Julian day 0 and Matlab day 0
if nargin>1
    strout = datestr(MJD+mjul2matlab, varargin{1});
else
    strout = datestr(MJD+mjul2matlab);
end