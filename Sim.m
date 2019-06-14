fileID = fopen('simResult.txt', 'w');

simNum = 1;
while simNum <= 100 
    successRatio(1:3,1:4) = 4;
    for i = 1:4
        successRatio(1,i) = SGAS(0.6, 1000, 5, i * 10 + 40);
        successRatio(2,i) = SGAS(0.6, 1000, 6, i * 10 + 40);
        successRatio(3,i) = SGAS(0.6, 1000, 8, i * 10 + 40);
    end
    fprintf(fileID, '%u %u %u %u\n', successRatio);
    simNum = simNum + 1;
    
end
% writematrix(successRatio,'simResult.txt');

fclose(fileID);