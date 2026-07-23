# Setting up environment
# Clean environment
rm(list = ls(all.names = TRUE))
gc()
options(max.pring = .Machine$integer.max, scipen = 999, stringsAsFactors = F, dplyr.summarise.inform = F)

# Set working directory
setwd()

# Load relavent libraries
library(Seurat)
library(tidyverse)
library(pheatmap)
library(patchwork)

# Read in the data
mac.atlas <- readRDS('mac.atlas.zenodo.200524.rds')

# Counts contains the raw counts
# not included in this object
head(mac.atlas@assays$RNA$counts)
mac.atlas@assays$RNA$counts["LYZ", 1:20]
sum(mac.atlas@assays$RNA$counts["LYZ", ])

# Data contains the normalized counts
head(mac.atlas@assays$RNA$data)
mac.atlas@assays$RNA$data["LYZ", 1:20]
sum(mac.atlas@assays$RNA$data["LYZ", ])

# Metadata
mac.atlas@meta.data %>% head()

mac.atlas$percent.mt <- PercentageFeatureSet(mac.atlas, pattern = "^MT-")

# Set rownames and column names to cellid
rownames(mac.atlas@meta.data) <- mac.atlas@meta.data$cellid
mac.atlas <- AddMetaData(mac.atlas, mac.atlas@meta.data)

saveRDS(mac.atlas, file = 'mac.atlas.1.rds')