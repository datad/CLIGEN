
#' Read a mutation file and construct the boolean matrix
#'
#'"temp/histoPat4mut.pdf" = Histogram patient per gene (patient count)
#'"temp/histoMut4pati.pdf" = Histogram mutations per patient (mutation count)
#' @return
#' @export
#'
#' @examples #TGCA data
#' createBoolMutation()
#' createBoolMutation(boolOrBin="bina")
createBoolMutation <- function(boolOrBin="bool"){
  dataFile = paste("data/",boolOrBin,"Mutation.RData", sep = '')
  if( file.exists(dataFile) ){
    load(dataFile, env = globalenv())
  } else {
    load("data/patients.RData")
    genes <- unique(as.character(mutation$Hugo_Symbol))
    if(boolOrBin == "bool")
    {
      boolMutation <- data.frame(matrix(FALSE,length(patients),length(genes)),
                                 row.names = patients)
      trueVal = TRUE
    } else{
      boolMutation <- data.frame(matrix(0,length(patients),length(genes)),
                                 row.names = patients)
      trueVal = 1
    }
    names(boolMutation) <- genes
    
    for(i in seq_len(dim(mutation)[1])){
      Apatient <- as.character(mutation$mutationBarcodes[i])
      if(Apatient %in% patients){
        #only non-silent mutations
        TMuta <- unique(mutation$Variant_Classification[i])
        if(TMuta != "Silent"){
          APgene <- mutation$Hugo_Symbol[i]
          boolMutation[Apatient,APgene] <- trueVal
        }
      }
    }
    
    ####
    #plot distributions
    #1 Number of mutations per patient
    mut4patient <- apply(boolMutation,1,sum)

    if( length(which(mut4patient<=minNumOfMutationsPerPatient)) > 0  ){
      boolMutation <- boolMutation[-which(mut4patient<=minNumOfMutationsPerPatient),]
      #after deletion
      mut4patient <- apply(boolMutation,1,sum)
    }
    
    cat("Number of mutations per patient: ")
    cat(range(mut4patient))
    
    
    pdf(file = "temp/histoMut4pati.pdf" ,  onefile = TRUE, pagecentre = FALSE, compress = FALSE)
    hist(mut4patient, main = "Histogram mutations per patient (mutation count)" ,
         ylab = "number of patients" ,
         xlab = "number of genes with mutations",
         breaks = 200)
    dev.off()
    
    #Number of patients with mutation x
    pat4genes <- apply(boolMutation,2,sum)

    #Genes to remove
    if ( length(which(pat4genes<=minNumOfPatientsPerGene)) > 0 ){
      boolMutation <- boolMutation[,-which(pat4genes<=minNumOfPatientsPerGene)]
      pat4genes <- apply(boolMutation,2,sum)
    }
    
    #Number of patients with mutation x
    cat("\nNumber of patients with mutation x:  ")
    cat(range(pat4genes))
    
      pdf(file = "temp/histoPat4mut.pdf" ,  onefile = TRUE, pagecentre = FALSE, compress = FALSE)
      hist(pat4genes, main = "Histogram patient per gene (patient count)",
           ylab = "Number of genes",
           xlab = "Number of mutations", breaks=70)
      dev.off()
      

      #description boolean table
      genes <- names(boolMutation)
      patients <- row.names(boolMutation)
      
      cat("\n Description boolean table:\n")
      cat("length(genes)      ",length(genes))
      cat("length(patients)   ", length(patients))
      cat("dim(boolMutation)  ",dim(boolMutation))

    save(patients,file="data/patients.RData")
    save(genes,file="data/genes.RData")
    save(boolMutation,file=dataFile)
  }
}
  
  
  
  
  #' get mutation data directly from RTCGA
  #'
  #' @return
  #' @export
  #'
  #' @examples
  #' load("data/OV/loadls.RData")
  #' source('~/10-Research/Current/CLINGEN/9source/CLIGEN/publicPackageCLIGEN/R/1-createBoolMutation.R', echo=F)
  #' mutationFromRTCGA()
  mutationFromRTCGA <- function(disease ="BRCA"){
    loadls("RTCGA.mutations dplyr reshape2",F)
    library(RTCGA.mutations)
    library(dplyr)
    if(disease == "BRCA") { 
      mutationsTCGA(BRCA.mutations) %>%
        filter(Variant_Classification != "Silent") %>% # cancer tissue
        filter(substr(bcr_patient_barcode, 14, 15) == "01") %>% # cancer tissue
        mutate(bcr_patient_barcode = substr(bcr_patient_barcode, 1, 12)) -> CANCER.mutations
    } else if(disease == "OV") { 
      mutationsTCGA(OV.mutations) %>%
        filter(Variant_Classification != "Silent") %>% # cancer tissue
        filter(substr(bcr_patient_barcode, 14, 15) == "01") %>% # cancer tissue
        mutate(bcr_patient_barcode = substr(bcr_patient_barcode, 1, 12)) -> CANCER.mutations
    } else {
      stop("disease not included")
    }
    patients <- unique(CANCER.mutations$bcr_patient_barcode)
    genes <- unique(CANCER.mutations$Hugo_Symbol)
    
    binaMutation <- data.frame(matrix(0,length(patients),length(genes)),
                               row.names = patients)
    names(binaMutation) <- genes
    
    for(i in seq_len(dim(CANCER.mutations)[1])){
      Apatient <- as.character(CANCER.mutations$bcr_patient_barcode[i])
      APgene <- as.character(CANCER.mutations$Hugo_Symbol[i])
      binaMutation[Apatient,APgene] <- 1
    }
    save(binaMutation, file="data/binaMutation.RData")
    save(patients,file="data/patients.RData")
  }