#!/bin/bash
#SBATCH --time=02:59:00
#SBATCH --gres=gpu:h100:1
#SBATCH --account=def-sbrugiap
#SBATCH --mem=64000

module load python/3.11
source ./PINN_PDE/bin/activate
python high_dimensional_periodic_diffusion_example_4_architecture.py $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11}
