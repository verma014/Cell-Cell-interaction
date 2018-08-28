
#Convert mouse gene names to human gene names since the connectome uses human gene names. 
#TPM is important for this analysis. Do not use read counts. FPKM may be ok.
library(biomaRt)
#Input files with all the genes that are expressed by the cell. 
SC_expressed<-read.csv("QSC1.csv")
#This files should have just the gene name and TPM
SC_expressed<-SC_expressed[,-c(1,3:8)]
#Take the genename or the best colnames(SC_expressed)[2]<-g

musGenes<-(SC_expressed$Gene.Name)

# Basic function to convert mouse to human gene names
#humangene = useMart("ensembl", dataset = "hsapiens_gene_ensembl")
mousegene = useMart("ensembl", dataset = "mmusculus_gene_ensembl")

#List all the attributes in the ensembl mart if you want to check which identifiers are available 
#humanattributes<-listAttributes(humangene)
#mouseattributes<-listAttributes(mousegene)
#Get a sheet with the original genename as well as the Uniprot gene id for Human. The UniportID will be combined with the file that will be used for figuring out the membrane vs secreted. 
#humanIDfromMouse<- getLDS(attributes = c("external_gene_name"), filters = "mgi_symbol", values = musGenes , mart = mousegene, attributesL = c("external_gene_name","uniprot_gn"), martL = humangene, uniqueRows=T)
#Better to use the homolog rather then convert the gene names, but the end result is the same. This way, you have to load less data. But this way you don't have the uniprotID to use.
human_homolog_genes<- getLDS(attributes = c("external_gene_name"), filters = "mgi_symbol", values = musGenes , mart = mousegene, attributesL = c("hsapiens_homolog_associated_gene_name"), martL = mousegene, uniqueRows=T)
colnames(human_homolog_genes)[1]<-"Gene.Name"
#musGenes2<- getLDS(attributes = c("mgi_symbol"), filters = "mgi_symbol", values = musGenes , mart = mousegene, attributesL = c("uniprot_gn","hgnc_symbol","entrezgene"), martL = humangene, uniqueRows=T)

#Combine the gene name to the expression data
SC_humanID<-merge(human_homolog_genes,SC_expressed,by ="Gene.Name")
#Grab the genes that are more than 10
#SC_expressed<-subset(SC_expressed,SC_expressed$TPM>10)
