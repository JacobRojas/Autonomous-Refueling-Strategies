close all
clear all

kValues = 2:1:16;

%Switch the comments to switch between stopping point methods
stoppingEq =  @(x) ceil(x/exp(1));
%stoppingEq =  @(x) ceil(sqrt(x));

results(1:length(kValues)) = 10;
highway = reallife("RealLife.csv");
%Use this line to start at different points
%highway = highway(500:end);
for k = 1:length(kValues)
    results(k) = SGAS2(highway, kValues(k), stoppingEq);
end


subplot(2, 1, 1);
stem(kValues, results);
ylabel("Gas Price");
xlabel("k");
title("Interstate 35");
