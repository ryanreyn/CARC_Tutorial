#!/bin/bash
#This wrapper script is the one that user runs to initialize migration process
project_dir=$1
slurm_file=$2

if [[ -z "$project_dir" || ! -d "$project_dir" ]]
then
        echo "Error: Option -d is mandatory and requires an argument." >&2
        exit 1
fi

if [[ -z "$slurm_file" || ! -f "$slurm_file" ]]
then

sbatch migrate.slurm $project_dir
