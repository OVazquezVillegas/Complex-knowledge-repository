
# https://ec.europa.eu/eurostat/databrowser/view/sdg_08_10/default/table?lang=en
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data/GDP")
GDP <- read_excel("data.xlsx", sheet = 3, col_names = T, n_max = 41, skip = 8)
seq <- seq(from = 2, to = 40, by = 2)
seq <- c(1,  2,  4,  6,  8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40)
GDP <- GDP[c(2:36), seq]
colnames(GDP)[1] <- ("Country")

# Values as numeric
GDP[,2:21] <- lapply(GDP[,2:21], as.numeric)

# Deleting NAs
GDP <- na.omit(GDP)

# Subseting two periods
GDP_1 <- GDP[,1:11]
GDP_2 <- GDP[,c(1,12:21)]

# Calculating sums
GDP_1$GDP_1_sum <- rowSums(subset(GDP_1, select = c(2:11)), na.rm = T)
GDP_2$GDP_2_sum <- rowSums(subset(GDP_2, select = c(2:11)), na.rm = T)

#Calculating avg
GDP_1$GDP_1_avg <- rowMeans(subset(GDP_1, select = c(2:11)), na.rm = T)
GDP_2$GDP_2_avg <- rowMeans(subset(GDP_2, select = c(2:11)), na.rm = T)

#Selecting avg
GDP_1 <- GDP_1[,c(1,13)]
GDP_2 <- GDP_2[,c(1,13)]

#Saving data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis")
write.table(GDP_1,"GDP_1.txt")
write.table(GDP_2,"GDP_2.txt")
