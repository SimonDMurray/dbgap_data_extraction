#!/bin/bash

set -euo pipefail

TAG=$1
GLIB=/lustre/scratch117/cellgen/cellgeni/TIC-bulkseq/tic-1066/star-fusion/GRCh38_gencode_v37_CTAT_lib_Mar012021.plug-n-play/ctat_genome_lib_build_dir
FQDIR=/lustre/scratch117/cellgen/cellgeni/TIC-bulkseq/tic-1066/fastqs
CPUS=16

R1=`find $FQDIR/* | grep $TAG | grep _1`
R2=`find $FQDIR/* | grep $TAG | grep _2`

singularity exec -e -B /lustre \
        /lustre/scratch117/cellgen/cellgeni/TIC-bulkseq/tic-1066/star-fusion/star-fusion.v1.10.1.simg \
        /usr/local/src/STAR-Fusion/STAR-Fusion \
        --left_fq $R1 \
        --right_fq $R2 \
        --genome_lib_dir $GLIB \
        -O /lustre/scratch117/cellgen/cellgeni/TIC-bulkseq/tic-1066/star-fusion/$TAG \
        --CPU $CPUS
