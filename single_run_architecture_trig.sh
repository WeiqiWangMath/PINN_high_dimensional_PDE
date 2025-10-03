#!/bin/bash
#SBATCH --account=def-sbrugiap
#SBATCH --time=02:59:00
#SBATCH --gres=gpu:1
#SBATCH --mem=64G

# Load specific CUDA version to avoid driver mismatch
module load python/3.10 cuda cudnn
source ./PINN_PDE/bin/activate

# Verify GPU availability
echo "CUDA_VISIBLE_DEVICES: $CUDA_VISIBLE_DEVICES"
nvidia-smi || echo "nvidia-smi failed"

python high_dimensional_periodic_diffusion_example_4_trig_basis.py $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11}
