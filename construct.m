function [highway] = construct(gasDensity, hwLength)
% SGAS Generates a highway and selects the lowest priced gas station, out
% of k stations, after passing a k/e stations.
% returns 1 if the station selected is the lowest of k, returns 0 if the 
% selected station is not the lowest.

highway = zeros(1, hwLength);

% Generating a highway by generating a gas station at each array location
% with probability `gasDensity`
i = 1;
while i <= length(highway)
    if ((1 + 99 * rand()) <= (100 * gasDensity))
        highway(i) = round((2 + 2*rand()) * 100) / 100;
    end  
    i = i + 1;
end
end