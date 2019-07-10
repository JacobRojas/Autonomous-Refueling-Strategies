function [rate, position] = SGAS5(highway, stoppingEq, ...
    alpha, beta, percentCalc, percentSecretary)

len = length(highway);
stopCalc = floor(len * percentCalc);
stopSecretary = floor(len * percentSecretary);

position = 0;


gasStations = 0;
lastStation = 0;
dev = 0;
est = 0;
%Calculate density for predicting k
for position = (position+1):stopCalc
    if highway(position) ~= 0
          gasStations = gasStations + 1;
          if(gasStations == 1)
              est = position;
          else
              est = alpha*est + (1-alpha)*(position - lastStation);
              dev = beta*dev + (1-beta)*abs(est - (position - lastStation));
          end
          lastStation = position;
    end
end

k = round((stopSecretary - position)/est);
stationsToPass = stoppingEq(k);
stationRates = [];

%Run the secretary problem
for position = (position+1):stopSecretary
    if highway(position) ~= 0
        stationRates = [stationRates highway(position)];
    
        if length(stationRates) == k
            rate = highway(position);
            return
        end

        if highway(position) <= min(stationRates) && ...
                length(stationRates) >= stationsToPass
            rate = highway(position);
            return
        end
    end
end

%In critical section. Stop at first available station
for position = (position+1):len
    if highway(position) ~= 0
        rate = highway(position);
        return
    end
end

position = -1;
rate = -1;
return