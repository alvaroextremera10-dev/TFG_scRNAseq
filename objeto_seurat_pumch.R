#Vamos a empezar a trabajar con el segundo dataset
#El objeto seurat ya se ha creado en halowan a partir de un archivo rds obtenido de GEO
#por lo que aqui simplemente lo cargamos
library(Seurat)
pumch_obj <- readRDS("C:/Users/alvar/Desktop/pumch_obj.rds")
saveRDS(pumch_obj, file = "C:/Users/alvar/OneDrive/Documentos/datos scRNAseq TFG/Segundo dataset/pumch_obj.rds")
