function f = compute_forcing_given_solution_2D(diffusion,grad_diffusion,u)
x = sym('x',[2,1]);
grad_u{1} = diff(u(x), x(1));
grad_u{2} = diff(u(x), x(2));
Laplacian_u = diff(grad_u{1},x(1)) + diff(grad_u{2},x(2));
f_sym = - grad_diffusion{1}(x) * grad_u{1} - grad_diffusion{2}(x) * grad_u{2} - diffusion(x) * Laplacian_u;
% for j = 1:2
%     if isAlways(diff(f_sym, x(j)) == 0)
%         Is_f_constant_wrt_xj(j) = 1;
%     end
% end
clear x

% Conversion to function handle
f = matlabFunction(f_sym); 
switch nargin(f)
    case 0 % constant function handle
        f = @(x) 0*x(1) + f();
    case 1 % function handle depending on one variable
        if Is_f_constant_wrt_xj(1) == 1
            f = @(x) 0*x(1) + f(x(2));
        elseif Is_f_constant_wrt_xj(2) == 1
            f = @(x) f(x(1)) + 0*x(2);
        end
end

end

