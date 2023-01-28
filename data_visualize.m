epoch = 30000;
N_runs = 21;
Error = zeros(N_runs, epoch);
for i = 0 : N_runs-1
    file_name = strcat('data\example1_N1000Run', num2str(i) , '.out')
    str_data = fileread(file_name);
    split_data = split(str_data);
    for j = 1 : epoch
        Error(i+1, j) = str2num(split_data{2*epoch+j});
    end
end
