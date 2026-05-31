#En este script vamos a normalizar
combinado<- NormalizeData(combinado)
saveRDS(combinado,"combinado_norm.rds")
#En este script vamos a llevar a cabo tambien la
#identificación de características altamente variables
combinado<-FindVariableFeatures(combinado, selection.method = "vst", nfeatures=2000)
#Ahora identificamos los 10 genes más variables
top10<- head(VariableFeatures(combinado), 10)
#Ploteamos
plot_variables<-VariableFeaturePlot(combinado)
plot_var_10<- LabelPoints(plot=plot_variables, points=top10, repel=TRUE)
plot_variables+plot_var_10
#Intentar corregir lo de que las etiquetas marquen bien los puntos!
