#!/bin/bash
# List of arguments:
  #1 : input_dim - number of dimensions of the problem
  #2 : N - number of sampling
  #3 : \nu - parameter \nu
  #4 : epochs - number of epochs
  #5 : M_error - number of sampling when measure error
  #6 : file_name - name of the output file
  #7 : N_runs - the number of runs
for j in {9..20}
do
  sbatch single_run.sh 6 1000 0.5 30000 10000 example1_N1000 $j
done