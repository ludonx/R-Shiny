# Load library for plotting
library(pheatmap)
library(plotly)

#Load data
load("/data/db/biobank/catalogue/hs_9.9/functional/compressed_hs_9.9_annot_all_addIPR.kosMetacardis.correctedMGSids.rda")
load("/data/db/biobank/catalogue/hs_9.9/hs_9.9_3463_cleaned_CAG_sup50_freeze1.rda")

#Put the path to "fam_1.0.tar.gz" 
path.to.fam.tar.gz = "/data/db/biobank/catalogue/hs_9.9/functional/fam_1.0.tar.gz"
install.packages(path.to.fam.tar.gz, repos = NULL, type="source")
library(fam)

if(!getOption("verbose")) chverb()

#Pre-step
hs9.9 = CatalogueBuilder(catalogue = hs_9.9_annot_all, mgs.annot = CAG, nCores = 6L)

compute.time = system.time(
  { 
    hs9.9$getFunctionalUnitsPrevalenceMgs()
  }
)[[3]]
cat("Functional unit prevalence per MGS:", compute.time/60, "minutes.\n")

#Compute module coverage
md.cov = hs9.9$moduleCoverage(only.kegg = F)
# Note: you need md.cov$coverage

# Plot 1
pheatmap(x, cluster_rows = F, cluster_cols = F)

# Plot 2 (interactive)
plot_ly(x=colnames(md.cov$coverage), y=rownames(md.cov$coverage), z=md.cov$coverage, type="heatmap",
        colorbar=list(title="Coverage"),
        colorscale=list(c(0,"rgb(224, 224, 224)"),
                        c(1, "rgb(255,0,0)"))
        )%>%
  layout(xaxis=list(showticklabels = FALSE), yaxis=list(showticklabels = FALSE))
