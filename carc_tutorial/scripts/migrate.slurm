#!/bin/bash
#SBATCH -p qcb
#SBATCH -A nmherrer_110
#SBATCH -t 28-00:00:00
#SBATCH --mem=32gb
#SBATCH --cpus-per-task=32
#SBATCH --out=migration_out
#SBATCH --error=migration_err

project_dir=$1

#Call the script that actually runs the migration
./migrate.sh $project_dir $SLURM_CPUS_PER_TASK