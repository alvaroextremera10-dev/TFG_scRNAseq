#En este script vamos a hacer el escalado y PCA
#Primero hacemos el escalado solo para las características variables
combinado<-FindVariableFeatures(combinado)
combinado<-ScaleData(combinado, features=VariableFeatures(combinado))
#Ahora hacemos PCA
combinado<-RunPCA(combinado, features=VariableFeatures(object = combinado))
#Hay diferentes formas de visualizar el PCA
#VizDimLoadings(combinado, dims = 1:2, reduction="pca")
#DimPlot(combinado, reduction = "pca") + NoLegend()
#Ahora dimensionamos para usarlo en el UMAP
ElbowPlot(combinado)
saveRDS(combinado, "combinado_pca.rds")
