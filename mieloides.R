#En este script vamos a subclusterizar las celulas mieloides
#de la anotacion que hemos hecho antes.
#Para ello, primero creamos el subset sabiendo que los clusters con
#mieloides son el 3 y el 7
mieloide <- subset(combinado_small, idents = c("Myeloid_macrophage","Myeloid_monocyte"))
#Ahora tenemos que repetir todo el pipeline con este dataset
mieloide<- NormalizeData(mieloide)
mieloide <- FindVariableFeatures(mieloide)
mieloide <- ScaleData(mieloide)
mieloide <- RunPCA(mieloide)
mieloide <- RunUMAP(mieloide, dims = 1:10)
mieloide <- FindNeighbors(mieloide, dims = 1:10)
mieloide <- FindClusters(mieloide, resolution = 0.5)
#Acabamos ploteando el UMAP
DimPlot(mieloide, label = TRUE)
#Ahora, de igual manera que hemos hecho con el dataset anterior,
#buscamos los marcadores para poder anotar los clusters
markers_mieloide <- FindAllMarkers(mieloide,
                                   only.pos = TRUE,
                                   min.pct = 0.25,
                                   logfc.threshold = 0.25)
head(markers_mieloide)
library(dplyr)
top10_mieloide <- markers_mieloide%>%
  group_by(cluster) %>%
  top_n(n=10, wt=avg_log2FC)
DoHeatmap(mieloide, features = top10_mieloide$gene)
#visualizamos los marcadores de cada cluster
View(top10_mieloide)
#Ahora ya podemos hacer asignacion celular
new.cluster.ids <- c(
  "Macrophague_C1CQ", #0
  "MDSC",             #1
  "Macrophague_SPP1", #2
  "Epithelial_like",  #3
  "MDSC",      #4
  "MDSC"              #5
)
names(new.cluster.ids) <- levels(mieloide)
mieloide<- RenameIdents(mieloide, new.cluster.ids)
DimPlot(mieloide, label=TRUE, repel=TRUE)
#Por ultimo visualizamos la presencia del gen CTSD
FeaturePlot(mieloide, features="CTSD")
VlnPlot(mieloide, features="CTSD")
DotPlot(mieloide, features="CTSD")+ RotatedAxis()
mieloide <- saveRDS(mieloide, "mieloide.rds")
