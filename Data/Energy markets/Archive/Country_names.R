
# https://ec.europa.eu/eurostat/databrowser/view/sdg_08_10/default/table?lang=en



library(readxl)
library(ggplot2)
library(ggthemes) # Load
library(gridExtra)
library(dplyr)
library(countrycode)

setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data/Energy markets/Original data")

# 0) TOTAL
TOTAL <- read_excel("TOTAL.xlsx", sheet = 3, col_names = T, n_max = 43, skip = 8)
seq <- seq(from = 2, to = 40, by = 2)
seq <- c(1,  2,  4,  6,  8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40)
TOTAL <- TOTAL[c(2:42), seq]
colnames(TOTAL)[1] <- ("Country")

# Values as numeric
TOTAL[,2:21] <- lapply(TOTAL[,2:21], as.numeric)

# Deleting NAs
TOTAL <- na.omit(TOTAL)

TOTAL <- TOTAL[,1]
TOTAL$Name <- countrycode(TOTAL$Country, origin = "iso2c", destination = "country.name", nomatch = NULL)

TOTAL <- t(TOTAL)
TOTAL <- as.data.frame(TOTAL)
