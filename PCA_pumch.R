#En este script vamos a hacer el escalado y PCA
pumch_obj <- FindVariableFeatures(pumch_obj)
pumch_obj <-ScaleData(pumch_obj, features = VariableFeatures(pumch_obj))
#Con esto ya podemos hacer el PCA
pumch_obj <- RunPCA(pumch_obj, features = VariableFeatures(object=pumch_obj))
saveRDS(pumch_obj, "pumch_PCA.rds")
#dimensionamos con elbowplot
ElbowPlot(pumch_obj)
