
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data/Population")
# https://ec.europa.eu/eurostat/databrowser/view/NRG_BAL_C__custom_1036970/default/table?lang=en

library(readxl)
# -------------   POPULATION  ----------------


# 3.POP

# Preparing data
POP <- read_excel("data.xlsx", sheet = 3, col_names = T, n_max = 338, skip = 9, na = ":")
seq <- seq(from = 2, to = 40, by = 2)
seq <- c(1,  2,  4,  6,  8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40)
POP <- POP[c(2:338), seq]



# Convert to numeric
POP[,2:21] <- lapply(POP[,2:21], as.numeric)

# Subseting two periods
POP_1 <- POP[,1:11]
POP_2 <- POP[,c(1,12:21)]

# Deliting NAs
POP_1 <- na.omit(POP_1)
POP_2 <- na.omit(POP_2)



#Calculating avg
POP_1$Pop_1_avg <- rowMeans(subset(POP_1, select = c(2:11)), na.rm = T)
POP_2$Pop_2_avg <- rowMeans(subset(POP_2, select = c(2:11)), na.rm = T)

#Selecting only avg
POP_1 <- POP_1[,c(1,12)]
POP_2 <- POP_2[,c(1,12)]


#Saving data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis")
write.table(POP_1,"Pop_1.txt")
write.table(POP_2,"Pop_2.txt")

