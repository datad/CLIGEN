#' version 1 (May/30/2018)
rm(list = ls())
source('~/CLIGEN_tgit/R/6-SurvivalAnalysis/6-9v1-SurvivalAnalysisofSVNSmooth.R')

results <- data.frame(matrix(NA, nrow = 14, ncol = 9))
row.names(results) <- c(2:15)
names(results) <- c(2:10)

resultsOK <- data.frame(matrix(NA, nrow = 14, ncol = 9))
row.names(resultsOK) <- c(2:15)
names(resultsOK) <- c(2:10)


# Survival Analysis -----------
for(k in c(2:10))
{
  for(i in c(2:15))
  {
    #K means without OL:
    #load(file=paste("temp/affiliationList_k",k,"_i",i,".RData",sep=''))
    #K means with OL:
    #load(file=paste("temp/affiliationListWithOutL_k",k,"_i",i,".RData",sep=''))
    # H clustering without OL:
    # load(file=paste("temp/affiliationHC_k",k,"_i",i,".RData",sep=''))
    # H clustering with OL:
     load(file=paste("temp/affiliationHCwithOL_k",k,"_i",i,".RData",sep=''))

    pval = survivalAnalysis(k,i)
    results[as.character(i),as.character(k)] <- as.numeric(pval)
    resultsOK[as.character(i),as.character(k)] <- ok
    rm(list = ls()[-which(ls() %in% c("i","k" , "survivalAnalysis", "results", "resultsOK")  )])
  }
}

# #K means without OL:
# write.csv(results,file=paste("finalResults/results_kmeans_without_OL.RData",sep='') )
# write.csv(resultsOK,file=paste("finalResults/resultsOK_kmeans_without_OL.RData",sep='') )
# #K means with OL:
# write.csv(results,file=paste("finalResults/results_kmeans_with_OL.RData",sep='') )
# write.csv(resultsOK,file=paste("finalResults/resultsOK_kmeans_with_OL.RData",sep='') )
# # H clustering without OL:
# write.csv(results,file=paste("finalResults/results_HC_without_OL.RData",sep='') )
# write.csv(resultsOK,file=paste("finalResults/resultsOK_HC_without_OL.RData",sep='') )
# H clustering with OL:
write.csv(results,file=paste("finalResults/results_HC_with_OL.RData",sep='') )
write.csv(resultsOK,file=paste("finalResults/resultsOK_HC_with_OL.RData",sep='') )
