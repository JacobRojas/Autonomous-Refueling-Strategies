
stoppingEq =  @(x) round(sqrt(x));

alpha = 0.875;
beta = 0.75;
startSecretary = 0.6;
startCritical = 0.85;

%Number of real highways you have
numSim = 75;

for simNum = 1:numSim
        highway = reallife("Trip" + simNum + ".csv");
        SGAS5_Stats(highway, stoppingEq, alpha, beta,...
            startSecretary, startCritical);
end