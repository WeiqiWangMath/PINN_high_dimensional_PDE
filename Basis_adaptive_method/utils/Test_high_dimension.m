addpath 'C:\Users\weiqi\Documents\Compressive spectral method\compressive spectral collocation method\ompbox10'
% Test the spectral collocation mathod in 2D
grad_diffusion{1} = @(x) 0.25 * ones(size(x,1));
grad_diffusion{2} = @(x) 0.25 * ones(size(x,1));
% grad_diffusion{3} = @(x) 0.5 * ones(size(x,1));
% grad_diffusion{4} = @(x) 0.25 * ones(size(x,1));
% grad_diffusion{5} = @(x) 0.5 * ones(size(x,1));
% grad_diffusion{6} = @(x) 0.75 * ones(size(x,1));

% diffusion = @(x) 1 + 0.25 * (x(:,1) + x(:,2) + 2 * x(:,3) + x(:,4) + 2 * x(:,5) + 3 * x(:,6));
diffusion = @(x) 1 + 0.25 * (x(:,1) + x(:,2));

u_exact = @(x) (4 * (x(:,1)+1) .* (x(:,2)+1) .* (1-x(:,1)) .* (1-x(:,2))).^2;
% u_exact = @(x) rand_trig_fcn([0 0 0 0 0 0],x);
% u_exact = @(x) rand_poly_fcn([2 1 3 2 1 1],x);
% u_exact = @(x) exp_cos_fcn([0 0 0 0 0 0],x);
BC_type = 'HOMO';
% BC_type = 'PERIODIC';
tic
n = 2; % dimension

I = generate_index_set_BA('TP',n,10); % index set for BA polynomial
% I = generate_index_set('TP',n,4); % index set for Fourier basis
if isequal(BC_type, 'PERIODIC')
    I(:,1)=[];
end
N = size(I,2); % number of sampling points for full recovery
s_vals = 2.^(1:7);
m_vals = ceil(2*s_vals*log(N));
N_runs = 5;

% random grid to measure the errors
N_error = 2*N;
h_int = 1/N_error;
y1_grid = generate_sampling_grid('uniform',n,N_error); 

full_grid = generate_sampling_grid('uniform',n,N); % generate sample points

u_exact_grid_int = u_exact(y1_grid);

i_s = 0;
for s = s_vals
    fprintf('%d ',s)
    i_s = i_s + 1;
    
    m = m_vals(i_s);
    
    
    A_full = generate_collocation_matrix(diffusion, grad_diffusion, I, full_grid, BC_type);

    % Compute the forcing terms
%     forcing_term = compute_forcing_given_solution_2D(diffusion, grad_diffusion, u_exact);
%     f_full = forcing_term(full_grid(:,1),full_grid(:,2));
    f_full = compute_forcing_given_solution(diffusion,u_exact,full_grid);

    % Full recover
    x_full = A_full\f_full;
    % Full omp
    x_full_omp = my_omp(A_full,f_full,s);
    
    for i_run = 1:N_runs
        
        
        % CS
        random_index = randi([1,N],1,m);
        random_grid = full_grid(random_index, :);
        A_CS = generate_collocation_matrix(diffusion, grad_diffusion, I, random_grid, BC_type);
        f_CS = f_full(random_index);
        x_CS = my_omp(A_CS,f_CS,s);
        
        % Compare solution to the exact one
        u_full = @(y_grid) evaluate_solution_given_coefficients(I, x_full, y_grid, BC_type);
        u_full_omp = @(y_grid) evaluate_solution_given_coefficients(I, x_full_omp, y_grid, BC_type);
        u_CS = @(y_grid) evaluate_solution_given_coefficients(I, x_CS, y_grid, BC_type);
        u_full_grid_int  = u_full(y1_grid);
        u_full_omp_grid_int  = u_full_omp(y1_grid);
        u_CS_grid_int  = u_CS(y1_grid);
        
        % Compute error
        u_L2_norm                        = h_int * norm(u_exact_grid_int(:),2);
        rel_L2_error_full(i_s,i_run)     = h_int * norm(u_exact_grid_int(:) - u_full_grid_int(:),2) / u_L2_norm;
        rel_L2_error_full_omp(i_s,i_run) = h_int * norm(u_exact_grid_int(:) - u_full_omp_grid_int(:),2) / u_L2_norm;
        rel_L2_error_CS(i_s,i_run)       = h_int * norm(u_exact_grid_int(:) - u_CS_grid_int(:),2) / u_L2_norm;
    end
end


figure(1)
boxplot(rel_L2_error_full','labels',s_vals)

figure(2)
boxplot(rel_L2_error_full_omp','labels',s_vals)

figure(3)
boxplot(rel_L2_error_CS','labels',s_vals)
FONT_SIZE = 20;
for i_fig = 1:3
    figure(i_fig)
    pbaspect([1 1 1])
    ylim([min(min([rel_L2_error_full; rel_L2_error_full_omp; rel_L2_error_CS])),...
    max(max([rel_L2_error_full; rel_L2_error_full_omp; rel_L2_error_CS]))]);
    if i_fig == 1
        ylabel('Relative $L^2(\Omega)$-error','interpreter','latex')
    else
        set(gca,'yticklabels',[]);
    end
    set(gca,'yscale','log')
    grid on
   
    set(gca,'fontsize',FONT_SIZE)
    set(gca,'ticklabelinterpreter','latex')
    set(gcf,'color','white')
end
toc
