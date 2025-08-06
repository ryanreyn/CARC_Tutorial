#!/bin/bash
#This wrapper script is the one that user runs to initialize migration process
#Establish the options for this program
while getopts d: args
do
    case ${args} in
        d) project_dir=${OPTARG};;
        \?) printf "\n  ${RED}Invalid argument: -${OPTARG}${NC}\n\n    Run 'migrate' 
        with no arguments, '-h', or '--help' only to see help menu.\n\n" >&2 && exit
    esac
done

if [ -z "$project_dir" ]; then
        echo "Error: Option -d is mandatory and requires an argument." >&2
        exit 1
fi

sbatch migrate.slurm $project_dir