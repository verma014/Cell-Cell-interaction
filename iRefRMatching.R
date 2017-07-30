library(iRefR)
#ftp://ftp.no.embnet.org/irefindex/iRefR/current/iRefR_tutorial.pdf

mouseiRefIndex<-get_irefindex(tax_id="10090",iref_version = "current",data_folder =  getwd())
mouseiRefIndex<-read.delim("10090.mitab.04072015.txt")
dim(mouseiRefIndex)
#This is the number of unique interaction that are non redundant 
length(unique(mouseiRefIndex$irigid))
#load the human database
humaniRefIndex<-read.delim("index/9606.mitab.04072015.txt")
length(unique(humaniRefIndex$irigid))
#The database for human includes human to virus or bacteria interactions. To get just human to human interactions you do this. This takes the the interaction number from 673100 to 623782 total interaction. And 268625 to 238006 unique interactions 
human_human_list = data.frame(humaniRefIndex$taxa,humaniRefIndex$taxb)
tmp = do.call(`paste`, c(unname(human_human_list),list(sep=".")))
humaniRefIndex = humaniRefIndex[tmp == "taxid:9606(Homo sapiens).taxid:9606(Homo sapiens)" |tmp == "-.taxid:9606(Homo sapiens)",]

#ID conversion table
id_conversion_table_human <- create_id_conversion_table(humaniRefIndex, "data","id_conversion_table_9606_a")
