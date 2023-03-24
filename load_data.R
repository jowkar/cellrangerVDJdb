library(stringr)

read_load_data_template <- function(fname = "load_data_template.sql"){
  load_data_template <- readLines(fname, warn = F)
  names(load_data_template) <- str_split_fixed(
    str_split_fixed(load_data_template," ",3)[,2],"\\(",2)[,1]
  return(load_data_template)
}

create_load_data_sql <- function(load_data_template, sname, dir){
  stopifnot(dir.exists(dir))
  fnames <- list()
  fnames[["barcodes"]] <- paste0(dir,"cell_barcodes.json")
  fnames[["clonotypes"]] <- paste0(dir,"clonotypes.csv")
  fnames[["airr_rearrangement"]] <- paste0(dir,"airr_rearrangement.tsv")
  fnames[["consensus_annotations"]] <- paste0(dir,"consensus_annotations.csv")
  fnames[["filtered_contig_annotations"]] <- paste0(dir,"filtered_contig_annotations.csv")
  
  for (tabname in names(fnames)){
    if (!file.exists(fnames[[tabname]])){
      stop(paste0("File does not exist: ",fnames[[tabname]]))
    }
  }
  
  for (tabname in names(fnames)){
    load_data_template[[tabname]] <- gsub(paste0("file_",tabname),
                                          fnames[[tabname]],
                                          load_data_template[[tabname]])
  }
  return(load_data_template)
}

write_load_data_script <- function(sname, resultsdir, cellranger_dir_structure, 
                                   outdir = "loading_commands"){
  cellranger_dir_structure <- gsub("__s__", sname, cellranger_dir_structure)
 
  dir <- paste0(resultsdir, cellranger_dir_structure)
  if (!dir.exists(dir)){
    stop("Input directory does not exist")
  }
  
  load_data_template <- read_load_data_template()
  load_data_sql <- create_load_data_sql(load_data_template, sname, dir)
  
  dir.create(outdir, showWarnings = F, recursive = T)
  writeLines(load_data_sql, con = paste0(outdir, "/", sname, "_load_data.sql"), 
             sep = "\n")
}

write_load_data_script(
    sname = "SampleID_9_11june18",
    resultsdir = "/Users/00105606/nimbus/data/proj/um_ss/Pipelines/10x/results/",
    cellranger_dir_structure = paste0("multi/", "__s__",
                                     "/outs/per_sample_outs/", "__s__",
                                     "/vdj_t/"))