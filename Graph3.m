close all
clear all

kValues = [4 9 16 36];
densities = 0.1:0.1:0.5;
numDev = 2;

%Switch the comments to switch between stopping point methods
stoppingEq =  @(x) ceil(x/exp(1));
%stoppingEq =  @(x) round(sqrt(x));

numSim = 500;
%          k                 lam                sim#
rates(1:length(kValues),1:length(densities),1:numSim) = 10;
starts(1:length(kValues),1:length(densities),1:numSim) = 10;
stops(1:length(kValues),1:length(densities),1:numSim) = 10;
for simNum = 1:numSim
    for i = 1:length(densities)
        highway = construct(densities(i), 1000);
        for k = 1:length(kValues)
            %fprintf("k: %d, density: %d", kValues(k), densities(i));
            [rates(k,i, simNum), starts(k, i, simNum), stops(k,i, simNum)] = SGAS3(highway, kValues(k), stoppingEq, numDev, 0.75);
        end
    end
end

avgPrice(1:length(kValues), 1:length(densities)) = 50;
for i = 1:length(kValues)
    for j = 1:length(densities)
        total = sum(rates(i, j, rates(i, j, :) >= 0));
        avgPrice(i, j) = total / length(rates(i, j, rates(i, j, :) >= 0));
    end
end

outOfGasRate(1:length(kValues), 1:length(densities)) = 50;
for i = 1:length(kValues)
    for j = 1:length(densities)
        total = sum(rates(i, j, rates(i, j, :) < 0));
        outOfGasRate(i, j) = -1 .* total / length(rates(i, j,:));
    end
end

avgStart(1:length(kValues), 1:length(densities)) = 50;
for i = 1:length(kValues)
    for j = 1:length(densities)
        total = sum(starts(i, j, starts(i, j, :) >= 0)) / length(highway);
        avgStart(i, j) = total / length(starts(i, j, starts(i, j, :) >= 0));
    end
end
avgStop(1:length(kValues), 1:length(densities)) = 50;
for i = 1:length(kValues)
    for j = 1:length(densities)
        total = sum(stops(i, j, stops(i, j, :) >= 0)) / length(highway);
        avgStop(i, j) = total / length(stops(i, j, stops(i, j, :) >= 0));
    end
end

for i = 1:length(kValues)
    subplot(length(kValues), 3, i*3-2);
    stem(densities, avgPrice(i, :));
    ylim([1.9 max([3 max(avgPrice(i, :)+0.2)])]);
    xticks(densities);
    ylabel("Avg. Gas Price");
    xlabel("Gas Station Density");
    title(sprintf("k = %d", kValues(i)));
    
    subplot(length(kValues), 3, i*3-1);
    stem(densities, outOfGasRate(i, :));
    ylim([0 max(outOfGasRate(i, :))+0.1]);
    xticks(densities);
    ylabel("% ran out of gas");
    xlabel("Gas Station Density");
    title(sprintf("k = %d", kValues(i)));
    
    subplot(length(kValues), 3, i*3);
    stem(densities, avgStart(i, :));
    hold on
    stem(densities, avgStop(i, :));
    ylim([0 max(avgStop(i, :))+0.1]);
    xticks(densities);
    ylabel("% highway before stop");
    xlabel("Gas Station Density");
    title(sprintf("k = %d", kValues(i)));
end
