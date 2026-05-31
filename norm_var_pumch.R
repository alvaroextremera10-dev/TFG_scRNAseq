#En este script vamos a normalizar los datos
pumch_obj <- NormalizeData(pumch_obj)
saveRDS(pumch_obj, "pumch_normalizado.rds")
#Ahora, igual que con el primer dataset, vamos a identificar los genes
#altamente variables para el PCA
pumch_obj <-FindVariableFeatures(pumch_obj, selection.method = "vst", nfeatures = 2000)
#Y de igual manera detectamos y ploteamos los 10 genes mas variables
top10_pumch <-head(VariableFeatures(pumch_obj), 10)
plot_var_pumch <-VariableFeaturePlot(pumch_obj)
plot_top10_pumch <- LabelPoints(plot=plot_var_pumch, points=top10_pumch, repel=TRUE)
print (plot_var_pumch + plot_top10_pumch)
