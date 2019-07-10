function [rate, start, stop] = SGAS4(highway, k, stoppingEq, numDev, alpha, beta)

%TESTING - we may not want there to be less than k gas stations
if length(highway(highway>0)) < k
    fprintf("Not k gas stations\n")
end

% Keep driving until the remaining distance to empty is less than avg
% distance between gas stations times k
gasStations = 0;
distance = 1;
lastStation = 0;
dev = 0;
est = 0;
while (gasStations == 0 && length(highway) > k * distance) || ...
      (gasStations ~= 0 && length(highway) - distance > (est + numDev * dev) * k && distance < length(highway))
      if highway(distance) ~= 0
          gasStations = gasStations + 1;
          if(gasStations == 1)
              est = distance;
          else
              est = alpha*est + (1-alpha)*(distance - lastStation);
              dev = beta*dev + (1-beta) * abs(est - (distance - lastStation));
          end
          lastStation = distance;
      end
      distance = distance + 1;
end
startingPoint = distance;

% Tau has been reached (the car is in search mode). Now stepping 
% through generated highway, passing k/e stations then stopping
% at the lowest priced (so far) gas station.
stationsToPass = stoppingEq(k);  % The number of stations to observe before being ready to stop
stationRates = [];      % Vector of station rates the car has visited thus far
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

        if highway(i1) <= min(stationRates) && length(stationRates) >= stationsToPass
            stoppingPoint = i1;
            break
        end
    end
    
    i1 = i1 + 1;
end

% You might have run out of gas
if i1 > length(highway)
    rate = -1;
    start = startingPoint;
    stop = -1;
    return
end

% Returning the rate payed.
rate = highway(stoppingPoint);
start = startingPoint;
stop = stoppingPoint;
return

end
