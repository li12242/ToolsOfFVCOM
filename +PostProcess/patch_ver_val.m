function patch_handle = patch_ver_val(Mobj, val)
% draw vertice value
% INPUT:
%
%
% OUTPUT:
%
%
patch_handle = patch('Vertices',[Mobj.x,Mobj.y],...
    'Faces',Mobj.tri,...
    'Cdata',val,...
    'edgecolor','k',...
    'facecolor','interp');
axis('equal','tight')
end