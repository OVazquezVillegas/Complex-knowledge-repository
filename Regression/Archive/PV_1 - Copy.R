
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
tech <- read.delim("PV_1.txt")

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

# 1.3 Compute average ubiquity (kr1 )
avg_ubiq <- MORc(mat, RCA = T, steps = 1)
nuts <- rownames(mat)
avg_ubiq <- cbind(nuts, avg_ubiq)
avg_ubiq <- as.data.frame(avg_ubiq)

# 1.3 Compute average diversity (kr2 )
avg_div <- MORc(mat, RCA = T, steps = 2)
avg_div <- cbind(nuts, avg_div)
avg_div <- as.data.frame(avg_div)

# 1.3 Compute ratio diversity/ubiquity
KNI <- cbind(avg_div$avg_div, avg_ubiq$avg_ubiq)
KNI <- cbind(nuts,KNI)
KNI <- as.data.frame(KNI)

colnames(KNI) <- c("nuts2", "Avg div", "Avg ubiq")
KNI$`Avg div` <- as.numeric(KNI$`Avg div`)
KNI$`Avg ubiq`<- as.numeric(KNI$`Avg ubiq`)
KNI$KNI <- KNI$`Avg div`/KNI$`Avg ubiq`

KNI <- KNI[,c(1,4)]


KNI <- inner_join(NUTS_country, KNI, by = "nuts2")

KNI <- unique(KNI) # 319 obs

# INDEPEDENT VARIABLES # -------------------------------------------------------

# 2. PATH DEPENDENCY: RELATEDNESS DENSITY #

# 2.1 Co-occurrence between clusters
c <- co.occurrence(t(RCA))

# 2.1 Relatedness between clusters
r <- relatedness(c)

# 2.1 Defining threshold (change nrow & ncol according to number of clusters)
vector <- as.vector(r)

bi_vector <- binarize.BASC(vector) #Threshold: 3.5

# test area

library(autothresholdr)
vector <- lapply(vector , as.integerish)
vector <- as.integer(vector)

class(vector)
t <- auto_thresh(vector, method = "MaxEntropy")
print(t)

# test area


print(bi_vector)
plot(bi_vector)
r <- matrix(bi_vector@binarizedMeasurements, nrow = 644, ncol = 644)
row.names(r) <- row.names(c)
colnames(r) <- colnames(c)

# 2.1 Calculating relatedness density
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


# 4. CARBON LOCK-IN: SHARE OF GWH  (Change CARBON)
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis")
CARBON <- read.delim("CARBON_1_share.txt", sep = "")
CARBON$Country <- countrycode(CARBON$Country,  origin = "country.name", destination = "iso2c" )
CARBON <- na.omit(CARBON)
CARBON <- inner_join(CARBON, NUTS_country, by = "Country")
CARBON <- unique(CARBON)


# 5. KNOWLEDGE DIFFUSION - INTERREGIONAL LINKAGES
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data/Interregional")
Links <-read.delim("PV_1.txt", sep = "")
colnames(Links) <- c("nuts2", "inter_links")
Links <- inner_join(Links, NUTS_country, by = "nuts2")
Links <- unique(Links)




# CONTROL VARIABLES # -------------------------------------------------------
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis")

# 6. LEVEL OF ECONOMIC DEVELOPMENT: GDP PER CAPITA (CHANGE)#
GDP <- read.delim("GDP_1.txt", sep = "")
GDP <- inner_join(GDP, NUTS_country, by = "Country")
GDP <- unique(GDP)


# 7. POPULATION: No. INHABITANTS #
POP <- read.delim("Pop_1.txt", sep = "")
colnames(POP) <- c("nuts2", "pop")
POP <- inner_join(POP, NUTS_country, by = "nuts2")
POP <- unique(POP)

# 8. RENEWABLE ENERGY TECHNOLOGY DEPLOYMENT: MW INSTALLED CAPACITY #
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data/Energy markets")
DEPLOYMENT <- read.delim("PV_1.txt", sep = "")
DEPLOYMENT <- inner_join(DEPLOYMENT, NUTS_country, by = "Country")
DEPLOYMENT <- unique(DEPLOYMENT)



# ALL VARIABLES # -------------------------------------------------------
TECH_DATA <- list(KNI, rd_mean, Knowledge, CARBON, Links, GDP, POP, DEPLOYMENT) %>% reduce(merge, by= c("Country", "nuts2"))
TECH_DATA <- TECH_DATA[,2:10]

# SAVING FILE # -------------------------------------------------------
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")

write.table(TECH_DATA, "PV_1.txt")








# REGRESION ANALYSIS# -------------------------------------------------------
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")

TECH_DATA <- read.table("PV_1.txt", sep = "")

TECH_DATA[,2:9] <- lapply(TECH_DATA[,2:9] , as.numeric)



# Model 1: all variables
model_1 <- lm(TECH_DATA$KNI ~ TECH_DATA$Knowledge + TECH_DATA$inter_links + 
              TECH_DATA$pop + TECH_DATA$GDP_1_avg + TECH_DATA$share + TECH_DATA$RD)
summary(model_1)


# Model 2: without control variables

model_1 <- lm(TECH_DATA$KNI ~ TECH_DATA$Knowledge + TECH_DATA$inter_links + 
               TECH_DATA$share + TECH_DATA$RD)
summary(model_1)



# REGRESION ANALYSIS# -------------------------------------------------------

# Model 3: standarization of variables 
str(TECH_DATA)
DATA <- TECH_DATA[,(2:9)]
DATA_SCALED <- scale(DATA)
str(DATA_SCALED)
TECH_DATA_SCALED <- as.data.frame(DATA_SCALED)
str(TECH_DATA_SCALED)
TECH_DATA_SCALED <- cbind(TECH_DATA$nuts2,  TECH_DATA_SCALED)
str(TECH_DATA_SCALED)
DATA_SCALED <- TECH_DATA_SCALED[,2:9]
str(DATA_SCALED)
colnames(TECH_DATA_SCALED)[1] <- "nuts2"


model_3 <- lm(TECH_DATA_SCALED$KNI ~ TECH_DATA_SCALED$Knowledge + TECH_DATA_SCALED$inter_links + 
                TECH_DATA_SCALED$pop + TECH_DATA_SCALED$GDP_1_avg + TECH_DATA_SCALED$share + TECH_DATA_SCALED$RD)
summary(model_3)

cor(DATA)

cor(DATA_SCALED)

