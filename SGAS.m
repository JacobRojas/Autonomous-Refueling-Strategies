function [success] = SGAS(gasDensity, hwLength, k, d)
% SGAS Generates a highway and selects the lowest priced gas station, out
% of k stations, after passing a k/e stations.
% returns 1 if the station selected is the lowest of k, returns 0 if the 
% selected station is not the lowest.

highway = zeros(1, hwLength);
stationsToPass = ceil(k / exp(1));

% Generating a highway, if not enough stations are generated (<k) then the
% highway is rerandomized from scratch
i = d;
while 1
    while i <= length(highway)
        if ((1 + 99 * rand()) <= (100 * gasDensity))
            highway(i) = round(2 + 2*rand(), 2);
        end  
        i = i + d;
    end
    
    if length(highway(highway>0)) >= k
        break
    end
    i = d;
end
% Assuming Tau has been reached (the car is in search mode). Now stepping 
% through generated highway, passing k/e stations then stopping
% at the lowest priced (so far) gas station.
stationRates = double.empty();      % Vector of station rates the car has visited thus far
allStations = highway(highway>0);   % Vector of all station rates along entire highway
stationRatesTot = allStations(1:k); % Vector of first k station rates
i1 = d;

% Finding max val and index of a generated highway
% highwayMin = min(stationRatesTot);
% highwayMinInd = find(highway == highwayMin);

% Finding the stopping point along the highway based on CSP
while i1 <= length(highway)
    while length(stationRates) < stationsToPass(1)
        if highway(i1) ~= 0
            stationRates = [stationRates highway(i1)];
        end
        i1 = i1 + d;
    end
    
    if highway(i1) == stationRatesTot(k)
        stoppingPoint = i1;
        break
    end
    
    if highway(i1) <= min(stationRates) & highway(i1) ~= 0
        stoppingPoint = i1;
        break
    end
    
    i1 = i1 + d;
end

% Returning whether or not the stopping point is the lowest priced
% gas station among k stations.
stoppingRate = highway(stoppingPoint);
if stoppingRate == min(stationRatesTot)
    disp("Success!")
    success = 1;
    return
end

success = 0;

end

