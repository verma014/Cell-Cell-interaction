#Convert mouse gene names to human gene names
library(biomaRt)
#Input files with all the genes that are expressed by the cell. 
mouse_secreted<-read.csv("Secreted3.csv")
#Take the genename or the best indentifier into a file list by itself.
#The Entry.name must be cropped in excel to xxx_mouse must be cropped to xxx
musGenes<-(mouse_secreted$Gene.names...primary..)

# Basic function to convert mouse to human gene names
humangene = useMart("ensembl", dataset = "hsapiens_gene_ensembl")
mousegene = useMart("ensembl", dataset = "mmusculus_gene_ensembl")

#List all the attributes in the ensembl mart if you want to check which identifiers are available 
#humanattributes<-listAttributes(humangene)
#mouseattributes<-listAttributes(mousegene)
#Get a sheet with the original genename as well as the Uniprot gene id for Human. The UniportID will be combined with the file that will be used for figuring out the membrane vs secreted. 
humanIDfromMouse<- getLDS(attributes = c("external_gene_name"), filters = "mgi_symbol", values = musGenes , mart = mousegene, attributesL = c("uniprot_gn"), martL = humangene, uniqueRows=T)


#musGenes2<- getLDS(attributes = c("mgi_symbol"), filters = "mgi_symbol", values = musGenes , mart = mousegene, attributesL = c("uniprot_gn","hgnc_symbol","entrezgene"), martL = humangene, uniqueRows=T)


