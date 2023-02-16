function x = my_omp(A,b,s)

[m,N] = size(A);
A1 = zeros(m,N);
norms = sqrt(sum(abs(A).^2,1));
A1 = A * diag(1./norms);
x1 = omp(A1'*b,A1'*A1,s);
x = x1 ./ norms(:);
end

