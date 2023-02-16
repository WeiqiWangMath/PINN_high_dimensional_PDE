clear
addpath '..\graphic'
addpath '..\utils'

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
    u_exact_f4 = @(x) u_exact_f4(x) + 1/i * sin(2*pi * x(:,i));
end
u_exact_f4 = @(x) exp(u_exact_f4(x)*2/d);

% u_exact_C = integral(u_exact_f1,0,1)^2;
% u_exact = @(x) exp(sin(2*pi*x(:,1))+sin(2*pi*x(:,2))) - u_exact_C;

BC_type = 'PERIODIC';
tic

for i = 3:d
    grad_diffusion{i} = @(x) zeros(size(x(:,1)));
end
%% Run adaptive OMP on example 1
m = 3000; %number of sample point
N = 150;
N_runs = 10;
rel_L2_error_CS = zeros(N, N_runs);
card_index = zeros(N, N_runs);
for i_runs = 1: N_runs
    [rel_L2_error_CS(:, i_runs), card_index(:, i_runs), ~, ~] = Adaptive_lower_OMP(diffusion, grad_diffusion, d, u_exact_f1, m, N, nu);
end
save('..\data\example1_data', 'rel_L2_error_CS', 'card_index')

%% Plot example 1
figure(14)
load('..\data\example1_data')
x_data = 1:N;
y_data = zeros(length(x_data), N_runs, 1);
y_data(:, :, 1) = rel_L2_error_CS;
[hMeanPlots] = plot_book_style(x_data, y_data, 'shaded', 'mean_std_log10');
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
ylim([1e-10 10]);
xlim([0 150])
xlabel('# of iterations');
ylabel('relative L2 error');
title('Example 1 (3000 sample pts)')
set(gca,'YScale','log')
set(gca,'FontSize',20);
title('Example 1')

%% Run adaptive OMP on example 2
m = 3000; %number of sample point
N = 150;
N_runs = 10;
rel_L2_error_CS = zeros(N, N_runs);
card_index = zeros(N, N_runs);
for i_runs = 1: N_runs
    [rel_L2_error_CS(:, i_runs), card_index(:, i_runs), ~, ~] = Adaptive_lower_OMP(diffusion, grad_diffusion, d, u_exact_f2, m, N, nu);
end
save('..\data\example2_data', 'rel_L2_error_CS', 'card_index')


%% Plot example 2
figure(15)
load('..\data\example2_data')
x_data = 1:N;
y_data = zeros(length(x_data), N_runs, 1);
y_data(:, :, 1) = rel_L2_error_CS;
[hMeanPlots] = plot_book_style(x_data, y_data, 'shaded', 'mean_std_log10');
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
ylim([1e-10 10]);
xlim([0 150])
xlabel('# of iterations');
ylabel('relative L2 error');
title('Example 1 (3000 sample pts)')
set(gca,'YScale','log')
set(gca,'FontSize',20);
title('Example 2')


%%  4
figure(4)
m = 3000; %number of sample point
N = 150;
[I3, z3] = Adaptive_lower_OMP(diffusion, grad_diffusion, d, u_exact_f3, m, N, nu);
title('Example 3')

%% Run adaptive OMP on example 4
m = 3000; %number of sample point
N = 200;
N_runs = 10;
rel_L2_error_CS = zeros(N, N_runs);
card_index = zeros(N, N_runs);
for i_runs = 1: N_runs
    [rel_L2_error_CS(:, i_runs), card_index(:, i_runs), ~, ~] = Adaptive_lower_OMP(diffusion, grad_diffusion, d, u_exact_f4, m, N, nu);
end
save('..\data\example4_data', 'rel_L2_error_CS', 'card_index')


%% Plot example 4
figure(16)
load('..\data\example4_data')
N = 200;
x_data = 1:N;
y_data = zeros(length(x_data), N_runs, 1);
y_data(:, :, 1) = rel_L2_error_CS;
[hMeanPlots] = plot_book_style(x_data, y_data, 'shaded', 'mean_std_log10');
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
ylim([1e-4 10]);
xlim([0 150])
xlabel('# of iterations');
ylabel('relative L2 error');
title('Example 1 (3000 sample pts)')
set(gca,'YScale','log')
set(gca,'FontSize',20);
title('Example 4')

