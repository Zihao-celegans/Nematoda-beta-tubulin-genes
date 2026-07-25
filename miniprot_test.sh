#!/bin/bash
#SBATCH -J miniprot_test                # Job name
#SBATCH -A eande106                     # Allocation (Andersen lab)
#SBATCH -p shared                       # Partition: shared (use 'express' for <8h test jobs)
#SBATCH -t 00:10:00                     # Walltime hh:mm:ss
#SBATCH --cpus-per-task=4               # 4 cores
#SBATCH --mem=8G                        # 8 GB total
#SBATCH -o /vast/eande106/projects/John/nematoda_beta_tubulin/logs/miniprot_test.%j.out
#SBATCH -e /vast/eande106/projects/John/nematoda_beta_tubulin/logs/miniprot_test.%j.err

set -euo pipefail

PROJECT=/vast/eande106/projects/John/nematoda_beta_tubulin
MINIPROT="$PROJECT/software/miniprot/miniprot"
GENOME="$PROJECT/software/miniprot/test/DPP3-hs.gen.fa.gz"
PROTEINS="$PROJECT/software/miniprot/test/DPP3-mm.pep.fa.gz"
OUTPUT="$PROJECT/results/DPP3.batch.gff3"

"$MINIPROT" \
    -t "$SLURM_CPUS_PER_TASK" \
     --gff-only \
      "$GENOME" \
      "$PROTEINS" \
      > "$OUTPUT"
