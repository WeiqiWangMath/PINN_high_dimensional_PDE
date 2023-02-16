%--- Description ---%
%
% Filename: Adaptive_lower_OMP.m
%
% Description: computes the reduced margin set of a given lower index set
%
% Inputs:
% diffusion - diffusion coefficient
% grad_diffusion - gradient of the diffusion coefficient
% d - number of dimension
% u_exact - exact solution
% m - number of total collocation points
% N - number of iterations
% N_runs - number of runs

% Output:
% I - index set of the solution by adaptive lower OMP
% z - Fourier coefficient of the solution on index set I


function [rel_L2_error_CS, card_index, I, z] = Adaptive_lower_OMP(diffusion, grad_diffusion, d, u_exact, m, N, nu)


tic
BC_type = 'PERIODIC'; % Type of boundary condition

I = zeros(d, 1);
R = zeros(d, 1);

% random collocation points
random_grid = generate_sampling_grid('uniform',d,m);

% random grid and the exact solution to measure the errors
N_error = 2*m;
h_int = 1/N_error;
y1_grid = generate_sampling_grid('uniform',d,N_error);
u_exact_grid_int = u_exact(y1_grid);
u_L2_norm  = h_int * norm(u_exact_grid_int(:),2);

% Compute the right hand size
f_CS = compute_forcing_given_solution(diffusion, u_exact, random_grid, nu);
r = f_CS; % initialize residual
A_CS_I = generate_collocation_matrix(diffusion, grad_diffusion, I, random_grid, BC_type, nu); 


rel_L2_error_CS = zeros(N, 1);
card_index = zeros(N, 1);

    % Number of iterations
    
    for k = 1:N

        k
        % Find reduced margin
        R_new = find_reduced_margin(I);
        
        % Find repear elements in reduced margin and undate CS matrix
        [~, loc] = ismember(R_new.', R.', "rows");
        A_CS_R_new = zeros(m, size(R_new,2));
        for j = 1: size(R_new,2)
            if loc(j) == 0
                A_CS_R_new(:, j) = generate_collocation_matrix(diffusion, grad_diffusion, R_new(:,j), random_grid, BC_type, nu);
            else
                A_CS_R_new(:, j) = A_CS_R(:, loc(j));
            end
        end
        A_CS_R = A_CS_R_new;
        A_CS = [A_CS_I A_CS_R];
        R = R_new;

        norms = sqrt(sum(abs(A_CS).^2,1));
        A_CS1 = A_CS * diag(1./norms);   % normalize columns
        
        if k > 1 
            % Calculate the residual
            r = f_CS - A_CS * [z ;zeros(size(R,2),1)];

            % Compare solution to the exact one
            u_CS = @(y_grid) evaluate_solution_given_coefficients(I, z, y_grid, BC_type);
            u_CS_grid_int  = u_CS(y1_grid);
            rel_L2_error_CS(k-1)       = h_int * norm(real(u_exact_grid_int(:) - u_CS_grid_int(:)),2) / u_L2_norm;
%             figure(2)
%             plot3(y1_grid(:,1),y1_grid(:,2), real(u_exact_grid_int(:) - u_CS_grid_int(:)),'.')

            % Save size of the current index set 
            card_index(k-1) = size(I, 2);


            % Plot figure of the lower set and margin set
%             clf
%             scatter(I(1,:)', I(2,:)', 'filled')
%             hold on
%             scatter(R(1,:)', R(2,:)')
%             set(gcf, 'InnerPosition',  [100, 0, 800, 700]);
%             set(gcf, 'OuterPosition',  [0, 0, 900, 700]);
%             xline(0);
%             yline(0); 
%             axis([-8 8 -8 8])
%             xlabel('\nu_1')
%             ylabel('\nu_2')
%             axis equal
%             pause
        end

        % CS using womp
        quantity = zeros(1, size(I,2) + size(R,2));
        T = (size(I,2)+1):(size(I,2) + size(R,2)); % Only search on the reduced margin set 
        quantity(T) = abs(A_CS1(:,T)'* r); 
        [~, sel_index] = max(quantity(T));
        
        % Current sparsity
        S = size(I,2);
      


        % Add new index sets to I
        support = 1: S;
        for i = 1:size(R,2)
            if isequal(abs(R(:,i)),abs(R(:,sel_index)))
                I = [I R(:,i)];
                support = [support S+i];
                A_CS_I = [A_CS_I A_CS_R(:, i)];
            end
        end
        
        % Solve for z for the current index set
        x_CS1 = A_CS1(:,support) \ f_CS;
        z = x_CS1 ./ norms(support)';
        
    end


% y_data = zeros(size(card_index,2),N_runs,2);
% % y_data(:,:,1) = rel_L2_error_full;
% y_data(:,:,1) = rel_L2_error_CS;
% hmean_plot = plot_book_style(card_index, y_data, 'shaded', 'mean_std_log10');
% % vert_plot = xline(length(I)/2,'Linewidth',2,'LineStyle',':');
% % legend([hmean_plot vert_plot],{'CS'})
% % legend(hmean_plot,'CS')
% set(gca,'YScale','log')
% xlabel('Cardinality of the index set')
% ylabel('Relative L_2 error')
% set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
% set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
% set(gca,'FontSize',20);



