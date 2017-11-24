
# Load WCA data -----------------------------------------------------------
library(data.table);library(dplyr);library(downloader);library(ggplot2);library(dplyr)

temp <- tempfile()
link <- ('https://www.worldcubeassociation.org/results/misc/WCA_export.tsv.zip')
download(link, dest="dataset.zip", mode="wb") 
unzip ("dataset.zip")

for(a in dir(pattern='tsv')){
  assign(gsub('.tsv|WCA_export_','',a),fread( a,encoding = 'UTF-8'))
}

res <- Results[grepl('^WC|^Euro|Championshi|National',competitionId)]
res <- res[res[,.I[uniqueN(roundTypeId)>1],by=.(competitionId,eventId)]$V1]
res <- res[eventId%in%unique(eventId)[c(1,2,3,4,5,6,7,10,11,12,13,14,15,16,17,18)]]
res <- res[order(roundTypeId),.SD,by=.(competitionId,eventId)]
res <- res[res[,.I[personId%in%personId[roundTypeId%in%c('f','c','b')& pos<4]],by=.(competitionId,eventId)]$V1]

res <- res[,list(FinalRank=pos[roundTypeId%in%c('f','c')],
                 SemiFinalRank=pos[roundTypeId==sort(roundTypeId)[uniqueN(roundTypeId)-1]]),
           by=.(competitionId,eventId,personId)]
