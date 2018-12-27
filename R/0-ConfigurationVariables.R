# Threshold on the number of minimum patients per gene
# 0 for all genes and patients
minNumOfPatientsPerGene <<- 1  #5 for ~500 patients and genes
minNumOfMutationsPerPatient <<- 1 #5


#load my libraries
libs<-c("Packages.R")
libs<-paste("https://gist.githubusercontent.com/datad/39b9401a53e7f4b44e9bea4d584ac3e8/raw/", libs,sep='')
sapply(libs, function(u) {source(u)})
