library(jsonlite)
library(rio)
library(ggplot2)
library(reshape2)
library(plyr)
library(grid)
library(gridExtra)

data_dwnz11_freq <- readRDS("/data/projects/iogold/data/microbiome/2.json.tables.Microbaria/MicrobariaGeneAbundance_renamed.Rda")

print("Debut")
export(x = data_dwnz11_freq[1000001:2000000,], file = "/data/projects/iogold/data/microbiome/2.json.tables.Microbaria/MicrobariaGeneAbundance_1000001:2000000.json")
print("1000001:2000000")
export(x = data_dwnz11_freq[2000001:3000000,], file = "/data/projects/iogold/data/microbiome/2.json.tables.Microbaria/MicrobariaGeneAbundance_2000001:3000000.json")

print("4000001:5000000")
export(x = data_dwnz11_freq[3000001:4000000,], file = "/data/projects/iogold/data/microbiome/2.json.tables.Microbaria/MicrobariaGeneAbundance_3000001:4000000.json")

print("4000001:5000000")
export(x = data_dwnz11_freq[4000001:5000000,], file = "/data/projects/iogold/data/microbiome/2.json.tables.Microbaria/MicrobariaGeneAbundance_4000001:5000000.json")

print("5000001:6000000")
export(x = data_dwnz11_freq[5000001:6000000,], file = "/data/projects/iogold/data/microbiome/2.json.tables.Microbaria/MicrobariaGeneAbundance_5000001:6000000.json")

print("6000001:7000000")
export(x = data_dwnz11_freq[6000001:7000000,], file = "/data/projects/iogold/data/microbiome/2.json.tables.Microbaria/MicrobariaGeneAbundance_6000001:7000000.json")

print("7000001:...")
export(x = data_dwnz11_freq[7000001:nrow(data_dwnz11_freq),], file = "/data/projects/iogold/data/microbiome/2.json.tables.Microbaria/MicrobariaGeneAbundance_7000001_end.json")

print("Fin")