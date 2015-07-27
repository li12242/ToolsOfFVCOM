function val = get_2d_val(file, varstr, itime)
% get variable value in horizontal grids
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
%   val = get_2d_val('test_001.nc', 'salinity', 10, 1)
% 
val = ncread(file,varstr,[1,itime],[inf,1],[1,1]);
end