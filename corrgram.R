library(corrplot)
library(data.table)
library(gplots)
library(RColorBrewer)
library(dendextend)
library(dplyr)

#load WCA data
Results <- fread('WCA_export_Results.tsv')

#filter
Results <- Results[grepl('^Euro....|^WC....$',competitionId)]
Results <- Results[grepl('201[567]',competitionId)]
Results <- Results[,c(1,2,8)]
Results <- Results[!duplicated(Results)]

#reshape for corr matrix
dcast(
  Results,
  personId + competitionId ~ eventId,
  fill = 0,
  fun.aggregate = function(x)
    ifelse(length(x) == 0, 0, 1)
) -> events_participation

#build corrmatrix and dendogram
corrmat <- cor(events_participation[,c(3:20)],method='pearson')

dend <- corrmat %>% dist() %>% hclust() %>% as.dendrogram() %>% color_branches(k = 7)
label_cols <- get_leaves_branches_col(dend)[order(order.dendrogram(dend))]
# output visualization
pdf("corrgram.pdf", width=15, height=15)
heatmap.2(
corrmat,
distfun = dist,
trace='none',
key = T, keysize = .5, density.info = "none", key.xlab = "Pearson r",
col = colorRampPalette(c(rep("lightblue", 1), rep("white", 1), rep("red", 1)))(256),
colCol = label_cols,
colRow = label_cols,
RowSideColors = label_cols,
ColSideColors = label_cols,
margins = c(25,25))
dev.off()
