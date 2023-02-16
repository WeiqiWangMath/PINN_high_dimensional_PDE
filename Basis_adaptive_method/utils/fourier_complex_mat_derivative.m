% Compute Fourier complex basis collocation matrix on 1D points. 
% Fourier basis is defined on [0,1] 1,exp(2*pi*1i*x),exp(-2*pi*1i*x)...
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

function [A, A1, A2] = fourier_complex_mat_derivative(grid ,k)
A = zeros(length(grid),k);
A1 = zeros(length(grid),k);
A2 = zeros(length(grid),k);

for j = -k:k
    A(:,j+k+1) = exp(j * 2*pi * 1i *grid');
    A1(:,j+k+1) = j * 2*pi * 1i * exp(j * 2*pi * 1i *grid');
    A2(:,j+k+1) = -j^2 * 4*pi^2 * exp(j * 2*pi * 1i *grid');
end

end
