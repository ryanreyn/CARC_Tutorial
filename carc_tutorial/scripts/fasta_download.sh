#!/bin/bash
#This is a shell file for downloading the fasta files used in the example workflow
#from the ENA database
#Setting within a simple if statement that will check if there are 8 fastq files of
#this format in the desired destination. If yes, will skip file entirely
destination_dir="../../data"
if [[ `ls $destination_dir/*_{1,2}.fastq.gz | wc -l` -ne 8  ]] || [ ! `ls $destination_dir/*_{1,2}.fastq.gz | wc -l` ]
then
    echo "Need to download the files!"
    wget -P "$destination_dir" -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR319/000/ERR3197110/ERR3197110_2.fastq.gz
    wget -P "$destination_dir" -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR319/009/ERR3197109/ERR3197109_2.fastq.gz
    wget -P "$destination_dir" -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR319/008/ERR3197108/ERR3197108_1.fastq.gz
    wget -P "$destination_dir" -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR319/001/ERR3197111/ERR3197111_2.fastq.gz
    wget -P "$destination_dir" -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR319/001/ERR3197111/ERR3197111_1.fastq.gz
    wget -P "$destination_dir" -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR319/008/ERR3197108/ERR3197108_2.fastq.gz
    wget -P "$destination_dir" -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR319/009/ERR3197109/ERR3197109_1.fastq.gz
    wget -P "$destination_dir" -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR319/000/ERR3197110/ERR3197110_1.fastq.gz
else
    echo "Files already in place, skipping this script!"
fi