function write_FVCOM_riverNameList(RiverNameList, RiverFile, RiverName, node_id, vel_dist)

nRiver = numel(node_id);
fig = fopen(RiverNameList, 'w');

for iriver = 1:nRiver
    fprintf(fig, '%s\n', '&NML_RIVER');
    fprintf(fig, '%s%s%d%s \n','RIVER_NAME = ''', RiverName, iriver-1, '''');
    fprintf(fig, '%s%s%s\n', 'RIVER_FILE = ''', RiverFile, '''');
    fprintf(fig, '%s %d, \n', 'RIVER_GRID_LOCATION = ', node_id(iriver));
    format = ['%s', repmat('%f ', 1, numel(vel_dist)), '\n'];
    fprintf(fig, format, 'RIVER_VERTICAL_DISTRIBUTION = ', vel_dist);
    fprintf(fig, '/ \n');
end
fclose(fig);
end