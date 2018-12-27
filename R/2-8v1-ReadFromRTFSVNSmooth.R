#' version 1 (May/30/2018)

rm(list = ls())


LoadFiles <- function(k){
  load("tempServer/bcCPk2.Rd", envir = globalenv())
  patientsF <- bcCP$A  #p x k
  genesF <- bcCP$B #genes x k
  clinicalF <- bcCP$C #clinical x k.
}

