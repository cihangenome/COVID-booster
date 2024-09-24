#setwd("current_directory")

packages <-c("readxl","readr","ggplot2","ggrepel","ggpubr","reshape2","writexl","pheatmap","immunarch","ggbeeswarm","viridis","tidyverse","dplyr","purrr","stringr")

invisible(lapply(packages, library, character.only = TRUE))

################
################

################
################
tcr_omd<-repLoad("./sampleExport_TCR")

saveRDS(tcr_omd,"Delmonte_TCR_data_84samples.rds")

tcr_data_omd_84samples_compact<-lapply(tcr_omd[["data"]], function(x) x%>% dplyr::select(Clones,Proportion,CDR3.aa,V.name,D.name,J.name))

tcr_data_omd_84samples_compact<-do.call(rbind,tcr_data_omd_84samples_compact)
tcr_data_omd_84samples_compact$Sample_name<-rownames(tcr_data_omd_84samples_compact)

tcr_data_omd_84samples_compact$Sample_name<-gsub("\\..*","",tcr_data_omd_84samples_compact$Sample_name)

saveRDS(tcr_data_omd_84samples_compact,"Delmonte_TCR_data_compact_84samples.rds")
################
################