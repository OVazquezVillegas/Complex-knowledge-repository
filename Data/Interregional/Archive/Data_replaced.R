
# DATA ANALYSIS (RAW VERSION) #

# Loading packages and establishing working directory 
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


# ----------------TECH # ----------------------------------------------------------
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/NUTS counts")
# Loading file
tech <- read.delim("PV_2.txt")
tech$country_iso_alpha3_code <- countrycode(tech$country_iso_alpha3_code, 
                                                   origin = "iso3c", destination = "iso2c")
NUTS_country <- tech[,1:2]
tech <- tech[,c(1,3:4)]
mat <- get.matrix(tech)
RCA_all <- location.quotient(mat, binary = TRUE)


# INTERREGIONAL LINKAGE

# 1 Relatedness density 

# Co-occurrence between clusters
c_all <- co.occurrence(t(RCA_all))

# Including fields with at least 1 co-ocurrance
c = c_all[(which(rowSums(c_all) != 0)), (which(rowSums(c_all) != 0))]  

RCA = RCA_all[, (which(rowSums(c_all) != 0))] 


# Relatedness between clusters
r <- relatedness(c)

# Defining threshold

r[r< mean(r)] = 0
r[r> mean(r)] = 1


# Calculating relatedness density
rd <- relatedness.density(RCA, r)


# 2  RCA all subfields
summary(RCA)
RCA_df <- as.data.frame(RCA)


# 3  Sum RD scores when RTA > 1
rd_df <- as.data.frame(rd)
rd_added <- RCA_df * rd_df
rd_added$sum <- rowSums(rd_added)


# 4 Calculating interregional linkages
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data/Interregional/Data")
inter <- read.delim("PV_2.txt", header = T)

g = graph.data.frame(inter,directed=F)
edge=as_ids(E(g))
edge=as.data.frame(edge)
split = as.data.table(cSplit(edge,"edge","|"))
split[,':='(dummy=1,
            key = paste(edge_1,edge_2,sep="_"))]
split = unique(split[,.(edge_1,edge_2,sum(dummy)),by=key])[,2:4,with=F]
split



# total of links 
matrix <- get.matrix(split)
c_t <- co.occurrence(t(matrix))
matrix <- graph_from_adjacency_matrix(c_t)
degree <- degree(matrix, mode = "out" )
df_degree <- as.data.frame(degree)
setDT(df_degree, keep.rownames = T) # transfer rowname to a column #

#Joining all columns ?
nuts2 <- df_degree$rn
inter_links <- cbind(nuts2, rd_added$sum,df_degree$degree)
inter_links <- as.data.frame(inter_links)
colnames(inter_links) <- c("nuts2","rel_added", "links")
str(inter_links)
inter_links[,2:3] <- lapply(inter_links[,2:3], as.numeric)
inter_links$inter_link <- inter_links$rel * inter_links$links
inter_links = inter_links[,c(1,4)]


#Saving data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data/Interregional")

write.table(inter_links,"PV_2.txt")



