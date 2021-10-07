
# Data analysis (raw) #

# Loading packages and establishing working directory 

setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis")
library(dplyr)
library(igraph)
library(EconGeo)
library(data.table)
library(writexl)
library(readxl)
library(ggplot2)

# 1. Knowledge complexity #

# 1.1 Load files
ocean <- read.delim("Ocean.txt")


# 1.2 Convert to matrix
mat <- get.matrix(ocean)


# 1.3 Compute the LQ with the 'binary' argument set to 'TRUE'
RCA <- location.quotient(mat, binary = TRUE)


# 1.3 Compute average ubiquity (ka1 )
avg_ubiq <- MORc(mat, RCA = T, steps = 1)
nuts <- rownames(mat)
avg_ubiq <- cbind(nuts, avg_ubiq)
avg_ubiq <- as.data.frame(avg_ubiq)


# 1.3 Compute average diversity (ka2 )
avg_div <- MORc(mat, RCA = T, steps = 2)
avg_div <- cbind(nuts, avg_div)
avg_div <- as.data.frame(avg_div)

# 1.3 Compute ratio diversity/ubiquity
KNI <- cbind(avg_div$avg_div, avg_ubiq$avg_ubiq)
KNI <- cbind(nuts,KNI)
KNI <- as.data.frame(KNI)
colnames(KNI) <- c("NUT", "Avg div", "Avg ubiq")
KNI$`Avg div` <- as.numeric(KNI$`Avg div`)
KNI$`Avg ubiq`<- as.numeric(KNI$`Avg ubiq`)
KNI$KNI <- KNI$`Avg div`/KNI$`Avg ubiq`


# 1.3 Plot ubiquity/diversity
plot(KNI$`Avg ubiq`,KNI$`Avg div`)
text(KNI$`Avg ubiq`,KNI$`Avg div`, KNI$NUT, cex = 0.6, pos =4, col ="red")

# 1.3 Creating network
nuts <- rownames(RCA)
clusters <- colnames (RCA)
matrix <- graph_from_incidence_matrix(RCA)
edge <- get.edgelist (matrix)

# Calculating degree for each NUTS-2 and tech fields #
d <- degree(matrix)
df_degree <- as.data.frame(d)
setDT(df_degree, keep.rownames = T) # transfer rowname to a column #
degree_NUTS <- df_degree[1:244, ] # degree centrality for each NUTS3 region #
names(degree_NUTS) <- c("NUTS", "degree")
degree_clusters <- df_degree[245:281, ] # degree centrality for each tech field #
names(degree_clusters) <- c("Cluster", "degree")

# Enhancing network, color based on degree
cols=setNames(colorRampPalette(c("yellow","red"))(length(unique(d))), sort(unique(d)))
vertex.color=cols[degree(matrix)]
size <- c(3,5)[V(matrix)$type+1]
plot(matrix, layout=layout.fruchterman.reingold, vertex.color=cols[as.character(degree(matrix))], 
     vertex.size = size, vertex.label.cex = 0.5)

#Other variables
