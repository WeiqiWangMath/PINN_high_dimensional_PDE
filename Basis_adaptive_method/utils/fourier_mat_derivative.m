% Compute Fourier basis collocation matrix on 1D points. 
% Fourier basis is defined on [0,1] 1,cos(2*pi*x),sin(2*pi*x)...
% Inputs:
% % grid - 1D column vector of sample points
% % k - number of Fourier basis 
% % d - order of derivatives 0,1,2
% Output:
% A -  matrix A, A(:,j) is the value of j-th (j-1 order) Fourier
% basis polynomial at grid points
% A1 -  matrix A1, A1(:,j) is the value of derivative j-th (j-1 order)
% Fourier basis at grid points
% A2 -  matrix A2, A2(:,j) is the value of 2nd derivative j-th (j-1 order)
% Fourier basis at grid points

function [A, A1, A2] = fourier_mat_derivative(grid ,k)
A = zeros(length(grid),k);
A1 = zeros(length(grid),k);
A2 = zeros(length(grid),k);
w = floor(k/2);

for j = 0:k-w-1
    A(:,j+1) = cos(j * 2*pi * grid');
    A1(:,j+1) = - j * 2*pi * sin(j* 2*pi* grid');
    A2(:,j+1) = - j^2 * 4*pi^2 * cos(j * 2*pi * grid');
end

for j = 1:w
    A(:,k-w+j) = sin(j * 2*pi * grid');
    A1(:,k-w+j) = j * 2*pi * cos(j* 2*pi* grid');
    A2(:,k-w+j) = - j^2 * 4*pi^2 * sin(j * 2*pi * grid');
end
end
