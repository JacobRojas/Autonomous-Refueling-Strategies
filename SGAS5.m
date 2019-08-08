function [rate, stop] = SGAS5(highway, stoppingEq, ...
    alpha, beta, percentCalc, percentSecretary)
%New solution separtes range of car into 3 sections: Density Observation,
%Secretary Solution, and Critical. 1) Density Observation: Uses TCP RTO
%calculations to estimate how many k gast stations will be seen in the
%Secretary section of the car's range. 2) Secretary Solution: Runs the
%Secretary Solution assuming k gas stations 3) Critical: Stops at the first
%available Gas Station.

len = length(highway);
stopCalc = floor(len * percentCalc);
stopSecretary = floor(len * percentSecretary);


gasStations = 0;
lastStation = 0;
dev = 0;
est = 0;
%Calculate density for predicting k
for position = 1:stopCalc
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

if(stopCalc > 0); k = round((gasStations*(stopSecretary - stopCalc))/(stopCalc)); else; k = 1; end

%Uncomment these two lines for perfect prediction
%temp = highway(stopCalc:stopSecretary);
%k = length(temp(temp > 0));

stationsToPass = stoppingEq(k);
stationRates = [];

%Run the secretary problem
for position = stopCalc:stopSecretary
    if highway(position) ~= 0
        stationRates = [stationRates highway(position)];
    
        %Program seems to perform better if we don't stop at last one
        %Instead it keeps going until critical section is reached
%         if length(stationRates) == k
%             stop = position / len;
%             rate = highway(position);
%             return
%         end

        if highway(position) <= min(stationRates) && ...
                length(stationRates) >= stationsToPass
            stop = position / len;
            rate = highway(position);
            return
        end
    end
end

%In critical section. Stop at first available station
for position = stopSecretary:len
    if highway(position) ~= 0
        stop = position / len;
        rate = highway(position);
        return
    end
end

stop = -1;
rate = -1;
return