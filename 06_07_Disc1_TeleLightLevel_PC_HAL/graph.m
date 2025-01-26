% import the experiment data
fid = fopen('experiment.txt', 'r');
data = fscanf(fid, '%d,', [inf]);  % Adjust format to match your data structure
fclose(fid);

plot(data)