% Compute value of solution from given BA-Legendre coefficients
% Inputs:
% % I - index set of BA-Legendre polynomial
% % c - BA-Legendre coefficients
% % y_grid - grid points
% Output:
% A -  value of the function with given coefficients at grid points
% polynomial at grid points
function ux = evaluate_solution_given_coefficients(I, c, y_grid, BC_type)
[d,N] = size(I); % get N (number of matrix columns) and d (dimension)
m = size(y_grid,1); % get m (number of matrix rows)
ux = zeros(m,1);
n = max(abs(I(:))); % find maximum polynomial degree

for i = 1:m
    y = y_grid(i,:); % select ith sample point

    switch BC_type
        case 'HOMO'
            % evaluate the 1D BA-Legendre matrix at the components of y
            [L, ~, ~] = legmat_derivative_BA(y', n); 
        case 'PERIODIC'
            % evaluate the 1D Fourier matrix at the components of y
            [L, ~, ~] = fourier_complex_mat_derivative(y', n);
    end

    % evaluate the dD polynomials via tensor products
    ux(i) = 0;
 
    L_j = ones(N,1);

        for k = 1:d
            L_j = L_j .* L(k,I(k,:)+n+1).';
        end
        ux(i) = ux(i) + sum( c .* L_j); 
end

end