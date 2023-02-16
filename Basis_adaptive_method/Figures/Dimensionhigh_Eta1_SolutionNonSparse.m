clear
addpath '..\graphic'
addpath '..\utils'


diffusion = @(x) 1 + 0.25 * sin(2*pi*x(:,1)) .* sin(2*pi*x(:,2));
grad_diffusion{1} = @(x) 0.25 * 2*pi*cos(2*pi*x(:,1)) .* sin(2*pi*x(:,2));
grad_diffusion{2} = @(x) 0.25 * 2*pi*cos(2*pi*x(:,2)) .* sin(2*pi*x(:,1));


% load exact solution
% Example1
u_exact_f1 = @(x) sin(4*pi* x(:,1)) .* sin(2*pi* x(:,2));

% Example2
u_exact_f2 = @(x,y) exp(sin(4*pi*x));

% u_exact_C = integral(u_exact_f1,0,1)^2;
% u_exact = @(x) exp(sin(2*pi*x(:,1))+sin(2*pi*x(:,2))) - u_exact_C;

BC_type = 'PERIODIC';
tic
nu = 0.5;
d = 6; % dimension
m = 2000; %number of sample point
N = 50;
for i = 3:d
    grad_diffusion{i} = @(x) zeros(size(x(:,1)));
end

figure(1)
[I, z] = Adaptive_lower_OMP(diffusion, grad_diffusion, d, u_exact_f1, m, N, nu)

