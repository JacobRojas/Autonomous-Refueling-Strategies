function [rate, stop] = ML(highway, stoppingEq, ...
    alpha, beta, percentCalc, percentSecretary)
%Run SGAS5 with the machine learning / data mining estimator for k
segments = 10;

if(percentCalc == 0.4)
    %alpha=0.875 beta=0.75 startSecretary=0.4 startCritical=0.8 intervals=10
    %Loss=165.8452 Test=185.04175 Error=183.49292744979036
    A = [1.950548   -0.6502751   0.21840912  1.4390206   1.773932    0.5589374   0.02463973 -1.3658805   1.8166544   3.2881432   1.6292295  -0.88117015];
    b = 22.120928;
    norm = [3.238410596	2.516556291	2.112582781	2.112582781	2.251655629	2.092715232	1.748344371	2.072847682	1.887417219	2.370860927	381.5231788	7.826320333;
            2.983752915	2.809161926	2.373585323	2.293594112	2.224765285	2.307526795	1.800809237	2.391929034	2.177285914	2.488951303	52.19384822	5.818226189];
elseif(percentCalc == 0.45)
    %alpha=0.875 beta=0.75 startSecretary=0.45 startCritical=0.8 intervals=10
    %Loss=110.256905 Test=243.48067 Error=165.03808562340257
    A = [0.60070807  1.4686313   2.5563564  -1.845549    0.13999034  0.53286827 -1.0067308  -0.25982526  0.5849283   3.915974    2.4631913  -0.7913226];
    b = 19.947886;
    norm = [3.562913907	2.735099338	2.377483444	2.410596026	2.470198675	2.158940397	2.21192053	2.105960265	2.145695364	2.927152318	381.5231788	8.259882132;
            3.295605476	3.034692707	2.542286954	2.683956093	2.365890803	2.163616464	2.573219181	2.254336023	2.350595247	2.905395757	52.19384822	6.589282898];
elseif(percentCalc == 0.5 )
    %alpha=0.875 beta=0.75 startSecretary=0.5 startCritical=0.8 intervals=10
    %Loss=109.74647 Test=73.68899 Error=94.59590984537174
    A = [-0.02853139 1.3586614  1.6684214  0.9273164  0.08528136 0.2047004  0.982986  -0.48114124 -0.1706203  3.1722786  0.944374  -2.5146515];
    b = 17.409117; 
    norm = [3.847682119	3.112582781	2.569536424	2.794701987	2.556291391	2.350993377	2.430463576	2.317880795	2.57615894	3.370860927	381.5231788	8.101101393;
            3.564170487	3.315706152	2.738636969	2.747891024	2.639787268	2.474398716	2.379103287	2.628994386	2.711548355	3.114730366	52.19384822	6.298249269];
elseif(percentCalc < 0.56 && percentCalc > 0.54)
    %alpha=0.875 beta=0.75 startSecretary=0.55 startCritical=0.8 intervals=10
    %Loss=73.2133 Test=83.99196 Error=60.79113334495156
    A = [1.1898959  0.2055698  0.75941604 1.0251251 -0.2615383 -0.40571907 0.9722487  1.0560969  0.5863801  2.2960877  0.4955168 -1.7743989];
    b = 14.61326;
    norm = [4.158940397	3.218543046	2.98013245	3.01986755	2.629139073	2.80794702	2.569536424	2.675496689	3.013245033	3.761589404	381.5231788	8.006133499;
            3.794896073	3.380126309	2.996598513	2.716542407	2.478214126	2.804080911	2.684548215	2.843822941	2.847189854	3.558480217	52.19384822	6.448275431];
elseif(percentCalc > 0.59 && percentCalc < 0.61)
    %alpha=0.875 beta=0.75 startSecretary=0.6 startCritical=0.8 intervals=10
    %Loss=57.545086 Test=70.08411 Error=63.45335646396127
    A = [0.84596866  1.0444715   1.089346    0.20929472  0.15196124  0.00671522  0.35720184  1.1267122   1.4312478   0.21743058  0.37441877 -1.0882144];
    b = 11.888933;
    norm = [4.503311258	3.430463576	3.231788079	3.284768212	2.794701987	2.98013245	2.794701987	3.238410596	3.410596026	4.231788079	381.5231788	7.886044656;
            4.023057166	3.51095416	3.215470331	3.08842459	2.826818897	2.709170103	2.894403521	3.153217636	3.374949922	3.965591521	52.19384822	6.358312312];
elseif(percentCalc == 0.65)
    %alpha=0.875 beta=0.75 startSecretary=0.65 startCritical=0.8 intervals=10
    %Loss=32.685402 Test=43.536526 Error=39.813562066211134
    A = [0.6335579   1.6669003   0.0299495   0.9600327  -0.8364118   0.24847163 -0.42053896  1.6494374   0.13099097  2.2241025   0.12897211 -0.7653106];
    b = 8.599519;
    norm = [4.814569536	3.622516556	3.682119205	3.298013245	3.125827815	3.086092715	3.284768212	3.523178808	4.026490066	4.450331126	381.5231788	7.935607097;
            4.194288137	3.755425802	3.289115101	3.161844824	3.12474988	3.162152004	3.35733522	3.393787338	3.831356626	3.960957362	52.19384822	6.473054953];
elseif(percentCalc > 0.69 && percentCalc < 0.71)
    %alpha=0.875 beta=0.75 startSecretary=0.7 startCritical=0.8 intervals=10
    %Loss=20.024832 Test=14.930893 Error=20.00089395934376
    A = [3.5563775e-05  1.3007342e+00  6.4841902e-01  3.6691308e-01 -9.5419556e-02 -6.3085884e-02 -2.6448639e-03 -3.0974352e-06  1.4080679e-01  1.9823351e+00  1.7886841e-01 -2.4034181e-01];
    b = 5.5334506;
    norm = [5.165562914	3.907284768	3.82781457	3.377483444	3.496688742	3.178807947	3.986754967	4.046357616	4.052980132	4.913907285	381.5231788	7.931541264;
            4.459342946	3.790076505	3.369988307	3.030383302	3.218434759	3.239518674	3.557127596	3.738694511	3.718042638	4.57229395	52.19384822	6.57098405];
elseif(percentCalc == 0.75)
    %alpha=0.875 beta=0.75 startSecretary=0.75 startCritical=0.8 intervals=10
    %Loss=5.063295 Test=4.231425 Error=3.550038423168775
    A = [-1.3317057e-01  1.2106877e-01  2.3745355e-05 -2.1664922e-01  1.1365748e-05  4.7024898e-02 -1.5285157e-01  2.1201725e-01 -7.8946520e-03  1.6174636e+00  5.0331199e-01 -7.3736273e-02];
    b = 2.7377255;
    norm = [5.483443709	4.052980132	4.132450331	3.635761589	3.735099338	3.715231788	4.112582781	4.496688742	4.437086093	4.993377483	381.5231788	7.640626113;
            4.70723458	3.889795332	3.683613256	3.305517496	3.352018271	3.542837814	3.909890103	4.155115999	4.075252399	4.693963057	52.19384822	6.248389332];
else
  fprintf("No matching model for %d\n", percentCalc)
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
x = (x - norm(1, :))./norm(2, :);
k = A * x' + b;

if(k <= 1)
    k = 1;
end

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