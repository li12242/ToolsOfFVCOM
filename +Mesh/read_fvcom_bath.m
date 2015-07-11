function [Mobj] = read_fvcom_bath(bathfile, Mobj) 

% Read fvcom bathymetry file 
%
% [h] = function read_fvcom_bath(bathfile, Mobj)
%
% DESCRIPTION:
%    Read FVCOM Bathymetry file 
%
% INPUT [keyword pairs]:  
%   'bathfile'  = fvcom bathymetry file
%
% OUTPUT:
%    h = bathymetry vector
%
% EXAMPLE USAGE
%    Mobj = read_fvcom_bath('tst_dep.dat')
%
% Author(s):  
%    Geoff Cowles (University of Massachusetts Dartmouth)
%
% Revision history
%   
%==============================================================================


%------------------------------------------------------------------------------
% read in the FVCOM bathymetry data
%------------------------------------------------------------------------------
fid = fopen(bathfile,'r');
if(fid  < 0)
  error(['file: ' bathfile ' does not exist']);
end;
C = fgetl(fid); n = find(C==' ');  Nverts = str2double(C(n(end):end));
h = zeros(Nverts,1);
fprintf('reading bathymetry file\n');
fprintf('# nodes %d\n',Nverts);

C = fscanf(fid, '%f %f %f', [3,Nverts]);
h = C(3,:);

fprintf('min depth %f max depth %f\n',min(h),max(h));
fprintf('bathymetry reading complete\n');
fclose(fid);

Mobj.h = h;



