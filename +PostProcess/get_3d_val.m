function val = get_3d_val(file, varstr, layer, itime)
% get variable value on vertices, three dimensional variable
%
% val = get_ver_val(file, varstr, layer, itime)
% INPUT:
%   file    - netcdf file
%   varstr  - variable name
%   layer   - No. of layer
%   itime   - specific time
% OUTPUT:
%   
% USAGE:
%   val = get_3d_val('test_001.nc', 'salinity', 10, 1)
% 
val = ncread(file,varstr,[1,layer,itime],[inf,1,1],[1,1,1]);
end