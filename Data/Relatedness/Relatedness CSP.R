


setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data/Relatedness")

##Start here for CSP
library(EconGeo)
### Relatedeness of CSP matrix

CSP_mat <- as.matrix(read.table(file="Matrix_CSP.txt",header=T))
is.matrix(CSP_mat)
cmat <- co.occurrence(CSP_mat)

# c :  counting Co-ocurence between -- technologies 
c <- co.occurrence(t(CSP_mat))

# Normalizing co-occurrences 
r <- relatedness(c)

r[r<1] = 0
r[r>1] = 1


#Visualizing the technology space of CSP
# Creating network #
library(igraph)
G <- graph_from_adjacency_matrix(r, mode = "undirected")

# Enhancing network, color based on degree
plot(G, layout=layout.fruchterman.reingold)



### Relatedeness of CSP matrix (per region) #### START HERE

CSP_mat <- as.matrix(read.table(file="Matrix_CSP.txt",header=T))
is.matrix(CSP_mat)
cmat <- co.occurrence(CSP_mat)

# c :  counting Co-ocurence between -- technologies 
c_r <- co.occurrence(CSP_mat)

# Normalizing co-occurrences 
r_r <- relatedness(c_r)

r_r[r_r<1] = 0
r_r[r_r>1] = 1


#Visualizing the technology space of CSP
# Creating network #
library(igraph)
G_r <- graph_from_adjacency_matrix(r_r, mode = "undirected")

# Enhancing network, color based on degree
plot(G_r, layout=layout.fruchterman.reingold, vertex.size = 0.5, vertex.label.cex = 0.1)

RCA_CSP <- RCA(CSP_mat, binary = T)

rd <- relatedness.density(RCA_CSP, r_r)

rd_df <- as.data.frame(rd)

rd_df$mean <- rowMeans(rd_df)
