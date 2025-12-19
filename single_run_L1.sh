#!/bin/bash
#SBATCH --time=01:30:00
#SBATCH --gres=gpu:1
#SBATCH --mem=32000

module load python/3.10 cuda cudnn
source ./PINN_PDE/bin/activate
python example2_l1.py $1 $2 $3 $4 $5 $6 $7 $8
