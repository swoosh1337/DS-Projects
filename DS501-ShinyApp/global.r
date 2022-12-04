library(readr)
library(readxl)
library(cluster)
library(ggvis)
library(shinythemes)
library(tidyverse)
library(ggpubr)
library(dplyr)
library(markdown)

csgo_data = read_csv("player_stats.csv")
#remove first column for clustering analysis
cs_df1 = csgo_data[,-1]
cs_df2 = cs_df1[,-1]
cs_df2 = cs_df2[,-1]
cs_df2 = cs_df2[,-1]



# k means centers loop
wss = kmeans(cs_df2, centers=1)$tot.withinss
for (i in 2:15)
  wss[i] = kmeans(cs_df2, centers=i)$tot.withinss
#sse analysis to pick # of clusters
sse = data.frame(c(1:15), c(wss))
names(sse)[1] = 'Clusters'
names(sse)[2] = 'SSE'
sse %>%
  ggvis(~Clusters, ~SSE) %>%
  layer_points(fill := 'blue') %>% 
  layer_lines() %>%
  set_options(height = 300, width = 400)

clusters = kmeans(cs_df2, 3)
cs_df1$Cluster = clusters$cluster
cs_dfClusplot = clusplot(cs_df2, clusters$cluster, color=T, shade=T,labels=0,lines=1, main="CSGO Stats K Means Analysis")
variables = names(cs_df2)