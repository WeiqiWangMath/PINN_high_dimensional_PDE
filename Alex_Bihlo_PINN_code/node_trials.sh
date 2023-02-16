#!/bin/bash

#SBATCH --nodes=1 		        # number of nodes to use
#SBATCH --ntasks-per-node=4     # number of tasks
#SBATCH --exclusive             # run on whole node
#SBATCH --cpus-per-task=6       # There are 24 CPU cores on Cedar p100 GPU nodes
#SBATCH --gres=gpu:p100:4       # number of GPUs to use
#SBATCH --mem=0     	    	# memory per node (0 = use all of it)
#SBATCH --time=00-03:00         # time (DD-HH:MM)
#SBATCH --account=def-adcockb

## Args:
# 1  = $run_ID 
# 2  = $output_dim
# 3  = $MATLAB_data 
# 4  = $SG_level 
# 5  = $training_ptset 
# 6  = $testing_ptset 
# 7  = $training_steps
# 8  = $nb_epochs_per_iter
# 9  = $optimizer 
# 10 = $use_regularizer 
# 11 = $reg_lambda 
# 12 = $lrn_rate_schedule 
# 13 = $loss_function
# 14 = $precision 
# 15 = $nb_epochs
# 16 = $error_tol 
# 17 = $blocktype 
# 18 = $initializer 
# 19 = $sigma 
# 20 = ${arch_layers[$k]} 
# 21 = ${arch_nodes[$k]} 
# 22 = $input_dim 
# 23 = ${train_pts[$i]} 
# 24 = $example 
# 25 = $activation 
# 26 = $training_method 
# 27 = $batch_size 
# 28 = $trial
# 29 = GPU

# for each set of four trials (for running on lgpu or base gpu)
for j in {0..16..4}
do
    bash trial_trainer.sh $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} ${12} ${13} ${14} ${15} ${16} ${17} ${18} ${19} ${20} ${21} ${22} ${23} ${24} ${25} ${26} ${27} $(($j+0)) 0 > run_out/$1_${25}_${17}_${20}x${21}_${23}_$5_pts_$(($j+0))_trial_${22}_dim_${24}_exmp_${26}_method_${16}_tol_$9_optimizer_${14}_precision_${15}_epochs_${10}_reg_${11}_lam_${18}_init_${19}_sigma_${12}_sched_jobid_$((SLURM_JOB_ID)).out &
    bash trial_trainer.sh $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} ${12} ${13} ${14} ${15} ${16} ${17} ${18} ${19} ${20} ${21} ${22} ${23} ${24} ${25} ${26} ${27} $(($j+1)) 1 > run_out/$1_${25}_${17}_${20}x${21}_${23}_$5_pts_$(($j+1))_trial_${22}_dim_${24}_exmp_${26}_method_${16}_tol_$9_optimizer_${14}_precision_${15}_epochs_${10}_reg_${11}_lam_${18}_init_${19}_sigma_${12}_sched_jobid_$((SLURM_JOB_ID)).out &
    bash trial_trainer.sh $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} ${12} ${13} ${14} ${15} ${16} ${17} ${18} ${19} ${20} ${21} ${22} ${23} ${24} ${25} ${26} ${27} $(($j+2)) 2 > run_out/$1_${25}_${17}_${20}x${21}_${23}_$5_pts_$(($j+2))_trial_${22}_dim_${24}_exmp_${26}_method_${16}_tol_$9_optimizer_${14}_precision_${15}_epochs_${10}_reg_${11}_lam_${18}_init_${19}_sigma_${12}_sched_jobid_$((SLURM_JOB_ID)).out &
    bash trial_trainer.sh $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} ${12} ${13} ${14} ${15} ${16} ${17} ${18} ${19} ${20} ${21} ${22} ${23} ${24} ${25} ${26} ${27} $(($j+3)) 3 > run_out/$1_${25}_${17}_${20}x${21}_${23}_$5_pts_$(($j+3))_trial_${22}_dim_${24}_exmp_${26}_method_${16}_tol_$9_optimizer_${14}_precision_${15}_epochs_${10}_reg_${11}_lam_${18}_init_${19}_sigma_${12}_sched_jobid_$((SLURM_JOB_ID)).out &
    wait
done
