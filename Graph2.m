close all
clear all

kValues = [4 9 16 36];
densities = 0.1:0.1:0.5;

%Switch the comments to switch between stopping point methods
stoppingEq =  @(x) ceil(x/exp(1));
%stoppingEq =  @(x) round(sqrt(x));

numSim = 500;
%          k                 lam                sim#
results(1:length(kValues),1:length(densities),1:numSim) = 10;
for simNum = 1:numSim
    for i = 1:length(densities)
        highway = construct(densities(i), 1000);
        for k = 1:length(kValues)
            %fprintf("k: %d, density: %d", kValues(k), densities(i));
            results(k,i, simNum) = SGAS2(highway, kValues(k), stoppingEq);
        end
    end
end

avgPrice(1:length(kValues), 1:length(densities)) = 5;
for i = 1:length(kValues)
    for j = 1:length(densities)
        total = sum(results(i, j, results(i, j, :) >= 0));
        avgPrice(i, j) = total / length(results(i, j, results(i, j, :) >= 0));
    end
end

outOfGasRate(1:length(kValues), 1:length(densities)) = 5;
for i = 1:length(kValues)
    for j = 1:length(densities)
        total = sum(results(i, j, results(i, j, :) < 0));
        outOfGasRate(i, j) = -1 .* total / length(results(i, j,:));
    end
end

for i = 1:length(kValues)
    subplot(length(kValues), 2, i*2-1);
    stem(densities, avgPrice(i, :));
    ylim([1.9 max([3 max(avgPrice(i, :)+0.2)])]);
    xticks(densities);
    ylabel("Average Gas Price");
    xlabel("Gas Station Density");
    title(sprintf("k = %d", kValues(i)));
    
    subplot(length(kValues), 2, i*2);
    stem(densities, outOfGasRate(i, :));
    ylim([0 max(outOfGasRate(i, :))+0.1]);
    xticks(densities);
    ylabel("% ran out of gas");
    xlabel("Gas Station Density");
    title(sprintf("k = %d", kValues(i)));
end