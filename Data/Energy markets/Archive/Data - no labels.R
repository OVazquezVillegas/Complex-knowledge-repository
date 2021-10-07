
# https://ec.europa.eu/eurostat/databrowser/view/sdg_08_10/default/table?lang=en



library(readxl)
library(ggplot2)
library(ggthemes) # Load
library(gridExtra)


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

# Subseting two periods
TOTAL_1 <- TOTAL[,1:11]
TOTAL_2 <- TOTAL[,c(1,12:21)]

# Calculating sums
TOTAL_1$TOTAL_1_sum <- rowSums(subset(TOTAL_1, select = c(2:11)), na.rm = T)
TOTAL_2$TOTAL_2_sum <- rowSums(subset(TOTAL_2, select = c(2:11)), na.rm = T)

#Calculating avg
TOTAL_1$TOTAL_1_avg <- rowMeans(subset(TOTAL_1, select = c(2:11)), na.rm = T)
TOTAL_2$TOTAL_2_avg <- rowMeans(subset(TOTAL_2, select = c(2:11)), na.rm = T)

#Selecting avg
TOTAL_1 <- TOTAL_1[,c(1,13)]
TOTAL_2 <- TOTAL_2[,c(1,13)]

#Saving data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data/Energy markets")
write.table(TOTAL_1,"TOTAL_1.txt")
write.table(TOTAL_2,"TOTAL_2.txt")




setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data/Energy markets/Original data")

# 1) HYDRO
HYDRO <- read_excel("hydro.xlsx", sheet = 3, col_names = T, n_max = 43, skip = 8)
seq <- seq(from = 2, to = 40, by = 2)
seq <- c(1,  2,  4,  6,  8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40)
HYDRO <- HYDRO[c(2:42), seq]
colnames(HYDRO)[1] <- ("Country")

# Values as numeric
HYDRO[,2:21] <- lapply(HYDRO[,2:21], as.numeric)

# Deleting NAs
HYDRO <- na.omit(HYDRO)

# Subseting two periods
HYDRO_1 <- HYDRO[,1:11]
HYDRO_2 <- HYDRO[,c(1,12:21)]

# Calculating sums
HYDRO_1$HYDRO_1_sum <- rowSums(subset(HYDRO_1, select = c(2:11)), na.rm = T)
HYDRO_2$HYDRO_2_sum <- rowSums(subset(HYDRO_2, select = c(2:11)), na.rm = T)

#Calculating avg
HYDRO_1$HYDRO_1_avg <- rowMeans(subset(HYDRO_1, select = c(2:11)), na.rm = T)
HYDRO_2$HYDRO_2_avg <- rowMeans(subset(HYDRO_2, select = c(2:11)), na.rm = T)

#Selecting avg
HYDRO_1 <- HYDRO_1[,c(1,13)]
HYDRO_2 <- HYDRO_2[,c(1,13)]


#Calculating share
HYDRO_1_share <-  HYDRO_1[,2]/TOTAL_1[,2] 
HYDRO_2_share <-  HYDRO_2[,2]/TOTAL_2[,2] 

#Selecting share
HYDRO_1 <- cbind(HYDRO$Country, HYDRO_1_share)
HYDRO_2 <- cbind(HYDRO$Country, HYDRO_2_share)

#Saving data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data/Energy markets")
write.table(HYDRO_1,"HYDRO_1.txt")
write.table(HYDRO_2,"HYDRO_2.txt")

# Plot
HYDRO_1$HYDRO_1_avg <- round(HYDRO_1$HYDRO_1_avg*100, digits = 1)


PLOT_HYDRO_1 <- ggplot(HYDRO_1, aes(reorder(HYDRO_1$`HYDRO$Country`,-HYDRO_1$HYDRO_1_avg, sum), HYDRO_1$HYDRO_1_avg)) +
  geom_col(data =HYDRO_1 , fill = "seagreen3")+
  geom_text(aes(label=HYDRO_1_avg), vjust=-0.5, color="black", size=3)+
  theme_few() + labs(title= "Share of electricity from hydropower (average: 2000-2009)", 
                      y="Share", x = "Country")
  

print(PLOT_HYDRO_1)

HYDRO_2$HYDRO_2_avg <- round(HYDRO_2$HYDRO_2_avg*100, digits = 1)


PLOT_HYDRO_2 <- ggplot(HYDRO_2, aes(reorder(HYDRO_2$`HYDRO$Country`,-HYDRO_2$HYDRO_2_avg, sum), HYDRO_2$HYDRO_2_avg)) +
  geom_col(data =HYDRO_2 , fill = "seagreen3")+
  geom_text(aes(label=HYDRO_2_avg), vjust=-0.5, color="black", size=3)+
  theme_few() + labs(title= "Share of electricity from hydropower (average: 2010-2019)", 
                     y="Share", x = "Country")


print(PLOT_HYDRO_2)


# 2) GEO
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data/Energy markets/Original data")

GEO <- read_excel("geo.xlsx", sheet = 3, col_names = T, n_max = 43, skip = 8)
seq <- seq(from = 2, to = 40, by = 2)
seq <- c(1,  2,  4,  6,  8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40)
GEO <- GEO[c(2:42), seq]
colnames(GEO)[1] <- ("Country")

# Values as numeric
GEO[,2:21] <- lapply(GEO[,2:21], as.numeric)

# Deleting NAs
GEO <- na.omit(GEO)

# Subseting two periods
GEO_1 <- GEO[,1:11]
GEO_2 <- GEO[,c(1,12:21)]

# Calculating sums
GEO_1$GEO_1_sum <- rowSums(subset(GEO_1, select = c(2:11)), na.rm = T)
GEO_2$GEO_2_sum <- rowSums(subset(GEO_2, select = c(2:11)), na.rm = T)

#Calculating avg
GEO_1$GEO_1_avg <- rowMeans(subset(GEO_1, select = c(2:11)), na.rm = T)
GEO_2$GEO_2_avg <- rowMeans(subset(GEO_2, select = c(2:11)), na.rm = T)

#Selecting avg
GEO_1 <- GEO_1[,c(1,13)]
GEO_2 <- GEO_2[,c(1,13)]

#Calculating share
GEO_1_share <-  GEO_1[,2]/TOTAL_1[,2] 
GEO_2_share <-  GEO_2[,2]/TOTAL_2[,2] 

#Selecting share
GEO_1 <- cbind(GEO$Country, GEO_1_share)
GEO_2 <- cbind(GEO$Country, GEO_2_share)

#Saving data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data/Energy markets")
write.table(GEO_1,"GEO_1.txt")
write.table(GEO_2,"GEO_2.txt")

# Plot
GEO_1$GEO_1_avg <- round(GEO_1$GEO_1_avg*100, digits = 2)


PLOT_GEO_1 <- ggplot(GEO_1, aes(reorder(GEO_1$`GEO$Country`,-GEO_1$GEO_1_avg, sum), GEO_1$GEO_1_avg)) +
  geom_col(data =GEO_1 , fill = "orangered1")+
  geom_text(aes(label=GEO_1_avg), vjust=-0.5, color="black", size=3)+
  theme_few() + labs(title= "Share of electricity from geothermal power (average: 2000-2009)", 
                     y="Share", x = "Country")


print(PLOT_GEO_1)

GEO_2$GEO_2_avg <- round(GEO_2$GEO_2_avg*100, digits = 2)


PLOT_GEO_2 <- ggplot(GEO_2, aes(reorder(GEO_2$`GEO$Country`,-GEO_2$GEO_2_avg, sum), GEO_2$GEO_2_avg)) +
  geom_col(data =GEO_2 , fill = "orangered1")+
  geom_text(aes(label=GEO_2_avg), vjust=-0.5, color="black", size=3)+
   theme_few() + labs(title= "Share of electricity from geothermal power (average: 2010-2019)", 
                     y="Share", x = "Country")


print(PLOT_GEO_2)


# 3) PV
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data/Energy markets/Original data")

PV <- read_excel("PV.xlsx", sheet = 3, col_names = T, n_max = 43, skip = 8)
seq <- seq(from = 2, to = 40, by = 2)
seq <- c(1,  2,  4,  6,  8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40)
PV <- PV[c(2:42), seq]
colnames(PV)[1] <- ("Country")

# Values as numeric
PV[,2:21] <- lapply(PV[,2:21], as.numeric)

# Deleting NAs
PV <- na.omit(PV)

# Subseting two periods
PV_1 <- PV[,1:11]
PV_2 <- PV[,c(1,12:21)]

# Calculating sums
PV_1$PV_1_sum <- rowSums(subset(PV_1, select = c(2:11)), na.rm = T)
PV_2$PV_2_sum <- rowSums(subset(PV_2, select = c(2:11)), na.rm = T)

#Calculating avg
PV_1$PV_1_avg <- rowMeans(subset(PV_1, select = c(2:11)), na.rm = T)
PV_2$PV_2_avg <- rowMeans(subset(PV_2, select = c(2:11)), na.rm = T)

#Selecting avg
PV_1 <- PV_1[,c(1,13)]
PV_2 <- PV_2[,c(1,13)]


#Calculating share
PV_1_share <-  PV_1[,2]/TOTAL_1[,2] 
PV_2_share <-  PV_2[,2]/TOTAL_2[,2] 

#Selecting share
PV_1 <- cbind(PV$Country, PV_1_share)
PV_2 <- cbind(PV$Country, PV_2_share)

#Saving data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data/Energy markets")
write.table(PV_1,"PV_1.txt")
write.table(PV_2,"PV_2.txt")




# Plot
PV_1$PV_1_avg <- round(PV_1$PV_1_avg*100, digits = 2)


PLOT_PV_1 <- ggplot(PV_1, aes(reorder(PV_1$`PV$Country`,-PV_1$PV_1_avg, sum), PV_1$PV_1_avg)) +
  geom_col(data =PV_1 , fill = "orange2")+
 geom_text(aes(label=PV_1_avg), vjust=-0.5, color="black", size=3)+
  theme_few() + labs(title= "Share of electricity from solar PV technology (average: 2000-2009)", 
                     y="Share", x = "Country")


print(PLOT_PV_1)

PV_2$PV_2_avg <- round(PV_2$PV_2_avg*100, digits = 1)


PLOT_PV_2 <- ggplot(PV_2, aes(reorder(PV_2$`PV$Country`,-PV_2$PV_2_avg, sum), PV_2$PV_2_avg)) +
 geom_col(data =PV_2 , fill = "orange2")+
  geom_text(aes(label=PV_2_avg), vjust=-0.5, color="black", size=3)+
  theme_few() + labs(title= "Share of electricity from solar PV technology (average: 2010-2019)", 
                     y="Share", x = "Country")


print(PLOT_PV_2)



# 4) THERMAL
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data/Energy markets/Original data")

THERMAL <- read_excel("THERMAL.xlsx", sheet = 3, col_names = T, n_max = 43, skip = 8)
seq <- seq(from = 2, to = 40, by = 2)
seq <- c(1,  2,  4,  6,  8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40)
THERMAL <- THERMAL[c(2:42), seq]
colnames(THERMAL)[1] <- ("Country")

# Values as numeric
THERMAL[,2:21] <- lapply(THERMAL[,2:21], as.numeric)

# Deleting NAs
THERMAL <- na.omit(THERMAL)

# Subseting two periods
THERMAL_1 <- THERMAL[,1:11]
THERMAL_2 <- THERMAL[,c(1,12:21)]

# Calculating sums
THERMAL_1$THERMAL_1_sum <- rowSums(subset(THERMAL_1, select = c(2:11)), na.rm = T)
THERMAL_2$THERMAL_2_sum <- rowSums(subset(THERMAL_2, select = c(2:11)), na.rm = T)

#Calculating avg
THERMAL_1$THERMAL_1_avg <- rowMeans(subset(THERMAL_1, select = c(2:11)), na.rm = T)
THERMAL_2$THERMAL_2_avg <- rowMeans(subset(THERMAL_2, select = c(2:11)), na.rm = T)

#Selecting avg
THERMAL_1 <- THERMAL_1[,c(1,13)]
THERMAL_2 <- THERMAL_2[,c(1,13)]



#Calculating share
THERMAL_1_share <-  THERMAL_1[,2]/TOTAL_1[,2] 
THERMAL_2_share <-  THERMAL_2[,2]/TOTAL_2[,2] 

#Selecting share
THERMAL_1 <- cbind(THERMAL$Country, THERMAL_1_share)
THERMAL_2 <- cbind(THERMAL$Country, THERMAL_2_share)

#Saving data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data/Energy markets")
write.table(THERMAL_1,"THERMAL_1.txt")
write.table(THERMAL_2,"THERMAL_2.txt")

# Plot
THERMAL_1$THERMAL_1_avg <- round(THERMAL_1$THERMAL_1_avg*100, digits = 2)


PLOT_THERMAL_1 <- ggplot(THERMAL_1, aes(reorder(THERMAL_1$`THERMAL$Country`,-THERMAL_1$THERMAL_1_avg, sum), THERMAL_1$THERMAL_1_avg)) +
  geom_col(data =THERMAL_1 , fill = "orangered3")+
  geom_text(aes(label=THERMAL_1_avg), vjust=-0.5, color="black", size=3)+
  theme_few() + labs(title= "Share of electricity from CSP technology (average: 2000-2009)", 
                     y="Share", x = "Country")


print(PLOT_THERMAL_1)

THERMAL_2$THERMAL_2_avg <- round(THERMAL_2$THERMAL_2_avg*100, digits = 2)


PLOT_THERMAL_2 <- ggplot(THERMAL_2, aes(reorder(THERMAL_2$`THERMAL$Country`,-THERMAL_2$THERMAL_2_avg, sum), THERMAL_2$THERMAL_2_avg)) +
  geom_col(data =THERMAL_2 , fill = "orangered3")+
  geom_text(aes(label=THERMAL_2_avg), vjust=-0.5, color="black", size=3)+
  theme_few() + labs(title= "Share of electricity from CSP technology (average: 2010-2019)", 
                     y="Share", x = "Country")


print(PLOT_THERMAL_2)


# 5) OCEAN
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data/Energy markets/Original data")

OCEAN <- read_excel("OCEAN.xlsx", sheet = 3, col_names = T, n_max = 43, skip = 8)
seq <- seq(from = 2, to = 40, by = 2)
seq <- c(1,  2,  4,  6,  8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40)
OCEAN <- OCEAN[c(2:42), seq]
colnames(OCEAN)[1] <- ("Country")

# Values as numeric
OCEAN[,2:21] <- lapply(OCEAN[,2:21], as.numeric)

# Deleting NAs
OCEAN <- na.omit(OCEAN)

# Subseting two periods
OCEAN_1 <- OCEAN[,1:11]
OCEAN_2 <- OCEAN[,c(1,12:21)]

# Calculating sums
OCEAN_1$OCEAN_1_sum <- rowSums(subset(OCEAN_1, select = c(2:11)), na.rm = T)
OCEAN_2$OCEAN_2_sum <- rowSums(subset(OCEAN_2, select = c(2:11)), na.rm = T)

#Calculating avg
OCEAN_1$OCEAN_1_avg <- rowMeans(subset(OCEAN_1, select = c(2:11)), na.rm = T)
OCEAN_2$OCEAN_2_avg <- rowMeans(subset(OCEAN_2, select = c(2:11)), na.rm = T)

#Selecting avg
OCEAN_1 <- OCEAN_1[,c(1,13)]
OCEAN_2 <- OCEAN_2[,c(1,13)]



#Calculating share
OCEAN_1_share <-  OCEAN_1[,2]/TOTAL_1[,2] 
OCEAN_2_share <-  OCEAN_2[,2]/TOTAL_2[,2] 

#Selecting share
OCEAN_1 <- cbind(OCEAN$Country, OCEAN_1_share)
OCEAN_2 <- cbind(OCEAN$Country, OCEAN_2_share)


#Saving data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data/Energy markets")
write.table(OCEAN_1,"OCEAN_1.txt")
write.table(OCEAN_2,"OCEAN_2.txt")



# Plot
OCEAN_1$OCEAN_1_avg <- round(OCEAN_1$OCEAN_1_avg*100, digits = 2)


PLOT_OCEAN_1 <- ggplot(OCEAN_1, aes(reorder(OCEAN_1$`OCEAN$Country`,-OCEAN_1$OCEAN_1_avg, sum), OCEAN_1$OCEAN_1_avg)) +
  geom_col(data =OCEAN_1 , fill = "mediumpurple3")+
  geom_text(aes(label=OCEAN_1_avg), vjust=-0.5, color="black", size=3)+
  theme_few() + labs(title= "Share of electricity from ocean energy technology (average: 2000-2009)", 
                     y="Share", x = "Country")


print(PLOT_OCEAN_1)

OCEAN_2$OCEAN_2_avg <- round(OCEAN_2$OCEAN_2_avg*100, digits = 2)


PLOT_OCEAN_2 <- ggplot(OCEAN_2, aes(reorder(OCEAN_2$`OCEAN$Country`,-OCEAN_2$OCEAN_2_avg, sum), OCEAN_2$OCEAN_2_avg)) +
  geom_col(data =OCEAN_2 , fill = "mediumpurple3")+
  geom_text(aes(label=OCEAN_2_avg), vjust=-0.5, color="black", size=3)+
  theme_few() + labs(title= "Share of electricity from ocean energy technology (average: 2010-2019)", 
                     y="Share", x = "Country")


print(PLOT_OCEAN_2)




# 6) WIND
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data/Energy markets/Original data")

WIND <- read_excel("WIND.xlsx", sheet = 3, col_names = T, n_max = 43, skip = 8)
seq <- seq(from = 2, to = 40, by = 2)
seq <- c(1,  2,  4,  6,  8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40)
WIND <- WIND[c(2:42), seq]
colnames(WIND)[1] <- ("Country")

# Values as numeric
WIND[,2:21] <- lapply(WIND[,2:21], as.numeric)

# Deleting NAs
WIND <- na.omit(WIND)

# Subseting two periods
WIND_1 <- WIND[,1:11]
WIND_2 <- WIND[,c(1,12:21)]

# Calculating sums
WIND_1$WIND_1_sum <- rowSums(subset(WIND_1, select = c(2:11)), na.rm = T)
WIND_2$WIND_2_sum <- rowSums(subset(WIND_2, select = c(2:11)), na.rm = T)

#Calculating avg
WIND_1$WIND_1_avg <- rowMeans(subset(WIND_1, select = c(2:11)), na.rm = T)
WIND_2$WIND_2_avg <- rowMeans(subset(WIND_2, select = c(2:11)), na.rm = T)

#Selecting avg
WIND_1 <- WIND_1[,c(1,13)]
WIND_2 <- WIND_2[,c(1,13)]

#Calculating share
WIND_1_share <-  WIND_1[,2]/TOTAL_1[,2] 
WIND_2_share <-  WIND_2[,2]/TOTAL_2[,2] 

#Selecting share
WIND_1 <- cbind(WIND$Country, WIND_1_share)
WIND_2 <- cbind(WIND$Country, WIND_2_share)


#Saving data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data/Energy markets")
write.table(WIND_1,"WIND_1.txt")
write.table(WIND_2,"WIND_2.txt")


# Plot
WIND_1$WIND_1_avg <- round(WIND_1$WIND_1_avg*100, digits = 1)


PLOT_WIND_1 <- ggplot(WIND_1, aes(reorder(WIND_1$`WIND$Country`,-WIND_1$WIND_1_avg, sum), WIND_1$WIND_1_avg)) +
  geom_col(data =WIND_1 , fill = "dodgerblue4")+
  geom_text(aes(label=WIND_1_avg), vjust=-0.5, color="black", size=3)+
  theme_few() + labs(title= "Share of electricity from wind power technology (average: 2000-2009)", 
                     y="Share", x = "Country")


print(PLOT_WIND_1)

WIND_2$WIND_2_avg <- round(WIND_2$WIND_2_avg*100, digits = 1)


PLOT_WIND_2 <- ggplot(WIND_2, aes(reorder(WIND_2$`WIND$Country`,-WIND_2$WIND_2_avg, sum), WIND_2$WIND_2_avg)) +
  geom_col(data =WIND_2 , fill = "dodgerblue4")+
  geom_text(aes(label=WIND_2_avg), vjust=-0.5, color="black", size=3)+
  theme_few() + labs(title= "Share of electricity from wind power technology (average: 2010-2019)", 
                     y="Share", x = "Country")


print(PLOT_WIND_2)



# 5) OCEAN
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data/Energy markets/Original data")

OCEAN <- read_excel("OCEAN.xlsx", sheet = 3, col_names = T, n_max = 43, skip = 8)
seq <- seq(from = 2, to = 40, by = 2)
seq <- c(1,  2,  4,  6,  8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40)
OCEAN <- OCEAN[c(2:42), seq]
colnames(OCEAN)[1] <- ("Country")

# Values as numeric
OCEAN[,2:21] <- lapply(OCEAN[,2:21], as.numeric)

# Deleting NAs
OCEAN <- na.omit(OCEAN)

# Subseting two periods
OCEAN_1 <- OCEAN[,1:11]
OCEAN_2 <- OCEAN[,c(1,12:21)]

# Calculating sums
OCEAN_1$OCEAN_1_sum <- rowSums(subset(OCEAN_1, select = c(2:11)), na.rm = T)
OCEAN_2$OCEAN_2_sum <- rowSums(subset(OCEAN_2, select = c(2:11)), na.rm = T)

#Calculating avg
OCEAN_1$OCEAN_1_avg <- rowMeans(subset(OCEAN_1, select = c(2:11)), na.rm = T)
OCEAN_2$OCEAN_2_avg <- rowMeans(subset(OCEAN_2, select = c(2:11)), na.rm = T)

#Selecting avg
OCEAN_1 <- OCEAN_1[,c(1,13)]
OCEAN_2 <- OCEAN_2[,c(1,13)]



#Calculating share
OCEAN_1_share <-  OCEAN_1[,2]/TOTAL_1[,2] 
OCEAN_2_share <-  OCEAN_2[,2]/TOTAL_2[,2] 

#Selecting share
OCEAN_1 <- cbind(OCEAN$Country, OCEAN_1_share)
OCEAN_2 <- cbind(OCEAN$Country, OCEAN_2_share)


#Saving data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data/Energy markets")
write.table(OCEAN_1,"OCEAN_1.txt")
write.table(OCEAN_2,"OCEAN_2.txt")



# Plot
OCEAN_1$OCEAN_1_avg <- round(OCEAN_1$OCEAN_1_avg*100, digits = 2)


PLOT_OCEAN_1 <- ggplot(OCEAN_1, aes(reorder(OCEAN_1$`OCEAN$Country`,-OCEAN_1$OCEAN_1_avg, sum), OCEAN_1$OCEAN_1_avg)) +
  geom_col(data =OCEAN_1 , fill = "mediumpurple3")+
  geom_text(aes(label=OCEAN_1_avg), vjust=-0.5, color="black", size=3)+
  theme_few() + labs(title= "Share of electricity from ocean energy technology (average: 2000-2009)", 
                     y="Share", x = "Country")


print(PLOT_OCEAN_1)

OCEAN_2$OCEAN_2_avg <- round(OCEAN_2$OCEAN_2_avg*100, digits = 2)


PLOT_OCEAN_2 <- ggplot(OCEAN_2, aes(reorder(OCEAN_2$`OCEAN$Country`,-OCEAN_2$OCEAN_2_avg, sum), OCEAN_2$OCEAN_2_avg)) +
  geom_col(data =OCEAN_2 , fill = "mediumpurple3")+
  geom_text(aes(label=OCEAN_2_avg), vjust=-0.5, color="black", size=3)+
  theme_few() + labs(title= "Share of electricity from ocean energy technology (average: 2010-2019)", 
                     y="Share", x = "Country")


print(PLOT_OCEAN_2)










### SAVE PLOTS
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Plots")
png("capacities_1.png", width = 800, height = 1100)
grid.arrange(PLOT_HYDRO_1, PLOT_HYDRO_2, ncol = 1, nrow = 2)
dev.off()


png("capacities_2.png", width = 800, height = 1100)
grid.arrange(PLOT_GEO_1, PLOT_GEO_2, ncol = 1, nrow = 2)
dev.off()


png("capacities_3.png", width = 800, height = 1100)
grid.arrange(PLOT_PV_1, PLOT_PV_2, ncol = 1, nrow = 2)
dev.off()


png("capacities_4.png", width = 800, height = 1100)
grid.arrange(PLOT_WIND_1, PLOT_WIND_2, ncol = 1, nrow = 2)
dev.off()


png("capacities_5.png", width = 800, height = 1100)
grid.arrange(PLOT_THERMAL_1, PLOT_THERMAL_2, ncol = 1, nrow = 2)
dev.off()


png("capacities_6.png", width = 800, height = 1100)
grid.arrange(PLOT_OCEAN_1, PLOT_OCEAN_2, ncol = 1, nrow = 2)
dev.off()