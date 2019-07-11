close all
clear all

%Switch the comments to switch between stopping point methods
%stoppingEq =  @(x) ceil(x/exp(1));
stoppingEq =  @(x) round(sqrt(x));
%stoppingEq =  @(x) 0.7 * round(sqrt(x));

alpha = 0.85;
beta = 0.75;
startSecretary = 0.6;
startCritical = 0.9;

%Number of real highways you have
numSim = 30;

rates(1:numSim) = 10;
stops(1:numSim) = 10;
for simNum = 1:numSim
        highway = reallife("Trip" + simNum + ".csv");
        
        [rates(simNum), stops(simNum)] ...
            = SGAS5(highway, stoppingEq, alpha, beta,   startSecretary,   startCritical);
        
        stops(simNum) = stops(simNum) / length(highway);
end


avgRate = sum(rates(rates > 0)) / length(rates(rates > 0))
avgStop = sum(stops(stops > 0)) / length(stops(stops > 0))
avgRunOutOfGas = -sum(rates(rates < 0)) / length(rates)


% avgPrice(1:length(kValues), 1:length(alpha)) = 50;
% for i = 1:length(kValues)
%     for j = 1:length(alpha)
%         total = sum(rates(i, j, rates(i, j, :) >= 0));
%         avgPrice(i, j) = total / length(rates(i, j, rates(i, j, :) >= 0));
%     end
% end
% 
% outOfGasRate(1:length(kValues), 1:length(alpha)) = 50;
% for i = 1:length(kValues)
%     for j = 1:length(alpha)
%         total = sum(rates(i, j, rates(i, j, :) < 0));
%         outOfGasRate(i, j) = -1 .* total / length(rates(i, j,:));
%     end
% end
% 
% avgStart(1:length(kValues), 1:length(alpha)) = 50;
% for i = 1:length(kValues)
%     for j = 1:length(alpha)
%         total = sum(starts(i, j, stops(i, j, :) >= 0)) / length(highway);
%         avgStart(i, j) = total / length(starts(i, j, stops(i, j, :) >= 0));
%     end
% end
% avgStop(1:length(kValues), 1:length(alpha)) = 50;
% for i = 1:length(kValues)
%     for j = 1:length(alpha)
%         total = sum(stops(i, j, stops(i, j, :) >= 0)) / length(highway);
%         avgStop(i, j) = total / length(stops(i, j, stops(i, j, :) >= 0));
%     end
% end
% 
% axisColor = 'black';
% 
% for i = 1:length(kValues)
%     subplot(length(kValues), 3, i*3-2);
%     stem(alpha, avgPrice(i, :), 'Color', [1 0 0]);
%     ylim([1.9 max([3 max(avgPrice(i, :)+0.2)])]);
%     %xticks(alpha);
%     ylabel("Avg. Gas Price");
%     xlabel("alpha");
%     title(sprintf("\\color{" + axisColor + "}k = %d", kValues(i)));
%     set(gca,'color','none')
%     set(gca,'XColor',axisColor,'YColor',axisColor)
%     
%     subplot(length(kValues), 3, i*3-1);
%     stem(alpha, outOfGasRate(i, :), 'Color', [1 0 0]);
%     ylim([0 max(outOfGasRate(i, :))+0.1]);
%     %xticks(alpha);
%     ylabel("% ran out of gas");
%     xlabel("alpha");
%     title(sprintf("\\color{" + axisColor + "}k = %d", kValues(i)));
%     set(gca,'color','none')
%     set(gca,'XColor',axisColor,'YColor',axisColor)
%     
%     subplot(length(kValues), 3, i*3);
%     stem(alpha, avgStart(i, :), 'Color', [0 0 1]);
%     hold on
%     stem(alpha, avgStop(i, :), 'Color', [1 0 0]);
%     ylim([0 max(avgStop(i, :))+0.1]);
%     %xticks(alpha);
%     ylabel("% highway before stop");
%     xlabel("alpha");
%     title(sprintf("\\color{" + axisColor + "}k = %d", kValues(i)));
%     set(gca,'color','none')
%     set(gca,'XColor',axisColor,'YColor',axisColor)
% end
% set(gcf, 'Position',  [100, 100, 2000, 700])
% addpath('altmany-export_fig-b1a7288');
% %export_fig fig.png -transparent
