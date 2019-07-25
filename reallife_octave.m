function highway = reallife_octave(file)
output = dlmread(file);
distances = output(:, 1);
prices = output(:, 2);
highway = [];
for i = 1:length(distances)
    highway = [highway zeros(1, distances(i)-1) prices(i)];
end
end