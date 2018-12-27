library("fpc")
library("NbClust")

rm(list = ls())

# K-Means Cluster Analysis -----------
for(k in c(2:10))
{
  load(file=paste("dataExample/Filtered/verotypesWithOutL_k",k,".RData",sep=''))
  #load(file=paste("dataExample/Filtered/verotypes_k",k,".RData",sep=''))
  for(i in c(2:15))
  {
    set.seed(1234)
    fit <- kmeans(mydata, centers = i , nstart = 25) # 5 cluster solution
    # get cluster means
    #fit$centers
    #aggregate(mydata,by=list(fit$cluster),FUN=mean)
    #clusplot(mydata, fit$cluster, color=T, shade=T)
    #plotcluster(mydata, fit$cluster)
    # append cluster assignment
    affiliationList = fit$cluster
    save(affiliationList,file=paste("temp/affiliationListWithOutL_k",k,"_i",i,".RData",sep=''))
    #save(affiliationList,file=paste("temp/affiliationList_k",k,"_i",i,".RData",sep=''))
    rm(list = ls()[-which(ls() %in% c("i", "k", "mydata")  )])
  }
  rm(list = ls()[-which(ls() %in% c("i","k")  )])
}

# source('~/CLIGEN_tgit/R/6-SurvivalAnalysis/6-9v1-SurvivalAnalysisofSVNSmooth.R', echo=TRUE)
# survivalAnalysis()



