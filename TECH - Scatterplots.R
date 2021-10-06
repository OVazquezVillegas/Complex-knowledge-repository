
###################################
####                          #####
####       Visualizations     #####
####                          ##### 
###################################

# ==================== #
#   Data preparation   # ----------------------------------------------------------------

## Reading packages 
library(readr) 
library(stringr)
library(dplyr)
library(ggplot2)
library(eurostat)
library(ggmap) 
library(mapproj)
library(EconGeo)
library(ggthemes) # Load
library(EnvStats)
library(gridExtra)



# - - - -  - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - 
#SCATTERPLOTS ----- KNI & RELATEDNESS

# HYDRO ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_1 <- read.table("HYDRO_1.txt", sep = "")
DATA_1[2:9] <- lapply(DATA_1[2:9], as.numeric)

#Select variable
DATA_1 <- DATA_1[,c(1,2,3)]

#Plot_1
plot_1 <-  ggplot(DATA_1, aes(x = DATA_1$RD, y = DATA_1$KNI))+ 
  geom_point(color = "blue3", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Hydropower (2000-2009)", 
        y  = "KNI", x = "Scientific relatedness", element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_1$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +  
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_1$Region)))



print(plot_1)

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_2 <- read.table("HYDRO_2.txt", sep = "")
DATA_2[2:9] <- lapply(DATA_2[2:9], as.numeric)

#Select variable
DATA_2 <- DATA_2[,c(1,2,3)]


#Plot_2
plot_2 <-  ggplot(DATA_2, aes(x = DATA_2$RD, y = DATA_2$KNI))+ 
  geom_point(color = "blue3", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Hydropower (2010-2019)", 
        y  = "KNI", x = "Scientific relatedness", element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_2$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +  
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_2$Region)))


print(plot_2)


# GEO ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_3 <- read.table("GEO_1.txt", sep = "")
DATA_3[2:9] <- lapply(DATA_3[2:9], as.numeric)

#Select variable
DATA_3 <- DATA_3[,c(1,2,3)]

#Plot_3
plot_3 <-  ggplot(DATA_3, aes(x = DATA_3$RD, y = DATA_3$KNI))+ 
  geom_point(color = "sienna3", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Geothermal power (2000-2009)", 
        y  = "KNI", x = "Scientific relatedness", element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_3$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm")) +
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_3$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_4 <- read.table("GEO_2.txt", sep = "")
DATA_4[2:9] <- lapply(DATA_4[2:9], as.numeric)

#Select variable
DATA_4 <- DATA_4[,c(1,2,3)]

#Plot_4
plot_4 <-  ggplot(DATA_4, aes(x = DATA_4$RD, y = DATA_4$KNI))+ 
  geom_point(color = "sienna3", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Geothermal power (2010-2019)", 
        y  = "KNI", x = "Scientific relatedness", element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_4$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_4$Region)))




# PV ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_5 <- read.table("PV_1.txt", sep = "")
DATA_5[2:9] <- lapply(DATA_5[2:9], as.numeric)

#Select variable
DATA_5 <- DATA_5[,c(1,2,3)]

#Plot_5
plot_5 <-  ggplot(DATA_5, aes(x = DATA_5$RD, y = DATA_5$KNI))+ 
  geom_point(color = "yellow", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Solar photovoltaics (PV) (2000-2009)", 
        y  = "KNI", x = "Scientific relatedness", element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_5$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_5$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_6 <- read.table("PV_2.txt", sep = "")
DATA_6[2:9] <- lapply(DATA_6[2:9], as.numeric)

#Select variable
DATA_6 <- DATA_6[,c(1,2,3)]


#Plot_6
plot_6 <-  ggplot(DATA_6, aes(x = DATA_6$RD, y = DATA_6$KNI))+ 
  geom_point(color = "yellow", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Solar photovoltaics (PV) (2010-2019)", 
        y  = "KNI", x = "Scientific relatedness", element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_6$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_6$Region)))



setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Plots")
png("KNI_RD_1.png", width = 800, height = 1100)
grid <- grid.arrange(plot_1, plot_2, plot_3, plot_4, plot_5, plot_6, ncol = 2)
dev.off()

class(plot_1)




# WIND ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_7 <- read.table("WIND_1.txt", sep = "")
DATA_7[2:9] <- lapply(DATA_7[2:9], as.numeric)

#Select variable
DATA_7 <- DATA_7[,c(1,2,3)]

#Plot_7
plot_7 <-  ggplot(DATA_7, aes(x = DATA_7$RD, y = DATA_7$KNI))+ 
  geom_point(color = "deepskyblue", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Wind power (2000-2009)", 
        y  = "KNI", x = "Scientific relatedness", element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_7$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_7$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_8 <- read.table("WIND_2.txt", sep = "")
DATA_8[2:9] <- lapply(DATA_8[2:9], as.numeric)

#Select variable
DATA_8 <- DATA_8[,c(1,2,3)]


#Plot_8
plot_8 <-  ggplot(DATA_8, aes(x = DATA_8$RD, y = DATA_8$KNI))+ 
  geom_point(color = "deepskyblue", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Wind power (2010-2019)", 
        y  = "KNI", x = "Scientific relatedness", element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_8$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +  
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_8$Region)))




# THERMAL ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_9 <- read.table("THERMAL_1.txt", sep = "")
DATA_9[2:9] <- lapply(DATA_9[2:9], as.numeric)

#Select variable
DATA_9 <- DATA_9[,c(1,2,3)]

#Plot_9
plot_9 <-  ggplot(DATA_9, aes(x = DATA_9$RD, y = DATA_9$KNI))+ 
  geom_point(color = "darkorange", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Concentrated solar power (CSP) (2000-2009)", 
        y  = "KNI", x = "Scientific relatedness", element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_9$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_9$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_10 <- read.table("THERMAL_2.txt", sep = "")
DATA_10[2:9] <- lapply(DATA_10[2:9], as.numeric)

#Select variable
DATA_10 <- DATA_10[,c(1,2,3)]


#Plot_10
plot_10 <-  ggplot(DATA_10, aes(x = DATA_10$RD, y = DATA_10$KNI))+ 
  geom_point(color = "darkorange", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Concentrated solar power (CSP) (2010-2019)", 
        y  = "KNI", x = "Scientific relatedness", element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_10$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_10$Region)))




# OCEAN ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_11 <- read.table("OCEAN_1.txt", sep = "")
DATA_11[2:9] <- lapply(DATA_11[2:9], as.numeric)

#Select variable
DATA_11 <- DATA_11[,c(1,2,3)]

#Plot_11
plot_11 <-  ggplot(DATA_11, aes(x = DATA_11$RD, y = DATA_11$KNI))+ 
  geom_point(color = "blueviolet", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Ocean energy (2000-2009)", 
        y  = "KNI", x = "Scientific relatedness", element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_11$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_11$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_12 <- read.table("OCEAN_2.txt", sep = "")
DATA_12[2:9] <- lapply(DATA_12[2:9], as.numeric)

#Select variable
DATA_12 <- DATA_12[,c(1,2,3)]


#Plot_12
plot_12 <-  ggplot(DATA_12, aes(x = DATA_12$RD, y = DATA_12$KNI))+ 
  geom_point(color = "blueviolet", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Ocean energy (2010-2019)", 
        y  = "KNI", x = "Scientific relatedness", element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_12$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +  
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_12$Region)))



setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Plots")
png("KNI_RD_2.png", width = 800, height = 1100)
grid.arrange(plot_7, plot_8, plot_9, plot_10, plot_11, plot_12, ncol = 2, nrow = 3)
dev.off()



###############################################################################


# - - - -  - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - 
#SCATTERPLOTS ----- KNI & Knowledge accumulation (K)

# HYDRO ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_1 <- read.table("HYDRO_1.txt", sep = "")
DATA_1[2:9] <- lapply(DATA_1[2:9], as.numeric)

#Select variable
DATA_1 <- DATA_1[,c(1,2,4)]

#Plot_1
plot_1 <-  ggplot(DATA_1, aes(x = DATA_1$K, y = DATA_1$KNI))+ 
  geom_point(color = "blue3", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Hydropower (2000-2009)", 
        y  = "KNI", x = "Knowledge accumulation" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_1$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +  
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_1$Region)))



print(plot_1)

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_2 <- read.table("HYDRO_2.txt", sep = "")
DATA_2[2:9] <- lapply(DATA_2[2:9], as.numeric)

#Select variable
DATA_2 <- DATA_2[,c(1,2,4)]


#Plot_2
plot_2 <-  ggplot(DATA_2, aes(x = DATA_2$K, y = DATA_2$KNI))+ 
  geom_point(color = "blue3", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Hydropower (2010-2019)", 
        y  = "KNI", x = "Knowledge accumulation" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_2$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +  
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_2$Region)))


print(plot_2)


# GEO ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_3 <- read.table("GEO_1.txt", sep = "")
DATA_3[2:9] <- lapply(DATA_3[2:9], as.numeric)

#Select variable
DATA_3 <- DATA_3[,c(1,2,4)]

#Plot_3
plot_3 <-  ggplot(DATA_3, aes(x = DATA_3$K, y = DATA_3$KNI))+ 
  geom_point(color = "sienna3", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Geothermal power (2000-2009)", 
        y  = "KNI", x = "Knowledge accumulation" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_3$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm")) +
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_3$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_4 <- read.table("GEO_2.txt", sep = "")
DATA_4[2:9] <- lapply(DATA_4[2:9], as.numeric)

#Select variable
DATA_4 <- DATA_4[,c(1,2,4)]

#Plot_4
plot_4 <-  ggplot(DATA_4, aes(x = DATA_4$K, y = DATA_4$KNI))+ 
  geom_point(color = "sienna3", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Geothermal power (2010-2019)", 
        y  = "KNI", x = "Knowledge accumulation" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_4$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_4$Region)))




# PV ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_5 <- read.table("PV_1.txt", sep = "")
DATA_5[2:9] <- lapply(DATA_5[2:9], as.numeric)

#Select variable
DATA_5 <- DATA_5[,c(1,2,4)]

#Plot_5
plot_5 <-  ggplot(DATA_5, aes(x = DATA_5$K, y = DATA_5$KNI))+ 
  geom_point(color = "yellow", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Solar photovoltaics (PV) (2000-2009)", 
        y  = "KNI", x = "Knowledge accumulation" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_5$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_5$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_6 <- read.table("PV_2.txt", sep = "")
DATA_6[2:9] <- lapply(DATA_6[2:9], as.numeric)

#Select variable
DATA_6 <- DATA_6[,c(1,2,4)]


#Plot_6
plot_6 <-  ggplot(DATA_6, aes(x = DATA_6$K, y = DATA_6$KNI))+ 
  geom_point(color = "yellow", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Solar photovoltaics (PV) (2010-2019)", 
        y  = "KNI", x = "Knowledge accumulation" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_6$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_6$Region)))



setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Plots")
png("KNI_K_1.png", width = 800, height = 1100)
grid <- grid.arrange(plot_1, plot_2, plot_3, plot_4, plot_5, plot_6, ncol = 2)
dev.off()

class(plot_1)




# WIND ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_7 <- read.table("WIND_1.txt", sep = "")
DATA_7[2:9] <- lapply(DATA_7[2:9], as.numeric)

#Select variable
DATA_7 <- DATA_7[,c(1,2,4)]

#Plot_7
plot_7 <-  ggplot(DATA_7, aes(x = DATA_7$K, y = DATA_7$KNI))+ 
  geom_point(color = "deepskyblue", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Wind power (2000-2009)", 
        y  = "KNI", x = "Knowledge accumulation" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_7$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_7$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_8 <- read.table("WIND_2.txt", sep = "")
DATA_8[2:9] <- lapply(DATA_8[2:9], as.numeric)

#Select variable
DATA_8 <- DATA_8[,c(1,2,4)]


#Plot_8
plot_8 <-  ggplot(DATA_8, aes(x = DATA_8$K, y = DATA_8$KNI))+ 
  geom_point(color = "deepskyblue", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Wind power (2010-2019)", 
        y  = "KNI", x = "Knowledge accumulation" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_8$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +  
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_8$Region)))




# THERMAL ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_9 <- read.table("THERMAL_1.txt", sep = "")
DATA_9[2:9] <- lapply(DATA_9[2:9], as.numeric)

#Select variable
DATA_9 <- DATA_9[,c(1,2,4)]

#Plot_9
plot_9 <-  ggplot(DATA_9, aes(x = DATA_9$K, y = DATA_9$KNI))+ 
  geom_point(color = "darkorange", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Concentrated solar power (CSP) (2000-2009)", 
        y  = "KNI", x = "Knowledge accumulation" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_9$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_9$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_10 <- read.table("THERMAL_2.txt", sep = "")
DATA_10[2:9] <- lapply(DATA_10[2:9], as.numeric)

#Select variable
DATA_10 <- DATA_10[,c(1,2,4)]


#Plot_10
plot_10 <-  ggplot(DATA_10, aes(x = DATA_10$K, y = DATA_10$KNI))+ 
  geom_point(color = "darkorange", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Concentrated solar power (CSP) (2010-2019)", 
        y  = "KNI", x = "Knowledge accumulation" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_10$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_10$Region)))




# OCEAN ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_11 <- read.table("OCEAN_1.txt", sep = "")
DATA_11[2:9] <- lapply(DATA_11[2:9], as.numeric)

#Select variable
DATA_11 <- DATA_11[,c(1,2,4)]

#Plot_11
plot_11 <-  ggplot(DATA_11, aes(x = DATA_11$K, y = DATA_11$KNI))+ 
  geom_point(color = "blueviolet", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Ocean energy (2000-2009)", 
        y  = "KNI", x = "Knowledge accumulation" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_11$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_11$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_12 <- read.table("OCEAN_2.txt", sep = "")
DATA_12[2:9] <- lapply(DATA_12[2:9], as.numeric)

#Select variable
DATA_12 <- DATA_12[,c(1,2,4)]


#Plot_12
plot_12 <-  ggplot(DATA_12, aes(x = DATA_12$K, y = DATA_12$KNI))+ 
  geom_point(color = "blueviolet", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Ocean energy (2010-2019)", 
        y  = "KNI", x = "Knowledge accumulation" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_12$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +  
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_12$Region)))



setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Plots")
png("KNI_K_2.png", width = 800, height = 1100)
grid.arrange(plot_7, plot_8, plot_9, plot_10, plot_11, plot_12, ncol = 2, nrow = 3)
dev.off()




###############################################################################


# - - - -  - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - 
#SCATTERPLOTS ----- KNI & ELECTRICITY FF (C)

# HYDRO ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_1 <- read.table("HYDRO_1.txt", sep = "")
DATA_1[2:9] <- lapply(DATA_1[2:9], as.numeric)

#Select variable
DATA_1 <- DATA_1[,c(1,2,5)]

#Plot_1
plot_1 <-  ggplot(DATA_1, aes(x = DATA_1$C, y = DATA_1$KNI))+ 
  geom_point(color = "blue3", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Hydropower (2000-2009)", 
        y  = "KNI", x = "Technological and infrastructural carbon lock-in" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_1$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +  
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_1$Region)))



print(plot_1)

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_2 <- read.table("HYDRO_2.txt", sep = "")
DATA_2[2:9] <- lapply(DATA_2[2:9], as.numeric)

#Select variable
DATA_2 <- DATA_2[,c(1,2,5)]


#Plot_2
plot_2 <-  ggplot(DATA_2, aes(x = DATA_2$C, y = DATA_2$KNI))+ 
  geom_point(color = "blue3", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Hydropower (2010-2019)", 
        y  = "KNI", x = "Technological and infrastructural carbon lock-in" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_2$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +  
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_2$Region)))


print(plot_2)


# GEO ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_3 <- read.table("GEO_1.txt", sep = "")
DATA_3[2:9] <- lapply(DATA_3[2:9], as.numeric)

#Select variable
DATA_3 <- DATA_3[,c(1,2,5)]

#Plot_3
plot_3 <-  ggplot(DATA_3, aes(x = DATA_3$C, y = DATA_3$KNI))+ 
  geom_point(color = "sienna3", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Geothermal power (2000-2009)", 
        y  = "KNI", x = "Technological and infrastructural carbon lock-in" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_3$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm")) +
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_3$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_4 <- read.table("GEO_2.txt", sep = "")
DATA_4[2:9] <- lapply(DATA_4[2:9], as.numeric)

#Select variable
DATA_4 <- DATA_4[,c(1,2,5)]

#Plot_4
plot_4 <-  ggplot(DATA_4, aes(x = DATA_4$C, y = DATA_4$KNI))+ 
  geom_point(color = "sienna3", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Geothermal power (2010-2019)", 
        y  = "KNI", x = "Technological and infrastructural carbon lock-in" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_4$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_4$Region)))




# PV ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_5 <- read.table("PV_1.txt", sep = "")
DATA_5[2:9] <- lapply(DATA_5[2:9], as.numeric)

#Select variable
DATA_5 <- DATA_5[,c(1,2,5)]

#Plot_5
plot_5 <-  ggplot(DATA_5, aes(x = DATA_5$C, y = DATA_5$KNI))+ 
  geom_point(color = "yellow", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Solar photovoltaics (PV) (2000-2009)", 
        y  = "KNI", x = "Technological and infrastructural carbon lock-in" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_5$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_5$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_6 <- read.table("PV_2.txt", sep = "")
DATA_6[2:9] <- lapply(DATA_6[2:9], as.numeric)

#Select variable
DATA_6 <- DATA_6[,c(1,2,5)]


#Plot_6
plot_6 <-  ggplot(DATA_6, aes(x = DATA_6$C, y = DATA_6$KNI))+ 
  geom_point(color = "yellow", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Solar photovoltaics (PV) (2010-2019)", 
        y  = "KNI", x = "Technological and infrastructural carbon lock-in" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_6$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_6$Region)))



setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Plots")
png("KNI_C_1.png", width = 800, height = 1100)
grid <- grid.arrange(plot_1, plot_2, plot_3, plot_4, plot_5, plot_6, ncol = 2)
dev.off()

class(plot_1)




# WIND ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_7 <- read.table("WIND_1.txt", sep = "")
DATA_7[2:9] <- lapply(DATA_7[2:9], as.numeric)

#Select variable
DATA_7 <- DATA_7[,c(1,2,5)]

#Plot_7
plot_7 <-  ggplot(DATA_7, aes(x = DATA_7$C, y = DATA_7$KNI))+ 
  geom_point(color = "deepskyblue", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Wind power (2000-2009)", 
        y  = "KNI", x = "Technological and infrastructural carbon lock-in" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_7$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_7$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_8 <- read.table("WIND_2.txt", sep = "")
DATA_8[2:9] <- lapply(DATA_8[2:9], as.numeric)

#Select variable
DATA_8 <- DATA_8[,c(1,2,5)]


#Plot_8
plot_8 <-  ggplot(DATA_8, aes(x = DATA_8$C, y = DATA_8$KNI))+ 
  geom_point(color = "deepskyblue", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Wind power (2010-2019)", 
        y  = "KNI", x = "Technological and infrastructural carbon lock-in" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_8$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +  
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_8$Region)))




# THERMAL ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_9 <- read.table("THERMAL_1.txt", sep = "")
DATA_9[2:9] <- lapply(DATA_9[2:9], as.numeric)

#Select variable
DATA_9 <- DATA_9[,c(1,2,5)]

#Plot_9
plot_9 <-  ggplot(DATA_9, aes(x = DATA_9$C, y = DATA_9$KNI))+ 
  geom_point(color = "darkorange", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Concentrated solar power (CSP) (2000-2009)", 
        y  = "KNI", x = "Technological and infrastructural carbon lock-in" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_9$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_9$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_10 <- read.table("THERMAL_2.txt", sep = "")
DATA_10[2:9] <- lapply(DATA_10[2:9], as.numeric)

#Select variable
DATA_10 <- DATA_10[,c(1,2,5)]


#Plot_10
plot_10 <-  ggplot(DATA_10, aes(x = DATA_10$C, y = DATA_10$KNI))+ 
  geom_point(color = "darkorange", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Concentrated solar power (CSP) (2010-2019)", 
        y  = "KNI", x = "Technological and infrastructural carbon lock-in" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_10$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_10$Region)))




# OCEAN ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_11 <- read.table("OCEAN_1.txt", sep = "")
DATA_11[2:9] <- lapply(DATA_11[2:9], as.numeric)

#Select variable
DATA_11 <- DATA_11[,c(1,2,5)]

#Plot_11
plot_11 <-  ggplot(DATA_11, aes(x = DATA_11$C, y = DATA_11$KNI))+ 
  geom_point(color = "blueviolet", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Ocean energy (2000-2009)", 
        y  = "KNI", x = "Technological and infrastructural carbon lock-in" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_11$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_11$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_12 <- read.table("OCEAN_2.txt", sep = "")
DATA_12[2:9] <- lapply(DATA_12[2:9], as.numeric)

#Select variable
DATA_12 <- DATA_12[,c(1,2,5)]


#Plot_12
plot_12 <-  ggplot(DATA_12, aes(x = DATA_12$C, y = DATA_12$KNI))+ 
  geom_point(color = "blueviolet", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Ocean energy (2010-2019)", 
        y  = "KNI", x = "Technological and infrastructural carbon lock-in" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_12$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +  
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_12$Region)))



setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Plots")
png("KNI_C_2.png", width = 800, height = 1100)
grid.arrange(plot_7, plot_8, plot_9, plot_10, plot_11, plot_12, ncol = 2, nrow = 3)
dev.off()









###############################################################################


# - - - -  - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - 
#SCATTERPLOTS ----- KNI & CL

# HYDRO ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_1 <- read.table("HYDRO_1.txt", sep = "")
DATA_1[2:9] <- lapply(DATA_1[2:9], as.numeric)

#Select variable
DATA_1 <- DATA_1[,c(1,2,6)]

#Plot_1
plot_1 <-  ggplot(DATA_1, aes(x = DATA_1$CL, y = DATA_1$KNI))+ 
  geom_point(color = "blue3", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Hydropower (2000-2009)", 
        y  = "KNI", x = "Access to complementary knowledge" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_1$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +  
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_1$Region)))



print(plot_1)

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_2 <- read.table("HYDRO_2.txt", sep = "")
DATA_2[2:9] <- lapply(DATA_2[2:9], as.numeric)

#Select variable
DATA_2 <- DATA_2[,c(1,2,6)]


#Plot_2
plot_2 <-  ggplot(DATA_2, aes(x = DATA_2$CL, y = DATA_2$KNI))+ 
  geom_point(color = "blue3", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Hydropower (2010-2019)", 
        y  = "KNI", x = "Access to complementary knowledge" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_2$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +  
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_2$Region)))


print(plot_2)


# GEO ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_3 <- read.table("GEO_1.txt", sep = "")
DATA_3[2:9] <- lapply(DATA_3[2:9], as.numeric)

#Select variable
DATA_3 <- DATA_3[,c(1,2,6)]

#Plot_3
plot_3 <-  ggplot(DATA_3, aes(x = DATA_3$CL, y = DATA_3$KNI))+ 
  geom_point(color = "sienna3", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Geothermal power (2000-2009)", 
        y  = "KNI", x = "Access to complementary knowledge" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_3$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm")) +
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_3$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_4 <- read.table("GEO_2.txt", sep = "")
DATA_4[2:9] <- lapply(DATA_4[2:9], as.numeric)

#Select variable
DATA_4 <- DATA_4[,c(1,2,6)]

#Plot_4
plot_4 <-  ggplot(DATA_4, aes(x = DATA_4$CL, y = DATA_4$KNI))+ 
  geom_point(color = "sienna3", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Geothermal power (2010-2019)", 
        y  = "KNI", x = "Access to complementary knowledge" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_4$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_4$Region)))




# PV ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_5 <- read.table("PV_1.txt", sep = "")
DATA_5[2:9] <- lapply(DATA_5[2:9], as.numeric)

#Select variable
DATA_5 <- DATA_5[,c(1,2,6)]

#Plot_5
plot_5 <-  ggplot(DATA_5, aes(x = DATA_5$CL, y = DATA_5$KNI))+ 
  geom_point(color = "yellow", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Solar photovoltaics (PV) (2000-2009)", 
        y  = "KNI", x = "Access to complementary knowledge" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_5$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_5$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_6 <- read.table("PV_2.txt", sep = "")
DATA_6[2:9] <- lapply(DATA_6[2:9], as.numeric)

#Select variable
DATA_6 <- DATA_6[,c(1,2,6)]


#Plot_6
plot_6 <-  ggplot(DATA_6, aes(x = DATA_6$CL, y = DATA_6$KNI))+ 
  geom_point(color = "yellow", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Solar photovoltaics (PV) (2010-2019)", 
        y  = "KNI", x = "Access to complementary knowledge" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_6$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_6$Region)))



setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Plots")
png("KNI_CL_1.png", width = 800, height = 1100)
grid <- grid.arrange(plot_1, plot_2, plot_3, plot_4, plot_5, plot_6, ncol = 2)
dev.off()

class(plot_1)




# WIND ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_7 <- read.table("WIND_1.txt", sep = "")
DATA_7[2:9] <- lapply(DATA_7[2:9], as.numeric)

#Select variable
DATA_7 <- DATA_7[,c(1,2,6)]

#Plot_7
plot_7 <-  ggplot(DATA_7, aes(x = DATA_7$CL, y = DATA_7$KNI))+ 
  geom_point(color = "deepskyblue", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Wind power (2000-2009)", 
        y  = "KNI", x = "Access to complementary knowledge" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_7$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_7$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_8 <- read.table("WIND_2.txt", sep = "")
DATA_8[2:9] <- lapply(DATA_8[2:9], as.numeric)

#Select variable
DATA_8 <- DATA_8[,c(1,2,6)]


#Plot_8
plot_8 <-  ggplot(DATA_8, aes(x = DATA_8$CL, y = DATA_8$KNI))+ 
  geom_point(color = "deepskyblue", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Wind power (2010-2019)", 
        y  = "KNI", x = "Access to complementary knowledge" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_8$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +  
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_8$Region)))




# THERMAL ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_9 <- read.table("THERMAL_1.txt", sep = "")
DATA_9[2:9] <- lapply(DATA_9[2:9], as.numeric)

#Select variable
DATA_9 <- DATA_9[,c(1,2,6)]

#Plot_9
plot_9 <-  ggplot(DATA_9, aes(x = DATA_9$CL, y = DATA_9$KNI))+ 
  geom_point(color = "darkorange", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Concentrated solar power (CSP) (2000-2009)", 
        y  = "KNI", x = "Access to complementary knowledge" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_9$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_9$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_10 <- read.table("THERMAL_2.txt", sep = "")
DATA_10[2:9] <- lapply(DATA_10[2:9], as.numeric)

#Select variable
DATA_10 <- DATA_10[,c(1,2,6)]


#Plot_10
plot_10 <-  ggplot(DATA_10, aes(x = DATA_10$CL, y = DATA_10$KNI))+ 
  geom_point(color = "darkorange", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Concentrated solar power (CSP) (2010-2019)", 
        y  = "KNI", x = "Access to complementary knowledge" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_10$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_10$Region)))




# OCEAN ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_11 <- read.table("OCEAN_1.txt", sep = "")
DATA_11[2:9] <- lapply(DATA_11[2:9], as.numeric)

#Select variable
DATA_11 <- DATA_11[,c(1,2,6)]

#Plot_11
plot_11 <-  ggplot(DATA_11, aes(x = DATA_11$CL, y = DATA_11$KNI))+ 
  geom_point(color = "blueviolet", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Ocean energy (2000-2009)", 
        y  = "KNI", x = "Access to complementary knowledge" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_11$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_11$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_12 <- read.table("OCEAN_2.txt", sep = "")
DATA_12[2:9] <- lapply(DATA_12[2:9], as.numeric)

#Select variable
DATA_12 <- DATA_12[,c(1,2,6)]


#Plot_12
plot_12 <-  ggplot(DATA_12, aes(x = DATA_12$CL, y = DATA_12$KNI))+ 
  geom_point(color = "blueviolet", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Ocean energy (2010-2019)", 
        y  = "KNI", x = "Access to complementary knowledge" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_12$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +  
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_12$Region)))



setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Plots")
png("KNI_CL_2.png", width = 800, height = 1100)
grid.arrange(plot_7, plot_8, plot_9, plot_10, plot_11, plot_12, ncol = 2, nrow = 3)
dev.off()






###############################################################################


# - - - -  - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - 
#SCATTERPLOTS ----- KNI & GDP

# HYDRO ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_1 <- read.table("HYDRO_1.txt", sep = "")
DATA_1[2:9] <- lapply(DATA_1[2:9], as.numeric)

#Select variable
DATA_1 <- DATA_1[,c(1,2,7)]

#Plot_1
plot_1 <-  ggplot(DATA_1, aes(x = DATA_1$GDP, y = DATA_1$KNI))+ 
  geom_point(color = "blue3", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Hydropower (2000-2009)", 
        y  = "KNI", x = "GDP" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_1$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +  
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_1$Region)))



print(plot_1)

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_2 <- read.table("HYDRO_2.txt", sep = "")
DATA_2[2:9] <- lapply(DATA_2[2:9], as.numeric)

#Select variable
DATA_2 <- DATA_2[,c(1,2,7)]


#Plot_2
plot_2 <-  ggplot(DATA_2, aes(x = DATA_2$GDP, y = DATA_2$KNI))+ 
  geom_point(color = "blue3", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Hydropower (2010-2019)", 
        y  = "KNI", x = "GDP" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_2$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +  
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_2$Region)))


print(plot_2)


# GEO ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_3 <- read.table("GEO_1.txt", sep = "")
DATA_3[2:9] <- lapply(DATA_3[2:9], as.numeric)

#Select variable
DATA_3 <- DATA_3[,c(1,2,7)]

#Plot_3
plot_3 <-  ggplot(DATA_3, aes(x = DATA_3$GDP, y = DATA_3$KNI))+ 
  geom_point(color = "sienna3", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Geothermal power (2000-2009)", 
        y  = "KNI", x = "GDP" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_3$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm")) +
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_3$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_4 <- read.table("GEO_2.txt", sep = "")
DATA_4[2:9] <- lapply(DATA_4[2:9], as.numeric)

#Select variable
DATA_4 <- DATA_4[,c(1,2,7)]

#Plot_4
plot_4 <-  ggplot(DATA_4, aes(x = DATA_4$GDP, y = DATA_4$KNI))+ 
  geom_point(color = "sienna3", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Geothermal power (2010-2019)", 
        y  = "KNI", x = "GDP" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_4$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_4$Region)))




# PV ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_5 <- read.table("PV_1.txt", sep = "")
DATA_5[2:9] <- lapply(DATA_5[2:9], as.numeric)

#Select variable
DATA_5 <- DATA_5[,c(1,2,7)]

#Plot_5
plot_5 <-  ggplot(DATA_5, aes(x = DATA_5$GDP, y = DATA_5$KNI))+ 
  geom_point(color = "yellow", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Solar photovoltaics (PV) (2000-2009)", 
        y  = "KNI", x = "GDP" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_5$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_5$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_6 <- read.table("PV_2.txt", sep = "")
DATA_6[2:9] <- lapply(DATA_6[2:9], as.numeric)

#Select variable
DATA_6 <- DATA_6[,c(1,2,7)]


#Plot_6
plot_6 <-  ggplot(DATA_6, aes(x = DATA_6$GDP, y = DATA_6$KNI))+ 
  geom_point(color = "yellow", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Solar photovoltaics (PV) (2010-2019)", 
        y  = "KNI", x = "GDP" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_6$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_6$Region)))



setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Plots")
png("KNI_GDP_1.png", width = 800, height = 1100)
grid <- grid.arrange(plot_1, plot_2, plot_3, plot_4, plot_5, plot_6, ncol = 2)
dev.off()

class(plot_1)




# WIND ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_7 <- read.table("WIND_1.txt", sep = "")
DATA_7[2:9] <- lapply(DATA_7[2:9], as.numeric)

#Select variable
DATA_7 <- DATA_7[,c(1,2,7)]

#Plot_7
plot_7 <-  ggplot(DATA_7, aes(x = DATA_7$GDP, y = DATA_7$KNI))+ 
  geom_point(color = "deepskyblue", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Wind power (2000-2009)", 
        y  = "KNI", x = "GDP" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_7$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_7$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_8 <- read.table("WIND_2.txt", sep = "")
DATA_8[2:9] <- lapply(DATA_8[2:9], as.numeric)

#Select variable
DATA_8 <- DATA_8[,c(1,2,7)]


#Plot_8
plot_8 <-  ggplot(DATA_8, aes(x = DATA_8$GDP, y = DATA_8$KNI))+ 
  geom_point(color = "deepskyblue", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Wind power (2010-2019)", 
        y  = "KNI", x = "GDP" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_8$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +  
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_8$Region)))




# THERMAL ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_9 <- read.table("THERMAL_1.txt", sep = "")
DATA_9[2:9] <- lapply(DATA_9[2:9], as.numeric)

#Select variable
DATA_9 <- DATA_9[,c(1,2,7)]

#Plot_9
plot_9 <-  ggplot(DATA_9, aes(x = DATA_9$GDP, y = DATA_9$KNI))+ 
  geom_point(color = "darkorange", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Concentrated solar power (CSP) (2000-2009)", 
        y  = "KNI", x = "GDP" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_9$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_9$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_10 <- read.table("THERMAL_2.txt", sep = "")
DATA_10[2:9] <- lapply(DATA_10[2:9], as.numeric)

#Select variable
DATA_10 <- DATA_10[,c(1,2,7)]


#Plot_10
plot_10 <-  ggplot(DATA_10, aes(x = DATA_10$GDP, y = DATA_10$KNI))+ 
  geom_point(color = "darkorange", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Concentrated solar power (CSP) (2010-2019)", 
        y  = "KNI", x = "GDP" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_10$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_10$Region)))




# OCEAN ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_11 <- read.table("OCEAN_1.txt", sep = "")
DATA_11[2:9] <- lapply(DATA_11[2:9], as.numeric)

#Select variable
DATA_11 <- DATA_11[,c(1,2,7)]

#Plot_11
plot_11 <-  ggplot(DATA_11, aes(x = DATA_11$GDP, y = DATA_11$KNI))+ 
  geom_point(color = "blueviolet", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Ocean energy (2000-2009)", 
        y  = "KNI", x = "GDP" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_11$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_11$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_12 <- read.table("OCEAN_2.txt", sep = "")
DATA_12[2:9] <- lapply(DATA_12[2:9], as.numeric)

#Select variable
DATA_12 <- DATA_12[,c(1,2,7)]


#Plot_12
plot_12 <-  ggplot(DATA_12, aes(x = DATA_12$GDP, y = DATA_12$KNI))+ 
  geom_point(color = "blueviolet", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Ocean energy (2010-2019)", 
        y  = "KNI", x = "GDP" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_12$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +  
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_12$Region)))



setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Plots")
png("KNI_GDP_2.png", width = 800, height = 1100)
grid.arrange(plot_7, plot_8, plot_9, plot_10, plot_11, plot_12, ncol = 2, nrow = 3)
dev.off()





###############################################################################


# - - - -  - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - 
#SCATTERPLOTS ----- KNI & P

# HYDRO ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_1 <- read.table("HYDRO_1.txt", sep = "")
DATA_1[2:9] <- lapply(DATA_1[2:9], as.numeric)

#Select variable
DATA_1 <- DATA_1[,c(1,2,8)]

#Plot_1
plot_1 <-  ggplot(DATA_1, aes(x = DATA_1$P, y = DATA_1$KNI))+ 
  geom_point(color = "blue3", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Hydropower (2000-2009)", 
        y  = "KNI", x = "Population" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_1$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +  
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_1$Region)))



print(plot_1)

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_2 <- read.table("HYDRO_2.txt", sep = "")
DATA_2[2:9] <- lapply(DATA_2[2:9], as.numeric)

#Select variable
DATA_2 <- DATA_2[,c(1,2,8)]


#Plot_2
plot_2 <-  ggplot(DATA_2, aes(x = DATA_2$P, y = DATA_2$KNI))+ 
  geom_point(color = "blue3", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Hydropower (2010-2019)", 
        y  = "KNI", x = "Population" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_2$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +  
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_2$Region)))


print(plot_2)


# GEO ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_3 <- read.table("GEO_1.txt", sep = "")
DATA_3[2:9] <- lapply(DATA_3[2:9], as.numeric)

#Select variable
DATA_3 <- DATA_3[,c(1,2,8)]

#Plot_3
plot_3 <-  ggplot(DATA_3, aes(x = DATA_3$P, y = DATA_3$KNI))+ 
  geom_point(color = "sienna3", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Geothermal power (2000-2009)", 
        y  = "KNI", x = "Population" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_3$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm")) +
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_3$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_4 <- read.table("GEO_2.txt", sep = "")
DATA_4[2:9] <- lapply(DATA_4[2:9], as.numeric)

#Select variable
DATA_4 <- DATA_4[,c(1,2,8)]

#Plot_4
plot_4 <-  ggplot(DATA_4, aes(x = DATA_4$P, y = DATA_4$KNI))+ 
  geom_point(color = "sienna3", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Geothermal power (2010-2019)", 
        y  = "KNI", x = "Population" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_4$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_4$Region)))




# PV ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_5 <- read.table("PV_1.txt", sep = "")
DATA_5[2:9] <- lapply(DATA_5[2:9], as.numeric)

#Select variable
DATA_5 <- DATA_5[,c(1,2,8)]

#Plot_5
plot_5 <-  ggplot(DATA_5, aes(x = DATA_5$P, y = DATA_5$KNI))+ 
  geom_point(color = "yellow", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Solar photovoltaics (PV) (2000-2009)", 
        y  = "KNI", x = "Population" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_5$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_5$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_6 <- read.table("PV_2.txt", sep = "")
DATA_6[2:9] <- lapply(DATA_6[2:9], as.numeric)

#Select variable
DATA_6 <- DATA_6[,c(1,2,8)]


#Plot_6
plot_6 <-  ggplot(DATA_6, aes(x = DATA_6$P, y = DATA_6$KNI))+ 
  geom_point(color = "yellow", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Solar photovoltaics (PV) (2010-2019)", 
        y  = "KNI", x = "Population" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_6$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_6$Region)))



setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Plots")
png("KNI_P_1.png", width = 800, height = 1100)
grid <- grid.arrange(plot_1, plot_2, plot_3, plot_4, plot_5, plot_6, ncol = 2)
dev.off()

class(plot_1)




# WIND ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_7 <- read.table("WIND_1.txt", sep = "")
DATA_7[2:9] <- lapply(DATA_7[2:9], as.numeric)

#Select variable
DATA_7 <- DATA_7[,c(1,2,8)]

#Plot_7
plot_7 <-  ggplot(DATA_7, aes(x = DATA_7$P, y = DATA_7$KNI))+ 
  geom_point(color = "deepskyblue", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Wind power (2000-2009)", 
        y  = "KNI", x = "Population" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_7$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_7$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_8 <- read.table("WIND_2.txt", sep = "")
DATA_8[2:9] <- lapply(DATA_8[2:9], as.numeric)

#Select variable
DATA_8 <- DATA_8[,c(1,2,8)]


#Plot_8
plot_8 <-  ggplot(DATA_8, aes(x = DATA_8$P, y = DATA_8$KNI))+ 
  geom_point(color = "deepskyblue", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Wind power (2010-2019)", 
        y  = "KNI", x = "Population" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_8$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +  
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_8$Region)))




# THERMAL ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_9 <- read.table("THERMAL_1.txt", sep = "")
DATA_9[2:9] <- lapply(DATA_9[2:9], as.numeric)

#Select variable
DATA_9 <- DATA_9[,c(1,2,8)]

#Plot_9
plot_9 <-  ggplot(DATA_9, aes(x = DATA_9$P, y = DATA_9$KNI))+ 
  geom_point(color = "darkorange", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Concentrated solar power (CSP) (2000-2009)", 
        y  = "KNI", x = "Population" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_9$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_9$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_10 <- read.table("THERMAL_2.txt", sep = "")
DATA_10[2:9] <- lapply(DATA_10[2:9], as.numeric)

#Select variable
DATA_10 <- DATA_10[,c(1,2,8)]


#Plot_10
plot_10 <-  ggplot(DATA_10, aes(x = DATA_10$P, y = DATA_10$KNI))+ 
  geom_point(color = "darkorange", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Concentrated solar power (CSP) (2010-2019)", 
        y  = "KNI", x = "Population" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_10$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_10$Region)))




# OCEAN ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_11 <- read.table("OCEAN_1.txt", sep = "")
DATA_11[2:9] <- lapply(DATA_11[2:9], as.numeric)

#Select variable
DATA_11 <- DATA_11[,c(1,2,8)]

#Plot_11
plot_11 <-  ggplot(DATA_11, aes(x = DATA_11$P, y = DATA_11$KNI))+ 
  geom_point(color = "blueviolet", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Ocean energy (2000-2009)", 
        y  = "KNI", x = "Population" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_11$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_11$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_12 <- read.table("OCEAN_2.txt", sep = "")
DATA_12[2:9] <- lapply(DATA_12[2:9], as.numeric)

#Select variable
DATA_12 <- DATA_12[,c(1,2,8)]


#Plot_12
plot_12 <-  ggplot(DATA_12, aes(x = DATA_12$P, y = DATA_12$KNI))+ 
  geom_point(color = "blueviolet", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Ocean energy (2010-2019)", 
        y  = "KNI", x = "Population" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_12$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +  
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_12$Region)))



setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Plots")
png("KNI_P_2.png", width = 800, height = 1100)
grid.arrange(plot_7, plot_8, plot_9, plot_10, plot_11, plot_12, ncol = 2, nrow = 3)
dev.off()






###############################################################################


# - - - -  - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - 
#SCATTERPLOTS ----- KNI & M

# HYDRO ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_1 <- read.table("HYDRO_1.txt", sep = "")
DATA_1[2:9] <- lapply(DATA_1[2:9], as.numeric)

#Select variable
DATA_1 <- DATA_1[,c(1,2,9)]

#Plot_1
plot_1 <-  ggplot(DATA_1, aes(x = DATA_1$M, y = DATA_1$KNI))+ 
  geom_point(color = "blue3", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Hydropower (2000-2009)", 
        y  = "KNI", x = "Renewable energy market" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_1$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +  
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_1$Region)))



print(plot_1)

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_2 <- read.table("HYDRO_2.txt", sep = "")
DATA_2[2:9] <- lapply(DATA_2[2:9], as.numeric)

#Select variable
DATA_2 <- DATA_2[,c(1,2,9)]


#Plot_2
plot_2 <-  ggplot(DATA_2, aes(x = DATA_2$M, y = DATA_2$KNI))+ 
  geom_point(color = "blue3", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Hydropower (2010-2019)", 
        y  = "KNI", x = "Renewable energy market" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_2$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +  
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_2$Region)))


print(plot_2)


# GEO ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_3 <- read.table("GEO_1.txt", sep = "")
DATA_3[2:9] <- lapply(DATA_3[2:9], as.numeric)

#Select variable
DATA_3 <- DATA_3[,c(1,2,9)]

#Plot_3
plot_3 <-  ggplot(DATA_3, aes(x = DATA_3$M, y = DATA_3$KNI))+ 
  geom_point(color = "sienna3", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Geothermal power (2000-2009)", 
        y  = "KNI", x = "Renewable energy market" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_3$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm")) +
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_3$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_4 <- read.table("GEO_2.txt", sep = "")
DATA_4[2:9] <- lapply(DATA_4[2:9], as.numeric)

#Select variable
DATA_4 <- DATA_4[,c(1,2,9)]

#Plot_4
plot_4 <-  ggplot(DATA_4, aes(x = DATA_4$M, y = DATA_4$KNI))+ 
  geom_point(color = "sienna3", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Geothermal power (2010-2019)", 
        y  = "KNI", x = "Renewable energy market" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_4$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_4$Region)))




# PV ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_5 <- read.table("PV_1.txt", sep = "")
DATA_5[2:9] <- lapply(DATA_5[2:9], as.numeric)

#Select variable
DATA_5 <- DATA_5[,c(1,2,9)]

#Plot_5
plot_5 <-  ggplot(DATA_5, aes(x = DATA_5$M, y = DATA_5$KNI))+ 
  geom_point(color = "yellow", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Solar photovoltaics (PV) (2000-2009)", 
        y  = "KNI", x = "Renewable energy market" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_5$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_5$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_6 <- read.table("PV_2.txt", sep = "")
DATA_6[2:9] <- lapply(DATA_6[2:9], as.numeric)

#Select variable
DATA_6 <- DATA_6[,c(1,2,9)]


#Plot_6
plot_6 <-  ggplot(DATA_6, aes(x = DATA_6$M, y = DATA_6$KNI))+ 
  geom_point(color = "yellow", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Solar photovoltaics (PV) (2010-2019)", 
        y  = "KNI", x = "Renewable energy market" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_6$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_6$Region)))



setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Plots")
png("KNI_M_1.png", width = 800, height = 1100)
grid <- grid.arrange(plot_1, plot_2, plot_3, plot_4, plot_5, plot_6, ncol = 2)
dev.off()

class(plot_1)




# WIND ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_7 <- read.table("WIND_1.txt", sep = "")
DATA_7[2:9] <- lapply(DATA_7[2:9], as.numeric)

#Select variable
DATA_7 <- DATA_7[,c(1,2,9)]

#Plot_7
plot_7 <-  ggplot(DATA_7, aes(x = DATA_7$M, y = DATA_7$KNI))+ 
  geom_point(color = "deepskyblue", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Wind power (2000-2009)", 
        y  = "KNI", x = "Renewable energy market" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_7$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_7$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_8 <- read.table("WIND_2.txt", sep = "")
DATA_8[2:9] <- lapply(DATA_8[2:9], as.numeric)

#Select variable
DATA_8 <- DATA_8[,c(1,2,9)]


#Plot_8
plot_8 <-  ggplot(DATA_8, aes(x = DATA_8$M, y = DATA_8$KNI))+ 
  geom_point(color = "deepskyblue", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Wind power (2010-2019)", 
        y  = "KNI", x = "Renewable energy market" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_8$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +  
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_8$Region)))




# THERMAL ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_9 <- read.table("THERMAL_1.txt", sep = "")
DATA_9[2:9] <- lapply(DATA_9[2:9], as.numeric)

#Select variable
DATA_9 <- DATA_9[,c(1,2,9)]

#Plot_9
plot_9 <-  ggplot(DATA_9, aes(x = DATA_9$M, y = DATA_9$KNI))+ 
  geom_point(color = "darkorange", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Concentrated solar power (CSP) (2000-2009)", 
        y  = "KNI", x = "Renewable energy market" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_9$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_9$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_10 <- read.table("THERMAL_2.txt", sep = "")
DATA_10[2:9] <- lapply(DATA_10[2:9], as.numeric)

#Select variable
DATA_10 <- DATA_10[,c(1,2,9)]


#Plot_10
plot_10 <-  ggplot(DATA_10, aes(x = DATA_10$M, y = DATA_10$KNI))+ 
  geom_point(color = "darkorange", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Concentrated solar power (CSP) (2010-2019)", 
        y  = "KNI", x = "Renewable energy market" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_10$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_10$Region)))




# OCEAN ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_11 <- read.table("OCEAN_1.txt", sep = "")
DATA_11[2:9] <- lapply(DATA_11[2:9], as.numeric)

#Select variable
DATA_11 <- DATA_11[,c(1,2,9)]

#Plot_11
plot_11 <-  ggplot(DATA_11, aes(x = DATA_11$M, y = DATA_11$KNI))+ 
  geom_point(color = "blueviolet", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Ocean energy (2000-2009)", 
        y  = "KNI", x = "Renewable energy market" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_11$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +   
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_11$Region)))



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_12 <- read.table("OCEAN_2.txt", sep = "")
DATA_12[2:9] <- lapply(DATA_12[2:9], as.numeric)

#Select variable
DATA_12 <- DATA_12[,c(1,2,9)]


#Plot_12
plot_12 <-  ggplot(DATA_12, aes(x = DATA_12$M, y = DATA_12$KNI))+ 
  geom_point(color = "blueviolet", size = 0.8)  + 
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  labs (title = "Ocean energy (2010-2019)", 
        y  = "KNI", x = "Renewable energy market" , element_text(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5)) +
  geom_text(label = DATA_12$Region, size = 2.5, check_overlap = T, nudge_y = 0.02, colour = "gray28") +  
  theme(plot.margin=unit(c(0,0,1,0),"cm"))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(DATA_12$Region)))



setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Plots")
png("KNI_M_2.png", width = 800, height = 1100)
grid.arrange(plot_7, plot_8, plot_9, plot_10, plot_11, plot_12, ncol = 2, nrow = 3)
dev.off()



