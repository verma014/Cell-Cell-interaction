# Cell-Cell-interaction
The receptor-ligand interactions between the different cell types was obtained and visualized using connectome (https://github.com/Hypercubed/connectome). The scripts below will take the average value TPM values from each of your groups(cell types) and make it ready for input into connectome. The ligand-receptor dataset is derived from human cells and thus requires the gene name to be human. If you have mouse data, first take you data through MouseIDtoHumanID.R and then HypercubedConnectome.R

Alternatively, similar data can be assessed using iRefR(in progress) but is a little bit more convoluted.  
1)Convert the mouse gene ID to human gene ID.
2)Filter them by expression in the membrane or secreted as supported by UniProtkb and SwisProt.
3)Merge them into ligands or receptor classes finall ID and search for possible interactions using iRefR. 
iRefR has more human than mouse interaction so its worth it to convert mouse to human anyways. Of note, iRefR are not curated so will have a lot of false positives. 
