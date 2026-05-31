#En este script vamos a hacer el UMAP y el clustering
#Empezamos agrupando las celulas y despues corremos el UMAP
pumch_obj <-FindNeighbors(pumch_obj, dims = 1:15)
pumch_obj <-FindClusters(pumch_obj, resolution = 0.5)
pumch_obj <-RunUMAP(pumch_obj, dims = 1:15)
#Ahora ploteamos y guardamos
DimPlot(pumch_obj, reduction = "umap")
saveRDS(pumch_obj, "pumch_umap.rds")
#Ahora hacemos clustering definiendo un subset
pumch_obj <-JoinLayers(pumch_obj)
set.seed(123)
pumch_small <- subset(pumch_obj,
                      cells= sample(colnames(pumch_obj), 5000))
markers <-FindAllMarkers(pumch_small,
                         only.pos= TRUE,
                         min.pct=0.1,
                         logfc.threshold=0.25)
#Y ahora seleccionamos los 10 genes mas diferenciales y visualizamos
library(dplyr)
top10_pumch <- markers%>%
  group_by(cluster) %>%
  slice_max(order_by=avg_log2FC, n=10)
pumch_small <-ScaleData(pumch_small, features=unique(top10_pumch$gene))
DoHeatmap(pumch_small, features=top10_pumch$gene) + NoLegend()
saveRDS(pumch_small, "pumch_small.rds")
