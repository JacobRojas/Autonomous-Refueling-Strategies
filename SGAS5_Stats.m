function [] = SGAS5_Stats(highway, stoppingEq, ...
    alpha, beta, percentCalc, percentSecretary, segments, fileID)
%Collects stats for machine learning.
%Format: n(0-percentCalc), highwayLength, EstDev, n(percentCalc-percentSecretary)

len = length(highway);
stopCalc = floor(len * percentCalc);
stopSecretary = floor(len * percentSecretary);
%Finding the length of each segment 
segmentCalc = floor(stopCalc / segments);
intervalStations = [];
intervalStationCount = 0;

%creating the fprintf format depending on how many segments the highway
%will be divided into
printFormat = '';
symbol = '%d, ';
for runs = 1:segments
    printFormat = strcat(printFormat, symbol);
end
printFormat = strcat(printFormat, '%d,%d,%d\n');

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

stationRates = [];

%Collecting number of gas stations in secretary section
for position = stopCalc:stopSecretary
    if highway(position) ~= 0
        stationRates = [stationRates highway(position)];
    end
end

fprintf(fileID, printFormat, intervalStations, len, dev, length(stationRates));

