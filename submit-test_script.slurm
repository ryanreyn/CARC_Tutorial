#!/bin/bash
#SBATCH -p qcb
#SBATCH -A nmherrer_110
#SBATCH -t 1-00:00:00
#SBATCH --mem=16gb
#SBATCH --cpus-per-task=8
#SBATCH --out=python_out
#SBATCH --error=python_err

module load python
python example-code.py
