function ele = functional_elev(Mobj, time)
% Setup surface elevation tides through function
timePeriod = 12./24; % days
amplitude = 1; % meters

level = amplitude*sin(time/timePeriod*2*pi);
ele = ones(Mobj.nObcNodes, 1)*level;
end