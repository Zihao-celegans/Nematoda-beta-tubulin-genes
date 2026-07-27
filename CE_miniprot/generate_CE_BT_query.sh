#!/bin/bash

set -euo pipefail

# Script to generate a query FASTA file of C. elegans beta-tubulin proteins from the reference proteome

# Define project and input/output directories
PROJECT=/vast/eande106/projects/John/nematoda_beta_tubulin

INPUT_DIR="$PROJECT/data/reference/C_elegans/WBPS19"
OUTPUT_DIR="$INPUT_DIR/beta_tubulin_proteins"

# Define input proteome and output FASTA file for beta-tubulin proteins
PROTEOME="$INPUT_DIR/caenorhabditis_elegans.PRJNA13758.WBPS19.protein.fa.gz"
OUTPUT_FASTA="$OUTPUT_DIR/C_elegans_beta_tubulins.WBPS19.protein.fa"

GENE_LIST='(ben-1|tbb-1|tbb-2|tbb-4|tbb-6|mec-7)'

mkdir -p "$OUTPUT_DIR"

# Confirm that the input file exists.
if [[ ! -f "$PROTEOME" ]]; then
    echo "ERROR: Protein FASTA not found:"
    echo "$PROTEOME"
    exit 1
fi

echo "Input proteome:"
echo "$PROTEOME"

echo "Extracting beta-tubulin proteins..."

zcat "$PROTEOME" \
    | awk -v bt_gene_name="$GENE_LIST" '
        /^>/ {
            keep = ($0 ~ ("locus=" bt_gene_name "([[:space:]]|$)"))
        }
        keep
    ' \
    > "$OUTPUT_FASTA"


PROTEIN_COUNT=$(grep -c '^>' "$OUTPUT_FASTA")

echo
echo "Extracted protein records: $PROTEIN_COUNT"
echo "Output FASTA:"
echo "$OUTPUT_FASTA"

echo
echo "Extraction completed successfully."
