function write_FVCOM_river(RiverFile,RiverName,nRivnodes,time,flux,temp,salt,RiverInfo1,RiverInfo2)
% write FVCOM 3.x NetCDF river file
%
% function write_FVCOM_river(RiverFile,RiverName,nRivnodes,time,flux,temp,salt,RiverInfo1,RiverInfo2)
%
% DESCRIPTION:
%    Write river flux, temperature, and salinity to an FVCOM river file
%    Note that it is assumed that the NetCDF file contains data for only
%    one river, even if it is split among multiple nodes.  The flux will be
%    set at each node as flux/nRivnodes where nRivnodes is the number of River
%    nodes.  Salinity and Temperature will be set the same at each node
%
% INPUT
%    RiverFile:   FVCOM 3.x NetCDF river forcing file
%    RiverName:   Name of the actual River
%    nRivnodes:   # of River nodes
%    time     :   timestamp in modified Julian day 
%    flux     :   Total river flux of same dimensions as time in m^3/s
%    temp     :   temperature in C of same dimensions as time
%    salt     :   salinity in PSU of same dimensions as time
%    RiverInfo1 : global attribute of file
%    RiverInfo2 : additional global attribute of file
%   
% OUTPUT:
%    FVCOM RiverFile with flux,temp,salt
%
% EXAMPLE USAGE
%  write_FVCOM_river('tst_riv.nc','Penobscot',3,time,flux,salt,'Penobscot Flux','source: USGS')  
%
% Author(s):  
%    Geoff Cowles (University of Massachusetts Dartmouth)
%
% Revision history
%   
%==============================================================================
warning off;

global ftbverbose;
if(ftbverbose);
subname = 'write_FVCOM_river';
fprintf('\n')
fprintf(['begin : ' subname '\n'])
end;


if(ftbverbose); 
  fprintf('creating river NetCDF file %s for River %s\n',RiverFile,RiverName); 
end;


nTimes = numel(flux);
if(ftbverbose);
  fprintf('# of river nodes: %d\n',nRivnodes);
  fprintf('# of time frames: %d\n',nTimes);
end;

[year,month,day,hour,mint,sec] = FVCOM.Time.mjulian2greg(time(1));
if(ftbverbose); fprintf('river begins at: %d %d %d\n',year,month,day); end;
[year,month,day,hour,mint,sec] = FVCOM.Time.mjulian2greg(time(end));
if(ftbverbose); fprintf('river ends at:   %d %d %d\n',year,month,day); end;

% set the flux
if(ftbverbose); fprintf('dividing flux into %d points\n',nRivnodes); end;
river_flux = zeros(nRivnodes,nTimes);
for i=1:nTimes
  river_flux(1:nRivnodes,i) = flux(i)/real(nRivnodes);
end;

% set temperature and salt
for i=1:nTimes
	river_salt(1:nRivnodes,i) = salt(i);
	river_temp(1:nRivnodes,i) = temp(i);
end;

% set some kind of sediment
% coarse_sand = 15*ones(nTimes,nRivnodes);
% medium_sand = 45*ones(nTimes,nRivnodes);
% fine_sand   = 30*ones(nTimes,nRivnodes);


%--------------------------------------------------------------
% dump to netcdf file
%--------------------------------------------------------------

% open boundary forcing
nc = netcdf.create(RiverFile, 'clobber');       

% nc.type = 'FVCOM RIVER FORCING FILE' ;
% nc.title = RiverInfo1;   
% nc.info =  RiverInfo2; 
% nc.history = 'FILE CREATED using write_river_file.m' ;

% define global attributes
netcdf.putAtt(nc,netcdf.getConstant('NC_GLOBAL'),'type', 'FVCOM RIVER FORCING FILE')
netcdf.putAtt(nc,netcdf.getConstant('NC_GLOBAL'),'title', RiverInfo1)
netcdf.putAtt(nc,netcdf.getConstant('NC_GLOBAL'),'info', RiverInfo2)
netcdf.putAtt(nc,netcdf.getConstant('NC_GLOBAL'),'history', 'FILE CREATED using write_river_file.m')

% dimensions
% nc('rivers') = nRivnodes; 
% nc('namelen') = 26; 
% nc('time') = 0; 
river_dimid        = netcdf.defDim(nc,'rivers',nRivnodes);  % open boundary node number
time_dimid         = netcdf.defDim(nc,'time',netcdf.getConstant('NC_UNLIMITED'));
date_str_len_dimid = netcdf.defDim(nc,'namelen',26);

% variables
% define variables and attributes
names_varid=netcdf.defVar(nc,'river_names','NC_CHAR',[date_str_len_dimid, river_dimid]);
% netcdf.putAtt(nc,Times_varid,'time_zone','UTC');

% time
time_varid=netcdf.defVar(nc,'time','NC_FLOAT',time_dimid);
netcdf.putAtt(nc,time_varid,'long_name','time');
netcdf.putAtt(nc,time_varid,'units','days since 1858-11-17 00:00:00');
netcdf.putAtt(nc,time_varid,'format','modified julian day (MJD)');
netcdf.putAtt(nc,time_varid,'time_zone','UTC');

% Itime
itime_varid=netcdf.defVar(nc,'Itime','NC_INT',time_dimid);
netcdf.putAtt(nc,itime_varid,'units','days since 1858-11-17 00:00:00');
netcdf.putAtt(nc,itime_varid,'format','modified julian day (MJD)');
netcdf.putAtt(nc,itime_varid,'time_zone','UTC');

% Itime2
itime2_varid=netcdf.defVar(nc,'Itime2','NC_INT',time_dimid);
netcdf.putAtt(nc,itime2_varid,'units','msec since 00:00:00');
netcdf.putAtt(nc,itime2_varid,'time_zone','UTC');

% river_flux
flux_varid=netcdf.defVar(nc,'river_flux','NC_FLOAT',[river_dimid, time_dimid]);
netcdf.putAtt(nc,flux_varid,'long_name','Open Boundary Elevation');
netcdf.putAtt(nc,flux_varid,'units','m^3s^-1');

% river_temp
temp_varid=netcdf.defVar(nc,'river_temp','NC_FLOAT',[river_dimid, time_dimid]);
netcdf.putAtt(nc,temp_varid,'long_name','river runoff temperature');
netcdf.putAtt(nc,temp_varid,'units','Celsius');

% river_salt
salt_varid=netcdf.defVar(nc,'river_salt','NC_FLOAT',[river_dimid, time_dimid]);
netcdf.putAtt(nc,salt_varid,'long_name','river runoff salinity');
netcdf.putAtt(nc,salt_varid,'units','PSU');

% end definitions
netcdf.endDef(nc);
% nc{'river_names'} = ncchar('rivers', 'namelen');
% 
% nc{'river_flux'} = ncfloat('time','rivers');
% nc{'river_flux'}.long_name = 'river runoff volume flux'; 
% nc{'river_flux'}.units     = 'm^3s^-1';  
% 
% nc{'river_temp'} = ncfloat('time','rivers');
% nc{'river_temp'}.long_name = 'river runoff temperature'; 
% nc{'river_temp'}.units     = 'Celsius';  
% 
% nc{'river_salt'} = ncfloat('time','rivers');
% nc{'river_salt'}.long_name = 'river runoff salinity'; 
% nc{'river_salt'}.units     = 'PSU';  

% river names (must be 26 character strings)
nStringOut = char();
for i=0:nRivnodes-1
  fname = [RiverName int2str(i)];
  temp  = '                          ';
  temp(1:length(fname)) = fname;
  nStringOut = [nStringOut, temp];
%   nc{'river_names'}(i,:)   = temp;
end;
netcdf.putVar(nc, names_varid, nStringOut); 
% % write data
% for i=0:nTimes-1
%   nc{'river_flux'}(i,1:nRivnodes) = river_flux(i,1:nRivnodes); 
%   nc{'river_temp'}(i,1:nRivnodes) = river_temp(i,1:nRivnodes); 
%   nc{'river_salt'}(i,1:nRivnodes) = river_salt(i,1:nRivnodes); 
%   nc{'coarse_sand'}(i,1:nRivnodes) = coarse_sand(i,1:nRivnodes); 
%   nc{'medium_sand'}(i,1:nRivnodes) = medium_sand(i,1:nRivnodes); 
%   nc{'fine_sand'}(i,1:nRivnodes) = fine_sand(i,1:nRivnodes); 
% end;

netcdf.putVar(nc,time_varid,0,nTimes,time);
netcdf.putVar(nc,itime_varid,floor(time));
netcdf.putVar(nc,itime2_varid,0,nTimes,mod(time,1)*24*3600*1000);
% the variable with NC_UNLIMITED dimension should put last !!
netcdf.putVar(nc,flux_varid,river_flux)
netcdf.putVar(nc,temp_varid,river_temp)
netcdf.putVar(nc,salt_varid,river_salt)

netcdf.close(nc); 


if(ftbverbose);
  fprintf(['end   : ' subname '\n'])
end;

