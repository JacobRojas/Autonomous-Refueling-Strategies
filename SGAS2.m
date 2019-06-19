function [rate] = SGAS2(highway, k, stoppingEq)

%TESTING - we may not want there to be less than k gas stations
if length(highway(highway>0)) < k
    fprintf("Not k gas stations\n")
end

% Keep driving until the remaining distance to empty is less than avg
% distance between gas stations times k
gasStations = 0;
distance = 1;
while (gasStations == 0 && distance < length(highway)/2) || ...
      (length(highway) - distance > distance * k / gasStations && distance < length(highway))
      if highway(distance) ~= 0
          gasStations = gasStations + 1;
      end
      distance = distance + 1;
end
startingPoint = distance;

% Tau has been reached (the car is in search mode). Now stepping 
% through generated highway, passing k/e stations then stopping
% at the lowest priced (so far) gas station.
stationsToPass = stoppingEq(k);  % The number of stations to observe before being ready to stop
stationRates = double.empty();      % Vector of station rates the car has visited thus far
i1 = startingPoint;

% Finding max val and index of a generated highway
% highwayMin = min(stationRatesTot);
% highwayMinInd = find(highway == highwayMin);

% Finding the stopping point along the highway based on CSP
while i1 <= length(highway)
    if highway(i1) ~= 0
        stationRates = [stationRates highway(i1)];
    
        if length(stationRates) == k
            stoppingPoint = i1;
            break
        end

        if highway(i1) <= min(stationRates) && length(stationRates) > stationsToPass
            stoppingPoint = i1;
            break
        end
    end
    
    i1 = i1 + 1;
end

% You might have run out of gas
if i1 > length(highway)
    rate = -1;
    return
end

% Returning the rate payed.
rate = highway(stoppingPoint);
return

end
