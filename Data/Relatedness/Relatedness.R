


setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data/Relatedness")

install.packages("devtools")
library(devtools)
devtools::install_github("PABalland/EconGeo", force = T)

#This works 
  install.packages("remotes")
  remotes::install_github("PABalland/EconGeo")


##Start here
library(EconGeo)

# Computing product space

M = as.matrix(
  read.csv("https://raw.githubusercontent.com/PABalland/ON/master/amz.csv", sep = ",", header = T, 
           row.names = 1))

# Relatedness: counting and normalizing co-ocurrences

co.occurrence(M)

c = co.occurrence(t(M))

r = relatedness(c)

r[r<1] = 0

r[r>1] = 1

g1 = graph_from_adjacency_matrix(r, mode = "undirected")

plot(g1)

?RCA

## generate a region - industry matrix
set.seed(31)
mat <- matrix(sample(0:100,20,replace=T), ncol = 4)
rownames(mat) <- c ("R1", "R2", "R3", "R4", "R5")
colnames(mat) <- c ("I1", "I2", "I3", "I4")

mat = RCA (mat, binary = TRUE)

library(igraph)



## generate a region - industry matrix
set.seed(31)
mat <- matrix(sample(0:100,20,replace=T), ncol = 4)
rownames(mat) <- c ("R1", "R2", "R3", "R4", "R5")
colnames(mat) <- c ("I1", "I2", "I3", "I4")
mat

mat <- RCA (mat, binary = TRUE)

mat

c = co.occurrence(t(mat))

r = relatedness(c)

r[r<1] = 0
r[r>1] = 1


## relatedness density 
rd = relatedness.density(mat, r)

rd = get.list (rd)



## generate a first region - industry matrix in which cells represent the presence/absence
## of a RCA (period 1)
set.seed(31)
mat1 <- matrix(sample(0:1,20,replace=T), ncol = 4)
rownames(mat1) <- c ("R1", "R2", "R3", "R4", "R5")
colnames(mat1) <- c ("I1", "I2", "I3", "I4")

## generate a second region - industry matrix in which cells represent the presence/absence
## of a RCA (period 2)
mat2 <- mat1
mat2[3,1] <- 1


## Predicting entry

d = entry.list (mat1, mat2)

colnames (d) = c("Region", "Industry", "Entry", "Period")

d = merge (d, rd, by = c("Region", "Industry"))

model <- summary(lm(d$Entry ~ d$Count)) 


# https://www-tandfonline-com.proxy.library.uu.nl/doi/full/10.1080/09654313.2019.1645814

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



### Relatedeness of CSP matrix (per region)

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

rd <- relatedness.density(RCA_CSP, r)

rd_df <- as.data.frame(rd)

rd_df$mean <- rowMeans(rd_df)
