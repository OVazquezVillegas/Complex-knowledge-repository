
###################################
####                          #####
####     Calculating KCI      #####
####                          ##### 
###################################

setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data/KNI")
library(dplyr)
library(igraph)
# ==================== #
#   Data preparation   # ----------------------------------------------------------------
# ==================== # 

## Loading files
wind.2 <- read.delim("wind 2.txt")


library(EconGeo)
# convert matrix
wind.2.matrix <- get.matrix(wind.2)

# compute the LQ with the 'binary' argument set to 'TRUE'
wind.2.RCA <- location.quotient(wind.2.matrix, binary = TRUE)

# compute KCI
KCI <- KCI(wind.2.matrix, RCA = T)
View(KCI)

# compute relatedness
c_nuts = co.occurrence(wind.2.matrix) # relatedness between nuts 

c_clusters = co.occurrence(t(wind.2.matrix)) #relatedness between clusters 

r = relatedness(c_clusters)

r[r<1] = 0 #defining thresholds
r[r>1] = 1

g = graph_from_adjacency_matrix(r, mode = "undirected") #knowledge space 
plot(g,layout=layout.fruchterman.reingold, vertex.size = 0.2, vertex.label.cex = 0.1)

# compute relatedness density 
mat = RCA(wind.2.matrix, binary = T) #matrix of comparative advtange
c1 = co.occurrence(t(mat)) #co-occurrence between clusters
r2 = relatedness(c1) #relatedness between clusters

r2[r2<1] = 0 #defining thresholds
r2[r2>1] = 1

rd = relatedness.density(mat, r2)

rd_list = get.list(rd)


