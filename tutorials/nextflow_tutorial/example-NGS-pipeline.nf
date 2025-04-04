#!/bin/bash/env nextflow
//This is an example nextflow pipeline script to take RNAseq data, apply an existing
//nextflow pipeline, and wrap that with extra functionality to run HTseq and DEseq
//We want to establish some parameters we'll be using, and include RNA-seq workflow
println "projectDir: $projectDir"
println "launchDir: $launchDir"
params.gtf_file="$projectDir/GCF_007858235.1_ASM785823v1_genomic.gtf"
params.htseq_out="$projectDir/pipeline-htseq-counts.txt"
params.bam_files="$projectDir/bam_files.txt"
params.sample_sheet="$projectDir/sample_sheet.csv"
params.fasta="$projectDir/GCF_007858235.1_ASM785823v1_genomic.fna"
params.outdir="$projectDir/test_flow"
params.projectDir="$projectDir"

sample_ch=Channel.fromPath(params.sample_sheet)

process call_RNAseq {
    input:
    val gtf_file
    val sample_sheet
    val fasta
    val outdir

    output:
    stdout

    script:
    """
    #!/bin/bash
    echo $sample_sheet
    nextflow run nf-core/rnaseq -profile apptainer \
        --input '$sample_sheet' \
        --outdir $outdir \
        --gtf $gtf_file \
        --fasta $fasta
    """
}

process call_HTseq {
    input:
    val gtf_file
    val out_directory
    val htseq_out
    val bam_files

    output:
    stdout

    script:
    """
    #!/bin/bash
    echo "Running the HTSeq script!"
    bash $projectDir/call-htseq.sh -b $bam_files \
        -d $out_directory -f $gtf_file \
        -o $htseq_out
    """
}

//process call_DEseq {
    """
    Rscript example-run-DEseq.R
    """
//}

workflow{
    RNA_out=call_RNAseq(params.gtf_file, params.sample_sheet, params.fasta, params.outdir)
    RNA_out.view()
    HTSeq_out=call_HTseq(params.gtf_file, params.projectDir, \
        params.htseq_out,params.bam_files)
    HTSeq_out.view()
}