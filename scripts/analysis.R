
rm(list = ls())  # Removes all objects from environment
#____________________________________________________________________________

# Reanalysis of RNA-seq Data from RB1 Mutant Retinal Organoids (E-MTAB-10331)
# Using DESeq2 for RNA-Seq differential expression 
# Data Source: https://www.ebi.ac.uk/gxa/experiments/E-MTAB-10331/Results

#______________________________________________________________________________________

#if (!requireNamespace("BiocManager", quietly = TRUE))
#  install.packages("BiocManager")
#BiocManager::install("DESeq2")
library(DESeq2)               #for differential expression

##
#BiocManager::install('EnhancedVolcano')        #for volcano plot
library(EnhancedVolcano)

#______________________________________________________

results <- "results"
dir.create(file.path("./", results), showWarnings = FALSE)

plots <- "plots"
dir.create(file.path("./", plots), showWarnings = FALSE)


#_______________________________________________________

# Download raw counts
counts = read.delim("https://www.ebi.ac.uk/gxa/experiments-content/E-MTAB-10331/resources/DifferentialSecondaryDataFiles.RnaSeq/raw-counts")

# Download metadata
metadata = read.delim("https://www.ebi.ac.uk/gxa/experiments-content/E-MTAB-10331/resources/ExperimentDesignFile.RnaSeq/experiment-design")

#________________________________________________________________

# DESeq expects the counts to have gene IDs as row names
rownames(counts) = counts$Gene.ID


# Remove unused columns (gene ID and gene name)
genes = counts[, c("Gene.ID", "Gene.Name")]
counts = counts[, -c(1, 2)]


# DESeq expects the metadata matrix to have sample IDs in the rownames
rownames(metadata) = metadata$Run


# Only keep columns of interest
metadata = metadata[, c("Sample.Characteristic.genotype."), drop=FALSE]

# Rename column
colnames(metadata) = c("genotype")

# Remove spaces in names to avoid DESeq warnings
metadata$genotype[metadata$genotype == 'wild type genotype'] = 'wildtype'
metadata$genotype[metadata$genotype == 'RB1-/-'] = 'RB1_knockout'
metadata$genotype[metadata$genotype == 'RB1+/-'] = 'RB1_heterozygous'

# Turn genotype into a factor 
metadata$genotype = factor(metadata$genotype, levels=c("wildtype", "RB1_heterozygous", "RB1_knockout"))


# ------------------------------------------------------------------------------
# Run DESeq
# ------------------------------------------------------------------------------

dds <- DESeqDataSetFromMatrix(countData=counts, colData=metadata, design=~genotype)

# Ignore genes with low counts
dds <- dds[rowSums(counts(dds)) > 10, ]

# Run DESeq
dds <- DESeq(dds)

# Compare expression
res_knockout = results(dds, contrast = c("genotype", "RB1_knockout", "wildtype"), alpha = 1e-5)
res_heterozygous = results(dds, contrast = c("genotype", "RB1_heterozygous", "wildtype"), alpha = 1e-5)

# Merge gene name into data frame 
res_df_knockout = as.data.frame(res_knockout)
res_df_heterozygous = as.data.frame(res_heterozygous)
res_df_knockout = merge(res_df_knockout, genes, by='row.names')
res_df_heterozygous = merge(res_df_heterozygous, genes, by='row.names')


# ------------------------------------------------------------------------------
# Visualization
# ------------------------------------------------------------------------------

# MA plot
plotMA(res_knockout)
plotMA(res_heterozygous)

# Volcano plot
EnhancedVolcano(res_knockout, lab=rownames(res_knockout), x='log2FoldChange', y='pvalue')
EnhancedVolcano(res_heterozygous, lab=rownames(res_heterozygous), x='log2FoldChange', y='pvalue')

#__________________________________________________________________________________

##save

#csv
write.csv(res_df_knockout, "results/deseq_knockout_vs_wildtype.csv")
write.csv(res_df_heterozygous, "results/deseq_heterozygous_vs_wildtype.csv")

#plots
pdf("plots/MAplot_knockout.pdf")
plotMA(res_knockout)
dev.off()

pdf("plots/MAplot_heterozygous.pdf")
plotMA(res_heterozygous)
dev.off()

pdf("plots/Volcano_knockout.pdf")
EnhancedVolcano(res_knockout,
                lab = rownames(res_knockout),
                x = 'log2FoldChange',
                y = 'pvalue')
dev.off()

pdf("plots/Volcano_heterozygous.pdf")
EnhancedVolcano(res_heterozygous,
                lab = rownames(res_heterozygous),
                x = 'log2FoldChange',
                y = 'pvalue')
dev.off()


