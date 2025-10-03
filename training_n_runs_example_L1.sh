#!/bin/bash
# L1 Regularization - Change λ value manually in single_run_L1.sh
# List of arguments:
  #1 : input_dim - number of dimensions of the problem
  #2 : N - number of sampling
  #3 : \nu - parameter \nu
  #4 : epochs - number of epochs
  #5 : M_error - number of sampling when measure error
  #6 : file_name - name of the output file
  #7 : N_runs - the number of runs
  #8 : k - regularization parameter
for j in {1..10}
do
  sbatch --account=def-sbrugiap single_run_L1.sh 10 1024 0.5 30000 10000 example2_L1_k0_N1024 $j 0
  sbatch --account=def-sbrugiap single_run_L1.sh 10 2048 0.5 30000 10000 example2_L1_k0_N2048 $j 0
  sbatch --account=def-sbrugiap single_run_L1.sh 10 4096 0.5 30000 10000 example2_L1_k0_N4096 $j 0
  sbatch --account=def-sbrugiap single_run_L1.sh 10 8192 0.5 30000 10000 example2_L1_k0_N8192 $j 0
  sbatch --account=def-sbrugiap single_run_L1.sh 10 16384 0.5 30000 10000 example2_L1_k0_N16384 $j 0
done
