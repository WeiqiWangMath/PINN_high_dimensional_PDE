function [x_vals,res,norms,stat] = womp(A,y,w,lambda,n_iter,type,cvx_opt)
% [X,RES,NORMS] = WOMP(A,Y,W,LAMBDA,N_ITER,OPT) 
%
% type 'wlasso', 'wsrlasso', 'wsrlassoGrad'
N = size(A,2);
for j = 1:N
    if abs(norm(A(:,j),2) - 1) > 1e-12
        error('The columns of A must have unit length')
    end
end

if ~exist('cvx_opt','var')
    cvx_opt = [];
end
cvx_opt = set_options(cvx_opt);

w = w(:); % weights must form a column vectors

% Initialize data structures
x_vals = zeros(N,n_iter+1);
res = zeros(1,n_iter+1); 
res(1) = norm(y); % first residual norm is ||y||_2 since x_0 = 0
norms = zeros(1,n_iter+1);
stat = cell(1,n_iter+1);
stat{1} = 'Solved';
support = [];

% if cvx_opt.womp_verbose
%     fprintf('Iter \t||Ax-y||_2 \t||x||_{1,w} \tMax Value \tSel Index\n')
% end

for iter = 2 : n_iter+1   
    r = y - A * x_vals(:,iter-1);  % current residual
    search_set = 1:N; 
    % search_set = setdiff(1:N, support);
    % define quantity to be maximized for the new index search
    switch type
        case 'wlasso'
            quantity = abs(abs(A'*r) - lambda/2 * w);
        case 'wsrlasso'           
            quantity = -(lambda * w .* abs(A'*r) + sqrt((1-(lambda*w).^2).*(norm(r,2)^2-abs(A'*r).^2)));
        case 'wsrlassoGrad'
            quantity = abs(A'*r/norm(r,2) + lambda * w.*sign(x));
        case 'l0w'
            S = support;      
            T = setdiff(search_set,S); % complement of S
            x = x_vals(:,iter-1);     % previous approximation (row vector)
            quantity(T) = min([-abs(A(:,T)'*r).^2 + lambda * w(T).^2, zeros(size(x(T)))],[],2);       
            quantity(S) = (1-(x(S)==0)) .* min([abs(x(S)).^2 - lambda * w(S).^2, zeros(size(x(S)))],[],2);
            quantity = - quantity; % switch sign to maximize it
        otherwise
            error('type not supported')
    end    
    [max_value, sel_index] = max(quantity(search_set)); % find new index  
    support = union(support, search_set(sel_index)); % update support
    
    % Solve reduced (regularized) least-squares problem
    if isequal(type,'wlasso')
        [x_S, status] = wlasso(A(:,support),y,w(support),lambda,cvx_opt);
    elseif isequal(type,'wsrlasso') || isequal(type,'wsrlassoGrad')
        [x_S,status] = wsrlasso(A(:,support),y,w(support),lambda,cvx_opt);
    elseif isequal(type,'l0w')
        x_S = A(:,support) \ y;
        status = 'Solved';
    else
        error('type not supported')
    end
    x_vals(support,iter) = x_S;
    
    res(iter) = norm(y - A*x_vals(:,iter),2);
    norms(iter) = norm(x_vals(:,iter) .* w, 1);
    stat{iter} = status;
    
    % Print output
%     if cvx_opt.womp_verbose
%         fprintf('%3d  \t%1.2e  \t%1.2e  \t%1.2e \t%d\n',iter,res(iter),norms(iter),max_value,sel_index)
%     end
    %stem(x); 
    %title(['iteration',num2str(iter)])
    %pause
        
end

