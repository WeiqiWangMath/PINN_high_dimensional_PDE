#!/bin/bash
# Architecture Testing - Test impact of m_periodic parameter
# List of arguments:
  #1 : input_dim - number of dimensions of the problem (d=10)
  #2 : N - number of sampling (N=10000)
  #3 : \nu - parameter \nu (default=0.5)
  #4 : epochs - number of epochs (default=30000)
  #5 : M_error - number of sampling when measure error (default=10000)
  #6 : file_name - name of the output file
  #7 : N_runs - the number of runs
  #8 : m_periodic - number of nodes in the first periodic layer
  #9 : n_periodic - number of nodes in the second periodic layer (default=30, unused)
  #10 : nb_hidden_layers - number of hidden layers (default=3)
  #11 : hw_ratio - height width ratio of hidden layers (default=10)

for j in {1..2}
do
  for m in 16 32 64
  do
    sbatch single_run_architecture_trig.sh 6 10000 0.5 50000 10000 example4_trig_arch_d6_m${m}_N4096 $j $m 30 3 10
  done
done
