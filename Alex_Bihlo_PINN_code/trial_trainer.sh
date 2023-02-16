#!/bin/bash

hostname
module load python/3
module load cuda cudnn
source tensorflow/bin/activate

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

CUDA_VISIBLE_DEVICES=${29}
echo "CONTROL: training ${23} point trials"
python DNN_sampling.py --run_ID $1 --output_dim $2 --MATLAB_data $3 --SG_level $4 --train_pointset $5 --test_pointset $6 --training_steps $7 --nb_epochs_per_iter $8 --optimizer $9 --use_regularizer ${10} --reg_lambda ${11} --lrn_rate_schedule ${12} --loss_function ${13} --precision ${14} --nb_epochs ${15} --error_tol ${16} --blocktype ${17} --initializer ${18} --sigma ${19} --nb_layers ${20} --nb_nodes_per_layer ${21} --input_dim ${22} --nb_train_points ${23} --example ${24} --activation ${25} --training_method ${26} --batch_size ${27} --nb_trials 20 --make_plots 0 --quiet 0 --trial_num ${28}
