#TODO: test mutationFromRTCGA <- function(){

rm(list = ls())

#Load mutation and clinical matrices
dataFile = "dataExample/noFiltered/boolMutation.RData"
load(dataFile, env = globalenv())
dataFile = "dataExample/noFiltered/boolClinical.RData"
load(dataFile, env = globalenv())

#merge
patients <- intersect( row.names(boolClinical), row.names(boolMutation) )
boolClinical <- boolClinical[patients,]
boolMutation <- boolMutation[patients,]

#safe in case these files were not present
genes <- names(boolMutation)
clinicalVars <- names(boolClinical)
save(patients,file="data/patients.RData")
save(genes,file="data/genes.RData")
save(clinicalVars,file="data/clinicalVars.RData")

binaClinical <- as.data.frame(lapply(boolClinical, as.numeric), stringsAsFactors = FALSE)
binaMutation <- as.data.frame(lapply(boolMutation, as.numeric), stringsAsFactors = FALSE)

row.names(binaClinical) <- row.names(boolClinical) 
row.names(binaMutation) <- row.names(boolClinical) 

save(binaClinical,file="data/binaClinical.RData")
save(binaMutation,file="data/binaMutation.RData")

#write csv files for python script
tClini = t(binaClinical)
write.csv2(tClini, file = "temp/10-binaC.csv",row.names = FALSE)
tBina = t(binaMutation)
write.table(tBina, file = "temp/10-binaM.csv", sep =';', dec = '.', row.names = FALSE )

save.image("temp/2-BoolMatrices.RData")
