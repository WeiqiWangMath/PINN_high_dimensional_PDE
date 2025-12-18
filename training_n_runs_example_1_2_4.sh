#!/bin/bash
# List of arguments:
  #1 : input_dim - number of dimensions of the problem
  #2 : N - number of sampling
  #3 : \nu - parameter \nu
  #4 : epochs - number of epochs
  #5 : M_error - number of sampling when measure error
  #6 : file_name - name of the output file
  #7 : N_runs - the number of runs
for j in {1..10}
do
  sbatch single_run_architecture.sh 6 10000 0.5 50000 10000 example4_dim6_m50000_N4096_Run${j} $j 11 30 3 10
done