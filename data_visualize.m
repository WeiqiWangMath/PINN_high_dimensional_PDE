addpath('./graphic')

%% Example 1
figure(1)
% load data
epoch = 30000;
N_runs = 21;
N_curves = 2;
Error_1000 = zeros(epoch, N_runs);
for i = 0 : N_runs-1
    file_name = strcat('data\example1_N1000Run', num2str(i) , '.out');
    str_data = fileread(file_name);
    split_data = split(str_data);
    for j = 1 : epoch
        Error_1000(j, i+1) = str2num(split_data{2*epoch+j});
    end
end

Error_2000 = zeros(epoch, N_runs);
for i = 0 : N_runs-1
    file_name = strcat('data\example1_N2000Run', num2str(i) , '.out');
    str_data = fileread(file_name);
    split_data = split(str_data);
    for j = 1 : epoch
        Error_2000(j, i+1) = str2num(split_data{2*epoch+j});
    end
end

Error_3000 = zeros(epoch, N_runs);
for i = 0 : N_runs-1
    file_name = strcat('data\example1_N3000Run', num2str(i) , '.out');
    str_data = fileread(file_name);
    split_data = split(str_data);
    for j = 1 : epoch
        Error_3000(j, i+1) = str2num(split_data{2*epoch+j});
    end
end

% plot data
x_data = 0:100:epoch-1;
y_data = zeros(length(x_data), N_runs, N_curves);
y_data(:, :, 1) = Error_1000(1:100:epoch, :);
y_data(:, :, 2) = Error_2000(1:100:epoch, :);
y_data(:, :, 3) = Error_3000(1:100:epoch, :);

[hMeanPlots] = plot_book_style(x_data, y_data, 'shaded', 'mean_std_log10');
legend(hMeanPlots, {'m=1000','m=2000','m=3000'},'Interpreter','latex')
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
ylim([1e-3 3]);
xlabel('number of epochs');
ylabel('relative L2 error');
title('Example 1')
set(gca,'YScale','log')
set(gca,'FontSize',20);


%% Example 2

figure(2)
% load data
epoch = 30000;
N_runs = 25;
N_curves = 2;
Error_1000 = zeros(epoch, N_runs);
for i = 0 : N_runs-1
    file_name = strcat('data\example2_N1000Run', num2str(i) , '.out');
    str_data = fileread(file_name);
    split_data = split(str_data);
    for j = 1 : epoch
        Error_1000(j, i+1) = str2num(split_data{2*epoch+j});
    end
end

Error_2000 = zeros(epoch, N_runs);
for i = 0 : N_runs-1
    file_name = strcat('data\example2_N2000Run', num2str(i) , '.out');
    str_data = fileread(file_name);
    split_data = split(str_data);
    for j = 1 : epoch
        Error_2000(j, i+1) = str2num(split_data{2*epoch+j});
    end
end

Error_3000 = zeros(epoch, N_runs);
for i = 0 : N_runs-1
    file_name = strcat('data\example2_N3000Run', num2str(i) , '.out');
    str_data = fileread(file_name);
    split_data = split(str_data);
    for j = 1 : epoch
        Error_3000(j, i+1) = str2num(split_data{2*epoch+j});
    end
end

% plot data
x_data = 0:100:epoch-1;
y_data = zeros(length(x_data), N_runs, N_curves);
y_data(:, :, 1) = Error_1000(1:100:epoch, :);
y_data(:, :, 2) = Error_2000(1:100:epoch, :);
y_data(:, :, 3) = Error_3000(1:100:epoch, :);

[hMeanPlots] = plot_book_style(x_data, y_data, 'shaded', 'mean_std_log10');
legend(hMeanPlots, {'m=1000','m=2000','m=3000'},'Interpreter','latex')
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
ylim([1e-4 3]);
xlabel('number of epochs');
ylabel('relative L2 error');
title('Example 2')
set(gca,'YScale','log')
set(gca,'FontSize',20);

%% Example 4

figure(3)
% load data
epoch = 30000;
N_runs = 25;
N_curves = 2;
Error_500 = zeros(epoch, N_runs);
for i = 0 : N_runs-1
    file_name = strcat('data\example4_N500Run', num2str(i) , '.out');
    str_data = fileread(file_name);
    split_data = split(str_data);
    for j = 1 : epoch
        Error_500(j, i+1) = str2num(split_data{2*epoch+j});
    end
end

Error_1000 = zeros(epoch, N_runs);
for i = 0 : N_runs-1
    file_name = strcat('data\example4_N1000Run', num2str(i) , '.out');
    str_data = fileread(file_name);
    split_data = split(str_data);
    for j = 1 : epoch
        Error_1000(j, i+1) = str2num(split_data{2*epoch+j});
    end
end

Error_2000 = zeros(epoch, N_runs);
for i = 0 : N_runs-1
    file_name = strcat('data\example4_N2000Run', num2str(i) , '.out');
    str_data = fileread(file_name);
    split_data = split(str_data);
    for j = 1 : epoch
        Error_2000(j, i+1) = str2num(split_data{2*epoch+j});
    end
end

% plot data
x_data = 0:100:epoch-1;
y_data = zeros(length(x_data), N_runs, N_curves);
y_data(:, :, 1) = Error_500(1:100:epoch, :);
y_data(:, :, 2) = Error_1000(1:100:epoch, :);
y_data(:, :, 3) = Error_2000(1:100:epoch, :);

[hMeanPlots] = plot_book_style(x_data, y_data, 'shaded', 'mean_std_log10');
legend(hMeanPlots, {'m=500','m=1000','m=2000'},'Interpreter','latex')
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
ylim([1e-4 3]);
xlabel('number of epochs');
ylabel('relative L2 error');
title('Example 4')
set(gca,'YScale','log')
set(gca,'FontSize',20);

%% Example 3 (3 terms)

figure(4)
% load data
epoch = 30000;
N_runs = 25;
N_curves = 2;
Error_5000 = zeros(epoch, N_runs);
for i = 0 : N_runs-1
    file_name = strcat('data\example3_N5000terms3_Run', num2str(i) , '.out');
    str_data = fileread(file_name);
    split_data = split(str_data);
    for j = 1 : epoch
        Error_5000(j, i+1) = str2num(split_data{2*epoch+j});
    end
end

Error_10000 = zeros(epoch, N_runs);
for i = 0 : N_runs-1
    file_name = strcat('data\example3_N10000terms3_Run', num2str(i) , '.out');
    str_data = fileread(file_name);
    split_data = split(str_data);
    for j = 1 : epoch
        Error_10000(j, i+1) = str2num(split_data{2*epoch+j});
    end
end

Error_20000 = zeros(epoch, N_runs);
for i = 0 : N_runs-1
    file_name = strcat('data\example3_N20000terms3_Run', num2str(i) , '.out');
    str_data = fileread(file_name);
    split_data = split(str_data);
    for j = 1 : epoch
        Error_20000(j, i+1) = str2num(split_data{2*epoch+j});
    end
end

% plot data
x_data = 0:100:epoch-1;
y_data = zeros(length(x_data), N_runs, N_curves);
y_data(:, :, 1) = Error_5000(1:100:epoch, :);
y_data(:, :, 2) = Error_10000(1:100:epoch, :);
y_data(:, :, 3) = Error_20000(1:100:epoch, :);

[hMeanPlots] = plot_book_style(x_data, y_data, 'shaded', 'mean_std_log10');
legend(hMeanPlots, {'m=5000','m=10000','m=20000'},'Interpreter','latex')
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
ylim([1e-3 10]);
xlabel('number of epochs');
ylabel('relative L2 error');
title('Example 3 (3 terms)')
set(gca,'YScale','log')
set(gca,'FontSize',20);

%% Example 3 (6 terms)

figure(5)
% load data
epoch = 30000;
N_runs = 25;
N_curves = 2;
Error_20000 = zeros(epoch, N_runs);
for i = 0 : N_runs-1
    file_name = strcat('data\example3_N20000terms6_Run', num2str(i) , '.out');
    str_data = fileread(file_name);
    split_data = split(str_data);
    for j = 1 : epoch
        Error_20000(j, i+1) = str2num(split_data{2*epoch+j});
    end
end

Error_30000 = zeros(epoch, N_runs);
for i = 0 : N_runs-1
    file_name = strcat('data\example3_N40000terms6_Run', num2str(i) , '.out');
    str_data = fileread(file_name);
    split_data = split(str_data);
    for j = 1 : epoch
        Error_30000(j, i+1) = str2num(split_data{2*epoch+j});
    end
end

Error_60000 = zeros(epoch, N_runs);
for i = 0 : N_runs-1
    file_name = strcat('data\example3_N60000terms6_Run', num2str(i) , '.out');
    str_data = fileread(file_name);
    split_data = split(str_data);
    for j = 1 : epoch
        Error_60000(j, i+1) = str2num(split_data{2*epoch+j});
    end
end

% plot data
x_data = 0:100:epoch-1;
y_data = zeros(length(x_data), N_runs, N_curves);
y_data(:, :, 1) = Error_20000(1:100:epoch, :);
y_data(:, :, 2) = Error_40000(1:100:epoch, :);
y_data(:, :, 3) = Error_60000(1:100:epoch, :);

[hMeanPlots] = plot_book_style(x_data, y_data, 'shaded', 'mean_std_log10');
legend(hMeanPlots, {'m=20000','m=40000','m=60000'},'Interpreter','latex')
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
ylim([1e-3 10]);
xlabel('number of epochs');
ylabel('relative L2 error');
title('Example 3 (6 terms)')
set(gca,'YScale','log')
set(gca,'FontSize',20);