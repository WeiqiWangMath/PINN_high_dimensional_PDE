clear
addpath '..\graphic'
addpath '..\utils'
% Test the spectral collocation mathod in 2D
% grad_diffusion{1} = @(x) zeros(size(x(:,1)));
% grad_diffusion{2} = @(x) zeros(size(x(:,1)));
% grad_diffusion{3} = @(x) 0.5 * ones(size(x,1));
% grad_diffusion{4} = @(x) 0.25 * ones(size(x,1));
% grad_diffusion{5} = @(x) 0.5 * ones(size(x,1));
% grad_diffusion{6} = @(x) 0.75 * ones(size(x,1));

% diffusion = @(x) 1 + 0.25 * (x(:,1) + x(:,2) + 2 * x(:,3) + x(:,4) + 2 * x(:,5) + 3 * x(:,6));
diffusion = @(x) 1 + 0.25 * sin(2*pi*x(:,1)) .* sin(2*pi*x(:,2)) + 0.25 * cos(4*pi*x(:,1));
grad_diffusion{1} = @(x) 0.25 * 2*pi*cos(2*pi*x(:,1)) .* sin(2*pi*x(:,2)) - 0.25 * 4*pi*sin(4*pi*x(:,1));
grad_diffusion{2} = @(x) 0.25 * 2*pi*cos(2*pi*x(:,2)) .* sin(2*pi*x(:,1));

% load exact solution
load('data/D8_Sparse_solution.mat')
% u_exact_f1 = @(x,y) exp(sin(2*pi*x));
% u_exact_f2 = @(x,y) exp(sin(4*pi*x));
% u_exact_C = integral(u_exact_f1,0,1)^2;
% u_exact = @(x) exp(sin(2*pi*x(:,1))+sin(2*pi*x(:,2))) - u_exact_C;

BC_type = 'PERIODIC';
tic
n = 8; % dimension


for k = 3 : n
    grad_diffusion{k} = @(x) zeros(size(x(:,1)));
end
I = generate_index_set('HC',n,10); % index set for Fourier basis
I(:,(size(I,2)+1)/2) = []; 

N = size(I,2); % number of sampling points for full recovery
s_vals = 2.^(2:10);

m_vals = ceil(2*s_vals);
N_runs = 25;

% random grid to measure the errors
N_error = 2*N;
h_int = 1/N_error;
y1_grid = generate_sampling_grid('uniform',n,N_error); 

u_exact_grid_int = u_exact(y1_grid);

N_error = 4*N;
full_uniform_grid = generate_sampling_grid('uniform',n,N_error);
A_full = generate_collocation_matrix(diffusion, grad_diffusion, I, full_uniform_grid, BC_type);
f_full = compute_forcing_given_solution(diffusion, u_exact, full_uniform_grid);
x_exact_approach = A_full\f_full;

x_sort = sort(x_exact_approach);

i_s = 0;
for s = s_vals
    fprintf('%d ',s)
    i_s = i_s + 1;
    
    % Number of the sampling points
%     m = m_vals(i_s);
    m = 2*s;
    
    
%     A_full = generate_collocation_matrix(diffusion, grad_diffusion, I, y1_grid, BC_type);

    % Compute the forcing terms

%     f_full = compute_forcing_given_solution(diffusion, u_exact, y1_grid);

    % Full recover
%     x_full = A_full\f_full;
    
    parfor i_run = 1:N_runs
        
        
        random_grid = generate_sampling_grid('uniform',n,m);
        A_CS = generate_collocation_matrix(diffusion, grad_diffusion, I, random_grid, BC_type);
        f_CS = compute_forcing_given_solution(diffusion, u_exact, random_grid);
         
        
        norms = sqrt(sum(abs(A_CS).^2,1));
        A_CS1 = A_CS * diag(1./norms);
        
        % CS using womp
        [x_CS1,res,~,stat] = womp_complex(A_CS1, f_CS,ones(size(A_CS,2),1),0,s,'l0w',[]);
%         [x_lasso1,res_1,~,stat1] = womp(A_CS1, f_CS,ones(size(A_CS,2),1),10,s,'wlasso',[]);

        [x_qcbp1,stat] = wqcbp(A_CS1,f_CS,ones(size(A_CS1,2),1),norm(A_CS*x_exact_approach-f_CS,2),[]);
        x_CS = x_CS1(:,s) ./ norms(:);
        x_qcbp = x_qcbp1(:) ./ norms(:);
%         norm(x_CS-x_CS1,2)
        x_backslash = A_CS\f_CS;
        
        % Compare solution to the exact one
%         u_full = @(y_grid) evaluate_solution_given_coefficients(I, x_full, y_grid, BC_type);
        u_qcbp = @(y_grid) evaluate_solution_given_coefficients(I, x_qcbp, y_grid, BC_type);
        u_CS = @(y_grid) evaluate_solution_given_coefficients(I, x_CS, y_grid, BC_type);
        u_backslash = @(y_grid) evaluate_solution_given_coefficients(I, x_backslash, y_grid, BC_type);
%         u_full_grid_int  = u_full(y1_grid);
        u_qcbp_grid_int  = u_qcbp(y1_grid);
        u_CS_grid_int  = u_CS(y1_grid);
        u_backslash_grid_int = u_backslash(y1_grid);
        
        % Compute error
        u_L2_norm                        = h_int * norm(u_exact_grid_int(:),2);
%         rel_L2_error_full(i_s,i_run)     = h_int * norm(real(u_exact_grid_int(:) - u_full_grid_int(:)),2) / u_L2_norm;
        rel_L2_error_backslash(i_s,i_run)     = h_int * norm(real(u_exact_grid_int(:) - u_backslash_grid_int(:)),2) / u_L2_norm;
        rel_L2_error_qcbp(i_s,i_run) = h_int * norm(u_exact_grid_int(:) - u_qcbp_grid_int(:),2) / u_L2_norm;
        rel_L2_error_CS(i_s,i_run)       = h_int * norm(real(u_exact_grid_int(:) - u_CS_grid_int(:)),2) / u_L2_norm;
        
    end
end




i_s = 0;
for s = s_vals
    i_s = i_s +1;
    for i_run = 1:N_runs
        rel_L2_s_term_error1(i_s,i_run) = norm(x_sort(1:(size(x_sort,1)-s)),1)/sqrt(s) / sqrt(h_int * norm(u_exact_grid_int(:),2)^2);
        rel_L2_s_term_error2(i_s,i_run) = norm(x_sort(1:(size(x_sort,1)-s)),2)/sqrt(s) / sqrt(h_int * norm(u_exact_grid_int(:),2)^2);
    end
end

y_data = zeros(size(s_vals,2),N_runs,2);
% y_data(:,:,1) = rel_L2_error_full;
y_data(:,:,1) = rel_L2_error_CS;
y_data(:,:,2) = rel_L2_error_qcbp;
y_data(:,:,3) = rel_L2_error_backslash;
y_data(:,:,4) = rel_L2_s_term_error1;
figure(6)
hmean_plot = plot_book_style(s_vals, y_data, 'shaded', 'mean_std_log10');
vert_plot1 = xline(length(I)/2,'Linewidth',2,'LineStyle',':');
legend([hmean_plot vert_plot1],{'CS','QCBP','Backslash','$$\sigma_s(c_\Lambda)_1/\sqrt{s}$$','$$s=|\Lambda|$$'},'Interpreter','latex')
set(gca,'YScale','log')
xlabel('s=m/2')
ylabel('Relative L_2 error')
toc
N = length(I);

save('data/D8_EtaSparse_SoluNonSparse.mat','s_vals','y_data','N');
