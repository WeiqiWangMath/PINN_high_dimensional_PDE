#!/bin/bash
# Architecture Testing - Test impact of hidden layer parameters
# List of arguments:
  #1 : input_dim - number of dimensions of the problem (d=10)
  #2 : N - number of sampling (N=10000)
  #3 : \nu - parameter \nu (default=0.5)
  #4 : epochs - number of epochs (default=30000)
  #5 : M_error - number of sampling when measure error (default=10000)
  #6 : file_name - name of the output file
  #7 : N_runs - the number of runs
  #8 : m_periodic - number of nodes in the first periodic layer (default=11)
  #9 : n_periodic - number of nodes in the second periodic layer (default=30, unused)
  #10 : nb_hidden_layers - number of hidden layers
  #11 : hw_ratio - height width ratio of hidden layers

# Test different hidden layer configurations
# nb_hidden_layers: {1, 3, 5, 7}
# hw_ratio: {3, 5, 10, 20}
for j in 1
do
  for nb_layers in 1 3
  do
    for hw in 5 10
    do
      sbatch --account=def-sbrugiap single_run_architecture.sh 20 10000 0.5 30000 10000 example4_dim20_h${nb_layers}r${hw} $j 11 30 ${nb_layers} ${hw}
    done
  done
done
