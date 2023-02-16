% Compute forcing term for given diffusion function and exact solution
% 
% Inputs:
% % diffusion - diffusion function
% % grid_pt - collocation points where we compute forcing term (m x d)
% % matrix
% % u_exact - exact solution
% % d - number of dimension of the problem
% % nu - nu in the equation
% Output:
% % f - value of the forcing term at collocation points

function f = compute_forcing_given_solution(diffusion, u_exact, grid_pt, nu)
[m,d] = size(grid_pt);
% d - number of dimension of the problem
dx = 3e-3; % difference in x
grad_diff = cell(1,d);
grad_u = cell(1,d);
Laplacian_u = zeros(m,1);
f = zeros(m,1);
f = f + nu * u_exact(grid_pt);
for i = 1:d
    dx_i = zeros(m,d);
    dx_i(:,i) = ones(m,1);
    
    % 4-th order finite difference scheme (first derivative)
%     grad_diff{i} = (1/12 * diffusion(grid_pt - 2*dx*dx_i) - 2/3 * diffusion(grid_pt - dx*dx_i) + 2/3 * diffusion(grid_pt + dx*dx_i) - 1/12 * diffusion(grid_pt + 2*dx*dx_i)) / dx;
%     grad_u{i} = (1/12 * u_exact(grid_pt - 2*dx*dx_i) - 2/3 * u_exact(grid_pt - dx*dx_i) + 2/3 * u_exact(grid_pt + dx*dx_i) - 1/12 * u_exact(grid_pt + 2*dx*dx_i)) / dx;
    
    % 6-th order finite difference scheme (first derivative)
    grad_diff{i} = (-1/60 * diffusion(grid_pt - 3*dx*dx_i) + 3/20 * diffusion(grid_pt - 2*dx*dx_i) - 3/4 * diffusion(grid_pt - dx*dx_i) + 3/4 * diffusion(grid_pt + dx*dx_i) - 3/20 * diffusion(grid_pt + 2*dx*dx_i) + 1/60 * diffusion(grid_pt + 3*dx*dx_i)) / dx;
    grad_u{i} = (-1/60 * u_exact(grid_pt - 3*dx*dx_i) + 3/20 * u_exact(grid_pt - 2*dx*dx_i) - 3/4 * u_exact(grid_pt - dx*dx_i) + 3/4 * u_exact(grid_pt + dx*dx_i) - 3/20 * u_exact(grid_pt + 2*dx*dx_i) + 1/60 * u_exact(grid_pt + 3*dx*dx_i)) / dx;
    
    f = f - grad_diff{i} .* grad_u{i};
    
    % 4-th order finite difference scheme (second derivative)
%     Laplacian_u = Laplacian_u + (-1/12 * u_exact(grid_pt - 2*dx*dx_i) + 4/3 * u_exact(grid_pt - dx*dx_i) - 5/2 * u_exact(grid_pt) + 4/3 * u_exact(grid_pt + dx*dx_i) - 1/12 * u_exact(grid_pt + 2*dx*dx_i)) / dx^2;
    
    % 6-th order finite difference scheme (second derivative)
    Laplacian_u = Laplacian_u + (1/90 * u_exact(grid_pt - 3*dx*dx_i) -3/20 * u_exact(grid_pt - 2*dx*dx_i) + 3/2 * u_exact(grid_pt - dx*dx_i) - 49/18 * u_exact(grid_pt) + 3/2 * u_exact(grid_pt + dx*dx_i) - 3/20 * u_exact(grid_pt + 2*dx*dx_i) +1/90 * u_exact(grid_pt + 3*dx*dx_i)) / dx^2;
end
f = f - diffusion(grid_pt) .* Laplacian_u;
end

