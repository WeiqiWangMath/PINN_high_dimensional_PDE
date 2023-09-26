clear
addpath '..\graphic'
addpath '..\utils'
cd ..

%%
d = 6; %dimension
nu = 0.5;

diffusion = @(x) 1 + 0.25 * sin(2*pi*x(:,1)) .* sin(2*pi*x(:,2));
grad_diffusion{1} = @(x) 0.25 * 2*pi*cos(2*pi*x(:,1)) .* sin(2*pi*x(:,2));
grad_diffusion{2} = @(x) 0.25 * 2*pi*cos(2*pi*x(:,2)) .* sin(2*pi*x(:,1));


% load exact solution
u_exact_f0 = @(x) exp(sin(2*pi*x(:,1)) + 0.25*sin(2*pi*x(:,2)));

% Example1
u_exact_f1 = @(x) sin(4*pi* x(:,1)) .* sin(2*pi* x(:,2));

% Example2
u_exact_f2 = @(x) exp(sin(2*pi*x(:,1)) + sin(2*pi*x(:,2)));

% Example3
u_exact_f3 = @(x) 0.34*sin(4*pi* x(:,1)) .* sin(2*pi* x(:,2)) - 0.69*sin(6*pi* x(:,3)) .* sin(4*pi* x(:,2)) + 0.287*sin(8*pi* x(:,6)) .* sin(4*pi* x(:,5));

% Example4
u_exact_f4 = @(x) zeros(size(x(:, 1)));
for i = 1:d
    u_exact_f4 = @(x) u_exact_f4(x) + 1/i^2 * sin(2*pi * x(:,i));
end
u_exact_f4 = @(x) exp(u_exact_f4(x));

% u_exact_C = integral(u_exact_f1,0,1)^2;
% u_exact = @(x) exp(sin(2*pi*x(:,1))+sin(2*pi*x(:,2))) - u_exact_C;

BC_type = 'PERIODIC';
tic

for i = 3:d
    grad_diffusion{i} = @(x) zeros(size(x(:,1)));
end
N_runs = 25;

%% Run adaptive OMP on example 1
m = 3000; %number of sample point
N = 150;

rel_L2_error_CS = zeros(N, N_runs);
card_index = zeros(N, N_runs);
for i_runs = 1: N_runs
    i_runs
    [rel_L2_error_CS(:, i_runs), card_index(:, i_runs), ~, ~] = Adaptive_lower_OMP(diffusion, grad_diffusion, d, u_exact_f1, m, N, nu);
end
save('..\data\example1_data', 'rel_L2_error_CS', 'card_index')

%% Plot example 1
figure(14)
clf(14)
load('..\data\example1_data')
N = 150;
x_data = 1:N-1;
y_data = zeros(length(x_data), N_runs, 1);
y1_data = zeros(length(x_data), N_runs, 1);
y_data(:, :, 1) = rel_L2_error_CS(1:N-1, :);
[hMeanPlots] = plot_book_style(x_data, y_data, 'shaded', 'mean_std_log10');
hold on
for i = 1: N_runs
    semilogy(x_data, y_data(:, i, 1),'.-', 'Color',  [0.5 0.5 0.5])
end
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
ylim([1e-12 30]);
xlim([0 149])
xlabel('# of iterations');
ylabel('relative L^2 error');
title('Example 1 (3000 sample pts)')
set(gca,'YScale','log')
set(gca,'FontSize',20);
h = get(gca, 'Children');
set(h(1), 'Marker', '.');
yyaxis right;
y1_data(:, :, 1) = card_index(1:N-1, :);
[hMeanPlots] = plot_book_style(x_data, y1_data, 'shaded', 'mean_std');
h = get(gca, 'Children');
set(h(1), 'Marker', '.');
set(h(1), 'MarkerFaceColor', [0.8500    0.3250    0.0980])
set(h(1), 'MarkerEdgeColor', [0.8500    0.3250    0.0980])
set(h(1), 'Color', [0.8500    0.3250    0.0980])
set(h(2), 'FaceColor', [0.8500    0.3250    0.0980])
set(h(3), 'MarkerFaceColor', [0.8500    0.3250    0.0980])
set(h(4), 'MarkerFaceColor', [0.8500    0.3250    0.0980])
ylim([0 1500])
ylabel('cardinality of the lower set')
ax = gca;
ax.YColor = 'k';
title('Example 1')

%% Run adaptive OMP on example 2
m = 3000; %number of sample point
N = 150;
N_runs = 25;
rel_L2_error_CS = zeros(N, N_runs);
card_index = zeros(N, N_runs);
for i_runs = 1: N_runs
    i_runs
    [rel_L2_error_CS(:, i_runs), card_index(:, i_runs), ~, ~] = Adaptive_lower_OMP(diffusion, grad_diffusion, d, u_exact_f2, m, N, nu);
end
save('..\data\example2_data', 'rel_L2_error_CS', 'card_index')


%% Plot example 2
figure(15)
load('..\data\example2_data')
N = 150;
x_data = 1:N-1;
y_data = zeros(length(x_data), N_runs, 1);
y_data(:, :, 1) = rel_L2_error_CS(1:N-1, :);
[hMeanPlots] = plot_book_style(x_data, y_data, 'shaded', 'mean_std_log10');
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
ylim([1e-12 30]);
xlim([0 149])
xlabel('# of iterations');
ylabel('relative L^2 error');
title('Example 1 (3000 sample pts)')
set(gca,'YScale','log')
set(gca,'FontSize',20);
h = get(gca, 'Children');
set(h(1), 'Marker', '.');
yyaxis right;
y_data(:, :, 1) = card_index(1:N-1, :);
[hMeanPlots] = plot_book_style(x_data, y_data, 'shaded', 'mean_std');
h = get(gca, 'Children');
set(h(1), 'Marker', '.');
set(h(1), 'MarkerFaceColor', [0.8500    0.3250    0.0980])
set(h(1), 'MarkerEdgeColor', [0.8500    0.3250    0.0980])
set(h(1), 'Color', [0.8500    0.3250    0.0980])
set(h(2), 'FaceColor', [0.8500    0.3250    0.0980])
set(h(3), 'MarkerFaceColor', [0.8500    0.3250    0.0980])
set(h(4), 'MarkerFaceColor', [0.8500    0.3250    0.0980])
ylim([0 1500])
ylabel('cardinality of the lower set')
ax = gca;
ax.YColor = 'k';
title('Example 2')


%%  4
figure(4)
m = 3000; %number of sample point
N = 150;
[I3, z3] = Adaptive_lower_OMP(diffusion, grad_diffusion, d, u_exact_f3, m, N, nu);
title('Example 3')

%% Run adaptive OMP on example 4
m = 3000; %number of sample point
N = 201;
N_runs = 25;
rel_L2_error_CS = zeros(N, N_runs);
card_index = zeros(N, N_runs);
for i_runs = 1: N_runs
    i_runs
    [rel_L2_error_CS(:, i_runs), card_index(:, i_runs), ~, ~] = Adaptive_lower_OMP(diffusion, grad_diffusion, d, u_exact_f4, m, N, nu);
end
save('..\data\example4_data', 'rel_L2_error_CS', 'card_index')


%% Plot example 4
figure(16)
load('..\data\example4_data')
N = 200;
x_data = 1:N-1;
y_data = zeros(length(x_data), N_runs, 1);
y_data(:, :, 1) = rel_L2_error_CS(1:N-1, :);
[hMeanPlots] = plot_book_style(x_data, y_data, 'shaded', 'mean_std_log10');
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
ylim([1e-12 30]);
xlim([0 199])
xlabel('# of iterations');
ylabel('relative L^2 error');
set(gca,'YScale','log');
set(gca,'FontSize',20);
yticks([1e-10 1e-5 1e-3 1e-2 0.1 1]);
h = get(gca, 'Children');
set(h(1), 'Marker', '.');
yyaxis right;
y_data(:, :, 1) = card_index(1:N-1, :);
[hMeanPlots] = plot_book_style(x_data, y_data, 'shaded', 'mean_std');
h = get(gca, 'Children');
set(h(1), 'Marker', '.');
set(h(1), 'MarkerFaceColor', [0.8500    0.3250    0.0980])
set(h(1), 'MarkerEdgeColor', [0.8500    0.3250    0.0980])
set(h(1), 'Color', [0.8500    0.3250    0.0980])
set(h(2), 'FaceColor', [0.8500    0.3250    0.0980])
set(h(3), 'MarkerFaceColor', [0.8500    0.3250    0.0980])
set(h(4), 'MarkerFaceColor', [0.8500    0.3250    0.0980])
ylim([0 1500])
ylabel('cardinality of the lower set')
ax = gca;
ax.YColor = 'k';
title('Example 3')

%% d = 30

d = 30; %dimension
nu = 0.5;

diffusion = @(x) 1 + 0.25 * sin(2*pi*x(:,1)) .* sin(2*pi*x(:,2));
grad_diffusion{1} = @(x) 0.25 * 2*pi*cos(2*pi*x(:,1)) .* sin(2*pi*x(:,2));
grad_diffusion{2} = @(x) 0.25 * 2*pi*cos(2*pi*x(:,2)) .* sin(2*pi*x(:,1));


% load exact solution
u_exact_f0 = @(x) exp(sin(2*pi*x(:,1)) + 0.25*sin(2*pi*x(:,2)));

% Example1
u_exact_f1 = @(x) sin(4*pi* x(:,1)) .* sin(2*pi* x(:,2));

% Example2
u_exact_f2 = @(x) exp(sin(2*pi*x(:,1)) + sin(2*pi*x(:,2)));

% Example3
u_exact_f3 = @(x) 0.34*sin(4*pi* x(:,1)) .* sin(2*pi* x(:,2)) - 0.69*sin(6*pi* x(:,3)) .* sin(4*pi* x(:,2)) + 0.287*sin(8*pi* x(:,6)) .* sin(4*pi* x(:,5));

% Example4
u_exact_f4 = @(x) zeros(size(x(:, 1)));
for i = 1:d
    u_exact_f4 = @(x) u_exact_f4(x) + 1/i^2 * sin(2*pi * x(:,i));
end
u_exact_f4 = @(x) exp(u_exact_f4(x));

% u_exact_C = integral(u_exact_f1,0,1)^2;
% u_exact = @(x) exp(sin(2*pi*x(:,1))+sin(2*pi*x(:,2))) - u_exact_C;

BC_type = 'PERIODIC';
tic

for i = 3:d
    grad_diffusion{i} = @(x) zeros(size(x(:,1)));
end

%% Run test example 4, d = 30

m = [500, 1000, 1500, 2000, 2500, 3000]; %number of sample point
N = 300;
N_runs = 25;
rel_L2_error_CS = zeros(N, 1);
card_index = zeros(N, 1);
L2_error = zeros(length(m), N_runs);
for i = 1:length(m)
    for i_runs = 1: N_runs
        i_runs
        [rel_L2_error_CS, card_index, ~, ~] = Adaptive_lower_OMP(diffusion, grad_diffusion, d, u_exact_f4, m(i), N, nu, m(i)/2);
        L2_error(i, i_runs) = rel_L2_error_CS(sum(card_index > 0));
        sum(card_index > 0)
    end
    save(append('..\data\example4_m',num2str(m(i))), 'L2_error')
end

%% Run test example 2, d = 30

m = [500, 1000, 1500, 2000, 2500, 3000]; %number of sample point
N = 800;
N_runs = 25;
rel_L2_error_CS = zeros(N, 1);
card_index = zeros(N, 1);
L2_error = zeros(length(m), N_runs);
for i = 3:length(m)
    for i_runs = 1: N_runs
        i_runs
        [rel_L2_error_CS, card_index, ~, ~] = Adaptive_lower_OMP(diffusion, grad_diffusion, d, u_exact_f2, m(i), N, nu, m(i)/2);
        L2_error(i, i_runs) = rel_L2_error_CS(sum(card_index > 0));
        sum(card_index > 0)
    end
    save(append('..\data\example2_m',num2str(m(i))), 'L2_error')
end

%% Plot adaptive OMP vs. NN (example 4)
figure(21)
m = [500, 1000, 1500, 2000, 2500, 3000]; %number of sample point
N_runs = 25;
x_data = m;
y_data = zeros(length(x_data), N_runs, 2);
for i = 1:length(m)
    load(append('..\data\example4_m',num2str(m(i))))
    y_data(i, :, 1) = L2_error(i, :);
    for j = 0: N_runs-1
        file_name = strcat('..\data\example4_dim30_N', num2str(m(i)), 'Run', num2str(j), '.out');
        str_data = fileread(file_name);
        split_data = split(str_data);
        y_data(i, j+1, 2) = str2num(split_data{300});
    end
end
[hMeanPlots] = plot_book_style(x_data, y_data, 'shaded', 'mean_std_log10');
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
ylim([1e-12 10]);
xlim([m(1) m(length(m))])
xlabel('# of sample points');
ylabel('relative L^2 error');
title('Example 3')
set(gca,'YScale','log')
set(gca,'FontSize',20);
yticks([1e-10 1e-5 1e-4 1e-3 1e-2 0.1 1]);
legend(hMeanPlots, {'Lower OMP', 'NN'},'Interpreter','latex')

%% Plot adaptive OMP vs. NN (example 2)
figure(22)
m = [500, 1000, 1500, 2000, 2500, 3000]; %number of sample point
N_runs = 25;
x_data = m;
y_data = zeros(length(x_data), N_runs, 2);
epoch = 30000;
for i = 1:length(m)
    if i <= 3
        load(append('..\data\example2_m',num2str(m(i))))
        y_data(i, :, 1) = L2_error(i, :);
    end
    for j = 0: N_runs-1
        file_name = strcat('..\data\example2_dim30_N', num2str(m(i)), 'Run', num2str(j), '.out');
        str_data = fileread(file_name);
        split_data = split(str_data);
        y_data(i, j+1, 2) = str2num(split_data{2*epoch+29901});
    end
end
[hMeanPlots] = plot_book_style(x_data, y_data, 'shaded', 'mean_std_log10');
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
ylim([1e-12 10]);
xlim([m(1) m(length(m))])
xlabel('# of sample points');
ylabel('relative L^2 error');
title('Example 2')
set(gca,'YScale','log')
set(gca,'FontSize',20);
yticks([1e-10 1e-5 1e-3 1e-2 0.1 1]);
legend(hMeanPlots, {'Lower OMP', 'NN'},'Interpreter','latex')


%% Try naive OMP, example 2, d = 6
d = 6
m = [250, 500, 750, 1000, 1250, 1500];
N_runs = 25;
[L2_error_naive, I] = Naive_OMP(diffusion, grad_diffusion, d, u_exact_f2, 3000, m, 16, nu, N_runs);
save('..\data\example2_naive_OMP', 'L2_error_naive')

%% naive OMP small m, example 2, d = 6
m = [8, 16, 32, 64, 128];
N_runs = 25;
[L2_error_naive, I] = Naive_OMP(diffusion, grad_diffusion, d, u_exact_f2, 3000, m, 16, nu, N_runs);
save('..\data\example2_naive_OMP_m_small', 'L2_error_naive')
%% Run test example 2, d = 6

m = [16, 32, 64, 128, 256, 500, 1000, 1500]; %number of sample point
N = 800;
N_runs = 25;
rel_L2_error_CS = zeros(N, 1);
card_index = zeros(N, 1);
L2_error = zeros(length(m), N_runs);
for i = 1:length(m)
    i
    for i_runs = 1: N_runs
        i_runs
        [rel_L2_error_CS, card_index, ~, ~] = Adaptive_lower_OMP(diffusion, grad_diffusion, d, u_exact_f2, m(i), N, nu, m(i)/2);
        L2_error(i, i_runs) = rel_L2_error_CS(sum(card_index > 0));
        sum(card_index > 0)
    end
    save(append('..\data\example2_dim6_adapt_m',num2str(m(i))), 'L2_error')
end

%% Plot adaptive OMP vs. traditional OMP (example 2)
figure(23)
m = [16, 32, 64, 128, 256, 500, 1000, 1500]; %number of sample point
N_runs = 25;
x_data = m;
y_data = zeros(length(x_data), N_runs, 2);
load('..\data\example2_naive_OMP_m_small.mat', 'L2_error_naive')
y_data(1:5, :, 1) = L2_error_naive;
load('..\data\example2_naive_OMP.mat', 'L2_error_naive')
y_data(6:8, :, 1) = L2_error_naive(1:3, :);
load('..\data\example2_dim6_adapt_m1500.mat','L2_error')
y_data(1:8, :, 2)= L2_error;
[hMeanPlots] = plot_book_style(x_data, y_data, 'shaded', 'mean_std_log10');
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
ylim([1e-12 10]);
xlim([m(1) m(length(m))])
xlabel('sparsity of the solution');
ylabel('relative L^2 error');
title('Example 2')
set(gca,'YScale','log')
set(gca,'FontSize',20);
yticks([1e-10 1e-5 1e-4 1e-3 1e-2 0.1 1]);
legend(hMeanPlots, {'traditional', 'adaptive'},'Interpreter','latex')

%% Try naive OMP, example 4, d = 6
d = 6
m = [250, 500, 750, 1000, 1250, 1500];
N_runs = 25;
[L2_error_naive, I] = Naive_OMP(diffusion, grad_diffusion, d, u_exact_f4, 3000, m, 18, nu, N_runs);
save('..\data\example4_naive_OMP', 'L2_error_naive')

%% naive OMP small m, example 4, d = 6
m = [8, 16, 32, 64, 128];
N_runs = 25;
[L2_error_naive, I] = Naive_OMP(diffusion, grad_diffusion, d, u_exact_f4, 3000, m, 18, nu, N_runs);
save('..\data\example4_naive_OMP_m_small', 'L2_error_naive')
%% Run test example 4, d = 6

m = [16, 32, 64, 128, 256, 500, 1000, 1500, 2000, 2500, 3000]; %number of sample point
N = 800;
N_runs = 25;
rel_L2_error_CS = zeros(N, 1);
card_index = zeros(N, 1);
L2_error = zeros(length(m), N_runs);
for i = 1:length(m)
    i
    for i_runs = 1: N_runs
        i_runs
        [rel_L2_error_CS, card_index, ~, ~] = Adaptive_lower_OMP(diffusion, grad_diffusion, d, u_exact_f4, m(i), N, nu, m(i)/2);
        L2_error(i, i_runs) = rel_L2_error_CS(sum(card_index > 0));
%         sum(card_index > 0)
    end
    save(append('..\data\example4_dim6_adapt_m',num2str(m(i))), 'L2_error')
end

%% Plot adaptive OMP vs. traditional OMP (example 4)
figure(23)
m = [16, 32, 64, 128, 256, 500, 1000, 1500, 2000, 2500, 3000]; %number of sample point
N_runs = 25;
x_data = m;
y_data = zeros(length(x_data), N_runs, 2);
load('..\data\example4_naive_OMP_m_small.mat', 'L2_error_naive')
y_data(1:5, :, 1) = L2_error_naive;
load('..\data\example4_naive_OMP.mat', 'L2_error_naive')
y_data(6:11, :, 1) = L2_error_naive(1:6, :);
load('..\data\example4_dim6_adapt_m3000.mat','L2_error')
y_data(1:11, :, 2)= L2_error;
[hMeanPlots] = plot_book_style(x_data, y_data, 'shaded', 'mean_std_log10');
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
ylim([1e-5 10]);
xlim([m(1) m(length(m))])
xlabel('sparsity of the solution');
ylabel('relative L^2 error');
title('Example 4')
set(gca,'YScale','log')
set(gca,'FontSize',20);
yticks([1e-5 1e-4 1e-3 1e-2 0.1 1]);
legend(hMeanPlots, {'traditional', 'adaptive'},'Interpreter','latex')