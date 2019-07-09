clear all
close all

kValues = [4 9 16];
stoppingEq =  @(x) ceil(x/exp(1));
%stoppingEq =  @(x) ceil(sqrt(x));

simNum = 1;
successRatio(1:3,1:4,1:100) = 4;
while simNum <= 100 
    for i = 1:4
        highway = construct(i/25, 1000);
        successRatio(1,i, simNum) = SGAS(highway, kValues(1), stoppingEq);
        successRatio(2,i, simNum) = SGAS(highway, kValues(2), stoppingEq);
        successRatio(3,i, simNum) = SGAS(highway, kValues(3), stoppingEq);
    end
    simNum = simNum + 1;
end

results(1:3, 1:4) = 4;
for i = 1:3
    for j = 1:4
        results(i, j) = sum(successRatio(i, j, :)) / length(successRatio(i, j, :));
    end
end

for i = 1:3
    subplot(3, 1, i);
    stem((1:4) ./ 25, results(i, :), 'Color',[1 0 0]);
    ylim([0 0.5]);
    xlim([0.03 0.17])
    xticks((0:1:4) ./ 25);
    ylabel("Success reatio");
    xlabel("Density");
    title(sprintf("\\color{black}k = %d", kValues(i)));
    set(gca,'color','none')
    set(gca,'XColor','black','YColor','black')
end
addpath('altmany-export_fig-b1a7288');
export_fig fig.png -transparent
