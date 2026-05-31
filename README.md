# TFG: Análisis de célula única en cáncer
Este repositorio contiene el código empleado para el análisis de datos de secuenciación de ARN de célula única (scRNA-seq) en adenocarcinoma ductal pancreático (PDAC). El análisis bioinformático se ha realizado sobre dos conjuntos de datos.

## Dataset 1
Werba et al.
GEO: GSE205013
Scripts:
- objeto_seurat.R
- Qc_y_filtrado.R
- normalizacion_y_variacion.R
- escalado_y_PCA.R
- Umap_y_clustering.R
- asignacion_celular.R
- mieloides.R
- DEG.R

## Dataset 2
Peng et al. (datos extraídos de un reanálisis de Luo et al.)
GEO: GSE210347
Los archivos con el sufijo "_pumch" corresponden a este conjunto de datos.

Scripts:
- objeto_seurat_pumch.R
- QC_filtrado_pumch.R
- norm_var_pumch.R
- PCA_pumch.R
- UMAP_clust_pumch.R
- asignacion_pumch.R
- mieloide_pumch.R
- DEG_pumch.R

## Pipeline
1. Creación del objeto seurat a partir de los datos descargados del repositorio público GEO.
2. Control de calidad y filtrado.
3. Normalización e identificación de genes altamente variables.
4. Escalado y PCA.
5. UMAP y clustering.
6. Anotación celular.
7. Subclusterización mieloide.
8. Análisis de expresión diferencial (DEG).
9. Enriquecimiento funcional con enrichGO.

## Software utilizado
- R
- Seurat
- dplyr
- clusterProfiler
