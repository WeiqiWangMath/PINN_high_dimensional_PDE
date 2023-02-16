function [c,stat] = wlasso(A,y,w,lambda,cvx_opt)
% C = WLASSO(A,Y,W,LAMBDA) solves the unconstrained weighted LASSO
%
%                2
% min ||A z - Y||   +  LAMBDA ||z||    
%  z             2                 1,W
%

% Simone Brugiapaglia, SFU 2017

n = size(A,2); % # of columns

if isequal(w,[])
    w = ones(n,1);
end

if ~exist('cvx_opt','var')
    cvx_opt = [];
end
cvx_opt = set_options(cvx_opt);

% the weights must form a column vector
w = w(:);

if lambda >= 0
    cvx_begin
        cvx_quiet(~cvx_opt.verbose)
        cvx_solver(cvx_opt.solver)
        cvx_precision(cvx_opt.precision)
        
        variable z(n) complex
        minimize( lambda * norm(w .* z,1) + (A*z - y)'*(A*z-y) ) % CVX does not accept norm()^2
    cvx_end
    
    stat = cvx_status;
    
    c = z;
else
    error('LAMBDA must be nonnegative')
end
