#!/bin/bash
#SBATCH --time=01:00:00
#SBATCH --account=def-sbrugiap
#SBATCH --gres=gpu:1
#SBATCH --mem=32000

module load python/3.10
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --no-index --upgrade pip
pip install --no-index numpy
pip install --no-index tensorflow==2.8
python high_dimensional_periodic_diffusion_example_1.py $1 $2 $3 $4 $5 $6 $7
