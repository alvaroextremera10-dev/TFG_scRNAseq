#Por ultimo en este script vamos a llevar a cabo la asignacion celular
top10
View(top10)
levels(combinado_small)
#Tras observar todos los genes ponemos etiquetas a cada cluster
new.cluster.ids <- c(
  "CD4_T_CXCL13",  #0
  "Epithelial",    #1
  "CD4_T_IL7R",    #2
  "Myeloid_macrophage",#3
  "Epithelial",    #4
  "Epithelial",    #5
  "Epithelial",    #6
  "Myeloid_monocyte",#7
  "Epithelial",    #8
  "Epithelial",    #9
  "NK",            #10
  "Mesenchymal",   #11
  "B_plasma",      #12
  "Mast",          #13
  "Proliferating", #14
  "Mesenchymal",   #15
  "Epithelial",    #16
  "Endothelial",   #17
  "Proliferating", #18
  "Proliferating", #19
  "Epithelial",    #20
  "Mesenchymal",   #21
  "Mesenchymal",   #22
  "Epithelial",    #23
  "Epithelial"     #24
)
names(new.cluster.ids)<- levels(combinado_small)
combinado_small<- RenameIdents(combinado_small, new.cluster.ids)
#Por ultimo ploteamos
DimPlot(combinado_small, label=TRUE, repel=TRUE)
saveRDS(combinado_small, "combinado_small.rds")
#Ahora vamos a buscar el marcador de la catepsina d (ctsd)
#Hay diferentes maneras de hacer esto
FeaturePlot(combinado_small, features="CTSD")
VlnPlot(combinado_small, features = "CTSD")
DotPlot(combinado_small, features="CTSD")+RotatedAxis()
