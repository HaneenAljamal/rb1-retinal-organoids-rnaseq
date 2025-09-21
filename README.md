# rb1-retinal-organoids-rnaseq
Reproducing and validating the differential expression analysis performed on retinal organoids differentiated from human embryonic stem cells (hESCs) carrying mutations in the **RB1** gene.    The original dataset comes from the [Expression Atlas](https://www.ebi.ac.uk/gxa/experiments/E-MTAB-10331/Results) (accession: **E-MTAB-10331**).

## Methods
The workflow follows standard RNA-seq differential expression analysis using **DESeq2**, with visualization via **EnhancedVolcano**.  
The analysis workflow is inspired by publicly available RNA-seq tutorials, such as  
["Differential Expression Analysis with DESeq2" by StatQuest](https://www.youtube.com/watch?v=NGbZmlGLG5w).  

## Outputs
Differential expression results: 
results/deseq_knockout_vs_wildtype.csv
results/deseq_knockout_vs_wildtype.csv

Plots
plots/MAplot_knockout.pdf
plots/Volcano_knockout.pdf

## Dataset
- **Accession:** E-MTAB-10331  
- **Source:** [Expression Atlas, EMBL-EBI](https://www.ebi.ac.uk/gxa/experiments/E-MTAB-10331/Results)  
- **Publication:** Kanber, C. et al. (2022). *Transcriptome profiling of retinal organoids with RB1 mutations*  
- **License:** Creative Commons Attribution 4.0 International (CC BY 4.0)

## Disclaimer
This repository is for **educational and reproducibility purposes only**.  
The authors of this repository do not claim ownership of the original dataset.

## Requirements
- R (version 4.4.1, released 2024-06-14)
- Suggested R packages:  `DESeq2`, `EnhancedVolcano`  `BiocManager` (for installation)
