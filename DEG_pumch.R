#Y en este script vamos a hacer el DEG
genX_exp <-FetchData(mieloide_pumch, vars = "GenX")
threshold <-median(genX_exp$GenX)
mieloide_pumch$GenX_group <-ifelse(GenX_exp$GenX>threshold, "high", "low")
Idents(mieloide_pumch)<-"GenX_group"
deg_pumch <-FindMarkers(
  mieloide_pumch,
  ident.1 = "high",
  ident.2 = "low",
  only.pos= FALSE
)
#Ahora el filtrado
#Cargamos primero las librerías
library(clusterProfiler)
library(org.Hs.eg.db)
genes_up_pumch <-rownames(deg_pumch[deg_pumch$avg_log2FC>0.25 & deg_pumch$p_val_adj<0.05, ])
ego_up <-enrichGO(
  gene = genes_up_pumch,
  OrgDb = org.Hs.eg.db,
  keyType = "SYMBOL",
  ont= "BP"
)
barplot(ego_up, showCategory = 10)
dotplot(ego_up, showCategory=10)
write.csv(genes_up_pumch, "genes_up_pumch.csv", row.names = FALSE)
genes_low_pumch <-rownames(deg_pumch[deg_pumch$avg_log2FC < -0.25 &deg_pumch$p_val_adj<0.05, ])
ego_low <-enrichGO(
  gene = genes_low_pumch,
  OrgDb = org.Hs.eg.db,
  keyType = "SYMBOL",
  ont= "BP"
)
barplot(ego_low, showCategory = 10)
dotplot(ego_low, showCategory=10)
write.csv(genes_low_pumch, "genes_low_pumch.csv", row.names = FALSE)
#vemos los 10 mas y menos expresados
top_up_pumch <- rownames(deg_pumch[order(-deg_pumch$avg_log2FC), ])[1:10]
top_low_pumch <- rownames(deg_pumch[order(deg_pumch$avg_log2FC), ])[1:10]
write.csv(top_up_pumch, "top10_genx_high_pumch.csv")
write.csv(top_low_pumch, "top10_genx_low_pumch.csv")
