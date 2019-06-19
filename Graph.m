clear all
close all

kValues = [5 6 8]

simNum = 1;
successRatio(1:3,1:4,1:100) = 4;
while simNum <= 100 
    for i = 1:4
        highway = construct(i/25, 1000);
        successRatio(1,i, simNum) = SGAS(highway, kValues(1));
        successRatio(2,i, simNum) = SGAS(highway, kValues(2));
        successRatio(3,i, simNum) = SGAS(highway, kValues(3));
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
    plot(1:4, results(i, :));
    ylabel("Success reatio");
    xlabel("Density / 25 units");
    title(sprintf("k = %d", kValues(i)));
end