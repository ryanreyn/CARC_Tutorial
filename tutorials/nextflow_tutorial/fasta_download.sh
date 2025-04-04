#!/bin/bash
#This is a shell file for downloading the fasta files used in the example workflow
#from the ENA database
wget -P "../../data/" -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR319/000/ERR3197110/ERR3197110_2.fastq.gz
wget -P "../../data/" -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR319/009/ERR3197109/ERR3197109_2.fastq.gz
wget -P "../../data/" -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR319/008/ERR3197108/ERR3197108_1.fastq.gz
wget -P "../../data/" -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR319/001/ERR3197111/ERR3197111_2.fastq.gz
wget -P "../../data/" -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR319/001/ERR3197111/ERR3197111_1.fastq.gz
wget -P "../../data/" -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR319/008/ERR3197108/ERR3197108_2.fastq.gz
wget -P "../../data/" -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR319/009/ERR3197109/ERR3197109_1.fastq.gz
wget -P "../../data/" -nc ftp://ftp.sra.ebi.ac.uk/vol1/fastq/ERR319/000/ERR3197110/ERR3197110_1.fastq.gz
