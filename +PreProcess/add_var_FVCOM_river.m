function add_var_FVCOM_river(RiverFile,VarName,VarLongName,VarUnits,VarData)
% add time dependent scalar variable to a Riverfile 
%
% function add_var_FVCOM_river(RiverFile,VarName,VarLongName,VarUnits,VarData)
%
% DESCRIPTION:
%    Write an additional scalar variable (e.g. sediment, DO) to a NetCDF
%    River file.  Note that the concentration of the scalar variable
%    is set the same at all river points in the file so it is assumed 
%    that even if the file contains multiple nodes, they all refer to the same
%    river.
%
% INPUT
%    RiverFile:   FVCOM 3.x NetCDF river forcing file
%    VarName:     Variable name (will be the name of the array in the NetCDF file)
%    VarLongName: Variable attribute "long_name"
%    VarUnits:    Variable attribute "units"
%    VarData:     1-D Time series of variable data of exact same dimensions as 
%                 the river flux 
%   
% OUTPUT:
%    Modified FVCOM RiverFile
%
% EXAMPLE USAGE
%    add_var_FVCOM_river('tst_riv.nc','medium_sand','medium sand','kg-m^-3',sand_ts)  
%
% Author(s):  
%    Geoff Cowles (University of Massachusetts Dartmouth)
%
% Revision history
%   
%==============================================================================

warning off

subname = 'add_var_FVCOM_river';
global ftbverbose;
if(ftbverbose);
  fprintf('\n')
  fprintf(['begin : ' subname '\n'])
end;

if(ftbverbose);fprintf('adding variable %s to file %s\n',VarName,RiverFile); end;

%------------------------------------------------------------------------------
% Open River Netcdf and read dimensions
%------------------------------------------------------------------------------
if(~exist(RiverFile))
	error(['file: ' RiverFile ' does not exist']);
end;

nc = netcdf.open(RiverFile, 'WRITE');  
 
% read dimensions
river_dimid = netcdf.inqDimID(nc, 'rivers');
time_dimid = netcdf.inqDimID(nc, 'time');
[~,nTimes] = netcdf.inqDim(nc,time_dimid);
[~,nRivnodes] = netcdf.inqDim(nc,river_dimid);

% make sure time dimension matches FVCOM river dims
tempTimes = numel(VarData);
if(nTimes ~= tempTimes)
	fprintf('# of time frames in file %s is %d\n',RiverFile,tempTimes)
	fprintf('# of time frames in VarData is %d\n',nTimes)
	error('you have chosen the wrong vocation')
end;


%------------------------------------------------------------------------------
% Write variable definition and data and close file
%------------------------------------------------------------------------------

% set field
river_field = zeros(nRivnodes, nTimes);
for i=1:nTimes
	river_field(1:nRivnodes,i) = VarData(i);
end;



%--------------------------------------------------------------
% dump to netcdf file
%--------------------------------------------------------------
netcdf.reDef(nc)
% open boundary forcing
varid=netcdf.defVar(nc,VarName,'NC_FLOAT',[river_dimid, time_dimid]);
netcdf.putAtt(nc,varid,'long_name',VarLongName);
netcdf.putAtt(nc,varid,'units',VarUnits);

netcdf.endDef(nc);
% nc{VarName} = ncfloat('time','rivers');
% nc{VarName}.long_name = VarLongName; 
% nc{VarName}.units     = VarUnits;   

% dump dynamic data
% for i=1:nTimes
%   nc{VarName}(i,1:nRivnodes) = river_field(i,1:nRivnodes); 
% end;

netcdf.putVar(nc,varid,river_field(:));
netcdf.close(nc); 
% nc = close(nc);    


if(ftbverbose);
  fprintf(['end   : ' subname '\n'])
end;

