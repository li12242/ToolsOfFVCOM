function [Mobj]  = add_sponge_nodes_list(Mobj,SpongeList,SpongeName,SpongeRadius,SpongeCoeff)

% Add a set of sponge nodes comprising a single sponge layer to Mesh structure  
%
% [Mobj] = add_sponge_nodes(Mobj)
%
% DESCRIPTION:
%    Select using ginput the set of nodes comprising a sponge layer
%
% INPUT
%    Mobj = Matlab mesh object
%    SpongeList = List of nodes to which to create a Sponge Layer
%    SpongeName = Name of the Sponge Layer
%    SpongeRadius = Radius of influence of the Sponge Layer 
%    SpongeCoeff  = Sponge damping coefficient
%
%
% OUTPUT:
%    Mobj = Matlab mesh object with an additional sponge nodelist
%
% EXAMPLE USAGE
%    Mobj = add_sponge_nodes(Mobj,1:25,'Sponge1',10000,.0001)
%
% Author(s):  
%    Geoff Cowles (University of Massachusetts Dartmouth)
%    Pierre Cazenave (Plymouth Marine Laboratory)
%    Karen Thurston (National Oceanography Centre, Liverpool)
%    li12242 (Tianjin University)
%
% Revision history
%    Modifed from add_sponge_nodes to read in nodes from a supplied list.
%    2012-11-26 Add ability to turn off the figures.
%    2013-01-18 Added support for variable sponge radius
%    2014-11-29 changed the properity 'spong_nodes' & 'sponge_rad' of Mobj 
%       to be cell array
%   
%==============================================================================
subname = 'add_sponge_nodes';

global ftbverbose
if(ftbverbose)
    fprintf('\n')
    fprintf(['begin : ' subname '\n'])
end


npts = length(SpongeList);

if(npts == 0)
	fprintf('No points in given list')
	fprintf(['end   : ' subname '\n'])
	return
end
if(ftbverbose)
    fprintf('%d points provided\n',npts)
end

% add to mesh object
Mobj.nSponge = Mobj.nSponge + 1;
Mobj.nSpongeNodes(Mobj.nSponge) = npts;
Mobj.sponge_nodes{Mobj.nSponge} = SpongeList;
Mobj.sponge_name{Mobj.nSponge} = SpongeName;
Mobj.sponge_fac(Mobj.nSponge) = SpongeCoeff;
Mobj.sponge_rad{Mobj.nSponge} = SpongeRadius;

if(ftbverbose)
    fprintf(['end   : ' subname '\n'])
end

