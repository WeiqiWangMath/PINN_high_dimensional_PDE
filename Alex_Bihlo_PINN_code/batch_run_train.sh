#!/bin/bash

python --version

echo "CONTROL: starting runs on test datasets"
# run parameters
declare -r run_ID="cedar_CAS_set1_1st_arch_henormal_Jun20"
declare -r output_dim=1
declare -r MATLAB_data="1"
declare -r SG_level="11" # not used unless MATLAB_data = 0
declare -r training_ptset="uniform_random"
declare -r testing_ptset="CC_sparse_grid" #"uniform_random" 

# training parameters
declare -r training_steps=10
declare -r nb_epochs_per_iter="5000"
declare -r optimizer="Adam"
declare -r use_regularizer=0
declare -r reg_lambda="1e-3"
declare -r lrn_rate_schedule="exp_decay"
declare -r loss_function="MSE"

# architecture/initialization parameters
declare -r precision="single"

# precision and tolerance setting
if [ "$precision" = "single" ]; then
    declare -r nb_epochs="50000"
    declare -r error_tol="5e-7"
elif [ "$precision" = "double" ]; then
    declare -r nb_epochs="200000"
    declare -r error_tol="5e-16"
fi

declare -r blocktype="default"
declare -r initializer="he_normal"
declare -r sigma="1e-1"

declare -A arch_layers
arch_layers[0]="1"
arch_layers[1]="2"
arch_layers[2]="3"
arch_layers[3]="4"
arch_layers[4]="5"
arch_layers[5]="10"
arch_layers[6]="20"
arch_layers[7]="30"

declare -A arch_nodes
arch_nodes[0]="10"
arch_nodes[1]="20"
arch_nodes[2]="30"
arch_nodes[3]="40"
arch_nodes[4]="50"
arch_nodes[5]="100"
arch_nodes[6]="200"
arch_nodes[7]="300"

# main iteration loop over the dimensions
for d in {0..0..1}
do
    if [ "$d" -eq "0" ]; then
        declare input_dim=1
    elif [ "$d" -eq "1" ]; then
        declare input_dim=2
    elif [ "$d" -eq "2" ]; then
        declare input_dim=4
    elif [ "$d" -eq "3" ]; then
        declare input_dim=8
    elif [ "$d" -eq "4" ]; then
        declare input_dim=16
    else
        echo "must be 0 through 4"
    fi

    declare -A train_pts
    if [ "$training_ptset" = "uniform_random" ]; then
        if [ "$input_dim" -eq "1" ]; then
            declare quick_test_pts=32769 #8193 
            declare test_pts=65537 #131073
            train_pts[0]="10000"
        elif [ "$input_dim" -eq "2" ]; then
            declare quick_test_pts=32769
            declare test_pts=311297 #655361
            train_pts[0]="10000"
        elif [ "$input_dim" -eq "3" ]; then
            declare quick_test_pts=72705
            declare test_pts=366593
            train_pts[0]="15000"
        elif [ "$input_dim" -eq "4" ]; then
            declare quick_test_pts=46721
            declare test_pts=643073
            train_pts[0]="20000"
        elif [ "$input_dim" -eq "8" ]; then
            declare quick_test_pts=56737
            declare test_pts=609025
            train_pts[0]="50000"
        elif [ "$input_dim" -eq "16" ]; then
            declare quick_test_pts=51137
            declare test_pts=2098753
            train_pts[0]="100000"
        else
            echo "input dim is 1, 2, 3, 4, 8, or 16"
        fi
    else
        echo "training points must be uniform_random"
    fi

    # iterate over examples
    for example in {1..1..1}
    do

        # skip example 4 because not defined for this problem
        if [ "$example" -ne "4" ]; then

            # iterate over each activation function "relu", "tanh"
            for p in {0..0..1}
            do

                if [ "$p" -eq "0" ]; then
                    declare activation="relu"
                elif [ "$p" -eq "1" ]; then
                    declare activation="tanh"
                elif [ "$p" -eq "2" ]; then
                    declare activation="elu"
                elif [ "$p" -eq "3" ]; then
                    declare activation="sigmoid"
                else
                    echo "must be either relu, tanh, elu or sigmoid"
                fi

                # iterate over each method "ASGD", "MC", "MC2"
                for l in {0..1..1}
                do

                    echo "CONTROL: l = $l"
                    if [ "$l" -eq "0" ]; then
                        declare training_method="ASGD"
                    elif [ "$l" -eq "1" ]; then
                        declare training_method="MC"
                    elif [ "$l" -eq "2" ]; then
                        declare training_method="MC2"
                    else
                        echo "must be one of the three methods"
                    fi

                    echo "CONTROL: using method $training_method"

                    # iterate over architectures
                    for k in {4..4..1}
                    do
                        # train and then test all of the point sets
                        for i in {0..0..1}
                        do
                            echo "CONTROL: running trials of ${train_pts[$i]} point trials"
                            declare batch_size="${train_pts[$i]}"

                            #echo "CONTROL: beginning ${train_pts[$i]} point trials."
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
                            echo "CONTROL: beginning run_ID = $run_ID, example = $example, input_dim = $input_dim, training_method = $training_method, ${activation}_${blocktype}_${arch_layers[$k]}x${arch_nodes[$k]} ${train_pts[$i]} $training_ptset point trials."

                            # grow with the arch_nodes arch_layers sizes above
                            sbatch node_trials.sh $run_ID $output_dim $MATLAB_data $SG_level $training_ptset $testing_ptset $training_steps $nb_epochs_per_iter $optimizer $use_regularizer $reg_lambda $lrn_rate_schedule $loss_function $precision $nb_epochs $error_tol $blocktype $initializer $sigma ${arch_layers[$k]} ${arch_nodes[$k]} $input_dim ${train_pts[$i]} $example $activation $training_method $batch_size

                        done

                        # test all of the trials for this point set
                        echo "CONTROL: testing ${train_pts[$i]} point trials"

                    done
                done

            done
        fi
    done
done
