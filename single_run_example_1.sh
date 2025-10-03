#!/bin/bash
#SBATCH --time=01:00:00
#SBATCH --account=def-rbdong
#SBATCH --gres=gpu:1
#SBATCH --mem=32000

module load python/3.10 cuda cudnn
source ./PINN_PDE/bin/activate
python high_dimensional_periodic_diffusion_example_1.py $1 $2 $3 $4 $5 $6 $7



