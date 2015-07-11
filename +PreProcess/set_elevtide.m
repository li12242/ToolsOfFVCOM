function elevation = set_elevtide(Mobj, time, func)
% Setup surface elevation tides on the open boundary 
%
% DESCRIPTION:
%   Setup surface elevation tides on the open boundary
%
% INPUT:
%   Mobj    - mesh object
%   time    - time serial
%   func    - function handle, ele = func(time)
%
% OUTPUT:
%   elevation - surface elevation, size [nOBNode, ntime]
%
% EXAMPLE USAGE
%    ele = set_elevtide(Mobj, time, func)
%
% Author(s):
%    li12242 (Tianjin University)
%
%============================================================

ntime = numel(time);
nObcNodes = Mobj.nObcNodes;

elevation = zeros(nObcNodes, ntime);

for itime = 1:ntime
    elevation(:, itime) = func(Mobj, time(itime) - time(1));
end

end% function

