%close all
clear all

%Switch the comments to switch between stopping point methods
%stoppingEq =  @(x) ceil(x/exp(1));
stoppingEq =  @(x) round(sqrt(x));
%stoppingEq =  @(x) 0.7 * round(sqrt(x));

alpha = 0.85;
beta = 0.75;
startSecretary = 0.6:0.05:0.8;
startCritical = 0.80:0.05:1;

%Number of real highways you have
numSim = 500;

rates(1:length(startSecretary), 1:length(startCritical), 1:numSim) = 10;
stops(1:length(startSecretary), 1:length(startCritical), 1:numSim) = 10;
for simNum = 1:numSim
        %highway = reallife("Trip" + simNum + ".csv");
        highway = construct(0.3, 1000);
        for i = 1:length(startSecretary)
            for j = 1:length(startCritical)
                [rates(i, j, simNum), stops(i, j, simNum)] ...
                    = SGAS5(highway, stoppingEq, alpha, beta,...
                    startSecretary(i), startCritical(j));

                stops(simNum) = stops(simNum) / length(highway);
            end
        end
end

avgRate(1:length(startSecretary), 1:length(startCritical)) = 100;
avgStop(1:length(startSecretary), 1:length(startCritical)) = 100;
avgRunOutOfGas(1:length(startSecretary), 1:length(startCritical)) = 100;
for i = 1:length(startSecretary)
    for j = 1:length(startCritical)
        avgRate(i, j) = sum(rates(i, j, rates(i, j, : ) > 0))...
            / length(rates(i, j, rates(i, j, : ) > 0));
        avgStop(i, j) = sum(stops(i, j, stops(i, j, : ) > 0))...
            / length(stops(i, j, stops(i, j, : ) > 0));
        avgRunOutOfGas(i, j) = -sum(rates(i, j, rates(i, j, : ) < 0))...
            / length(rates(i, j, : ));
    end
end



axisColor = 'black';

subplot(2, 3, 1);
stem(startSecretary, mean(avgRate, 2), 'Color', [1 0 0]);
%ylim([1.9 max([3 max(avgPrice(i, :)+0.2)])]);
%xticks(alpha);
ylabel("Avg. Gas Price");
xlabel("Start of Secretary");
%title(sprintf("\\color{" + axisColor + "}k = %d", kValues(i)));
set(gca,'color','none')
set(gca,'XColor',axisColor,'YColor',axisColor)

subplot(2, 3, 2);
stem(startSecretary, mean(avgRunOutOfGas, 2), 'Color', [1 0 0]);
%ylim([0 max(outOfGasRate(i, :))+0.1]);
%xticks(alpha);
ylabel("% ran out of gas");
xlabel("Start of Secretary");
%title(sprintf("\\color{" + axisColor + "}k = %d", kValues(i)));
set(gca,'color','none')
set(gca,'XColor',axisColor,'YColor',axisColor)

subplot(2, 3, 3);
stem(startSecretary, mean(avgStop, 2), 'Color', [0 0 1]);
%ylim([0 max(avgStop(i, :))+0.1]);
%xticks(alpha);
ylabel("% highway before stop");
xlabel("Start of Secretary");
title(sprintf("\\color{" + axisColor + "}k = %d", kValues(i)));
set(gca,'color','none')
set(gca,'XColor',axisColor,'YColor',axisColor)

subplot(2, 3, 4);
stem(startSecretary, mean(avgRate, 2), 'Color', [1 0 0]);
%ylim([1.9 max([3 max(avgPrice(i, :)+0.2)])]);
%xticks(alpha);
ylabel("Avg. Gas Price");
xlabel("Start of Secretary");
%title(sprintf("\\color{" + axisColor + "}k = %d", kValues(i)));
set(gca,'color','none')
set(gca,'XColor',axisColor,'YColor',axisColor)

subplot(2, 3, 5);
stem(startSecretary, mean(avgRunOutOfGas, 2), 'Color', [1 0 0]);
%ylim([0 max(outOfGasRate(i, :))+0.1]);
%xticks(alpha);
ylabel("% ran out of gas");
xlabel("Start of Secretary");
%title(sprintf("\\color{" + axisColor + "}k = %d", kValues(i)));
set(gca,'color','none')
set(gca,'XColor',axisColor,'YColor',axisColor)

subplot(2, 3, 6);
stem(startSecretary, mean(avgStop, 2), 'Color', [0 0 1]);
%ylim([0 max(avgStop(i, :))+0.1]);
%xticks(alpha);
ylabel("% highway before stop");
xlabel("Start of Secretary");
title(sprintf("\\color{" + axisColor + "}k = %d", kValues(i)));
set(gca,'color','none')
set(gca,'XColor',axisColor,'YColor',axisColor)

set(gcf, 'Position',  [0, 0, 2000, 700])
addpath('altmany-export_fig-b1a7288');
%export_fig fig.png -transparent
