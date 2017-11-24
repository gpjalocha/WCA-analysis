source('load data.R')


# Best podiums according to 3rd place result ------------------------------

comp_event_key <- Results[pos==3 & roundTypeId%in%c('c','f') & average>0][,
                          list(best_avg=min(average),
                               competitionId=competitionId[average==min(average)]),
                          by=.(eventId)][,c(1,3)]

BestPodiums <- comp_event_key[
  Results[pos<=3 & roundTypeId%in%c('c','f')],on=c('eventId','competitionId'),nomatch=0]