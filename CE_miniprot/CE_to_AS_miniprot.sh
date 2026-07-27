#!/bin/bash
#SBATCH -J CE_to_AS_miniprot            # Job name
#SBATCH -A eande106                     # Allocation (Andersen lab)
#SBATCH -p shared                       # Partition: shared (use 'express' for <8h test jobs)
#SBATCH -t 00:30:00                     # Walltime hh:mm:ss
#SBATCH --cpus-per-task=4               # 4 cores
#SBATCH --mem=8G                        # 8 GB total
#SBATCH -o /vast/eande106/projects/John/nematoda_beta_tubulin/logs/CE_to_AS_miniprot.%j.out
#SBATCH -e /vast/eande106/projects/John/nematoda_beta_tubulin/logs/CE_to_AS_miniprot.%j.err


set -euo pipefail

PROJECT=/vast/eande106/projects/John/nematoda_beta_tubulin
MINIPROT="$PROJECT/software/miniprot/miniprot"
AS_GENOME="$PROJECT/data/genomes/A_suum/PRJNA62057/WBPS9/ascaris_suum.PRJNA62057.WBPS9.genomic.fa.gz"
CE_BT_PROTEINS="$PROJECT/data/reference/C_elegans/WBPS19/beta_tubulin_proteins/C_elegans_beta_tubulins.WBPS19.protein.fa"
OUTPUT_DIR="$PROJECT/results/A_suum/PRJNA62057/WBPS9"
OUTPUT="$OUTPUT_DIR/CE_to_AS_miniprot.gff3"

mkdir -p "$OUTPUT_DIR"


"$MINIPROT" \
    -I \
    -t "$SLURM_CPUS_PER_TASK" \
    --gff \
    -u \
    --outs 0.6 \
    --outc 0.5 \
    "$AS_GENOME" \
    "$CE_BT_PROTEINS" \
    > "$OUTPUT"

