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
%%
figure(1)
m = 3000; %number of sample point
N = 100;
[I1, z1] = Adaptive_lower_OMP(diffusion, grad_diffusion, d, u_exact_f1, m, N, nu);
title('Example 1')

%%
figure(2)
m = 3000; %number of sample point
N = 100;
[I2, z2] = Adaptive_lower_OMP(diffusion, grad_diffusion, d, u_exact_f2, m, N, nu);
title('Example 2')

%%
figure(3)
m = 500;
N = 20;
[I3, z3] = Adaptive_lower_OMP(diffusion, grad_diffusion, d, u_exact_f0, m, N, nu);

%%
figure(4)
m = 4000; %number of sample point
N = 200;
[I3, z3] = Adaptive_lower_OMP(diffusion, grad_diffusion, d, u_exact_f3, m, N, nu);
title('Example 3')

%%
figure(5)
m = 3000; %number of sample point
N = 100;
[I4, z4] = Adaptive_lower_OMP(diffusion, grad_diffusion, d, u_exact_f4, m, N, nu);
title('Example 4')

