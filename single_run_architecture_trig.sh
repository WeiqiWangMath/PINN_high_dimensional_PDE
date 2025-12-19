#!/bin/bash
#SBATCH --account=def-sbrugiap
#SBATCH --time=02:59:00
#SBATCH --gres=gpu:h100:1
#SBATCH --nodes=1
#SBATCH --mem=64G

module load python/3.11
source ./PINN_PDE/bin/activate

# Verify GPU availability
echo "CUDA_VISIBLE_DEVICES: $CUDA_VISIBLE_DEVICES"
nvidia-smi || echo "nvidia-smi failed"

python example3_trig_basis.py $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11}
