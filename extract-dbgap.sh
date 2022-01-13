#!/bin/bash
set -euo pipefail

# need to activate conda activate sra-tools-env first
# need to convert accession/accession_project.sra to accession/accession
# i.e. cat ../accession-list.txt | while read i; do mv $i/*.sra $i/$i; done
# example command: fasterq-dump --split-files SRR1767410/SRR1767410 --ngc ../actions/prj_28998.ngc -O ../fastqs/ -t ../temp-files-place/

sf=accession=list.txt

cat $sf | while read i; do
  fasterq-dump --split-files $i/$i --ngc prj_28998.ngc -O ../fastqs/$i/ -t ../temp-files-place/ > ../logs/$i.out 2> ../logs/$i.err;
done
