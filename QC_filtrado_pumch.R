#En este script vamos a empezar con el pipeline del segundo dataset
#empezando por el control de calidad
library(dplyr)
library(Seurat)
library(patchwork)
#Calculamos los genes mitocondriales
pumch_obj[["percent.mt"]] <- PercentageFeatureSet(pumch_obj, pattern = "^MT-")
Idents(pumch_obj) <- "sample"
VlnPlot(pumch_obj, features=c("nFeature_RNA","nCount_RNA","percent.mt"), ncol=3)
#Ahora comparamos caracteristicas
plot1 <- FeatureScatter(pumch_obj, feature1 = "nCount_RNA", feature2 = "percent.mt")
plot2 <- FeatureScatter(pumch_obj, feature1 = "nCount_RNA", feature2 = "nFeature_RNA")
print(plot1 + plot2)
#Ahora filtramos en Feature>500 y <6000 y percent <15 segun el QC que hemos obtenido
pumch_obj <- subset(
  pumch_obj,
  subset=
    nFeature_RNA >500 &
    nFeature_RNA <6000 &
    percent.mt <15
)
saveRDS(pumch_obj, "pumch_filtrado.rds")
