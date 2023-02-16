clear;
% Test the spectral collocation mathod in 2D
grad_diffusion{1} = @(x) 0.25 * ones(size(x,1));
grad_diffusion{2} = @(x) 0.25 * ones(size(x,1));
diffusion = @(x) 1 + 0.25 * (x(:,1) + x(:,2));
% u_exact = @(x) (4 * (x(1)+1) .* (x(2)+1) .* (1-x(1)) .* (1-x(2))).^2;
% u_exact = @(x) cos(pi*x(:,1)/2) .* cos(pi*x(:,2)/2);
u_exact = @(x) (exp(cos(pi*x(:,1)/2))-1) .* (exp(cos(pi*x(:,2)/2))-1);


n = 20; % dimension
N = n^2;
s_vals = 2.^(1:6);
m_vals = ceil(2*s_vals*log(N));
N_runs = 5;



I = generate_index_set_BA('TP',2,n-1);
h_int = 2/(n+2)/4;
[X, Y] = meshgrid(-1:h_int:1);
y1_grid = [X(:) Y(:)];
u_exact_grid_int = zeros(size(y1_grid,1),1);
full_grid = generate_full_grid_2D(n);
% full_grid = generate_sampling_grid('uniform',2,N);
for i = 1: size(y1_grid,1)
    u_exact_grid_int(i) = u_exact(y1_grid(i,:));
end
i_s = 0;
for s = s_vals
    fprintf('%d ',s)
    i_s = i_s + 1;
    
    m = m_vals(i_s);
    
    
    A_full = generate_collocation_matrix(diffusion,grad_diffusion,I,full_grid);

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
        A_CS = generate_collocation_matrix(diffusion,grad_diffusion,I,random_grid);
        f_CS = f_full(random_index);
        x_CS = my_omp(A_CS,f_CS,s);
        
        % Compare solution to the exact one
        u_full = @(y_grid) evaluate_solution_given_coefficients(I, x_full, y_grid);
        u_full_omp = @(y_grid) evaluate_solution_given_coefficients(I, x_full_omp, y_grid);
        u_CS = @(y_grid) evaluate_solution_given_coefficients(I, x_CS, y_grid);
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

figure(4)
[X, Y] = meshgrid(-1:0.1:1);
y1_grid = [X(:) Y(:)];
u_exact_grid_plot = zeros(size(y1_grid,1),1);
for i = 1: size(y1_grid,1)
    u_exact_grid_plot(i) = u_exact(y1_grid(i,:));
end
u_exact_grid_plot = reshape(u_exact_grid_plot,[21 21]);
surf(X, Y, u_exact_grid_plot);