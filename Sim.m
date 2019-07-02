fileID = fopen('simResult.txt', 'w');

stoppingEq =  @(x) ceil(x/exp(1));
simNum = 1;
while simNum <= 100 
    successRatio(1:3,1:4) = 4;
    for i = 1:4
        highway = construct(i/25, 1000);
        successRatio(1,i) = SGAS(highway, 5, stoppingEq);
        successRatio(2,i) = SGAS(highway, 6, stoppingEq);
        successRatio(3,i) = SGAS(highway, 8, stoppingEq);
    end
    fprintf(fileID, '%u %u %u %u\n', successRatio);
    simNum = simNum + 1;
    
end
% writematrix(successRatio,'simResult.txt');

fclose(fileID);