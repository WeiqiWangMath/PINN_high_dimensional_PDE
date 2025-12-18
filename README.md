# Physics-informed deep learning and compressive collocation for high-dimensional diffusion-reaction

Paper: https://arxiv.org/abs/2406.01539

This repository contains two experiment tracks:
- Python PINNs for periodic high-dimensional diffusion–reaction problems (GPU-enabled TensorFlow/Keras).
- MATLAB basis-adaptive compressive Fourier/collocation experiments and figure generation.

Nothing in the numerical code was altered; this release adds structure and documentation for reproducibility.

## Repository layout (kept as-is, described for clarity)
- Python PINN scripts (root):
  - `high_dimensional_periodic_diffusion_example_1.py`: baseline periodic PINN, Example 1.
  - `high_dimensional_periodic_diffusion_example_1_GPU.py`: multi-GPU MirroredStrategy variant.
  - `high_dimensional_periodic_diffusion_example_1_L1.py`: Example 1 with L1 regularization on the last layer (adds `lambda_l1` arg).
  - `high_dimensional_periodic_diffusion_example_2.py`: Example 2, exponential exact solution.
  - `high_dimensional_periodic_diffusion_example_3.py`: Example 3, random multi-term trigonometric exact solution (adds `p` arg).
  - `high_dimensional_periodic_diffusion_example_4.py`: Example 4, exponential exact solution with mixed smoothness.
  - `high_dimensional_periodic_diffusion_example_3_architecture.py`, `high_dimensional_periodic_diffusion_example_4_architecture.py`: architecture sweep versions (tunable periodic layers / hidden widths).
  - `high_dimensional_periodic_diffusion_example_4_trig_basis.py`: Example 4 using a trigonometric basis.
- Slurm helpers (root):
  - `single_run*.sh`: one-off Slurm jobs wrapping the Python scripts.
  - `training_n_runs*.sh`: arrays of Slurm jobs to sweep seeds/params (e.g., `training_n_runs.sh`, `training_n_runs_example_3.sh`, `training_n_runs_example_L1.sh`, etc.).
- Data and logs:
  - `data/`: `.out` files written by the Python scripts (PDE loss, network loss, error curves).
  - Numerous `slurm-*.out` files: captured cluster logs for past runs.
- Figures and plotting:
  - `figs/`: EPS figures for the paper’s PINN results.
  - MATLAB figures: `Basis_adaptive_method/Figures/eps files/` plus scripts under `Basis_adaptive_method/Figures/`.
- MATLAB compressive collocation (basis adaptive):
  - `Basis_adaptive_method/` with `Readme.txt`, `Figures/` (data + plotting scripts), `utils/` (collocation/OMP tools), `graphic/` (plot styling), and `ompbox10/`.

## Python experiments (CLI)
All PINN scripts share the base signature:
```
python high_dimensional_periodic_diffusion_example_<k>.py \
  input_dim N nu epochs M_error file_name N_runs [extra_args]
```
- `input_dim`: problem dimension.
- `N`: training sample count (Monte Carlo points).
- `nu`: reaction parameter.
- `epochs`: training epochs.
- `M_error`: number of MC points to report error during training.
- `file_name`: prefix for output `.out` file(s).
- `N_runs`: run index/seed.
- Extra args:
  - Example 1 L1: `lambda_l1`.
  - Example 3: `p` (number of terms in the exact solution).
  - Architecture/trig variants (Examples 3/4): `m_periodic`, `n_periodic`, `nb_hidden_layers`, `hw_ratio` as documented in each file header.

### Slurm usage
- Single job: `sbatch single_run.sh 6 1000 0.5 30000 10000 example1_N1000 1`
- Sweeps:
  - `training_n_runs.sh` for Example 1 (N sweep).
  - `training_n_runs_example_3.sh` for Example 3 (p sweep).
  - `training_n_runs_example_L1.sh` for L1 sweeps (k / lambda choices).
  - Similar wrappers exist for Examples 2 and 4 (`single_run_example_*.sh`, `training_n_runs_example_1_2_4.sh`, etc.).
Each script activates the `PINN_PDE` environment (or sets up a temp venv on some clusters) and writes outputs to `data/FILE_PREFIXRun<N>.out`.

## MATLAB basis-adaptive pipeline
- Start from `Basis_adaptive_method/Readme.txt` for a figure-to-data mapping (kept intact).
- Regenerate all MATLAB figures with `Basis_adaptive_method/Figures/Visualize_data.m`. It loads precomputed `.mat` data under `Basis_adaptive_method/Figures/data/` and writes EPS files to `Basis_adaptive_method/Figures/eps files/`.
- Utilities for generating new data (collocation matrices, OMP solvers, sampling grids) live in `Basis_adaptive_method/utils/`. Plot styling helpers are in `Basis_adaptive_method/graphic/`.

## Environment setup
- Existing env: activate the provided conda/venv `PINN_PDE` if present.
- Fresh setup (Python ≥3.10, GPU recommended):
  ```
  python -m venv .venv
  source .venv/bin/activate
  pip install --upgrade pip
  pip install -r requirements.txt
  ```
- GPU expectations: TensorFlow 2.19.x with CUDA/cuDNN matching your platform (e.g., CUDA 12.x on recent TF builds). Adjust `tensorflow`/`tensorflow-io-gcs-filesystem` versions if your CUDA toolchain differs.
- MATLAB: required for basis-adaptive experiments; CVX/OMP toolboxes are bundled under `Basis_adaptive_method/ompbox10/` but may need platform-specific MEX builds.

## Recreating paper results (high level)
- PINN (Python):
  - Example 1: `high_dimensional_periodic_diffusion_example_1.py` (baseline), `_GPU.py` (multi-GPU), `_L1.py` (L1).
  - Example 2: `high_dimensional_periodic_diffusion_example_2.py`.
  - Example 3: `high_dimensional_periodic_diffusion_example_3.py` (`p` terms), `_architecture.py` for layer-size sweeps.
  - Example 4: `high_dimensional_periodic_diffusion_example_4.py`, `_architecture.py`, `_trig_basis.py`.
  - Use the corresponding `single_run*.sh` / `training_n_runs*.sh` wrappers to match the sample sizes, p, and architecture sweeps reported in the paper; outputs land in `data/`.
- Compressive collocation (MATLAB):
  - Run `Basis_adaptive_method/Figures/Visualize_data.m` to regenerate all paper figures from the provided `.mat` files.
  - The figure/data mapping table is preserved in `Basis_adaptive_method/Readme.txt`.

## Results and artifacts
- `.out` training logs are already git-ignored (pattern `*.out`). Precomputed `.out` files in `data/` are retained for reference; delete locally if you need a clean rerun.
- Cluster logs (`slurm-*.out`) are kept as provenance; also safe to delete locally if storage is a concern.
- EPS figures under `figs/` and `Basis_adaptive_method/Figures/eps files/` correspond to the paper plots.

## Notes
- Code paths and logic were not modified; only documentation and environment packaging were added.
- If you adjust file locations, update the Slurm wrappers to point to the new paths; current layout assumes the scripts stay at repo root.
