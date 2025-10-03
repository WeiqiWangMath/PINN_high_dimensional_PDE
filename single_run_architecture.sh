#!/bin/bash
#SBATCH --time=02:30:00
#SBATCH --gres=gpu:1
#SBATCH --mem=32000

module load python/3.10 cuda cudnn
source ./PINN_PDE/bin/activate
python high_dimensional_periodic_diffusion_example_4_architecture.py $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11}
