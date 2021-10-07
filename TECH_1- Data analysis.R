
# REGRESSION ANALYSIS  #

# Loading packages and establishing working directory 
library(dplyr)
library(igraph)
library(EconGeo)
library(data.table)
library(writexl)
library(readxl)
library(Binarize)
library(ISOcodes)
library(countrycode)
library(purrr)
library(MASS)
library(car)
library(moments)
library(splitstackshape)

# ----------------TECH 1 # ----------------------------------------------------------



# DEPEDENT VARIABLE # ----------------------------------------------------------

# 1. KNOWLEDGE COMPLEXITY #

# 1.1 Load files
setwd("C:/Users/6674828/OneDrive - Universiteit Utrecht/Thesis-research paper/Complex-knowledge-repository/NUTS counts")
tech <- read.delim("GEO.txt")

# counts
sum(tech$counts)
length(unique(tech$cluster_id1))

# 1.1 Dataframe NUTS - country
tech$country_iso_alpha3_code <- countrycode(tech$country_iso_alpha3_code, origin = "iso3c", destination = "iso2c", nomatch = NULL)
tech$country_iso_alpha3_code <-   gsub("GB", "UK", tech$country_iso_alpha3_code )


NUTS_country <- tech[,1:2]
colnames(NUTS_country) <- c("nuts2", "Country")

# 1.1 Weighted edgelist
tech <- tech[,c(1,3:4)]

# 1.2 Convert to incidence matrix
mat <- get.matrix(tech)

# 1.3 Compute the LQ with the 'binary' argument set to 'TRUE'
RCA <- location.quotient(mat, binary = TRUE)


# 1.3 Compute average diversity (kr0)
div <- MORc(mat, RCA = T, steps = 0)
div <- cbind(nuts, div)
div <- as.data.frame(div)
str(div)
div$div = as.numeric(div$div)


# 1.3 Compute average ubiquity (kr0 ) - did not changed
avg_ubiq <- MORc(mat, RCA = T, steps = 1)
nuts <- rownames(mat)
avg_ubiq <- cbind(nuts, avg_ubiq)
avg_ubiq <- as.data.frame(avg_ubiq)
str(avg_ubiq)
avg_ubiq$avg_ubiq = as.numeric(avg_ubiq$avg_ubiq)



# 1.3 Compute ratio diversity/ubiquity
KNI <- cbind(div$div, avg_ubiq$avg_ubiq)
KNI <- cbind(nuts,KNI)
KNI <- as.data.frame(KNI)
colnames(KNI) <- c("nuts2", "Div", "Avg ubiq")

str(KNI)
KNI$`Div` <- as.numeric(KNI$`Div`)
KNI$`Avg ubiq`<- as.numeric(KNI$`Avg ubiq`)
KNI$KNI <- KNI$`Div`/KNI$`Avg ubiq`

KNI <- KNI[,c(1,4)]


KNI <- inner_join(NUTS_country, KNI, by = "nuts2")

KNI <- unique(KNI) #



# test zone

str(KNI)
str(tech)
str(avg_div)
str(avg_ubiq)

test = MORt(mat, RCA = T, steps = 0)
test = as.data.frame(test)




# INDEPEDENT VARIABLES # -------------------------------------------------------

# 2. PATH DEPENDENCY: RELATEDNESS DENSITY #

# 2.1 Co-occurrence between clusters
c <- co.occurrence(t(RCA))
which(rowSums(c) == 0)      

# 2.1 Relatedness between clusters
r <- relatedness(c)
which(rowSums(r) == 0)      

# Including fields with at least 1 co-ocurrance
c = c[(which(rowSums(c) != 0)), (which(rowSums(c) != 0))]  
RCA = RCA[, (which(rowSums(c) != 0))] 

# Relatedness between clusters
r <- relatedness(c)
mean(r)

# Defining threshold
r[r < mean(r)] = 0
r[r > mean(r)] = 1

# Calculating relatedness density
rd <- relatedness.density(RCA, r)

# 2.1 Calculating mean of relatedness density 
rd_mean <- as.data.frame(rd)
rd_mean$mean <- rowMeans(rd_mean)
rd_mean <- cbind(nuts,rd_mean$mean)
rd_mean <- as.data.frame(rd_mean)
colnames (rd_mean) <- c("nuts2", "RD")
rd_mean <- inner_join(rd_mean, NUTS_country, by = "nuts2")
rd_mean <- unique(rd_mean)



# 3. PLACE DEPENDENCY: ACUMMULATED KNOWLEDGE  #

# 3.1 Calculating total citations of publications
Knowledge <- as.data.frame(mat)
Knowledge$total <- rowSums(Knowledge)
Knowledge <- cbind(nuts, Knowledge$total)
Knowledge <- as.data.frame(Knowledge)
colnames(Knowledge) <- c("nuts2", "Knowledge")
Knowledge$Knowledge <- as.numeric(Knowledge$Knowledge )
Knowledge <- inner_join(Knowledge, NUTS_country, by = "nuts2")
Knowledge <- unique(Knowledge)



#(from here data is imported)


# 4. CARBON LOCK-IN: SHARE OF GWH  #
setwd("C:/Users/6674828/OneDrive - Universiteit Utrecht/Thesis-research paper/Complex-knowledge-repository/Data/Carbon lock-in")
CARBON <- read.delim("CARBON_1_share.txt", sep = "")
CARBON <- inner_join(CARBON, NUTS_country, by = "Country")
CARBON <- unique(CARBON)


# 5. KNOWLEDGE DIFFUSION - INTERREGIONAL LINKAGES

# Step 2 ----------------------------------------------------------------------
# Determine which clusters c are missing in region r (RTA<1) Inverse of RCA
RCA_inv <- +(!RCA)


# Step 3 ----------------------------------------------------------------------
# Which regions are specialized (RTA<1)
RCA 


# Step 4 ----------------------------------------------------------------------
# Sum all RD scores around a cluster that are missing in region r (RCA as complementary )
rd_added <- RCA * rd # multiplying rd scores with regions with RCA>1
rd_added <- as.data.frame(rd_added) 
rd_added <- colSums(rd_added) #summing RD scores around a cluster
rd_added <- as.data.frame(t(rd_added)) 
rd_added <- do.call("rbind", replicate(n = nrow(RCA), rd_added, simplify = FALSE))
rownames(rd_added) <- rownames(rd) 
rd_added <- RCA_inv * rd_added #adding the RD added to regions that are not specialized RCA<1


# Step 5 ----------------------------------------------------------------------
# Determine the number of co-inventors ties a region has with each region and 
# multiply with the RD added of each region 

setwd("C:/Users/6674828/OneDrive - Universiteit Utrecht/Thesis-research paper/Complex-knowledge-repository/Data/Interregional/Data")
inter <- read.delim("PV_1.txt", sep = "", header = T)

g = graph.data.frame(inter,directed=F)

edge=as_ids(E(g))
edge=as.data.frame(edge)
split = as.data.table(cSplit(edge,"edge","|"))
split[,':='(dummy=1,
            key = paste(edge_1,edge_2,sep="_"))]
split = unique(split[,.(edge_1,edge_2,sum(dummy)),by=key])[,2:4,with=F]
split


# total of links 
matrix <- get.matrix(split) #adjacency matrix showing links between regions (diagonals 0)
c_t <- co.occurrence(t(matrix))
matrix <- graph_from_adjacency_matrix(c_t)
degree <- degree(matrix, mode = "out" )
df_degree <- as.data.frame(degree)
setDT(df_degree, keep.rownames = T) # transfer rowname to a column #



# Step 6 ----------------------------------------------------------------------
# sum the scores in the fifth step for all regions s, so we obtain a total score of CL 
# for region r in technology i, based on the RD added multiplied by the number of ties

#Joining all columns ?
nuts2 <- df_degree$rn

rd_added$sum <- rowSums(rd_added)
inter_links <- cbind(nuts2, rd_added$sum,df_degree$degree)
inter_links <- as.data.frame(inter_links)
colnames(inter_links) <- c("nuts2","rel_added", "links")
str(inter_links)
inter_links[,2:3] <- lapply(inter_links[,2:3], as.numeric)
inter_links$inter_link <- inter_links$rel * inter_links$links
Links = inter_links[,c(1,4)]
Links <- inner_join(Links, NUTS_country, by = "nuts2")
Links <- unique(Links)



# CONTROL VARIABLES # -------------------------------------------------------
setwd("C:/Users/6674828/OneDrive - Universiteit Utrecht/Thesis-research paper/Complex-knowledge-repository")

# 6. LEVEL OF ECONOMIC DEVELOPMENT: GDP PER CAPITA #
GDP <- read.delim("GDP_1.txt", sep = "")
GDP <- inner_join(GDP, NUTS_country, by = "Country")
GDP <- unique(GDP)


# 7. POPULATION: No. INHABITANTS #
POP <- read.delim("Pop_1.txt", sep = "")
colnames(POP) <- c("nuts2", "pop")
POP <- inner_join(POP, NUTS_country, by = "nuts2")
POP <- unique(POP)

# 8. RENEWABLE ENERGY TECHNOLOGY DEPLOYMENT: MW INSTALLED CAPACITY #
setwd("C:/Users/6674828/OneDrive - Universiteit Utrecht/Thesis-research paper/Complex-knowledge-repository/Data/Energy markets")
DEPLOYMENT <- read.delim("PV_1.txt", sep = "")
colnames(DEPLOYMENT) <- c("Country", "DEPLOYMENT")
DEPLOYMENT <- inner_join(DEPLOYMENT, NUTS_country, by = "Country")
DEPLOYMENT <- unique(DEPLOYMENT)


# ALL VARIABLES # -------------------------------------------------------
TECH_DATA <- list(KNI, rd_mean, Knowledge, CARBON, Links, GDP, POP, DEPLOYMENT) %>% reduce(merge, by= c("Country", "nuts2"))
TECH_DATA <- TECH_DATA[,2:10]

colnames(TECH_DATA) <- c("Region", "KNI", "RD", "K", "C", "CL", "GDP", "P", "M")
TECH_DATA <- unique(TECH_DATA)

# SAVING FILE # -------------------------------------------------------
setwd("C:/Users/6674828/OneDrive - Universiteit Utrecht/Thesis-research paper/Complex-knowledge-repository/Regression improved")

write.table(TECH_DATA, "PV_1.txt")

