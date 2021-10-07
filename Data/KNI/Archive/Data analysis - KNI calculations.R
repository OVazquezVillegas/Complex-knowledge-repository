
# Data analysis (raw) #

# Loading packages and establishing working directory 

library(dplyr)
library(igraph)
library(EconGeo)
library(data.table)
library(writexl)
library(readxl)

# 1. Knowledge complexity #

# 1.1 Load files
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/NUTS counts")
tech <- read.delim("OCEAN_1.txt")
tech <- tech[,c(1,3:4)]


# 1.2 Convert to matrix
mat <- get.matrix(tech)



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


# 1.3 Compute KNI (default steps)
KNI_def <- MORc(mat, RCA = T)
KNI_all <- cbind(KNI, KNI_def)
KNI_all$prop <- KNI_all$KNI_def/KNI_all$KNI








# 1.3 Computing KCI manually 
RCA <- location.quotient(mat, binary = TRUE)
nuts2 <- rownames(RCA)
clusters <- colnames (RCA)

matrix <- graph_from_incidence_matrix(RCA)
edge <- get.edgelist (matrix) #(useless)

is.bipartite(matrix)


# Calculating degree for each NUTS-2 and tech fields #
d <- degree(matrix)
df_degree <- as.data.frame(d)
setDT(df_degree, keep.rownames = T) # transfer rowname to a column #
degree_NUTS <- df_degree[1:244, ] # degree centrality for each NUTS3 region #
names(degree_NUTS) <- c("NUTS", "degree")
degree_clusters <- df_degree[245:281, ] # degree centrality for each tech field #
names(degree_clusters) <- c("Cluster", "degree")

# Enhancing network, color based on degree
cols=setNames(colorRampPalette(c("red","yellow"))(length(unique(d))), sort(unique(d)))
vertex.color=cols[degree(matrix)]
size <- c(3,5)[V(matrix)$type+1]
plot(matrix, layout=layout.fruchterman.reingold, vertex.color=cols[as.character(degree(matrix))], 
     vertex.size = size, vertex.label.cex = 0.5)

## build up formulate to compute KCI ##
# add the degree centrality of tech into Tech_NUTS3_RTA #
degree_clusters_t <- data.frame(t(degree_clusters))
degree_clusters_t <- degree_clusters_t[-1,] 
setDT(degree_clusters_t, keep.rownames = T)

data <- as.data.frame(RCA)
data <- data.table(data, keep.rownames =T)
colnames (degree_clusters_t) <- colnames(data)
data <- rbind(data, degree_clusters_t)


# add the degree centrality of NUTS3 into Tech_NUTS3_RTA #
colnames(data)[1] <- "NUTS"
data <- full_join(data, degree_NUTS, by = "NUTS")

# write file
write_xlsx(data, "Cluster_nuts_rca.xlsx") # do the calculation in excel

# load the KCI from excel #
KCI <- read_excel("Tech_NUTS3_RTA.solved.new.xlsx", sheet = "Sheet3")

