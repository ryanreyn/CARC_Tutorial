#!/bin/bash
#This wrapper script is the one that user runs to initialize migration process
project_dir=$1
slurm_file=$2
process_script=$3
process_time=$4

if [[ -z "$project_dir" || ! -d "$project_dir" ]]
then
        printf "Error: The project directory either hasn't been provided or is empty." >&2
        exit 1
fi

if [[ -z "$slurm_file" || ! -f "$slurm_file" ]]
then
        printf "Error: The slurm file either hasn't been provided or is empty." >&2
        exit 1
fi

if [[ -z "$process_script" || ! -f "$process_script" ]]
then
        printf "Error: The slurm file either hasn't been provided or is empty." >&2
        exit 1
fi

if [[ -z "$process_time" ]]
then
        printf "Error: Please provide a number of days for the migration job." >&2
        exit 1
fi

sed -i "s/input_time/$process_time/g" $slurm_file

sbatch $slurm_file $project_dir $process_script
