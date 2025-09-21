# rb1-retinal-organoids-rnaseq
Reproducing and validating the differential expression analysis performed on retinal organoids differentiated from human embryonic stem cells (hESCs) carrying mutations in the **RB1** gene.    The original dataset comes from the [Expression Atlas](https://www.ebi.ac.uk/gxa/experiments/E-MTAB-10331/Results) (accession: **E-MTAB-10331**).

## Methods
The workflow follows standard RNA-seq differential expression analysis using **DESeq2**, with visualization via **EnhancedVolcano**.  
The analysis workflow is inspired by publicly available RNA-seq tutorials, such as  
["Differential Expression Analysis with DESeq2" by StatQuest](https://www.youtube.com/watch?v=NGbZmlGLG5w).  

## Outputs
Differential expression results: 
- results/deseq_knockout_vs_wildtype.csv
- results/deseq_heterozygous_vs_wildtype.csv

Plots:
- plots/MAplot_knockout.pdf
- plots/Volcano_knockout.pdf
- plots/MAplot_heterozygous.pdf
- plots/Volcano_heterozygous.pdf

## Dataset
- **Accession:** E-MTAB-10331  
- **Source:** [Expression Atlas, EMBL-EBI](https://www.ebi.ac.uk/gxa/experiments/E-MTAB-10331/Results)  
- **Publication:** Kanber, C. et al. (2022). *Transcriptome profiling of retinal organoids with RB1 mutations*  
- **License:** Creative Commons Attribution 4.0 International (CC BY 4.0)


## Requirements
- R (version 4.4.1, released 2024-06-14)
- Suggested R packages:  `DESeq2`, `EnhancedVolcano`  `BiocManager` (for installation)

Install missing packages in R:

```r
if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(c("DESeq2", "EnhancedVolcano"))
```
## Disclaimer
This repository is for **educational and reproducibility purposes only**.  
The authors of this repository do not claim ownership of the original dataset.

  ## Usage

Clone the repository and run the analysis script:

```bash
git clone https://github.com/HaneenAljamal/rb1-retinal-organoids-rnaseq.git
cd rb1-retinal-organoids-rnaseq
Rscript scripts/analysis.R
```
## Repository Structure
```
rb1-retinal-organoids-rnaseq/
│
├── scripts/ # Folder containing the R analysis script
│ └── analysis.R
├── results/ # Folder where DESeq2 CSV output files will be saved
│ ├── deseq_knockout_vs_wildtype.csv
│ └── deseq_heterozygous_vs_wildtype.csv
├── plots/ # Folder where plots (PDFs) will be saved
│ ├── MAplot_knockout.pdf
│ └── Volcano_knockout.pdf
└── README.md # This file, explains the project
```

## Citations
- Love, M. I., Huber, W., & Anders, S. (2014). Moderated estimation of fold change and dispersion for RNA-seq data with DESeq2. Genome Biology, 15(12), 550.
- Blighe, K., Rana, S., & Lewis, M. (2019). EnhancedVolcano: publication-ready volcano plots with enhanced colouring and labeling. Bioconductor package.



