% Compute Boundary adapted Legendre matrix on 1D points. 
% Legendre polynomial is defined on [-1,1]
% Inputs:
% % grid - 1D column vector of sample points
% % k - maximum order of Legendre polynomial +1 
% % d - order of derivatives 0,1,2
% Output:
% A -  matrix A, A(:,j) is the value of j-th (j-1 order) Legendre
% polynomial at grid points
% A1 -  matrix A1, A1(:,j) is the value of derivative j-th (j-1 order) Legendre
% polynomial at grid points
% A2 -  matrix A2, A2(:,j) is the value of 2nd derivative j-th (j-1 order) Legendre
% polynomial at grid points

function [A, A1, A2] = legmat_derivative_BA(grid ,k)
T = zeros(k, length(grid)); % T is the transform matrix from Legendre to boundary adapted Legendre
switch k
    case 1
        T = 1/2;
    case 2
        T = [1/2 1/2;-1/2 1/2];
    otherwise
        T=zeros(k);
        T(1,1) = 1/2;
        T(1,2) = 1/2;
        T(2,1) = -1/2;
        T(2,2) = 1/2;
        for i = 3:k
            T(i-2, i) = 1/sqrt(2 * (2*i-3));
            T(i, i) = -1/sqrt(2 * (2*i-3));
        end
A = legmat_derivative(grid ,k, 0) * T;
A1 = legmat_derivative(grid ,k, 1) * T;
A2 = legmat_derivative(grid ,k, 2) * T;
end
