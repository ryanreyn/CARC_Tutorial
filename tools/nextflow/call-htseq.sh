#!/bin/bash
#This script is intended to perform a simple, iterative call of HTSeq for multiple genomes from a file list
#This script is formatted to take inputs fed in through a nextflow workflow
bam_files=''
out_dir=''
gtf_file=''
out_file=''

print_usage() {
  printf "Usage: ..."
}

while getopts 'b:d:f:o:' flag; do
  case "${flag}" in
    b) bam_files="${OPTARG}" ;;
    d) out_dir="${OPTARG}" ;;
    f) gtf_file="${OPTARG}" ;;
    o) out_file="${OPTARG}" ;;
    *) print_usage
       exit 1 ;;
  esac
done

while read line
do
    echo ${out_dir}'/'${line}
    htseq-count -r pos -s yes ${out_dir}'/'${line} ${gtf_file} -c ${out_file}
done < ${bam_files}