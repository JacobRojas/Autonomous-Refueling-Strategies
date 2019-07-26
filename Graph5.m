close all
clear all

%Switch the comments to switch between stopping point methods
%stoppingEq =  @(x) ceil(x/exp(1));
stoppingEq =  @(x) round(sqrt(x));
%stoppingEq =  @(x) 0.7 * round(sqrt(x));

alpha = 0.875;
beta = 0.75;
startSecretary = 0.6;
startCritical = 0.8;

%Number of real highways you have
numSim = 151;

successes = 0;
total = 0;

rates(1:length(startSecretary), 1:length(startCritical), 1:numSim) = 10;
stops(1:length(startSecretary), 1:length(startCritical), 1:numSim) = 10;
for simNum = 1:numSim
        highway = reallife(['Trip' mat2str(simNum) '.csv']);
        %highway = construct(0.2, 1000);
        
        sorted = sort(highway(highway > 0));
        goal = sorted(round(length(sorted) * 0.2));
        
        for i = 1:length(startSecretary)
            for j = 1:length(startCritical)
                [rates(i, j, simNum), stops(i, j, simNum)] ...
                    = SGAS5(highway, stoppingEq, alpha, beta,...
                    startSecretary(i), startCritical(j));
                if(rates(i, j, simNum) <= goal && rates(i, j, simNum) > 0)
                    successes = successes + 1;
                    %Graph success rate instead of gas rate
                    rates(i, j, simNum) = 1;
                else
                    rates(i, j, simNum) = 0;
                end
                total = total + 1;
            end
        end
end

display(successes / total)

avgRate(1:length(startSecretary), 1:length(startCritical)) = 100;
avgStop(1:length(startSecretary), 1:length(startCritical)) = 100;
avgRunOutOfGas(1:length(startSecretary), 1:length(startCritical)) = 100;
for i = 1:length(startSecretary)
    for j = 1:length(startCritical)
        avgRate(i, j) = sum(rates(i, j, rates(i, j, : ) >= 0))...
            / length(rates(i, j, rates(i, j, : ) >= 0));
        avgStop(i, j) = sum(stops(i, j, stops(i, j, : ) > 0))...
            / length(stops(i, j, stops(i, j, : ) > 0));
        avgRunOutOfGas(i, j) = -sum(rates(i, j, rates(i, j, : ) < 0))...
            / length(rates(i, j, : ));
    end
end

axisColor = 'black';

subplot(2, 3, 1);
stem(startSecretary, mean(avgRate, 2), 'Color', [1 0 0]);
ylim([(min(mean(avgRate, 1))-0.05) (max(mean(avgRate, 2))+0.05)]);
%xticks(alpha);
ylabel("Avg. Gas Price");
xlabel("Start of Secretary");
%title(sprintf("\\color{" + axisColor + "}k = %d", kValues(i)));
set(gca,'color','none')
set(gca,'XColor',axisColor,'YColor',axisColor)

subplot(2, 3, 2);
stem(startSecretary, mean(avgRunOutOfGas, 2), 'Color', [1 0 0]);
ylim([0 max(mean(avgRunOutOfGas, 2))+0.05]);
%xticks(alpha);
ylabel("% ran out of gas");
xlabel("Start of Secretary");
%title(sprintf("\\color{" + axisColor + "}k = %d", kValues(i)));
set(gca,'color','none')
set(gca,'XColor',axisColor,'YColor',axisColor)

subplot(2, 3, 3);
stem(startSecretary, mean(avgStop, 2), 'Color', [0 0 1]);
ylim([0.5 max(mean(avgStop, 2))+0.1]);
%xticks(alpha);
ylabel("% highway before stop");
xlabel("Start of Secretary");
%title(sprintf("\\color{" + axisColor + "}k = %d", kValues(i)));
set(gca,'color','none')
set(gca,'XColor',axisColor,'YColor',axisColor)

subplot(2, 3, 4);
stem(startCritical, mean(avgRate, 1), 'Color', [1 0 0]);
ylim([(min(mean(avgRate, 1))-0.05) (max(mean(avgRate, 1))+0.05)]);
%xticks(alpha);
ylabel("Avg. Gas Price");
xlabel("Start of Critical");
%title(sprintf("\\color{" + axisColor + "}k = %d", kValues(i)));
set(gca,'color','none')
set(gca,'XColor',axisColor,'YColor',axisColor)

subplot(2, 3, 5);
stem(startCritical, mean(avgRunOutOfGas, 1), 'Color', [1 0 0]);
ylim([0 max(mean(avgRunOutOfGas, 2))+0.05]);
%xticks(alpha);
ylabel("% ran out of gas");
xlabel("Start of Critical");
%title(sprintf("\\color{" + axisColor + "}k = %d", kValues(i)));
set(gca,'color','none')
set(gca,'XColor',axisColor,'YColor',axisColor)

subplot(2, 3, 6);
stem(startCritical, mean(avgStop, 1), 'Color', [0 0 1]);
ylim([0.5 max(mean(avgStop, 2))+0.1]);
%xticks(alpha);
ylabel("% highway before stop");
xlabel("Start of Critical");
%title(sprintf("\\color{" + axisColor + "}k = %d", kValues(i)));
set(gca,'color','none')
set(gca,'XColor',axisColor,'YColor',axisColor)

%set(gcf, 'Position',  [0, 950, 1076, 884])
%addpath('altmany-export_fig-b1a7288');
%export_fig fig.png -transparent
