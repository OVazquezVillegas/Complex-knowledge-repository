

library(readxl)
library(countrycode)
# https://ec.europa.eu/eurostat/databrowser/view/NRG_BAL_C__custom_1036970/default/table?lang=en
# FORGET ALL !!!!! https://ec.europa.eu/eurostat/databrowser/view/nrg_bal_c/default/table?lang=en

# 3.TOTAL

# Preparing data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data/Carbon lock-in")

TOTAL <- read_excel("data.xlsx", sheet = 3, col_names = T, n_max = 41, skip = 9)
seq <- seq(from = 2, to = 4, by = 2)
seq <- c(1,  2,  4,  6,  8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40)
TOTAL <- TOTAL[c(2:41), seq]


# Country codes
match <- c(`United Kingdom` = 'UK')
countries <- countrycode(TOTAL$TIME, origin = "country.name", destination = "genc2c", custom_match = match)
TOTAL[,1] <- countries
colnames(TOTAL)[1] <- ("Country")

# Values as numeric
TOTAL[,2:21] <- lapply(TOTAL[,2:21], as.numeric)

# Deleting NAs
TOTAL <- na.omit(TOTAL)


# Subseting two periods
TOTAL_1 <- TOTAL[,1:11]
TOTAL_2 <- TOTAL[,c(1,12:21)]


# Calculating sums
TOTAL_1$TOTAL_1_sum <- rowSums(subset(TOTAL_1, select = c(2:11)), na.rm = T)
TOTAL_2$TOTAL_2_sum <- rowSums(subset(TOTAL_2, select = c(2:11)), na.rm = T)


#Calculating avg
TOTAL_1$TOTAL_1_avg <- rowMeans(subset(TOTAL_1, select = c(2:11)), na.rm = T)
TOTAL_2$TOTAL_2_avg <- rowMeans(subset(TOTAL_2, select = c(2:11)), na.rm = T)





# 4.SFF (Solid fossil fuels)

# Preparing data
SFF <- read_excel("data.xlsx", sheet = 4, col_names = T, n_max = 41, skip = 9)
SFF <- SFF[c(2:41), seq]

# Values as numeric
countries <- countrycode(SFF$TIME, origin = "country.name", destination = "iso3c")
SFF[,1] <- countries
colnames(SFF)[1] <- ("Country")
SFF[,2:21] <- lapply(SFF[,2:21], as.numeric)

# Deleting NAs
SFF <- na.omit(SFF)

# Subseting two periods
SFF_1 <- SFF[,1:11]
SFF_2 <- SFF[,c(1,12:21)]

# Calculating sums
SFF_1$SFF_sum <- rowSums(subset(SFF_1, select = c(2:11)), na.rm = T)
SFF_2$SFF_sum <- rowSums(subset(SFF_2, select = c(2:11)), na.rm = T)


#Calculating avg
SFF_1$SFF_avg <- rowMeans(subset(SFF_1, select = c(2:11)), na.rm = T)
SFF_2$SFF_avg <- rowMeans(subset(SFF_2, select = c(2:11)), na.rm = T)



# 5.MFG (Manufactured gases)

# Preparing data
MFG <- read_excel("data.xlsx", sheet = 5, col_names = T, n_max = 41, skip = 9)
MFG <- MFG[c(2:41), seq]

# Values as numeric
countries <- countrycode(MFG$TIME, origin = "country.name", destination = "iso3c")
MFG[,1] <- countries
colnames(MFG)[1] <- ("Country")
MFG[,2:21] <- lapply(MFG[,2:21], as.numeric)

# Deleting NAs
MFG <- na.omit(MFG)

# Subseting two periods
MFG_1 <- MFG[,1:11]
MFG_2 <- MFG[,c(1,12:21)]

# Calculating sums
MFG_1$MFG_sum <- rowSums(subset(MFG_1, select = c(2:11)), na.rm = T)
MFG_2$MFG_sum <- rowSums(subset(MFG_2, select = c(2:11)), na.rm = T)


#Calculating avg
MFG_1$MFG_avg <- rowMeans(subset(MFG_1, select = c(2:11)), na.rm = T)
MFG_2$MFG_avg <- rowMeans(subset(MFG_2, select = c(2:11)), na.rm = T)



# 6.PEAT (Peat and peat products)

# Preparing data
PEAT <- read_excel("data.xlsx", sheet = 6, col_names = T, n_max = 41, skip = 9)
PEAT <- PEAT[c(2:41), seq]

# Values as numeric
countries <- countrycode(PEAT$TIME, origin = "country.name", destination = "iso3c")
PEAT[,1] <- countries
colnames(PEAT)[1] <- ("Country")
PEAT[,2:21] <- lapply(PEAT[,2:21], as.numeric)

# Deleting NAs
PEAT <- na.omit(PEAT)

# Subseting two periods
PEAT_1 <- PEAT[,1:11]
PEAT_2 <- PEAT[,c(1,12:21)]

# Calculating sums
PEAT_1$PEAT_sum <- rowSums(subset(PEAT_1, select = c(2:11)), na.rm = T)
PEAT_2$PEAT_sum <- rowSums(subset(PEAT_2, select = c(2:11)), na.rm = T)

#Calculating avg
PEAT_1$PEAT_avg <- rowMeans(subset(PEAT_1, select = c(2:11)), na.rm = T)
PEAT_2$PEAT_avg <- rowMeans(subset(PEAT_2, select = c(2:11)), na.rm = T)



# 7.OIL (Oil shale and oil sands)

# Preparing data
OIL <- read_excel("data.xlsx", sheet = 7, col_names = T, n_max = 41, skip = 9)
OIL <- OIL[c(2:41), seq]

# Values as numeric
countries <- countrycode(OIL$TIME, origin = "country.name", destination = "iso3c")
OIL[,1] <- countries
colnames(OIL)[1] <- ("Country")
OIL[,2:21] <- lapply(OIL[,2:21], as.numeric)

# Deleting NAs
OIL <- na.omit(OIL)

# Subseting two periods
OIL_1 <- OIL[,1:11]
OIL_2 <- OIL[,c(1,12:21)]

# Calculating sums
OIL_1$OIL_sum <- rowSums(subset(OIL_1, select = c(2:11)), na.rm = T)
OIL_2$OIL_sum <- rowSums(subset(OIL_2, select = c(2:11)), na.rm = T)

#Calculating avg
OIL_1$OIL_avg <- rowMeans(subset(OIL_1, select = c(2:11)), na.rm = T)
OIL_2$OIL_avg <- rowMeans(subset(OIL_2, select = c(2:11)), na.rm = T)



# 8.NG (Natural gas)

# Preparing data
NG <- read_excel("data.xlsx", sheet = 8, col_names = T, n_max = 41, skip = 9)
NG <- NG[c(2:41), seq]

# Values as numeric
countries <- countrycode(NG$TIME, origin = "country.name", destination = "iso3c")
NG[,1] <- countries
colnames(NG)[1] <- ("Country")
NG[,2:21] <- lapply(NG[,2:21], as.numeric)

# Deleting NAs
NG <- na.omit(NG)

# Subseting two periods
NG_1 <- NG[,1:11]
NG_2 <- NG[,c(1,12:21)]

# Calculating sums
NG_1$NG_sum <- rowSums(subset(NG_1, select = c(2:11)), na.rm = T)
NG_2$NG_sum <- rowSums(subset(NG_2, select = c(2:11)), na.rm = T)

#Calculating avg
NG_1$NG_avg <- rowMeans(subset(NG_1, select = c(2:11)), na.rm = T)
NG_2$NG_avg <- rowMeans(subset(NG_2, select = c(2:11)), na.rm = T)



# 9.O_P

# Preparing data
O_P <- read_excel("data.xlsx", sheet = 9, col_names = T, n_max = 41, skip = 9)
O_P <- O_P[c(2:41), seq]

# Values as numeric
countries <- countrycode(O_P$TIME, origin = "country.name", destination = "iso3c")
O_P[,1] <- countries
colnames(O_P)[1] <- ("Country")
O_P[,2:21] <- lapply(O_P[,2:21], as.numeric)

# Deleting NAs
O_P <- na.omit(O_P)

# Subseting two periods
O_P_1 <- O_P[,1:11]
O_P_2 <- O_P[,c(1,12:21)]

# Calculating sums
O_P_1$O_P_sum <- rowSums(subset(O_P_1, select = c(2:11)), na.rm = T)
O_P_2$O_P_sum <- rowSums(subset(O_P_2, select = c(2:11)), na.rm = T)

#Calculating avg
O_P_1$O_P_avg <- rowMeans(subset(O_P_1, select = c(2:11)), na.rm = T)
O_P_2$O_P_avg <- rowMeans(subset(O_P_2, select = c(2:11)), na.rm = T)


# 10.REN (Renewables and biofuels)

# Preparing data
REN <- read_excel("data.xlsx", sheet = 10, col_names = T, n_max = 41, skip = 9)
REN <- REN[c(2:41), seq]

# Values as numeric
countries <- countrycode(REN$TIME, origin = "country.name", destination = "iso3c")
REN[,1] <- countries
colnames(REN)[1] <- ("Country")
REN[,2:21] <- lapply(REN[,2:21], as.numeric)

# Deleting NAs
REN <- na.omit(REN)

# Subseting two periods
REN_1 <- REN[,1:11]
REN_2 <- REN[,c(1,12:21)]

# Calculating sums
REN_1$REN_sum <- rowSums(subset(REN_1, select = c(2:11)), na.rm = T)
REN_2$REN_sum <- rowSums(subset(REN_2, select = c(2:11)), na.rm = T)


#Calculating avg
REN_1$REN_avg <- rowMeans(subset(REN_1, select = c(2:11)), na.rm = T)
REN_2$REN_avg <- rowMeans(subset(REN_2, select = c(2:11)), na.rm = T)


# 11.NRE (Non-renewable waste)

# Preparing data
NRE <- read_excel("data.xlsx", sheet = 11, col_names = T, n_max = 41, skip = 9)
NRE <- NRE[c(2:41), seq]

# Values as numeric
countries <- countrycode(NRE$TIME, origin = "country.name", destination = "iso3c")
NRE[,1] <- countries
colnames(NRE)[1] <- ("Country")
NRE[,2:21] <- lapply(NRE[,2:21], as.numeric)

# Deleting NAs
NRE <- na.omit(NRE)

# Subseting two periods
NRE_1 <- NRE[,1:11]
NRE_2 <- NRE[,c(1,12:21)]

# Calculating sums
NRE_1$NRE_sum <- rowSums(subset(NRE_1, select = c(2:11)), na.rm = T)
NRE_2$NRE_sum <- rowSums(subset(NRE_2, select = c(2:11)), na.rm = T)

#Calculating avg
NRE_1$NRE_avg <- rowMeans(subset(NRE_1, select = c(2:11)), na.rm = T)
NRE_2$NRE_avg <- rowMeans(subset(NRE_2, select = c(2:11)), na.rm = T)





# 12.NUC (Nuclear heat)

# Preparing data
NUC <- read_excel("data.xlsx", sheet = 12, col_names = T, n_max = 41, skip = 9)
NUC <- NUC[c(2:41), seq]

# Values as numeric
countries <- countrycode(NUC$TIME, origin = "country.name", destination = "iso3c")
NUC[,1] <- countries
colnames(NUC)[1] <- ("Country")
NUC[,2:21] <- lapply(NUC[,2:21], as.numeric)

# Deleting NAs
NUC <- na.omit(NUC)

# Subseting two periods
NUC_1 <- NUC[,1:11]
NUC_2 <- NUC[,c(1,12:21)]

# Calculating sums
NUC_1$NUC_sum <- rowSums(subset(NUC_1, select = c(2:11)), na.rm = T)
NUC_2$NUC_sum <- rowSums(subset(NUC_2, select = c(2:11)), na.rm = T)


#Calculating avg
NUC_1$NUC_avg <- rowMeans(subset(NUC_1, select = c(2:11)), na.rm = T)
NUC_2$NUC_avg <- rowMeans(subset(NUC_2, select = c(2:11)), na.rm = T)








#----- FOSSIL FUELS - PERIDO 1------#


#Joining all datasets (ENERGY_1)
Country <- TOTAL$Country
ENERGY_1 <- cbind(Country,MFG_1$MFG_sum, NG_1$NG_sum, NRE_1$NRE_sum, NUC_1$NUC_sum,
                  O_P_1$O_P_sum, OIL_1$OIL_sum, PEAT_1$PEAT_sum, REN_1$REN_sum, SFF_1$SFF_sum)
ENERGY_1 <- as.data.frame(ENERGY_1)

#Convert to numeric
ENERGY_1[,2:10] <- lapply(ENERGY_1[,2:10], as.numeric)

#Calculate total
ENERGY_1$sum <- rowSums(subset(ENERGY_1, select = c(2:10)), na.rm = T)
ENERGY_1$sum == TOTAL_1$TOTAL_1_sum

#Calculate avg
ENERGY_1_avg <- cbind(Country,MFG_1$MFG_avg, NG_1$NG_avg, NRE_1$NRE_avg, NUC_1$NUC_avg,
                      O_P_1$O_P_avg, OIL_1$OIL_avg, PEAT_1$PEAT_avg, REN_1$REN_avg, SFF_1$SFF_avg)

ENERGY_1_avg <- as.data.frame(ENERGY_1_avg)
ENERGY_1_avg[,2:10] <- lapply(ENERGY_1_avg[,2:10], as.numeric)



# Joining average (fossil fuels)
CARBON_1 <- cbind(Country, MFG_1$MFG_avg, NG_1$NG_avg,
                  O_P_1$O_P_avg, OIL_1$OIL_avg, PEAT_1$PEAT_avg,SFF_1$SFF_avg)
CARBON_1 <- as.data.frame(CARBON_1)
CARBON_1[,2:7] <- lapply(CARBON_1[,2:7], as.numeric)



#Calculate avg all fossil fuels (summing all averages)
CARBON_1$avg <- rowSums(subset(CARBON_1, select = c(2:7)), na.rm = T)
CARBON_1 <- cbind(Country, CARBON_1$avg, TOTAL_1$TOTAL_1_avg)
CARBON_1 <- as.data.frame(CARBON_1)
colnames(CARBON_1) <- c("Country", "Carbon", "Total")
CARBON_1[,2:3] <- lapply(CARBON_1[,2:3], as.numeric)

#Calculate share
CARBON_1$share <- CARBON_1$Carbon/CARBON_1$Total


CARBON_1_share <- CARBON_1[,c(1,4)]


#----- FOSSIL FUELS - PERIDO 1------#


#Joining all datasets (ENERGY_1)
Country <- TOTAL$Country
ENERGY_1 <- cbind(Country,MFG_1$MFG_sum, NG_1$NG_sum, NRE_1$NRE_sum, NUC_1$NUC_sum,
                  O_P_1$O_P_sum, OIL_1$OIL_sum, PEAT_1$PEAT_sum, REN_1$REN_sum, SFF_1$SFF_sum)
ENERGY_1 <- as.data.frame(ENERGY_1)

#Convert to numeric
ENERGY_1[,2:10] <- lapply(ENERGY_1[,2:10], as.numeric)

#Calculate total
ENERGY_1$sum <- rowSums(subset(ENERGY_1, select = c(2:10)), na.rm = T)
ENERGY_1$sum == TOTAL_1$TOTAL_1_sum

#Calculate avg
ENERGY_1_avg <- cbind(Country,MFG_1$MFG_avg, NG_1$NG_avg, NRE_1$NRE_avg, NUC_1$NUC_avg,
                      O_P_1$O_P_avg, OIL_1$OIL_avg, PEAT_1$PEAT_avg, REN_1$REN_avg, SFF_1$SFF_avg)

ENERGY_1_avg <- as.data.frame(ENERGY_1_avg)
ENERGY_1_avg[,2:10] <- lapply(ENERGY_1_avg[,2:10], as.numeric)



# Joining average (fossil fuels)
CARBON_1 <- cbind(Country, MFG_1$MFG_avg, NG_1$NG_avg,
                  O_P_1$O_P_avg, OIL_1$OIL_avg, PEAT_1$PEAT_avg,SFF_1$SFF_avg)
CARBON_1 <- as.data.frame(CARBON_1)
CARBON_1[,2:7] <- lapply(CARBON_1[,2:7], as.numeric)



#Calculate avg all fossil fuels (summing all averages)
CARBON_1$avg <- rowSums(subset(CARBON_1, select = c(2:7)), na.rm = T)
CARBON_1 <- cbind(Country, CARBON_1$avg, TOTAL_1$TOTAL_1_avg)
CARBON_1 <- as.data.frame(CARBON_1)
colnames(CARBON_1) <- c("Country", "Carbon", "Total")
CARBON_1[,2:3] <- lapply(CARBON_1[,2:3], as.numeric)

#Calculate share
CARBON_1$share <- CARBON_1$Carbon/CARBON_1$Total


#----- FOSSIL FUELS - PERIDO 1------#


#Joining all datasets (ENERGY_2)
Country <- TOTAL$Country
ENERGY_2 <- cbind(Country,MFG_2$MFG_sum, NG_2$NG_sum, NRE_2$NRE_sum, NUC_2$NUC_sum,
                  O_P_2$O_P_sum, OIL_2$OIL_sum, PEAT_2$PEAT_sum, REN_2$REN_sum, SFF_2$SFF_sum)
ENERGY_2 <- as.data.frame(ENERGY_2)

#Convert to numeric
ENERGY_2[,2:10] <- lapply(ENERGY_2[,2:10], as.numeric)

#Calculate total
ENERGY_2$sum <- rowSums(subset(ENERGY_2, select = c(2:10)), na.rm = T)
ENERGY_2$sum == TOTAL_2$TOTAL_2_sum

#Calculate avg
ENERGY_2_avg <- cbind(Country,MFG_2$MFG_avg, NG_2$NG_avg, NRE_2$NRE_avg, NUC_2$NUC_avg,
                      O_P_2$O_P_avg, OIL_2$OIL_avg, PEAT_2$PEAT_avg, REN_2$REN_avg, SFF_2$SFF_avg)

ENERGY_2_avg <- as.data.frame(ENERGY_2_avg)
ENERGY_2_avg[,2:10] <- lapply(ENERGY_2_avg[,2:10], as.numeric)



# Joining average (fossil fuels)
CARBON_2 <- cbind(Country, MFG_2$MFG_avg, NG_2$NG_avg,
                  O_P_2$O_P_avg, OIL_2$OIL_avg, PEAT_2$PEAT_avg,SFF_2$SFF_avg)
CARBON_2 <- as.data.frame(CARBON_2)
CARBON_2[,2:7] <- lapply(CARBON_2[,2:7], as.numeric)



#Calculate avg all fossil fuels (summing all averages)
CARBON_2$avg <- rowSums(subset(CARBON_2, select = c(2:7)), na.rm = T)
CARBON_2 <- cbind(Country, CARBON_2$avg, TOTAL_2$TOTAL_2_avg)
CARBON_2 <- as.data.frame(CARBON_2)
colnames(CARBON_2) <- c("Country", "Carbon", "Total")
CARBON_2[,2:3] <- lapply(CARBON_2[,2:3], as.numeric)

#Calculate share
CARBON_2$share <- CARBON_2$Carbon/CARBON_2$Total

CARBON_2_share <- CARBON_2[,c(1,4)]


#Saving data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data/Carbon lock-in")
write.table(CARBON_1_share,"CARBON_1_share.txt")
write.table(CARBON_2_share,"CARBON_2_share.txt")

