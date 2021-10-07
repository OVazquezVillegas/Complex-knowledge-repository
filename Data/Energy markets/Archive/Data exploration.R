
###################################
####                          #####
####     Data exploration     #####
####                          ##### 
###################################

setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data/Energy markets")
library(dplyr)
library(countrycode)
# ==================== #
#   Data preparation   # ----------------------------------------------------------------
# ==================== # 
###Approaches of data collection

## Schmidt & Sewerin (2019) used data from the OECD (https://data.oecd.org/energy.htm)
# They focus on the power sector = share of total power generation capacity

## Li et al. used data from the World Energy Balances of IEA 
# They focus on the power sector = share of total electricity generated from renewable

## Loading files
RET_ktoe <- read.csv("DP_LIVE_19022021153432452.csv")

RET_share <- read.csv("DP_LIVE_19022021152843825.csv")

RET_all <- merge(RET_ktoe, RET_share, by = "LOCATION")
RET_all <- RET_all[,c(1,6:7, 14)]

colnames(RET_all)  <- c("LOCATION", "year", "toe", "share")

RET_all$RET_GW <- RET_all$toe*11.63

Power <- read.csv("DP_LIVE_19022021154225900.csv")

Energy_all <- merge(Power, RET_all, by = "LOCATION")

Energy_all <- Energy_all[, c(1,7,10:12)]

colnames(Energy_all)[2] <- "ALL_GW"

## EUROSTAT - "Net electricity generation by type of fuel - monthly data" available since 2016
# (https://data.europa.eu/euodp/en/data/dataset/dHYu0mhmQuNr1LrWsMa6gQ)
# 

## IEA Energy Supply /TPES by source : Finland

FN <- read.csv("Electricity generation by source - France.csv",                
               header=T, skip = 4, check.names = F)
FN <- FN[,1:8]
FN[is.na(FN)] <- 0
FN$fossil_fuels <- rowSums(FN[,c(2,3,7)])
FN[,c(1)]
FN$RET <- rowSums(FN[, c(4,6,8)]) 

# getting the means
FN_1 <- FN[1:3, c(1,9,10)]
FN_1_mean <- colMeans(FN_1)

FN_2 <- FN[3:7, c(1,9,10)]
FN_2_mean <- colMeans(FN_2)


# FORGET ALL !!!!! https://ec.europa.eu/eurostat/databrowser/view/nrg_bal_c/default/table?lang=en
Carbon <- read_excel("~/Downloads/NRG_BAL_C__custom_10324371622967899416.xlsx", sheet = 3, col_names = T, n_max = 32, skip = 9)
seq <- seq(from = 2, to = 40, by = 2)
seq <- c(1,  2,  4,  6,  8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40)
Carbon <- Carbon[c(2:30), seq]
countries <- countrycode(Carbon$TIME, origin = "country.name", destination = "iso3c")
Carbon[,1] <- countries
colnames(Carbon) <- ("Country")
colnames(Carbon)[2:21] <- Years
Years <- seq(from = 2000, to = 2019, by = 1)
Carbon_1 <- Carbon[2]
Carbon_2
Carbon$avg <- mean

Carbon$Average <- average()

