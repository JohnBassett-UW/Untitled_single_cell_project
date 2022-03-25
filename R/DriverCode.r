data.path <- "C:/Users/jbassett/Desktop/github/Data/UW36/filtered_feature_bc_matrix.h5"
#hto.path <-

#Import and qc filter
QC_pipeline <- function(data.path){
  ptm = proc.time()
  counts <- import10x(data.path)
  sce <- newSC_obj(counts)
  sce <- Attach_QC(sce)
  sce <- detect_anomalies(sce)
  sce <- rm_anomalies(sce)
  
  cat("Total \n time ")
  print((proc.time() - ptm)[3]) #print time elapsed
  return(sce)
}

#sc_obj to Seurat object
sc_to_Seurat <- function(sc_obj){
  Seurat_Object <- CreateSeuratObject(counts = sc_obj@assay[[1]])
  return(Seurat_Object)
}

#ccSeurat
ccSeurat <- function(){
  s.genes <- cc.genes$s.genes
  g2m.genes <- cc.genes$g2m.genes
  
  obj_seurat <- NormalizeData(obj_seurat)
  obj_seurat <- FindVariableFeatures(obj_seurat, selection.method = "vst")
  obj_seurat <- ScaleData(obj_seurat, features = rownames(obj_seurat))
  obj_seurat <- RunPCA(obj_seurat, features = VariableFeatures(obj_seurat))
  
  DimHeatmap(obj_seurat)
}


sce <- pipeline(data.path)
obj_seurat <- sc_to_Seurat(sce)
gridExtra::grid.arrange(sce@graphs[[2]])
