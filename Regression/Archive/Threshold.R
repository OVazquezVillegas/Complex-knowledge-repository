
# REGRESSION ANALYSIS (RAW VERSION) #

# Loading packages and establishing working directory 
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/NUTS counts")
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
library(Binarize)
# ----------------HYDRO 1 # ----------------------------------------------------------



# DEPEDENT VARIABLE # ----------------------------------------------------------

# 1. KNOWLEDGE COMPLEXITY #

# 1.1 Load files
tech <- read.delim("WIND_2.txt")

# 1.1 Dataframe NUTS - country
tech$country_iso_alpha3_code <- countrycode(tech$country_iso_alpha3_code, origin = "iso3c", destination = "iso2c")
NUTS_country <- tech[,1:2]
colnames(NUTS_country) <- c("nuts2", "Country")

# 1.1 Weighted edgelist
tech <- tech[,c(1,3:4)]

# 1.2 Convert to matrix
mat <- get.matrix(tech)

# 1.3 Compute the LQ with the 'binary' argument set to 'TRUE'
RCA <- location.quotient(mat, binary = TRUE)

# 2.1 Co-occurrence between clusters
c <- co.occurrence(t(RCA))

# 2.1 Relatedness between clusters
r <- relatedness(c, method = "association")

relatedness
install.packages("remotes")
remotes::install_github("PABalland/EconGeo")

library(EconGeo)
relatedness()

# Understanind relatedness

test <- t(RCA) %*% RCA
diag(test) <- 0

diag(RCA)

c <- co.occurrence(t(RCA))

c == test
relatedness
Cij <- c
diag(Cij) <- 0
Si <- colSums(Cij)
Sj <- colSums(Cij)
Si == Sj
T <- (sum(Cij))

# 2.1 Defining threshold (change nrow & ncol according to number of clusters)
vector <- as.vector(r)
summary(vector)
median(vector)
bi_vector <- binarize.kMeans(vector) #Threshold: 3.5

bi_vector_BASC <-  #Threshold: 3.5
t <- binarize.BASC(vector, method = "A")


r_bin <- binarizeMatrix(r)
rbin <- rbin@
r_bin <- bi_vector@binarizedMeasurements
r_bin <- as.matrix(r_bin)
colnames(r_bin) =colnames(r)
rownames(r_bin) = rownames(r)

#####

relatedness.density


rel <- RCA %*% r
reltot <- colSums(r)
reldens <- t(rel)/reltot
reldens <- t(reldens)*100


rd == reldens