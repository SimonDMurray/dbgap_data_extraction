#!/bin/bash

TAG=$1
SREF=/nfs/cellgeni/alexp/STARsolo-GRCh38-1.2.0/STAR
RREF=/nfs/cellgeni/alexp/STARsolo-GRCh38-1.2.0/Homo_sapiens.GRCh38.84.filtered.rsem
FQDIR=/lustre/scratch117/cellgen/cellgeni/TIC-bulkseq/tic-1066/fastqs
PAIRED=--paired-end
CPUS=32

mkdir $TAG && cd $TAG
R1=`find $FQDIR/* | grep $TAG | grep _1`
R2=`find $FQDIR/* | grep $TAG | grep _2`

## /nfs/users/nfs_a/ap41/STAR/bin/Linux_x86_64_static/STAR - v 2.7.7

STAR --runThreadN $CPUS --genomeDir $SREF --readFilesIn $R1 $R2 --outFilterMultimapNmax 20 \
     --alignSJoverhangMin 8 --alignSJDBoverhangMin 1 --outFilterMismatchNmax 999 --outFilterMismatchNoverReadLmax 0.04 \
     --alignIntronMin 20 --alignIntronMax 1000000 --alignMatesGapMax 1000000 --outSAMheaderCommentFile COfile.txt \
     --outSAMheaderHD @HD VN:1.4 SO:coordinate --outSAMunmapped Within --outFilterType BySJout --outSAMattributes NH HI AS NM MD \
     --outSAMtype BAM SortedByCoordinate --quantMode TranscriptomeSAM GeneCounts --sjdbScore 1 --limitBAMsortRAM 30000000000

rsem-calculate-expression $PAIRED -p $CPUS --bam --estimate-rspd --seed 12345 --no-bam-output --forward-prob 0.5 Aligned.toTranscriptome.out.bam $RREF $TAG.rsem
