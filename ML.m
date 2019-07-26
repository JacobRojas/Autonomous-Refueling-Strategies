function [rate, stop] = ML(highway, stoppingEq, ...
    alpha, beta, percentCalc, percentSecretary)
%Run SGAS5 with the machine learning / data mining estimator for k
segments = 10;

%Model with Loss=80.374626 TestLoss=44.139317 Error=71.78995685604697
%Stats from alpha=0.875 beta=0.75 startSecretary=0.6 startCritical=0.85 intervals=10
%NumSegments = 10
%A = [1.59040   1.92435  -0.80867  -0.16671   1.04729  -0.63408   0.57891   0.47217   2.53032   1.66596   0.38587  -0.92485];
%b = 12.219927;

%Model with  Loss=71.03162 Test=43.095203 Error=64.93993026180149
%Stats from alpha=0.875 beta=0.75 startSecretary=0.55 startCritical=0.8 intervals=10
A = [1.9026456e+00  7.3775005e-01  1.2414066e-06 -2.0269197e-01  5.6631085e-02  4.5237908e-01 -6.7727196e-05  9.0136755e-01  1.2495881e+00  3.5226269e+00  4.8628077e-01 -1.2678128e+00]
b = 12.347133


len = length(highway);
stopCalc = floor(len * percentCalc);
stopSecretary = floor(len * percentSecretary);
%Finding the length of each segment 
segmentCalc = floor(stopCalc / segments);
intervalStations = [];
intervalStationCount = 0;

gasStations = 0;
lastStation = 0;
dev = 0;
est = 0;
%Calculate density for predicting k
for position = 1:stopCalc
    if highway(position) ~= 0
          gasStations = gasStations + 1;
          intervalStationCount = intervalStationCount + 1;
          if(gasStations == 1)
              est = position;
          else
              est = alpha*est + (1-alpha)*(position - lastStation);
              dev = beta*dev + (1-beta)*abs(est - (position - lastStation));
          end
          lastStation = position;
    end
    if (mod(position,segmentCalc) == 0 && length(intervalStations) < segments ...
            || (position == stopCalc && length(intervalStations) < segments))
        intervalStations = [intervalStations intervalStationCount];
        intervalStationCount = 0;
    end
    if (position == stopCalc && length(intervalStations) >= segments)
        intervalStations(segments)= intervalStations(segments) + ...
                                     intervalStationCount;
    end
end

x = [intervalStations len dev];
k = A * x' + b;

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
end
