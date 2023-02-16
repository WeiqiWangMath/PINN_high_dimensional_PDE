function [c,stat] = wqcbp(A,y,w,eta,cvx_opt)
% C = WLASSO(A,Y,W,LAMBDA) solves the unconstrained weighted LASSO
%
%                            
% min ||z||     s.t. ||A z - Y||  <=  ETA     
%  z       1,W                  2                
%
%       
%
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

if eta < 0
    error('eta must be nonnegative.')
elseif eta == 0
    cvx_begin  
        cvx_quiet(~cvx_opt.verbose)    
        cvx_solver(cvx_opt.solver)
        cvx_precision(cvx_opt.precision)
    
        variable d(n) complex
        minimize( norm( w .* d, 1 ) )
        subject to
            A * d == y 
            

    cvx_end
    
    
    stat = cvx_status;
    
    c = d;    
else
    cvx_begin 
        cvx_quiet(~cvx_opt.verbose)    
        cvx_solver(cvx_opt.solver)
        cvx_precision(cvx_opt.precision)
        
        variable d(n) complex
        minimize( norm( w .* d, 1 ) )
        subject to
            norm( A * d - y , 2 ) <= eta
            
    cvx_end
    
    
    stat = cvx_status;
    
    c = d;
end