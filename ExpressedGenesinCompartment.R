
#load the gene names with the high expression with the mouse names that are not the human names. 

total_human_membrane<-read.delim("index/uniprot_human_cellmembrane_Aug2017.tab")
row.names(total_human_membrane)<-total_human_membrane$Entry
total_human_secreted<-read.delim("index/uniprot_human_secreted_Aug2017.tab")
row.names(total_human_secreted)<-total_human_secreted$Entry

#Change the label that so that the Uniprot ID has the column name of "Entry
colnames(humanIDfromMouse)<-c("Gene.names","Entry")
#Merge the two tables. This makes sure that all the gene names are there.
expressed_human_secreted_SC<- merge(humanIDfromMouse,total_human_secreted,by="Entry")
expressed_human_secreted_EC<- merge(humanIDfromMouse,total_human_secreted,by="Entry")
#Merge the two tables. This gets rid of the duplicated gene names and keeps the uniprot ID as unique.#expressed_human_secreted<-subset(total_human_secreted, Entry %in% humanIDfromMouse$Entry)
expressed_human_membrane_SC<- merge(humanIDfromMouse,total_human_membrane,by="Entry")
expressed_human_membrane_EC<- merge(humanIDfromMouse,total_human_membrane,by="Entry")
# Specify the ligand and receptor for each subset
SC_ligand<- rbind(expressed_human_membrane_SC,expressed_human_secreted_SC)
EC_ligand<- rbind(expressed_human_membrane_EC,expressed_human_secreted_EC)
SC_receptor<- expressed_human_membrane_SC
EC_receptor<- expressed_human_membrane_EC
