addpath('./graphic')

%% Example 1
figure(1)
% load data
epoch = 30000;
N_runs = 25;
N_curves = 3;
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
ylim([1e-4 3]);
xlabel('number of epochs');
ylabel('relative L^2 error');
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
ylabel('relative L^2 error');
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
ylabel('relative L^2 error');
title('Example 3')
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

Error_40000 = zeros(epoch, N_runs);
for i = 0 : N_runs-1
    file_name = strcat('data\example3_N40000terms6_Run', num2str(i) , '.out');
    str_data = fileread(file_name);
    split_data = split(str_data);
    for j = 1 : epoch
        Error_40000(j, i+1) = str2num(split_data{2*epoch+j});
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

%% Example 1 impact of the dimensionality
figure(6)
% load data
epoch = 30000;
N_runs = 21;
N_curves = 2;
Error_dim6 = zeros(epoch, N_runs);
for i = 0 : N_runs-1
    file_name = strcat('data\example1_N3000Run', num2str(i) , '.out');
    str_data = fileread(file_name);
    split_data = split(str_data);
    for j = 1 : epoch
        Error_dim6(j, i+1) = str2num(split_data{2*epoch+j});
    end
end

Error_dim10 = zeros(epoch, N_runs);
for i = 0 : N_runs-1
    file_name = strcat('data\example1_dim10_N3000Run', num2str(i) , '.out');
    str_data = fileread(file_name);
    split_data = split(str_data);
    for j = 1 : epoch
        Error_dim10(j, i+1) = str2num(split_data{2*epoch+j});
    end
end

Error_dim20 = zeros(epoch, N_runs);
for i = 0 : N_runs-1
    file_name = strcat('data\example1_dim20_N3000Run', num2str(i) , '.out');
    str_data = fileread(file_name);
    split_data = split(str_data);
    for j = 1 : epoch
        Error_dim20(j, i+1) = str2num(split_data{2*epoch+j});
    end
end

% plot data
x_data = 0:100:epoch-1;
y_data = zeros(length(x_data), N_runs, N_curves);
y_data(:, :, 1) = Error_dim6(1:100:epoch, :);
y_data(:, :, 2) = Error_dim10(1:100:epoch, :);
y_data(:, :, 3) = Error_dim20(1:100:epoch, :);

[hMeanPlots] = plot_book_style(x_data, y_data, 'shaded', 'mean_std_log10');
legend(hMeanPlots, {'d=6','d=10','d=20'},'Interpreter','latex')
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
ylim([1e-4 3]);
xlabel('number of epochs');
ylabel('relative L^2 error');
title('Example 1 (3000 sample points)')
set(gca,'YScale','log')
set(gca,'FontSize',20);

%% Example 1 impact of the dimensionality (10000 sample points)
figure(7)
% load data
epoch = 30000;
N_runs = 21;
N_curves = 2;
Error_dim6 = zeros(epoch, N_runs);
for i = 0 : N_runs-1
    file_name = strcat('data\example1_dim6_N10000Run', num2str(i) , '.out');
    str_data = fileread(file_name);
    split_data = split(str_data);
    for j = 1 : epoch
        Error_dim6(j, i+1) = str2num(split_data{2*epoch+j});
    end
end

Error_dim10 = zeros(epoch, N_runs);
for i = 0 : N_runs-1
    file_name = strcat('data\example1_dim10_N10000Run', num2str(i) , '.out');
    str_data = fileread(file_name);
    split_data = split(str_data);
    for j = 1 : epoch
        Error_dim10(j, i+1) = str2num(split_data{2*epoch+j});
    end
end

Error_dim20 = zeros(epoch, N_runs);
for i = 0 : N_runs-1
    file_name = strcat('data\example1_dim20_N10000Run', num2str(i) , '.out');
    str_data = fileread(file_name);
    split_data = split(str_data);
    for j = 1 : epoch
        Error_dim20(j, i+1) = str2num(split_data{2*epoch+j});
    end
end

% plot data
x_data = 0:100:epoch-1;
y_data = zeros(length(x_data), N_runs, N_curves);
y_data(:, :, 1) = Error_dim6(1:100:epoch, :);
y_data(:, :, 2) = Error_dim10(1:100:epoch, :);
y_data(:, :, 3) = Error_dim20(1:100:epoch, :);

[hMeanPlots] = plot_book_style(x_data, y_data, 'shaded', 'mean_std_log10');
legend(hMeanPlots, {'d=6','d=10','d=20'},'Interpreter','latex')
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
ylim([1e-4 3]);
xlabel('number of epochs');
ylabel('relative L^2 error');
title('Example 1 (10000 sample points)')
set(gca,'YScale','log')
set(gca,'FontSize',20);

%% Example 2 impact of the dimensionality (3000 sample points)
figure(8)
% load data
epoch = 30000;
N_runs = 21;
N_curves = 2;
Error_dim6 = zeros(epoch, N_runs);
for i = 0 : N_runs-1
    file_name = strcat('data\example2_N3000Run', num2str(i) , '.out');
    str_data = fileread(file_name);
    split_data = split(str_data);
    for j = 1 : epoch
        Error_dim6(j, i+1) = str2num(split_data{2*epoch+j});
    end
end

Error_dim10 = zeros(epoch, N_runs);
for i = 0 : N_runs-1
    file_name = strcat('data\example2_dim10_N3000Run', num2str(i) , '.out');
    str_data = fileread(file_name);
    split_data = split(str_data);
    for j = 1 : epoch
        Error_dim10(j, i+1) = str2num(split_data{2*epoch+j});
    end
end

Error_dim20 = zeros(epoch, N_runs);
for i = 0 : N_runs-1
    file_name = strcat('data\example2_dim20_N3000Run', num2str(i) , '.out');
    str_data = fileread(file_name);
    split_data = split(str_data);
    for j = 1 : epoch
        Error_dim20(j, i+1) = str2num(split_data{2*epoch+j});
    end
end

% plot data
x_data = 0:100:epoch-1;
y_data = zeros(length(x_data), N_runs, N_curves);
y_data(:, :, 1) = Error_dim6(1:100:epoch, :);
y_data(:, :, 2) = Error_dim10(1:100:epoch, :);
y_data(:, :, 3) = Error_dim20(1:100:epoch, :);

[hMeanPlots] = plot_book_style(x_data, y_data, 'shaded', 'mean_std_log10');
legend(hMeanPlots, {'d=6','d=10','d=20'},'Interpreter','latex')
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
ylim([1e-4 3]);
xlabel('number of epochs');
ylabel('relative L^2 error');
title('Example 2 (3000 sample points)')
set(gca,'YScale','log')
set(gca,'FontSize',20);

%% Example 4 impact of the dimensionality (3000 sample points)
figure(9)
% load data
epoch = 30000;
N_runs = 21;
N_curves = 2;
Error_dim6 = zeros(epoch, N_runs);
for i = 0 : N_runs-1
    file_name = strcat('data\example4_N3000Run', num2str(i) , '.out');
    str_data = fileread(file_name);
    split_data = split(str_data);
    for j = 1 : epoch
        Error_dim6(j, i+1) = str2num(split_data{2*epoch+j});
    end
end

Error_dim10 = zeros(epoch, N_runs);
for i = 0 : N_runs-1
    file_name = strcat('data\example4_dim10_N3000Run', num2str(i) , '.out');
    str_data = fileread(file_name);
    split_data = split(str_data);
    for j = 1 : epoch
        Error_dim10(j, i+1) = str2num(split_data{2*epoch+j});
    end
end

Error_dim20 = zeros(epoch, N_runs);
for i = 0 : N_runs-1
    file_name = strcat('data\example4_dim20_N3000Run', num2str(i) , '.out');
    str_data = fileread(file_name);
    split_data = split(str_data);
    for j = 1 : epoch
        Error_dim20(j, i+1) = str2num(split_data{2*epoch+j});
    end
end

% plot data
x_data = 0:100:epoch-1;
y_data = zeros(length(x_data), N_runs, N_curves);
y_data(:, :, 1) = Error_dim6(1:100:epoch, :);
y_data(:, :, 2) = Error_dim10(1:100:epoch, :);
y_data(:, :, 3) = Error_dim20(1:100:epoch, :);

[hMeanPlots] = plot_book_style(x_data, y_data, 'shaded', 'mean_std_log10');
legend(hMeanPlots, {'d=6','d=10','d=20'},'Interpreter','latex')
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
ylim([1e-4 3]);
xlabel('number of epochs');
ylabel('relative L^2 error');
title('Example 3 (3000 sample points)')
set(gca,'YScale','log')
set(gca,'FontSize',20);

%% Example 1 Error vs. number of sample points (after 30000 epochs)
figure(10)
% load data
epoch = 30000;
N_runs = 10;
Error_dim6 = zeros(13, N_runs);
Error_dim10 = zeros(13, N_runs);
Error_dim20 = zeros(13, N_runs);
for j = 6 : 13
    for i = 0 : N_runs-1
        file_name = strcat('data\example1_N', num2str(2^j), 'Run', num2str(i) , '.out');
        str_data = fileread(file_name);
        split_data = split(str_data);
        Error_dim6(j, i+1) = str2num(split_data{2*epoch+29901});
    end
end

for j = 6 : 13
    for i = 0 : N_runs-1
        file_name = strcat('data\example1_dim10_N', num2str(2^j), 'Run', num2str(i) , '.out');
        str_data = fileread(file_name);
        split_data = split(str_data);
        Error_dim10(j, i+1) = str2num(split_data{2*epoch+29901});
    end
end

for j = 6 : 13
    for i = 0 : N_runs-1
        file_name = strcat('data\example1_dim20_N', num2str(2^j), 'Run', num2str(i) , '.out');
        str_data = fileread(file_name);
        split_data = split(str_data);
        Error_dim20(j, i+1) = str2num(split_data{2*epoch+29901});
    end
end


% plot data
x_data = 2.^(6:13);
y_data = zeros(length(x_data), N_runs, 3);
y_data(:, :, 1) = Error_dim6(6:13, :);
y_data(:, :, 2) = Error_dim10(6:13, :);
y_data(:, :, 3) = Error_dim20(6:13, :);

[hMeanPlots] = plot_book_style(x_data, y_data, 'shaded', 'mean_std_log10');
legend(hMeanPlots, {'d=6', 'd=10', 'd=20'},'Interpreter','latex')
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
ylim([1e-4 3]);
xlim([0 8192])
xlabel('number of sample points');
ylabel('relative L^2 error');
title('Example 1 (after 30000 epochs)')
set(gca,'YScale','log')
set(gca,'FontSize',20);


%% Example 2 Error vs. number of sample points (after 30000 epochs)
figure(11)
% load data
epoch = 30000;
N_runs = 10;
Error_dim6 = zeros(13, N_runs);
Error_dim10 = zeros(13, N_runs);
Error_dim20 = zeros(13, N_runs);
for j = 6 : 12
    for i = 0 : N_runs-1
        file_name = strcat('data\example2_dim6_N', num2str(2^j), 'Run', num2str(i) , '.out');
        str_data = fileread(file_name);
        split_data = split(str_data);
        Error_dim6(j, i+1) = str2num(split_data{2*epoch+29901});
    end
end

for j = 6 : 12
    for i = 0 : N_runs-1
        file_name = strcat('data\example2_dim10_N', num2str(2^j), 'Run', num2str(i) , '.out');
        str_data = fileread(file_name);
        split_data = split(str_data);
        Error_dim10(j, i+1) = str2num(split_data{2*epoch+29901});
    end
end

for j = 6 : 12
    for i = 0 : N_runs-1
        file_name = strcat('data\example2_dim20_N', num2str(2^j), 'Run', num2str(i) , '.out');
        str_data = fileread(file_name);
        split_data = split(str_data);
        Error_dim20(j, i+1) = str2num(split_data{2*epoch+29901});
    end
end


% plot data
x_data = 2.^(6:12);
y_data = zeros(length(x_data), N_runs, 3);
y_data(:, :, 1) = Error_dim6(6:12, :);
y_data(:, :, 2) = Error_dim10(6:12, :);
y_data(:, :, 3) = Error_dim20(6:12, :);

[hMeanPlots] = plot_book_style(x_data, y_data, 'shaded', 'mean_std_log10');
legend(hMeanPlots, {'d=6', 'd=10', 'd=20'},'Interpreter','latex')
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
ylim([1e-4 3]);
xlim([0 4096])
xlabel('number of sample points');
ylabel('relative L^2 error');
title('Example 2 (after 30000 epochs)')
set(gca,'YScale','log')
set(gca,'FontSize',20);

%% Example 3 (3 terms) Error vs. number of sample points (after 30000 epochs)
figure(12)
% load data
epoch = 30000;
N_runs = 10;
Error_dim6 = zeros(16, N_runs);
Error_dim10 = zeros(16, N_runs);
Error_dim20 = zeros(16, N_runs);
for j = 12 : 16
    for i = 0 : N_runs-1
        file_name = strcat('data\example3_dim6_N', num2str(2^j), 'terms3_Run', num2str(i) , '.out');
        str_data = fileread(file_name);
        split_data = split(str_data);
        Error_dim6(j, i+1) = str2num(split_data{2*epoch+29901});
    end
end

for j = 12 : 16
    for i = 0 : N_runs-1
        file_name = strcat('data\example3_dim10_N', num2str(2^j), 'terms3_Run', num2str(i) , '.out');
        str_data = fileread(file_name);
        split_data = split(str_data);
        Error_dim10(j, i+1) = str2num(split_data{2*epoch+29901});
    end
end

for j = 12 : 14
    for i = 0 : N_runs-1
        file_name = strcat('data\example3_dim20_N', num2str(2^j), 'terms3_Run', num2str(i) , '.out');
        str_data = fileread(file_name);
        split_data = split(str_data);
        Error_dim20(j, i+1) = str2num(split_data{2*epoch+29901});
    end
end


% plot data
x_data = 2.^(12:16);
y_data = zeros(length(x_data), N_runs, 3);
y_data(:, :, 1) = Error_dim6(12:16, :);
y_data(:, :, 2) = Error_dim10(12:16, :);
y_data(:, :, 3) = Error_dim20(12:16, :);

[hMeanPlots] = plot_book_style(x_data, y_data, 'shaded', 'mean_std_log10');
legend(hMeanPlots, {'d=6', 'd=10', 'd=20'},'Interpreter','latex')
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
ylim([1e-3 10]);
xlim([0 65536])
xlabel('# of sample points');
ylabel('relative L^2 error');
title('Example 3 (after 30000 epochs)')
set(gca,'YScale','log')
set(gca,'FontSize',20);


%% Example 4 Error vs. number of sample points (after 30000 epochs)
figure(21)
% load data
epoch = 30000;
N_runs = 10;
Error_dim6 = zeros(13, N_runs);
Error_dim10 = zeros(13, N_runs);
Error_dim20 = zeros(13, N_runs);
for j = 6 : 12
    for i = 0 : N_runs-1
        file_name = strcat('data\example4_dim6_N', num2str(2^j), 'Run', num2str(i) , '.out');
        str_data = fileread(file_name);
        split_data = split(str_data);
        Error_dim6(j, i+1) = str2num(split_data{300});
    end
end

for j = 6 : 12
    for i = 0 : N_runs-1
        file_name = strcat('data\example4_dim10_N', num2str(2^j), 'Run', num2str(i) , '.out');
        str_data = fileread(file_name);
        split_data = split(str_data);
        Error_dim10(j, i+1) = str2num(split_data{300});
    end
end

for j = 6 : 12
    for i = 0 : N_runs-1
        file_name = strcat('data\example4_dim20_N', num2str(2^j), 'Run', num2str(i) , '.out');
        str_data = fileread(file_name);
        split_data = split(str_data);
        Error_dim20(j, i+1) = str2num(split_data{300});
    end
end


% plot data
x_data = 2.^(6:12);
y_data = zeros(length(x_data), N_runs, 3);
y_data(:, :, 1) = Error_dim6(6:12, :);
y_data(:, :, 2) = Error_dim10(6:12, :);
y_data(:, :, 3) = Error_dim20(6:12, :);

[hMeanPlots] = plot_book_style(x_data, y_data, 'shaded', 'mean_std_log10');
legend(hMeanPlots, {'d=6', 'd=10', 'd=20'},'Interpreter','latex')
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
ylim([1e-4 3]);
xlim([0 4096])
xlabel('number of sample points');
ylabel('relative L^2 error');
title('Example 3 (after 30000 epochs)')
set(gca,'YScale','log')
set(gca,'FontSize',20);

%% Example 4 test architecture of the neural network
% Error vs. number of hidden layer (and width height ratio)
figure(17)
N_runs = 10;
ratio = {'3', '5', '10', '20'};
x_data = 1:2:7;
y_data = zeros(length(x_data), N_runs, length(ratio));
for r = 1:4
    for j = 1:4
        for i = 0 : N_runs-1
            h = x_data(j);
            file_name = strcat('data\example4_h', num2str(h), 'r', ratio{r}, 'Run', num2str(i), '.out');
            str_data = fileread(file_name);
            split_data = split(str_data);
            y_data(j, i+1, r) = str2num(split_data{300});
        end
    end
end



[hMeanPlots] = plot_book_style(x_data, y_data, 'shaded', 'mean_std_log10');
legend(hMeanPlots, {'r=3', 'r=5', 'r=10', 'r=20'},'Interpreter','latex')
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
ylim([1e-5 10]);
xlim([1 7])
xlabel('# of hidden layers');
ylabel('relative L^2 error');
% title('Example 4 (5000 sample pts after 30000 epochs)')
title('Hidden layer test')
set(gca,'YScale','log')
set(gca,'FontSize',20);
xticks([1 3 5 7])
yticks([1e-5 1e-4 1e-3 1e-2 1])

%% Example 3 test architecture of the neural network
% Error vs. number of hidden layer (and width height ratio)
figure(18)
N_runs = 10;
ratio = {'3', '5', '10', '20'};
x_data = 1:2:7;
y_data = zeros(length(x_data), N_runs, length(ratio));
for r = 1:4
    for j = 1:4
        for i = 0 : N_runs-1
            h = x_data(j);
            file_name = strcat('data\example3_h', num2str(h), 'r', ratio{r}, 'Run', num2str(i), '.out');
            str_data = fileread(file_name);
            split_data = split(str_data);
            y_data(j, i+1, r) = str2num(split_data{300});
        end
    end
end



[hMeanPlots] = plot_book_style(x_data, y_data, 'shaded', 'mean_std_log10');
legend(hMeanPlots, {'r=3', 'r=5', 'r=10', 'r=20'},'Interpreter','latex')
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
ylim([1e-3 10]);
xlim([0 7])
xlabel('# of hidden layers');
ylabel('relative L2 error');
title('Example 3 (20000 sample pts after 30000 epochs)')
set(gca,'YScale','log')
set(gca,'FontSize',20);


%% Example 3 test periodic layers of the neural network
% Error vs. number of hidden layer (and width height ratio)
figure(19)
m = 10:5:50;
n = 10:10:50;
N_runs = 1;
data = zeros(9,5,N_runs);
z_data = data(:,:,1);
for i = 1: 9
    for j = 1:5
        for k = 0 : 4
            file_name = strcat('data\example3_m', num2str(m(i)), 'n', num2str(n(j)), 'Run', num2str(k), '.out');
            str_data = fileread(file_name);
            split_data = split(str_data);
            data(i, j, k+1) = str2num(split_data{300});
        end
        z_data(i, j) = 10^(mean(log10(data(i,j,:))));
    end
end

[X, Y] = meshgrid(n,m);
surf(X, Y, z_data);
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
set(gca, 'ZScale','log')
xlim([10 50])
ylim([10 50])
zlim([1e-2 10])
xlabel('m');
ylabel('n');
zlabel('relative L2 error');
title('Example 3 (20000 sample pts after 30000 epochs)')
set(gca,'FontSize',20);


%% Example 4 test periodic layers of the neural network
% Error vs. number of hidden layer (and width height ratio)
figure(20)
m = 10:5:50;
x_data = m;
n = 10:10:50;
N_runs = 1;
data = zeros(9,5,N_runs);
y_data = zeros(9, 25, 1);
for i = 1: 9
    for j = 1:5
        for k = 0 : 4
            file_name = strcat('data\example4_m', num2str(m(i)), 'n', num2str(n(j)), 'Run', num2str(k), '.out');
            str_data = fileread(file_name);
            split_data = split(str_data);
            y_data(i, j*5+k-4, 1) = str2num(split_data{300});
        end
    end
end

[hMeanPlots] = plot_book_style(x_data, y_data, 'shaded', 'mean_std_log10');
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
xlim([10 50])
ylim([1e-4 5e-3])
xlabel('# of nodes m in the periodic layer');
ylabel('relative L^2 error');
% title('Example 4 (5000 sample pts after 30000 epochs)')
title('Periodic layer test')
set(gca,'FontSize',20);