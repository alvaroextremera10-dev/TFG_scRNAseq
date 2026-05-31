#En este script vamos a crear el objeto seurat para mis muestras
#cargamos las librerías (despues de instalar los paquetes)
library(Seurat)
library(Matrix)
#Ahora definimos la ruta a la carpeta con todas mis carpetas
dir_base<- "C:/Users/alvar/OneDrive/Documentos/datos scRNAseq TFG/"
#Ahora leemos una muestra (empezando por P04)
data_P04 <- Read10X(data.dir = paste0(dir_base, "P04/"))
#comprobamos que funciona con su dimension
dim(data_P04)
#Una vez comprobado que esta bien leida vamos a crear el objeto seurat
P04 <- CreateSeuratObject(counts = data_P04, project = "P04")
P04
#Repetimos para todas las muestras
#P05
data_P05 <- Read10X(data.dir = paste0(dir_base, "P05/"))
P05 <- CreateSeuratObject(counts = data_P05, project = "P05")
#P07
data_P07 <- Read10X(data.dir = paste0(dir_base, "P07/"))
P07 <- CreateSeuratObject(counts = data_P07, project = "P07")
#P09
data_P09 <- Read10X(data.dir = paste0(dir_base, "P09/"))
P09 <- CreateSeuratObject(counts = data_P09, project = "P09")
#P13
data_P13 <- Read10X(data.dir = paste0(dir_base, "P13/"))
P13 <- CreateSeuratObject(counts = data_P13, project = "P13")
#P15
data_P15 <- Read10X(data.dir = paste0(dir_base, "P15/"))
P15 <- CreateSeuratObject(counts = data_P15, project = "P15")
#P19
data_P19 <- Read10X(data.dir = paste0(dir_base, "P19/"))
P19 <- CreateSeuratObject(counts = data_P19, project = "P19")
#P20
data_P20 <- Read10X(data.dir = paste0(dir_base, "P20/"))
P20 <- CreateSeuratObject(counts = data_P20, project = "P20")
#P22
data_P22 <- Read10X(data.dir = paste0(dir_base, "P22/"))
P22 <- CreateSeuratObject(counts = data_P22, project = "P22")
#P23
data_P23 <- Read10X(data.dir = paste0(dir_base, "P23/"))
P23 <- CreateSeuratObject(counts = data_P23, project = "P23")
#P26
data_P26 <- Read10X(data.dir = paste0(dir_base, "P26/"))
P26 <- CreateSeuratObject(counts = data_P26, project = "P26")
#Por ultimo combinamos todos los objetos para crear uno único para el experimento entero
combinado <- merge(P04, y=c(P05,P07,P09,P13,P15,P19,P20,P22,P23,P26))
saveRDS(combinado,"combinado.rds")
