library(ggplot2)
#Open up the LR expression from the app/data/ folder for the connectome app. Change the LR.expr to LR.expr.original.txt to keep track of the file. 
LRlist<-read.delim("LR.expr.original.txt")
#Keep only the gene name and remove all the other columns if you dont have that data
LRlist<-as.data.frame(LRlist[,1])
colnames(LRlist)[1]<-"Human.gene.name"
#Set cahracter to upper case so that it fits with the LR.expr.txt
humanID$Human.gene.name<-toupper(humanID$Human.gene.name)
#temp<-unique(SC_humanID$Gene.Name)
#U_SC_humanID<-SC_humanID[temp,]
#Combine the LRlist with the expression
LRlistEC_SC_SMF<-merge(LRlist,humanID[,c(2,5:7)],by="Human.gene.name",all.x = T)
#
UniqueLRMatrix<-LRlistEC_SC_SMF
#COnvert to Log2
#UniqueLRMatrix[,2:9]<-log2(UniqueLRMatrix[,2:9])
#colnames(EC_Fantom5)[1]<-"Gene.Name"
#U_EC_Fantom5<-distinct(EC_Fantom5,Gene.Name,.keep_all = TRUE)
#LRlistEC_SC<-merge(U_LRlistSC,U_EC_Fantom5,by="Gene.Name",all.x = T)
#UniqueLRMatrix<-LRlistEC_SC[,-5]
colnames(UniqueLRMatrix)[1]<-"ApprovedSymbol"
#Graph the density of individual expression values 
graph<-UniqueLRMatrix[,c(2:4)]
ggplot(graph)+
  geom_density(aes(log2((ECaverage))), color = "green")+
  geom_density(aes(log2((SCaverage))), color = "red")+
  geom_density(aes(log2((SMFaverage))), color = "blue")+
  ggtitle(("Ligands/Receptors"))+ 
  xlim(-10,10)+
  labs(x=expression(Log[2](TPM)), y="Density")+
  ylim(0,.18)+
  theme(plot.title = element_text(hjust = 0.5))
#Copy the file into the app/data/ folder for the connectome app.
write.table(UniqueLRMatrix,"LR.expr.txt", col.names = TRUE, sep = "\t", quote = FALSE,row.names = FALSE)
