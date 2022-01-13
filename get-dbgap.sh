#!/bin/bash
set -euo pipefail

# need to activate conda activate sra-tools-env first

for kt in cart/*; do prefetch --ngc actions/prj_28998.ngc $kt -X 5t -O ../data/ >ooo.txt 2>eee.txt; done
