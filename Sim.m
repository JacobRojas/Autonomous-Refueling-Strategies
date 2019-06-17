fileID = fopen('simResult.txt', 'w');

simNum = 1;
while simNum <= 100 
    successRatio(1:3,1:4) = 4;
    for i = 1:4
        successRatio(1,i) = SGAS(i/25, 1000, 5);
        successRatio(2,i) = SGAS(i/25, 1000, 6);
        successRatio(3,i) = SGAS(i/25, 1000, 8);
    end
    fprintf(fileID, '%u %u %u %u\n', successRatio);
    simNum = simNum + 1;
    
end
% writematrix(successRatio,'simResult.txt');

fclose(fileID);