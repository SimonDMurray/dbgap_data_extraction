#!/bin/bash

SCRIPT=$1
ARG=$2
QUE="long"
WDIR=`pwd`

bsub -G cellgeni -n16 -R"span[hosts=1] select[mem>32000] rusage[mem=32000]" -M32000 -o $WDIR/%J.bsub.log -e $WDIR/%J.bsub.err -q $QUE $WDIR/$SCRIPT $ARG
