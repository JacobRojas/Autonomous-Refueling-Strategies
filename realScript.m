stoppingEq =  @(x) round(sqrt(x));

alpha = 0.875;
beta = 0.75;
startSecretary = 0.5;
startCritical = 0.8;
intervals = 10;

delete realStats.csv
fileID = fopen('realStats.csv', 'a');

%Number of real highways you have
numSim = 151;

for simNum = 1:numSim
        highway = reallife("Trip" + simNum + ".csv");
        SGAS5_Stats(highway, stoppingEq, alpha, beta,...
            startSecretary, startCritical, intervals, fileID);
end
fclose(fileID);
disp('done');