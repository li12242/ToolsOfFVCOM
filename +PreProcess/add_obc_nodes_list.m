function [Mobj]  = add_obc_nodes_list(Mobj,Nlist,Obcser,ObcName,ObcType,plotFig) 

% Add a set of obc nodes comprising a single obc boundary to Mesh structure  
% Using a list of nodes
%
% [Mobj] = add_obc_nodes_list(Mobj,Nlist,Obcser,ObcName,ObcType)
%
% DESCRIPTION:
%    Select using ginput the set of nodes comprising an obc
%
% INPUT
%    Mobj = Matlab mesh object
%    Nlist = List of nodes, column only
%    ObcName = Name of the Open Boundary
%    Obcser  = the serial number of the Open Boundary
%    ObcType = FVCOM Flag for OBC Type
%    plotFig = [optional] show a figure of the mesh (1 = yes)
%
% OUTPUT:
%    Mobj = Matlab mesh object with an additional obc nodelist
%
% EXAMPLE USAGE
%    Mobj = add_obc_nodes_list(Mobj,Nlist,'OpenOcean')
%
% Author(s):  
%    Geoff Cowles (University of Massachusetts Dartmouth)
%    Pierre Cazenave (Plymouth Marine Laboratory)
%    li12242 (Tianjin University)
%
% Revision history:
%    2012-11-26 Add ability to turn off the figures.
%    2014-11-21 Add parameter Obcser 
%==========================================================================
subname = 'add_obc_nodes';
global ftbverbose
if(ftbverbose)
  fprintf('\n')
  fprintf(['begin : ' subname '\n'])
end

% check whether Nlist is column
if (size(Nlist,2)>1)
    error('Nlist should be a column, check input')
end

% Do we want a figure showing how we're getting along?
if nargin == 4
    plotFig = 0;
end

%--------------------------------------------------------------------------
% Get a unique list and make sure they are in the range of node numbers 
%--------------------------------------------------------------------------
Nlist = unique(Nlist);

if(max(Nlist) > Mobj.nVerts);
  fprintf('your open boundary node number exceed the total number of nodes in the domain\n');
  error('stopping...\n')
end

%--------------------------------------------------------------------------
% Plot the mesh 
%--------------------------------------------------------------------------
if plotFig == 1
    if strcmpi(Mobj.nativeCoords(1:3), 'car')
        x = Mobj.x;
        y = Mobj.y;
    else
        x = Mobj.lon;
        y = Mobj.lat;
    end

    figure
    patch('Vertices',[x,y],'Faces',Mobj.tri,...
            'Cdata',Mobj.h,'edgecolor','k','facecolor','interp');
    hold on;
    whos Nlist
    plot(x(Nlist),y(Nlist),'ro');
    axis('equal','tight')
    title('open boundary nodes');
end

% add to mesh object
npts = numel(Nlist);
Mobj.nObcNodes(Obcser) = npts;
Mobj.obc_nodes{Obcser} = Nlist;
Mobj.obc_name{Obcser} = ObcName;
Mobj.obc_type(Obcser) = ObcType;


if(ftbverbose)
  fprintf(['end   : ' subname '\n'])
end

