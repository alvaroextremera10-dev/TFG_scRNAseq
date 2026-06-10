#En este script vamos a hacer el DEG para Gen X high y low
#Como ya hemos visto la expresion de Gen X en el script anterior
#ahora vamos a empezar definiendo Gen X high y low
genx_exp <- FetchData(mieloide, vars="GenX")
threshold<- median(ctsd_exp$GenX)
mieloide$GenX_group <- ifelse(ctsd_exp$GenX >threshold, "high", "low")
Idents(mieloide)<- "GenX_group"
deg<- FindMarkers(
  mieloide,
  ident.1 = "high",
  ident.2 = "low",
  only.pos= FALSE)
#Ahora que hemos definido el DEG hacemos el analisis de las rutas
#Primero descargamos los paquetes y cargamos las librerias necesarias
install.packages("BiocManager")
BiocManager::install("clusterProfiler")
BiocManager::install("org.Hs.eg.db")
library(clusterProfiler)
library(org.Hs.eg.db)
genes_up<- rownames(deg[deg$avg_log2FC>0.25 & deg$p_val_adj<0.05, ])
ego <- enrichGO(
  gene= genes_up,
  OrgDb = org.Hs.eg.db,
  keyType = "SYMBOL",
  ont = "BP"
)
dotplot(ego)
saveRDS(deg, "deg_genx.rds")
saveRDS(ego, "ego_genx.rds")
#tenemos que guardar la tabla de genes
genes_up_df <- data.frame(gene=genes_up)
write.csv(genes_up_df, "genes_up.csv", row.names = FALSE)
saveRDS(genes_up_df, "genes_up")
#vamos a ver los 10 mas sobreexpresados
top_up <-rownames(deg[order(-deg$avg_log2FC), ])[1:10]
View(top_up)
write.csv(top_up, "top10_high_genx.csv")
