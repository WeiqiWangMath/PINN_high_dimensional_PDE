addpath('../graphic')
addpath('./data')

%% Visualize 2D HC index set Fig 1(a),1(b)

figure(1);
I = generate_index_set('HC',2,38); 
I(:,223) = []; 
figure(1);
plot(I(1,:),I(2,:),'.')
axis on;
xlabel('\nu_1');
ylabel('\nu_2');
set(gcf, 'InnerPosition',  [100, 0, 800, 700]);
set(gcf, 'OuterPosition',  [0, 0, 900, 700]);
set(gca,'FontSize',24);

figure(2);
I = generate_index_set('HC',3,24); 
I(:,388) = []; 
plot3(I(1,:),I(2,:),I(3,:),'.');
axis on;
xlabel('\nu_1');
ylabel('\nu_2');
zlabel('\nu_3');
set(gcf, 'InnerPosition',  [100, 0, 800, 700]);
set(gcf, 'OuterPosition',  [0, 0, 900, 700]);
set(gca,'FontSize',24);

%% Fig 2(a) Surf plot of Exact solution : Sparse 

load('data/Exact_sparse_2D.mat')
figure(3)
[X,Y]=meshgrid(0:0.01:1,0:0.01:1);
surf(X,Y,reshape(u_exact([X(:),Y(:)]),101,101));
set(gcf, 'InnerPosition',  [100, 0, 1200, 800]);
set(gcf, 'OuterPosition',  [0, 0, 1200, 800]);
set(gca,'FontSize',20);
xlabel('x_1');
ylabel('x_2');
zlabel('u(x_1,x_2)');


%% Fig 2(b) Surf plot of Exact solution : Sparse

load('data/Exact_non_sparse.mat')
figure(4)
[X,Y]=meshgrid(0:0.01:1,0:0.01:1);
surf(X,Y,reshape(u_exact([X(:),Y(:)]),101,101));
set(gcf, 'InnerPosition',  [100, 0, 1200, 800]);
set(gcf, 'OuterPosition',  [0, 0, 1200, 800]);
set(gca,'FontSize',20);
xlabel('x_1');
ylabel('x_2');
zlabel('u(x_1,x_2)');



%% Fig 3(a) Dimensions = 2, Eta = 1, Solution: Sparse 

figure(5);
load('data/D2_Eta1_SoluSparse.mat');
hmean_plot = plot_book_style(s_vals*2, y_data(:,:,1:3), 'shaded', 'mean_std_log10');
% vert_plot1 = xline(Sp,'Linewidth',2,'LineStyle','-.');
vert_plot2 = xline(N,'Linewidth',2,'LineStyle',':');
legend([hmean_plot vert_plot2],{'OMP','QCBP','Backslash','$$m=|\Lambda|$$'},'Interpreter','latex')
set(gca,'YScale','log')
xlabel('m')
ylabel('Relative L^2 error')
xlim([0 760])
ylim([1e-10 3]);
set(gca, 'YGrid', 'on')
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 670, 550]);
set(gca, 'FontSize', 20);


%% Fig 3(b) Dimensions = 2, Eta: Sparse, Solution: Sparse

figure(6);
load('data/D2_EtaSparse_SoluSparse.mat');
hmean_plot = plot_book_style(s_vals*2, y_data(:,:,1:3), 'shaded', 'mean_std_log10');
% vert_plot1 = xline(Sp,'Linewidth',2,'LineStyle','-.');
vert_plot2 = xline(N,'Linewidth',2,'LineStyle',':');
legend([hmean_plot vert_plot2],{'OMP','QCBP','Backslash','$$m=|\Lambda|$$'},'Interpreter','latex')
set(gca,'YScale','log')
xlabel('m')
% ylabel('Relative L_2 error')
xlim([0 760])
ylim([1e-10 3]);
set(gca, 'YGrid', 'on')
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
set(gca,'FontSize',20);
set(gca,'yticklabel',[]);


%% Fig 3(c) Dimensions = 2, Eta: Non-Sparse, Solution: Sparse 

figure(7);
load('data/D2_EtaNonSparse_SoluSparse.mat');
hmean_plot = plot_book_style(s_vals*2, y_data(:,:,1:3), 'shaded', 'mean_std_log10');
% vert_plot1 = xline(Sp,'Linewidth',2,'LineStyle','-.');
vert_plot2 = xline(N,'Linewidth',2,'LineStyle',':');
legend([hmean_plot vert_plot2],{'OMP','QCBP','Backslash','$$m=|\Lambda|$$'},'Interpreter','latex')
set(gca,'YScale','log')
xlim([0 760])
ylim([1e-10 3]);
xlabel('m')
set(gca, 'YGrid', 'on')
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
set(gca,'FontSize',20);
set(gca,'yticklabel',[]);


%% Fig 4(a) Dimensions = 2, Eta = 1, Solution: Non-Sparse 
figure(8);
load('data/D2_Eta1_SoluNonSparse.mat');
hmean_plot = plot_book_style(2*s_vals, y_data, 'shaded', 'mean_std_log10');
vert_plot2 = xline(N,'Linewidth',2,'LineStyle',':');
legend([hmean_plot vert_plot2],{'OMP','QCBP','Backslash','$$\sigma_s(\mathbf{c}_\Lambda)_1/\sqrt{s}$$','$$m=|\Lambda|$$'},'Interpreter','latex')
set(gca,'YScale','log')
xlabel('m')
ylabel('Relative L^2 error')
xlim([0 750])
ylim([1e-10 3]);
set(gca, 'YGrid', 'on')
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 665, 550]);
set(gca,'FontSize',20);




%% Fig 4(b) Dimensions = 2, Eta: Sparse, Solution: Non-Sparse 

figure(9);
load('data/D2_EtaSparse_SoluNonSparse.mat');
hmean_plot = plot_book_style(2*s_vals, y_data, 'shaded', 'mean_std_log10');
vert_plot2 = xline(N,'Linewidth',2,'LineStyle',':');
legend([hmean_plot vert_plot2],{'OMP','QCBP','Backslash','$$\sigma_s(\mathbf{c}_\Lambda)_1/\sqrt{s}$$','$$m=|\Lambda|$$'},'Interpreter','latex')
set(gca,'YScale','log')
xlabel('m')
xlim([0 750])
ylim([1e-10 3]);
set(gca, 'YGrid', 'on')
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
set(gca,'FontSize',20);
set(gca,'yticklabel',[]);




%% Fig 4(c) Dimensions = 2, Eta: Non-Sparse, Solution: Non-Sparse 

figure(10);
load('data/D2_EtaNonSparse_SoluNonSparse.mat');
hmean_plot = plot_book_style(2*s_vals, y_data, 'shaded', 'mean_std_log10');
vert_plot2 = xline(N,'Linewidth',2,'LineStyle',':');
legend([hmean_plot vert_plot2],{'OMP','QCBP','Backslash','$$\sigma_s(\mathbf{c}_\Lambda)_1/\sqrt{s}$$','$$m=|\Lambda|$$'},'Interpreter','latex')
set(gca,'YScale','log')
xlabel('m')
xlim([0 750])
ylim([1e-10 3]);
set(gca, 'YGrid', 'on')
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
set(gca,'FontSize',20);
set(gca,'yticklabel',[]);


%% Fig 5(a) Dimensions = 8, Eta: 1, Solution: Sparse

figure(11);
load('data/D8_Eta1_SoluSparse.mat');
hmean_plot = plot_book_style(2*s_vals, y_data, 'shaded', 'mean_std_log10');
vert_plot2 = xline(N,'Linewidth',2,'LineStyle',':');
legend([hmean_plot vert_plot2],{'OMP','QCBP','Backslash','$$m=|\Lambda|$$'},'Interpreter','latex')
set(gca,'YScale','log')
xlabel('m')
ylabel('Relative L^2 error')
xlim([0 760])
ylim([1e-10 3]);
set(gca, 'YGrid', 'on')
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 670, 550]);
set(gca,'FontSize',20);


%% Fig 5(b) Dimensions = 8, Eta: Sparse, Solution: Sparse 

figure(12);
load('data/D8_EtaSparse_SoluSparse.mat');
hmean_plot = plot_book_style(s_vals*2, y_data, 'shaded', 'mean_std_log10');
vert_plot2 = xline(N,'Linewidth',2,'LineStyle',':');
legend([hmean_plot vert_plot2],{'OMP','QCBP','Backslash','$$m=|\Lambda|$$'},'Interpreter','latex')
set(gca,'YScale','log')
xlabel('m')
xlim([0 760])
ylim([1e-10 3]);
set(gca, 'YGrid', 'on')
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
set(gca,'FontSize',20);
set(gca,'yticklabel',[]);




%% Fig 5(c) Dimensions = 8, Eta: Non-Sparse, Solution: Sparse 

figure(13);
load('data/D8_EtaNonSparse_SoluSparse.mat');
hmean_plot = plot_book_style(s_vals*2, y_data, 'shaded', 'mean_std_log10');
vert_plot2 = xline(N,'Linewidth',2,'LineStyle',':');
legend([hmean_plot vert_plot2],{'OMP','QCBP','Backslash','$$m=|\Lambda|$$'},'Interpreter','latex')
set(gca,'YScale','log')
xlabel('m')
xlim([0 760])
ylim([1e-10 3]);
set(gca, 'YGrid', 'on')
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
set(gca,'FontSize',20);
set(gca,'yticklabel',[]);


%% Fig 6(a) Dimensions = 8, Eta = 1, Solution: Non-Sparse 

figure(14);
load('data/D8_Eta1_SoluNonSparse.mat');
hmean_plot = plot_book_style(s_vals*2, y_data(:,:,1:3), 'shaded', 'mean_std_log10');
vert_plot2 = xline(N,'Linewidth',2,'LineStyle',':');
legend([hmean_plot vert_plot2],{'OMP','QCBP','Backslash','$$m=|\Lambda|$$'},'Interpreter','latex','Location','northeast')
set(gca,'YScale','log')
xlabel('m')
ylabel('Relative L^2 error')
xlim([0 2200])
ylim([1e-2 3]);
set(gca, 'YGrid', 'on')
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 670, 550]);
set(gca,'FontSize',20);






%% Fig 6(b) Dimensions = 8, Eta : Sparse, Solution: Non-Sparse 

figure(15);
load('data/D8_EtaSparse_SoluNonSparse.mat');
hmean_plot = plot_book_style(s_vals*2, y_data(:,:,1:3), 'shaded', 'mean_std_log10');
vert_plot2 = xline(N,'Linewidth',2,'LineStyle',':');
legend([hmean_plot vert_plot2],{'OMP','QCBP','Backslash','$$m=|\Lambda|$$'},'Interpreter','latex','Location','northeast')
set(gca,'YScale','log')
xlabel('m')
xlim([0 2200])
ylim([1e-2 3]);
set(gca, 'YGrid', 'on')
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
set(gca,'FontSize',20);
set(gca,'yticklabel',[]);




%% Fig 6(c) Dimensions = 8, Eta : Non-Sparse, Solution: Non-Sparse 

figure(16);
load('data/D8_EtaNonSparse_SoluNonSparse.mat');
hmean_plot = plot_book_style(2*s_vals, y_data(:,:,1:3), 'shaded', 'mean_std_log10');
vert_plot2 = xline(N,'Linewidth',2,'LineStyle',':');
legend([hmean_plot vert_plot2],{'OMP','QCBP','Backslash','$$m=|\Lambda|$$'},'Interpreter','latex','Location','northeast')
set(gca,'YScale','log')
xlabel('m')
xlim([0 2200])
ylim([1e-2 3]);
set(gca, 'YGrid', 'on')
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
set(gca,'FontSize',20);
set(gca,'yticklabel',[]);


%% Fig 7(a) Dimensions = 8, Eta : Non-Sparse, Solution: Non-Sparse 

figure(17);
load('data/D8_EtaNonSparse_SoluNonSparse_N7.mat');
hmean_plot = plot_book_style(s_vals*2, y_data(:,:,1:3), 'shaded', 'mean_std_log10');
legend(hmean_plot,{'OMP','QCBP','Backslash'},'Interpreter','latex','Location','northeast')
set(gca,'YScale','log')
xlabel('m')
ylabel('Relative L^2 error')
xlim([0 1100])
ylim([1e-3 3]);
set(gca, 'YGrid', 'on')
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 670, 550]);
set(gca,'FontSize',20);


%% Fig 7(b) Dimensions = 8, Eta : Non-Sparse, Solution: Non-Sparse 

figure(18);
load('data/D8_EtaNonSparse_SoluNonSparse_N11.mat');
hmean_plot = plot_book_style(2*s_vals, y_data(:,:,1:3), 'shaded', 'mean_std_log10');
legend(hmean_plot,{'OMP','QCBP','Backslash'},'Interpreter','latex','Location','northeast')
set(gca,'YScale','log')
xlabel('m')
ylim([1e-3 3]);
xlim([0 1100])
set(gca, 'YGrid', 'on')
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
set(gca,'FontSize',20);
set(gca,'yticklabel',[]);


%% Fig 7(c) Dimensions = 8, Eta : Non-Sparse, Solution: Non-Sparse 

figure(19);
load('data/D8_EtaNonSparse_SoluNonSparse_N15.mat');
hmean_plot = plot_book_style(2*s_vals, y_data(:,:,1:3), 'shaded', 'mean_std_log10');
% vert_plot2 = xline(N,'Linewidth',2,'LineStyle',':');
legend(hmean_plot,{'OMP','QCBP','Backslash'},'Interpreter','latex','Location','northeast')
set(gca,'YScale','log')
xlabel('m')
ylim([1e-3 3]);
xlim([0 1100])
set(gca, 'YGrid', 'on')
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
set(gca,'FontSize',20);
set(gca,'yticklabel',[]);





%% Fig 8(a) Dimensions = 8, Eta : Non-Sparse, Solution: Non-Sparse Cardinality=1504

figure(20);
load('data/D8_card_1504.mat');
hmean_plot = plot_book_style(2*s_vals, y_data(:,:,1:3), 'shaded', 'mean_std_log10');
legend(hmean_plot,{'OMP','QCBP','Backslash'},'Interpreter','latex','Location','northeast')
set(gca,'YScale','log')
xlabel('m')
ylabel('Relative L^2 error')
ylim([1e-2 3]);
xlim([0 1100])
set(gca, 'YGrid', 'on')
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 670, 550]);
set(gca,'FontSize',20);


%% Fig 8(b) Dimensions = 8, Eta : Non-Sparse, Solution: Non-Sparse Cardinality=2520

figure(21);
load('data/D20_card_2520.mat');
hmean_plot = plot_book_style(2*s_vals, y_data(:,:,1:3), 'shaded', 'mean_std_log10');
% vert_plot2 = xline(N,'Linewidth',2,'LineStyle',':');
legend(hmean_plot,{'OMP','QCBP','Backslash'},'Interpreter','latex','Location','northeast')
set(gca,'YScale','log')
xlabel('m')
ylim([1e-2 3]);
xlim([0 1100])
set(gca, 'YGrid', 'on')
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
set(gca,'FontSize',20);
set(gca,'yticklabel',[]);


%% Fig 9(a) Dimensions = 2, Eta : Non-Sparse, Solution: Sparse Success rate
figure(22);
load('data/D2_EtaNonSparse_Success_rate.mat');
hmean_plot = plot_book_style(2*s_vals, y_data(:,:,1:3), 'shaded', 'mean_std_log10');
legend(hmean_plot,{'q=4','q=8','q=12'})
xlabel('m')
ylabel('Success rate')
ylim([0 1.05]);
xlim([20 220])
set(gca, 'YGrid', 'on')
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 670, 550]);
set(gca,'FontSize',20);

%% Fig 9(b) Dimensions = 8, Eta : Non-Sparse, Solution: Sparse Success rate

figure(23);
load('data/D8_EtaNonSparse_Success_rate.mat');
hmean_plot = plot_book_style(2*s_vals, y_data(:,:,1:3), 'shaded', 'mean_std_log10');
legend(hmean_plot,{'q=4','q=8','q=12'})
xlabel('m')
ylim([0 1.05]);
xlim([20 220])
set(gca, 'YGrid', 'on')
set(gcf, 'InnerPosition',  [0, 0, 550, 550]);
set(gcf, 'OuterPosition',  [0, 0, 550, 550]);
set(gca,'FontSize',20);
set(gca,'yticklabel',[]);

