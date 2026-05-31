#Ahora vamos a subclusterizar mieloides y anotarlas
#Empezamos creando el subset de mieloides
mieloide_pumch <- subset(pumch_small, idents = "Macrophage")
#Repetimos pipeline
mieloide_pumch <-NormalizeData(mieloide_pumch)
mieloide_pumch <-FindVariableFeatures(mieloide_pumch)
mieloide_pumch <-ScaleData(mieloide_pumch)
mieloide_pumch <-RunPCA(mieloide_pumch)
mieloide_pumch <-RunUMAP(mieloide_pumch, dims = 1:15)
mieloide_pumch <-FindNeighbors(mieloide_pumch, dims = 1:15)
mieloide_pumch <-FindClusters(mieloide_pumch, resolution = 0.5)
#Ploteamos el UMAP para ver los clusters
DimPlot(mieloide_pumch, label = TRUE)
#Y ahora buscamos marcadores para asignacion
markers_mieloide_pumch <-FindAllMarkers(mieloide_pumch,
                                       only.pos = TRUE,
                                       min.pct = 0.25,
                                       logfc.threshold = 0.25)
head(markers_mieloide_pumch)
#Voy a ver los 10 genes para representar heatmap
top10_mieloide_pumch <- markers_mieloide_pumch %>%
  group_by(cluster)%>%
  top_n(n=10, wt=avg_log2FC)
genes_heatmap <- top10_mieloide_pumch$gene
mieloide_pumch <- ScaleData(mieloide_pumch, features = genes_heatmap)
DoHeatmap(mieloide_pumch, features = genes_heatmap) +NoLegend()
View(markers_mieloide_pumch)
View(top10_mieloide_pumch)
new.ids <- c(
  "SPP1_macrophage",   # 0
  "C1QC_macrophage",   # 1
  "MDSC",              # 2
  "C1QC_macrophage",   # 3
  "Proliferating",     # 4
  "Mast"               # 5
)
names(new.ids) <-levels(mieloide_pumch)
mieloide_pumch <-RenameIdents(mieloide_pumch, new.ids)
DimPlot(mieloide_pumch, label = TRUE, repel = TRUE)
FeaturePlot(mieloide_pumch, features = "CTSD")
VlnPlot(mieloide_pumch, features = "CTSD")
DotPlot(mieloide_pumch, features="CTSD")+ RotatedAxis()
saveRDS(mieloide_pumch, "mieloide_pumch.rds")
