function Mobj = read_ADCIRC_spher_mesh(filepath)
% Read sms mesh files into Matlab mesh object
%
% DESCRIPTION:
%    Read ADCIRC bathymetry file 
%    Store in matlab mesh object
%
% INPUT [keyword pairs]:  
%   filepath    - path to ADCIRC bathymetry file, .e.g 'samples/fort.14'
%
% OUTPUT: Mobj properties, include
%   x       - coordinate
%   y       - coordinate
%   lon     - same as x
%   lat     - same as y
%   h       - mesh depth
%   tri     - element to vertice, size [nElement x 3] (for triangle only)
%   
% EXAMPLE USAGE
%    Mobj = read_sms_mesh('samples/fort.14','coor','coordinate','project',true)
%
% Author:  
%    li12242
%
% Email:
%    li12242@tju.edu.cn
%   
%==============================================================================

%------------------------------------------------------------------------------
% Create a blank mesh object
%------------------------------------------------------------------------------
Mobj = make_blank_mesh();
coordinate = 'spherical';
		
%------------------------------------------------------------------------------
% Read the mesh from the fort14 file
%------------------------------------------------------------------------------

mesh = smsFort14(filepath);
x = mesh.PointPositionXY(:,1); 
y = mesh.PointPositionXY(:,2);

lon = x;
lat = y;

%------------------------------------------------------------------------------
% Transfer to Mesh structure
%------------------------------------------------------------------------------

Mobj.nVerts  = mesh.pointNum;
Mobj.nElems  = mesh.elementNum;
Mobj.nativeCoords = coordinate;

Mobj.have_xy = false;

Mobj.x            = x;
Mobj.y            = y;
Mobj.lon          = lon;
Mobj.lat          = lat;
Mobj.h            = mesh.PointDepth;
Mobj.tri          = mesh.ElementComponent;
Mobj.have_bath  = true;

%------------------------------------------------------------------------------
% write Boundary to Mesh structure
%------------------------------------------------------------------------------
Mobj.nObs         = numel(mesh.OpenBoundarySerial_cell);
Mobj.obc_nodes    = cell(Mobj.nObs,1);

plotFig = 0; ObcType = 1; ObcName = 'Open_Boundary';

for i = 1:Mobj.nObs
    Obcser = i;
    Mobj  = add_obc_nodes_list(Mobj,mesh.OpenBoundarySerial_cell{i},...
        Obcser,ObcName,ObcType,plotFig);
end

end% function