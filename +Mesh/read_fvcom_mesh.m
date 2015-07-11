function [Mobj] = read_fvcom_mesh(gridfile, Mobj) 

% Read fvcom mesh file into Matlab mesh object  
%
% [Mobj] = function read_fvcom_mesh(gridfile, Mobj)
%
% DESCRIPTION:
%    Read FVCOM Grid file (connectivity + nodes)
%    Store in a matlab mesh object 
%
% INPUT [keyword pairs]:  
%   'gridfile'  = fvcom mesh file
%
% OUTPUT:
%    Mobj = matlab structure containing mesh data
%
% EXAMPLE USAGE
%    Mobj = read_fvcom_mesh('tst_grd.dat')
%
% Author(s):  
%    Geoff Cowles (University of Massachusetts Dartmouth)
%
% Revision history
%   
%==============================================================================

%------------------------------------------------------------------------------
% Initialize
%------------------------------------------------------------------------------

coordinate = 'cartesian';
have_bath = true;
have_xy = true;

%------------------------------------------------------------------------------
% Read the mesh from the fvcom grid file
%------------------------------------------------------------------------------


fid = fopen(gridfile,'r');
if(fid  < 0)
	error(['file: ' gridfile ' does not exist']);
end;

%----------------------------------------------------
% read in the fvcom connectivity and vertices 
%----------------------------------------------------
C = fgetl(fid); n = find(C==' '); nVerts = str2double(C(n(end):end));
C = fgetl(fid); n = find(C==' '); nElems = str2double(C(n(end):end));
tri = zeros(nElems,3);
% x   = zeros(nVerts,1);
% y   = zeros(nVerts,1);
h   = zeros(nVerts,1);

fprintf('reading mesh file\n');
fprintf('# nodes %d\n',nVerts);
fprintf('# elems %d\n',nElems);


C = fscanf(fid,' %d %d %d %d %d\n',[5, nElems]);
tri(:,1) = C(2,:)';  tri(:,2) = C(3,:)'; tri(:,3) = C(4,:)';

C = fscanf(fid, '%d %f %f %f', [4, nVerts]);
x = C(2,:)';
y = C(3,:)';

fclose(fid);

%------------------------------------------------------------------------------
% Transfer to Mesh structure
%------------------------------------------------------------------------------

Mobj.nVerts  = nVerts;
Mobj.nElems  = nElems;
Mobj.nativeCoords = coordinate;


if(have_xy)
	Mobj.have_xy      = have_xy;
end;
if(have_bath)
	Mobj.have_bath    = have_bath;
end;
Mobj.x            = x;
Mobj.y            = y;
Mobj.h            = h;
Mobj.tri          = tri;


