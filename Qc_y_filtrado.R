#En este script vamos a hacer el control de calidad (QC) y filtrado
#Empezamos con el control de calidad
#Primero cargamos las librerias
library(dplyr)
library(Seurat)
library(patchwork)
#Calculamos los genes mitocondriales
combinado[["percent.mt"]] <- PercentageFeatureSet(combinado, pattern = "^MT-")
VlnPlot(combinado, features=c("nFeature_RNA","nCount_RNA","percent.mt"), ncol=3)
#Ahora filtramos en nFeatures >300 y <6000 y percent <15
combinado<-subset(combinado,
                  subset=nFeature_RNA>300 &
                    nFeature_RNA<6000 &
                    percent.mt<15)
#Voy a volver al objeto sin filtrar para comparar características
combinado<-readRDS("combinado.rds")
#Ahora comparamos las características
plot1 <- FeatureScatter(combinado, feature1 = "nCount_RNA", feature2 = "percent.mt")
plot2 <- FeatureScatter(combinado, feature1 = "nCount_RNA", feature2 = "nFeature_RNA")
plot1 + plot2
#Y ahora volvemos a ejecutar el comando de filtrado (lineas 11-14)
saveRDS(combinado,"combinado_filtrado.rds")
