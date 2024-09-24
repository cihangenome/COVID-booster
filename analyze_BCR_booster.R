#setwd("current_directory")

packages <-c("readxl","readr","ggplot2","ggrepel","ggpubr","reshape2","writexl","pheatmap","immunarch","ggbeeswarm","viridis","tidyverse","dplyr","purrr","stringr")

invisible(lapply(packages, library, character.only = TRUE))


#bcr_omd<-repLoad("./sampleExport_BCR")

################
################
bcr_omd_filtered_min2clones <-repFilter(bcr_omd, .method = "by.clonotype", .query = list(Clones = morethan(1)))$data

dist_bcr_omd_filtered_min2clones <- seqDist( bcr_omd_filtered_min2clones, .col = 'CDR3.aa')

clust_bcr_omd_filtered_min2clones <- seqCluster(bcr_omd_filtered_min2clones, dist_bcr_omd_filtered_min2clones,.perc_similarity = 0.8 )


clust_bcr_omd_filtered_min2clones_compact<-lapply(clust_bcr_omd_filtered_min2clones, function(x) x%>% select(Clones,Proportion,CDR3.aa,V.name,D.name,J.name,Cluster))

clust_bcr_omd_filtered_min2clones_compact<-do.call(rbind,clust_bcr_omd_filtered_min2clones_compact)

clust_bcr_omd_filtered_min2clones_compact$Sample_name<-rownames(clust_bcr_omd_filtered_min2clones_compact)
clust_bcr_omd_filtered_min2clones_compact$Sample_name<-gsub("\\..*","",clust_bcr_omd_filtered_min2clones_compact$Sample_name)

clust_bcr_omd_filtered_min2clones_compact %>% .$Cluster %>% unique() %>% length()


duplic_cluster_entries_clust_bcr_omd_filtered_min2clones<-clust_bcr_omd_filtered_min2clones_compact$Cluster[duplicated(clust_bcr_omd_filtered_min2clones_compact$Cluster)]



clust_bcr_omd_filtered_min2clones_compact_multi_row_clusters<-clust_bcr_omd_filtered_min2clones_compact[which(clust_bcr_omd_filtered_min2clones_compact$Cluster %in% duplic_cluster_entries_clust_bcr_omd_filtered_min2clones),]


clust_bcr_omd_filtered_min2clones_compact_multi_row_clusters<-clust_bcr_omd_filtered_min2clones_compact_multi_row_clusters[grep("cluster",clust_bcr_omd_filtered_min2clones_compact_multi_row_clusters$Cluster),]

clust_bcr_omd_filtered_min2clones_row_count<-as.data.frame(table(clust_bcr_omd_filtered_min2clones_compact_multi_row_clusters$Cluster))
################
################

saveRDS(bcr_omd,"Delmonte_BCR_data_42samples.rds")



############
############
bcr_data_omd_42samples_compact<-lapply(bcr_omd[["data"]], function(x) x%>% select(Clones,Proportion,CDR3.aa,V.name,D.name,J.name))

bcr_data_omd_42samples_compact<-do.call(rbind,bcr_data_omd_42samples_compact)
bcr_data_omd_42samples_compact$Sample_name<-rownames(bcr_data_omd_42samples_compact)

bcr_data_omd_42samples_compact$Sample_name<-gsub("\\..*","",bcr_data_omd_42samples_compact$Sample_name)
############
############
saveRDS(bcr_data_omd_42samples_compact,"Delmonte_BCR_data_compact_42samples.rds")
############
############
