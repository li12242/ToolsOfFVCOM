function Mobj = read_fvcom_netcdf(filepath, Mobj)
% read mesh objects from fvcom result file, netcdf format.
% INPUT:
%   filepath    - path/file
% OUTPUT: 
%   Mobj mesh object with properties
%   nVerts      - No. of vertice
%   nElems      - No. of element
%   xc      - triangle centre coordinate
%   yc      - triangle centre coordinate
%   x       - vertice coordinate
%   y       - vertice coordinate
% WARRNING:
%   The netcdf format result doesn't contain any information of
%   vertices in element. 



end