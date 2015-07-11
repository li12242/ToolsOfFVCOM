function time = get_julian_time(startTimeStr, endTimeStr, interval)
% get modified julian time array
% 
% Input:
%   startTime   - start time, .e.g '2014-01-01 00:00:00'
%   endTime     - end time, .e.g '2014-04-01 00:00:00'
%   interval    - hours of time interval, .e.g  interval = 1/24
% Output:
%   time    - real time dates, size [1 x ntime]
%

timevec = datevec(startTimeStr);
startTime = FVCOM.Time.greg2mjulian...
    (timevec(1),timevec(2), timevec(3), timevec(4), timevec(5), timevec(6));

timevec = datevec(endTimeStr);
endTime = FVCOM.Time.greg2mjulian...
    (timevec(1),timevec(2), timevec(3), timevec(4), timevec(5), timevec(6));

% time = startTime:interval:endTime+interval;
ntime = ceil( (endTime - startTime)./interval );
time = linspace(startTime, endTime, ntime);
end