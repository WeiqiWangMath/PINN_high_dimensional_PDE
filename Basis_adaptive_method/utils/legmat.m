% Compute Legendre matrix on 1D points
% Inputs:
% % grid - 1D column vector of sample points
% % k - maximum order of Legendre polynomial
% % d - order of derivatives 0,1,2
% Output:
% A -  matrix A, A(:,j) is the value of j-th (j-1 order) Legendre
% polynomial at grid points

function A = legmat_derivative(grid ,k ,d)
A = zeros(length(grid),k);
A(:,1) = 1;
A(:,2) = grid;
for i = 2:k-1
    A(:,i+1)=(grid.* (2*i - 1).*A(:,i)- (i-1).*A(:,i-1))/i;
end
if d == 1
    A1 = zeros(length(grid),k); % A1: Legendre derivative matrix
    A1(:,1) = 0;
    A1(:,2) = 1;
    for i = 2:k-1
        A1(:,i+1) = (i * A(:,i)- A1(:,i-1) .* grid);
    end
elseif d==2
    A2 = zeros(length(grid),k); % A1: Legendre derivative matrix
    A2(:,1) = 0;
    A2(:,2) = 1;
    for i = 2:k-1
        A2(:,i+1) = ;
    end
end
if d == 1
    A = A1;
elseif d == 2
    A = A2;
end
end
