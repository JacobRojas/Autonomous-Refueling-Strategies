function [rate, stop] = ML(highway, stoppingEq, ...
    alpha, beta, percentCalc, percentSecretary)
%Run SGAS5 with the machine learning / data mining estimator for k
segments = 10;

if(percentCalc == 0.4)
    %alpha=0.875 beta=0.75 startSecretary=0.4 startCritical=0.8 intervals=10
    %Loss=165.8452 Test=185.04175 Error=183.49292744979036
    A = [1.950548   -0.6502751   0.21840912  1.4390206   1.773932    0.5589374   0.02463973 -1.3658805   1.8166544   3.2881432   1.6292295  -0.88117015];
    b = 22.120928;
elseif(percentCalc == 0.45)
    %alpha=0.875 beta=0.75 startSecretary=0.45 startCritical=0.8 intervals=10
    %Loss=110.256905 Test=243.48067 Error=165.03808562340257
    A = [0.60070807  1.4686313   2.5563564  -1.845549    0.13999034  0.53286827 -1.0067308  -0.25982526  0.5849283   3.915974    2.4631913  -0.7913226];
    b = 19.947886;
elseif(percentCalc == 0.5 )
    %alpha=0.875 beta=0.75 startSecretary=0.5 startCritical=0.8 intervals=10
    %Loss=109.74647 Test=73.68899 Error=94.59590984537174
    A = [-0.02853139 1.3586614  1.6684214  0.9273164  0.08528136 0.2047004  0.982986  -0.48114124 -0.1706203  3.1722786  0.944374  -2.5146515];
    b = 17.409117; 
elseif(percentCalc == 0.55)
    %alpha=0.875 beta=0.75 startSecretary=0.55 startCritical=0.8 intervals=10
    %Loss=73.2133 Test=83.99196 Error=60.79113334495156
    A = [1.1898959  0.2055698  0.75941604 1.0251251 -0.2615383 -0.40571907 0.9722487  1.0560969  0.5863801  2.2960877  0.4955168 -1.7743989];
    b = 14.61326;
elseif(percentCalc == 0.6 )
    %alpha=0.875 beta=0.75 startSecretary=0.6 startCritical=0.8 intervals=10
    %Loss=57.545086 Test=70.08411 Error=63.45335646396127
    A = [0.84596866  1.0444715   1.089346    0.20929472  0.15196124  0.00671522  0.35720184  1.1267122   1.4312478   0.21743058  0.37441877 -1.0882144];
    b = 11.888933;
elseif(percentCalc == 0.65)
    %alpha=0.875 beta=0.75 startSecretary=0.65 startCritical=0.8 intervals=10
    %Loss=32.685402 Test=43.536526 Error=39.813562066211134
    A = [0.6335579   1.6669003   0.0299495   0.9600327  -0.8364118   0.24847163 -0.42053896  1.6494374   0.13099097  2.2241025   0.12897211 -0.7653106];
    b = 8.599519;
elseif(percentCalc == 0.7 )
    %alpha=0.875 beta=0.75 startSecretary=0.7 startCritical=0.8 intervals=10
    %Loss=20.024832 Test=14.930893 Error=20.00089395934376
    A = [3.5563775e-05  1.3007342e+00  6.4841902e-01  3.6691308e-01 -9.5419556e-02 -6.3085884e-02 -2.6448639e-03 -3.0974352e-06  1.4080679e-01  1.9823351e+00  1.7886841e-01 -2.4034181e-01];
    b = 5.5334506;
elseif(percentCalc == 0.75)
    %alpha=0.875 beta=0.75 startSecretary=0.75 startCritical=0.8 intervals=10
    %Loss=5.063295 Test=4.231425 Error=3.550038423168775
    A = [-1.3317057e-01  1.2106877e-01  2.3745355e-05 -2.1664922e-01  1.1365748e-05  4.7024898e-02 -1.5285157e-01  2.1201725e-01 -7.8946520e-03  1.6174636e+00  5.0331199e-01 -7.3736273e-02];
    b = 2.7377255;
else
  disp("No matching model")
  rate = -1;
  stop = -1;
  return
end

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

%Old Models

%Model with Loss=80.374 TestLoss=44.139 Error=71.789
%Stats from alpha=0.875 beta=0.75 startSecretary=0.6 startCritical=0.85 intervals=10
%NumSegments = 10
%A = [1.59040   1.92435  -0.80867  -0.16671   1.04729  -0.63408   0.57891   0.47217   2.53032   1.66596   0.38587  -0.92485];
%b = 12.219927;

%Model with  Loss=71.031 TestLoss=43.095 Error=64.939
%Stats from alpha=0.875 beta=0.75 startSecretary=0.55 startCritical=0.8 intervals=10
%A = [1.9026456e+00  7.3775005e-01  1.2414066e-06 -2.0269197e-01  5.6631085e-02  4.5237908e-01 -6.7727196e-05  9.0136755e-01  1.2495881e+00  3.5226269e+00  4.8628077e-01 -1.2678128e+00];
%b = 12.347133;