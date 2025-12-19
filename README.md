# Physics-informed deep learning and compressive collocation for high-dimensional diffusion-reaction

Paper: https://arxiv.org/abs/2406.01539

This repository contains two experiment tracks:
- Python PINNs for periodic high-dimensional diffusion–reaction problems (GPU-enabled TensorFlow/Keras).
- MATLAB basis-adaptive compressive Fourier/collocation experiments and figure generation.

## Figure-by-figure reproduction (paper order)
Use `data_visualize.m` as the illustrative workflow for plotting regenerated data (it shows how figure assets are produced from data for all figures). Python outputs can be visualized similarly from regenerated `.out` files into `figs/`.

Figure 1 in the paper is a TikZ figure (not generated here). 
Figure 2 illustrates the reduced margin \(R(S)\) of a multi-index set (conceptual schematic). To recreate the idea: build an index set `S = generate_index_set(...)`, compute `RS = find_reduced_margin(S)` (see `Basis_adaptive_method/utils/find_reduced_margin.m`), and plot `S` vs `RS` in MATLAB.
Figure 3: impact of number of samples \(m\) on PINNs for the exact solutions 1–3; parameters \(d=6\), \(\rho=\nu=0.5\), 30000 epochs. Regenerate with:
- Example 1: `example1.py`
- Example 2: `example2.py`
- Example 3: `example3.py`; set `input_dim=6`, `nu=0.5`, `epochs=30000`, `M_error=10000`, vary `N`. Slurm wrappers: `training_n_runs.sh` / `single_run_example_1.sh` give example of multiple runs. Outputs are written as `data/<file_name>Run<N_runs>.out`.
Figure 4: impact of dimension \(d\) on PINNs for the exact solutions; same settings as Figure 3 except sweeping `input_dim` (see `figs/PINN_dimension_solu*.eps`). Run `example1.py`, `example2.py`, `example3.py` with fixed `N` per figure, `nu=0.5`, `epochs=30000`, `M_error=10000`, and sweep `input_dim`. Outputs: `data/<file_name>Run<N_runs>.out`.
Figure 5: final-error vs. number of sample points (after 30000 epochs), for the exact solutions 1–3. Use `example1.py`, `example2.py`, `example3.py` with the sample counts shown in the figure; take the final reported error from each run (last epoch) to plot. Outputs: `data/<file_name>Run<N_runs>.out`. Visualization for PINN curves is scripted in `data_visualize.m` (root).
Figure 6: architecture sweeps (hidden layers / periodic layers) for paper Example 3. Run:
- Hidden-layer/width sweeps: `single_run_architecture.sh input_dim N nu epochs M_error file_name N_runs m_periodic n_periodic nb_hidden_layers hw_ratio` (calls `example3_architecture.py`). Example from paper scripts: `20 10000 0.5 30000 10000 example3_h{nb_layers}r{hw} <run> 11 30 {nb_layers} {hw}`.
- Periodic-layer sweeps: `single_run_architecture_trig.sh input_dim N nu epochs M_error file_name N_runs m_periodic n_periodic nb_hidden_layers hw_ratio` (calls `example3_trig_basis.py`; note `n_periodic` is currently unused there). Example: `20 10000 0.5 30000 10000 example3_m{m}_N10000 <run> {m} 30 3 10`.
- Batch examples: `training_n_runs_architecture_hidden.sh` (varies `nb_hidden_layers`, `hw_ratio`) and `training_n_runs_architecture_periodic.sh` (varies `m_periodic`), used for Fig 6 data generation.
Outputs: `data/<file_name>Run<N_runs>.out`, plotted via `data_visualize.m`.

## Repository layout (kept as-is, described for clarity)
- Python PINN scripts (root):
  - `example1.py`: baseline periodic PINN, Example 1.
  - `example1_gpu.py`: multi-GPU MirroredStrategy variant.
  - `example1_l1.py`: Example 1 with L1 regularization on the last layer (adds `lambda_l1` arg).
  - `example2.py`: Example 2, exponential exact solution.
  - `example3.py`: Example 3 in the paper (\(u_3\)), exponential exact solution with mixed smoothness.
  - `example3_architecture.py`: architecture sweep version (tunable periodic layers / hidden widths) for \(u_3\).
  - `example3_trig_basis.py`: \(u_3\) using a trigonometric basis.
- Slurm helpers (root):
  - `single_run*.sh`: one-off Slurm jobs wrapping the Python scripts.
  - `training_n_runs*.sh`: arrays of Slurm jobs to sweep seeds/params (e.g., `training_n_runs.sh`, `training_n_runs_example_L1.sh`, etc.).
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
python example<k>.py \
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
  - Architecture/trig variants (paper Example 3): `m_periodic`, `n_periodic`, `nb_hidden_layers`, `hw_ratio` as documented in each file header.

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
- PINN (Python) — no `.out` files are tracked; rerun to regenerate:
  - Example 1: `high_dimensional_periodic_diffusion_example_1.py` (baseline), `_GPU.py` (multi-GPU), `_L1.py` (adds `lambda_l1`).
    - Typical params used in the paper: dimensions 6–20, `N` in {1000…10000}, `nu=0.5`, `epochs=30000`, `M_error=10000`, run index `N_runs` varies via `training_n_runs.sh`.
  - Example 2: `high_dimensional_periodic_diffusion_example_2.py` with the exponential exact solution; sweeps over `N` via `single_run_example_1_2_4.sh` / `training_n_runs_example_1_2_4.sh`.
- Example 3 (paper \(u_3\)): `high_dimensional_periodic_diffusion_example_4.py`; architecture variations in `_architecture.py` and trigonometric basis in `_trig_basis.py`. Use `single_run_example_1_2_4.sh` / `training_n_runs_example_1_2_4.sh` for batching.
  - Slurm wrappers (`single_run*.sh`, `training_n_runs*.sh`) show the exact CLI invocations used for each figure; adjust arguments there to match the paper’s sample sizes and p/architecture settings. Outputs will be written to `data/FILE_PREFIXRun<N>.out` (not stored in the repo).
- Compressive collocation (MATLAB) — no `.mat` data tracked; rerun to regenerate:
  - Generate all figure data and plots by running `Basis_adaptive_method/Figures/Visualize_data.m`.
  - This script calls the pre-defined figure scripts under `Basis_adaptive_method/Figures/` and the utilities in `Basis_adaptive_method/utils/`. Use the parameter choices noted inside those scripts (e.g., index-set sizes, dimensions, sparse vs. non-sparse cases). The legacy mapping of figure → script/data is described in `Basis_adaptive_method/Readme.txt`; reusing the same script names with fresh runs will recreate the .mat data and EPS.

## Results and artifacts
- `.out` training logs are git-ignored (pattern `*.out`). No `.out` files are tracked; rerun the scripts to regenerate.
- `.mat` data for MATLAB figures are not tracked; running `Basis_adaptive_method/Figures/Visualize_data.m` will recreate them alongside EPS outputs.
- Cluster logs (`slurm-*.out`) are kept as provenance; safe to delete locally if desired.
- EPS figures under `figs/` and `Basis_adaptive_method/Figures/eps files/` correspond to the paper plots when regenerated.

## Notes
- Code paths and logic were not modified; only documentation and environment packaging were added.
- If you adjust file locations, update the Slurm wrappers to point to the new paths; current layout assumes the scripts stay at repo root.
