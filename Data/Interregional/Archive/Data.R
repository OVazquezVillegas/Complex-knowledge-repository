
# DATA ANALYSIS (RAW VERSION) #

# Loading packages and establishing working directory 
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/NUTS counts")
library(dplyr)
library(igraph)
library(EconGeo)
library(writexl)
library(readxl)
library(Binarize)
library(ISOcodes)
library(igraph)
library(splitstackshape)
library(data.table)


# ----------------HYDRO 1 # ----------------------------------------------------------



# DEPEDENT VARIABLE # ----------------------------------------------------------

# 1. KNOWLEDGE COMPLEXITY #

# 1.1 Load files
tech <- read.delim("Hydro 1.txt")

# 1.1 Change iso
tech$country_iso_alpha3_code <- countrycode(tech$country_iso_alpha3_code, 
                                                   origin = "iso3c", destination = "iso2c")

# 1.1 Dataframe NUTS - country
NUTS_country <- tech[,1:2]

# 1.1 Dataframe NUTS - country
tech <- tech[,c(1,3:4)]

# 1.2 Convert to matrix
mat <- get.matrix(tech)

# 1.3 Compute the LQ with the 'binary' argument set to 'TRUE'
RCA <- location.quotient(mat, binary = TRUE)



# 2. PATH DEPENDENCY: RELATEDNESS DENSITY #

# 2.1 Co-occurrence between clusters
c <- co.occurrence(t(RCA))

# 2.1 Relatedness between clusters
r <- relatedness(c)

# 2.1 Defining threshold
vector <- as.vector(r)
bi_vector <- binarize.BASC(vector) #Threshold: 0.1564967 
print(bi_vector)
plot(bi_vector)
r <- matrix(bi_vector@binarizedMeasurements, nrow = 32, ncol = 32)
row.names(r) <- row.names(c)
colnames(r) <- colnames(c)

# 2.1 Calculating relatedness density
rd <- relatedness.density(RCA, r)



# 4. INTERREGIONAL LINKAGES

# 4.1  RD all subfields
summary(rd)

# 4.2  RCA all subfields
summary(RCA)

RCA_df <- as.data.frame(RCA)


summary(RCA_co)

# 4.3  Sum RD scores when RTA > 1
rd_df <- as.data.frame(rd)

rd_added <- RCA_df * rd_df
rd_added$sum <- rowSums(rd_added)




# 4.4 Calculating interregional linkages

setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data/Interregional")


inter <- read.delim("Hydro_1.txt", header = F)
g = graph.data.frame(inter,directed=F)
edge=as_ids(E(g))
edge=as.data.frame(edge)
split = as.data.table(cSplit(edge,"edge","|"))
split[,':='(dummy=1,
            key = paste(edge_1,edge_2,sep="_"))]
split = unique(split[,.(edge_1,edge_2,sum(dummy)),by=key])[,2:4,with=F]
split


# total of links (summing rows possible duplication)
mat <- get.matrix(split)
c <- co.occurrence(t(mat))
c_df <- as.data.frame.array(c)
c_df$sum <- rowSums(c_df)
c_df_sum <- c_df[,c(136)]


# total of links (degree)
matrix <- graph_from_adjacency_matrix(c)
degree <- degree(matrix)
df_degree <- as.data.frame(degree)
setDT(df_degree, keep.rownames = T) # transfer rowname to a column #


nuts <- df_degree$rn
inter_links <- cbind(nuts, rd_added$sum,df_degree$degree)
inter_links <- as.data.frame(inter_links)
colnames(inter_links) <- c("nuts","rel", "links")
inter_links
inter_links[,2:3] <- lapply(inter_links[,2:3], as.numeric)
inter_links$inter_link <- inter_links$rel * inter_links$links



#Adjacency matrix (region to region and weighted)
adjacency <- graph_from_adjacency_matrix(c, weighted = T)


#Ohter method 

df <- as_data_frame(adjacency)


RCA_co <- co.occurrence(RCA)
test <- RCA_co* rd_added

class(rd_added)

rd_added_co <- co.occurrence(rd_added)

