% Compute the gradient of the diffusion coefficient
% Legendre polynomial is defined on [-1,1]
% Inputs:
% % f - diffusion coefficient
% % d - f is a dD function
% Output:
% % Df - gradient of f, Df{i} is the partial derivative to i-th component
function Df = compute_gradient(f)

% Symbolic differentiation
x = sym('x',[2 1]);

for dim = 1:2
    Df_sym{dim} = diff( f(x(1),x(2)), x(dim) );
    for j = 1:2
        if isAlways(diff(Df_sym{dim}, x(j)) == 0)
            Is_Df_constant_wrt_xj(dim,j) = 1;
        end
    end
end
clear x;

% Conversion to function handle
for dim = 1:2
    Df{dim} = matlabFunction(Df_sym{dim});
    switch nargin(Df{dim}) 
        case 0 % constant function handle
            Df{dim} = @(x1,x2) 0*x1 + Df{dim}(); 
        case 1 % function handle depending on one variable
            if Is_Df_constant_wrt_xj(dim,1) == 1
                Df{dim} = @(x1,x2) 0*x1 + Df{dim}(x2);
            elseif Is_Df_constant_wrt_xj(dim,2) == 1
                Df{dim} = @(x1,x2) Df{dim}(x1) + 0*x2;
            end
    end    
end