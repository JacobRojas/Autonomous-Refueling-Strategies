close all
clear all

kValues = 2:1:16;
numDev = 2;

%Switch the comments to switch between stopping point methods
stoppingEq =  @(x) ceil(x/exp(1));
%stoppingEq =  @(x) round(sqrt(x));


rates(1:length(kValues)) = 10;
starts(1:length(kValues)) = 10;
stops(1:length(kValues)) = 10;

highway = reallife("SANMO_AUS.csv");
for k = 1:length(kValues)
    [rates(k), starts(k), stops(k)] = SGAS3(highway, kValues(k), stoppingEq, numDev, 0.75);
end

    subplot(2, 1, 1);
    stem(kValues, rates);
    ylim([1.9 max([3 max(rates)+0.2])]);
    xticks(kValues);
    ylabel("Avg. Gas Price");
    xlabel("k");
    
    
    subplot(2, 1, 2);
    stem(kValues, starts / length(highway));
    hold on
    stem(kValues, stops / length(highway));
    ylim([0 (max(stops)/length(highway) + 0.1)]);
    xticks(kValues);
    ylabel("% highway before stop");
    xlabel("k");
