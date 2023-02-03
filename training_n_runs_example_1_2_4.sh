#!/bin/bash
# List of arguments:
  #1 : input_dim - number of dimensions of the problem
  #2 : N - number of sampling
  #3 : \nu - parameter \nu
  #4 : epochs - number of epochs
  #5 : M_error - number of sampling when measure error
  #6 : file_name - name of the output file
  #7 : N_runs - the number of runs
for j in {1..2}
do
  sbatch single_run_example_1_2_4.sh 6 2000 0.5 30000 10000 example4_N2000 $j
done