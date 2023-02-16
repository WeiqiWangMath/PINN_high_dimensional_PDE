Run Figures/Visualize_data.m to generate all figures in the paper.

All figure data are saved in Figures/data in .mat.

Figures/eps files includes all .eps file in the paper.

Below is a list of .m files generating data and the data files generating the figures

Figure			data					.m file 					.eps file 
1(a)			Figure is generate directly in Visualize_data.m using generate_index_set		HC38_2D.eps
1(b)			Figure is generate directly in Visualize_data.m using generate_index_set		HC24_3D.eps
2(a)			Exact_sparse_2D.mat			Dimension2_Eta1_SolutionSparse.m		Dimension2_SolutionNonsparse.eps
2(b)			Exact_non_sparse.mat			Dimension2_Eta1_SolutionNonsparse.m		Dimension2_RandomSolutionSparse.eps
3(a)			D2_Eta1_SoluSparse.mat			Dimension2_Eta1_SolutionSparse.m		Dimension2_Eta1_Solutionsparse.eps
3(b)			D2_EtaSparse_SoluSparse.mat 		Dimension2_EtaSparse_SolutionSparse.m 		Dimension2_EtaSparse_Solutionsparse.eps
3(c)			D2_EtaNonSparse_SoluSparse.mat 		Dimension2_EtaNonSparse_SolutionSparse.m 	Dimension2_EtaNonsparse_SolutionSparse.eps
4(a)			D2_Eta1_SoluNonSparse.mat		Dimension2_Eta1_SolutionNonsparse.m		Dimension2_Eta1_SolutionNonsparse.eps
4(b)			D2_EtaSparse_SoluNonSparse.mat		Dimension2_EtaSparse_SolutionNonsparse.m	Dimension2_EtaSparse_SolutionNonsparse.eps
4(c)			D2_EtaNonSparse_SoluNonSparse.mat 	Dimension2_EtaNonSparse_SolutionNonsparse.m 	Dimension2_EtaNonsparse_SolutionNonsparse.eps
5(a)			D8_Eta1_SoluSparse.mat			Dimensionhigh_Eta1_SolutionSparse.m		Dimension8_Eta1_SolutionSparse.eps
5(b)			D8_EtaSparse_SoluSparse.mat 		Dimensionhigh_EtaSparse_SolutionSparse.m 	Dimension8_EtaSparse_SolutionSparse.eps
5(c)			D8_EtaNonSparse_SoluSparse.mat 		Dimensionhigh_EtaNonSparse_SolutionSparse.m 	Dimension8_EtaNonsparse_SolutionSparse.eps
6(a)			D8_Eta1_SoluNonSparse.mat		Dimensionhigh_Eta1_SolutionNonSparse.m		Dimension8_Eta1_SolutionNonsparse.eps
6(b)			D8_EtaSparse_SoluNonSparse.mat		Dimensionhigh_EtaSparse_SolutionNonSparse.m	Dimension8_EtaSparse_SolutionNonsparse.eps
6(c)			D8_EtaNonSparse_SoluNonSparse.mat 	Dimensionhigh_EtaNonSparse_SolutionNonSparse.m 	Dimension8_EtaNonsparse_SolutionNonsparse.eps
7(a)			D8_EtaNonSparse_SoluNonSparse.mat 	Dimensionhigh_EtaNonSparse_SolutionNonSparse.m 	Dimension8_EtaNonSparse_SolutionNonSparseN7.eps
7(b)			D8_EtaNonSparse_SoluNonSparse.mat 	Dimensionhigh_EtaNonSparse_SolutionNonSparse.m 	Dimension8_EtaNonSparse_SolutionNonSparseN11.eps
7(c)			D8_EtaNonSparse_SoluNonSparse.mat 	Dimensionhigh_EtaNonSparse_SolutionNonSparse.m 	Dimension8_EtaNonSparse_SolutionNonSparseN15.eps
8(a)			D8_card_1504.mat			Dimension_compare_EtaNonSparse_SolutionNonSparse.m	Dimension8_card_1504.eps
8(b)			D20_card_2520.mat			Dimension_compare_EtaNonSparse_SolutionNonSparse.m	Dimension20_card_2520.eps
9(a)			D2_EtaNonSparse_Success_rate.mat	Dimension2_EtaNonSparse_Success_rate.m		Dimension2_success_rate.eps
9(b)			D8_EtaNonSparse_Success_rate.mat	Dimension8_EtaNonSparse_Success_rate.m		Dimension8_success_rate.eps
Change n for the index set to 6,10,14 in Dimensionhigh_EtaNonSparse_SolutionNonSparse.m to generate figure 7(a),(b),(c)

graphic file is used to set color, format of figures with random runs. 

utils file has all utilities of the paper：
generate_index_set.m: generate the index set with given dimension, type and size.
generate_sampling_grid.m: generate random point in d dimension. (Monte carlo)
generate_collocation_matrix.m: generate the collocation matrix. (Matrix A in the paper)
compute_forcing_given_solution.m: Compute the exact forcing term on the right for given exact solution using the finite difference method.
womp_complex.m: Complex omp method (Algorithm 1) to find the solution of the linear system.
wqcbp.m: Use cvx box to find the solution of the QCBP problem.
plot_book_style.m: Make plots using the style defined in Graphic file
set_options.m: Set options for cvx solver

Other files are written for the future project.