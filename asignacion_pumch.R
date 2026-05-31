#En este script vamos a hacer la asignacion celular
View(top10_pumch)
View(markers)
new.cluster.ids <- c(
  "Stellate",        # 0
  "Macrophage",      # 1
  "Endothelial",     # 2
  "T_cell",          # 3
  "Ductal",          # 4
  "Fibroblast",      # 5
  "Lymphocyte_mix",  # 6
  "Ductal",          # 7
  "Stellate",        # 8
  "Ductal",          # 9
  "Macrophage",      # 10
  "Ductal",          # 11
  "Ductal",          # 12
  "Ductal",          # 13
  "B_cell",          # 14
  "Ductal",          # 15
  "Ductal",          # 16
  "Acinar",          # 17
  "T_cell",          # 18
  "Lymphocyte_mix",  # 19
  "Macrophage",      # 20
  "Endocrine",       # 21
  "Stellate",        # 22
  "Stellate"         # 23
)
names(new.cluster.ids) <-levels(pumch_small)
pumch_small <-RenameIdents(pumch_small, new.cluster.ids)
DimPlot(pumch_small, label = TRUE, repel = TRUE)
#Ahora buscamos CTSD
FeaturePlot(pumch_small, features = "CTSD")
VlnPlot(pumch_small, features = "CTSD")
DotPlot(pumch_small, features="CTSD")+RotatedAxis()
