#En este script vamos a hacer el UMAP
#Para ello primero agrupamos las celulas
combinado<-FindNeighbors(combinado, dims=1:10)
combinado<- FindClusters(combinado, resolution=0.5)
#Ahora corremos el UMAP
combinado<- RunUMAP(combinado, dims = 1:10)
#Ploteamos
DimPlot(combinado, reduction = "umap")
saveRDS(combinado, "combinado_umap.rds")
#Ahora en este script vamos tambien a identificar biomarcadores de clusters
#Para ello primero usamos joinlayer
#combinado<- JoinLayers(combinado)
#markers<- FindAllMarkers(combinado,
 #                        only.pos = TRUE,
  #                       min.pct = 0.25,
   #                      logfc.threshold = 0.25)
#head(markers)
#lo de arriba no funcionaba por RAM así que hay que usar este codigo
combinado <- JoinLayers(combinado)
set.seed(123)
combinado_small<- subset(combinado, cells=sample(colnames(combinado), 5000))
markers <- FindAllMarkers(combinado_small, only.pos = TRUE, min.pct = 0.1, logfc.threshold = 0.25)
head(markers)
#Ahora seleccionamos los 10 genes más diferenciales
library(dplyr)
top10 <- markers%>%
  group_by(cluster) %>%
  slice_max(order_by=avg_log2FC, n=10)
#Lo visualizamos
combinado_small <- ScaleData(combinado_small, features = unique(top10$gene))
DoHeatmap(combinado_small, features = top10$gene)+ NoLegend()
