close all
clear all

kValues = [4 9 16 36];
densities = 0.1:0.1:0.5;
numDev = 2;

%Switch the comments to switch between stopping point methods
%stoppingEq =  @(x) ceil(x/exp(1));
stoppingEq =  @(x) round(sqrt(x));
%stoppingEq =  @(x) 0.7 * round(sqrt(x));

%Number of synthetic or real highways you want/have
numSim = 500;

%          k                 lam                sim#
rates(1:length(kValues),1:length(densities),1:numSim) = 10;
starts(1:length(kValues),1:length(densities),1:numSim) = 10;
stops(1:length(kValues),1:length(densities),1:numSim) = 10;
for simNum = 1:numSim
    for i = 1:length(densities)
        %You can contruct using synthetic data or real data
        % if you use real data, set numSim to the number of 'Trip's you
        % have
        highway = construct(densities(i), 1000);
        %highway = reallife("Trip" + simNum + ".csv");
        
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
        total = sum(starts(i, j, stops(i, j, :) >= 0)) / length(highway);
        avgStart(i, j) = total / length(starts(i, j, stops(i, j, :) >= 0));
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
    stem(densities, avgPrice(i, :), 'Color', [0 0 1]);
    ylim([1.9 max([3 max(avgPrice(i, :)+0.2)])]);
    xticks(densities);
    ylabel("Avg. Gas Price");
    xlabel("Gas Station Density");
    title(sprintf("k = %d", kValues(i)));
    set(gca,'color','none')
    
    subplot(length(kValues), 3, i*3-1);
    stem(densities, outOfGasRate(i, :), 'Color', [0 0 1]);
    ylim([0 max(outOfGasRate(i, :))+0.1]);
    xticks(densities);
    ylabel("% ran out of gas");
    xlabel("Gas Station Density");
    title(sprintf("k = %d", kValues(i)));
    set(gca,'color','none')
    
    subplot(length(kValues), 3, i*3);
    stem(densities, avgStart(i, :), 'Color', [1 0 0]);
    hold on
    stem(densities, avgStop(i, :), 'Color', [0 0 1]);
    ylim([0 max(avgStop(i, :))+0.1]);
    xticks(densities);
    ylabel("% highway before stop");
    xlabel("Gas Station Density");
    title(sprintf("k = %d", kValues(i)));
    set(gca,'color','none')
end
%set(gcf, 'Position',  [100, 100, 2000, 700])
%addpath('altmany-export_fig-b1a7288');
%export_fig fig.png -transparent
