#' version 1 (May/30/2018)
library("purrr")
library("cluster")

#loadls("cluster")

rm(list = ls())

# K-Means Cluster Analysis -----------
for(k in c(2:10))
{
  #withoutOutliers
  #load(file=paste("temp/verotypes_k",k,".RData",sep=''))
  #with ourliers
  load(file=paste("temp/verotypesWithOutL_k",k,".RData",sep=''))


  # Dissimilarity matrix
  d <- dist(mydata, method = "euclidean")
  # # Hierarchical clustering using Complete Linkage
  # hc1 <- hclust(d, method = "complete" )
  # # Plot the obtained dendrogram
  # plot(hc1, cex = 0.6, hang = -1)
  # # Compute with agnes
  # hc2 <- agnes(mydata, method = "complete")
  # # Agglomerative coefficient
  # hc2$ac
  # # methods to assess
  # m <- c( "average", "single", "complete", "ward")
  # names(m) <- c( "average", "single", "complete", "ward")
  # # function to compute coefficient
  # ac <- function(x) {
  #   agnes(mydata, method = x)$ac
  # }
  # map_dbl(m, ac)
  # hc3 <- agnes(mydata, method = "ward")
  # pltree(hc3, cex = 0.6, hang = -1, main = "Dendrogram of agnes")
  # Ward's method
  hc5 <- hclust(d, method = "ward.D2" )


  for(i in c(2:15))
  {
    # Cut tree into 4 groups
    sub_grp <- cutree(hc5, k = i)
    # Number of members in each cluster
    #table(sub_grp)
    affiliationList = sub_grp
    #save(affiliationList,file=paste("temp/affiliationHC_k",k,"_i",i,".RData",sep=''))
    save(affiliationList,file=paste("temp/affiliationHCwithOL_k",k,"_i",i,".RData",sep=''))
    rm(list = ls()[-which(ls() %in% c("i","k", "hc5" )  )])
  }
  rm(list = ls()[-which(ls() %in% c("i","k")  )])
}

# source('~/CLIGEN_tgit/R/6-SurvivalAnalysis/6-9v1-SurvivalAnalysisofSVNSmooth.R', echo=TRUE)
# survivalAnalysis()



