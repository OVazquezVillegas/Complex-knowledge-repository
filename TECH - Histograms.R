
###################################
####                          #####
####       Visualizations     #####
####                          ##### 
###################################
 #Instructions: 
 #1. Change tech
 #2. Change color 
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
#HISTOGRAMS

# Data 1 ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_1 <- read.table("HYDRO_1.txt", sep = "")
DATA_1[2:9] <- lapply(DATA_1[2:9], as.numeric)

#Select variable
DATA_1 <- DATA_1[,c(1,2)]
hist(DATA_1$KNI)

# Change variable name
hist_1 <- hist(DATA_1$KNI, breaks = 50)
freq <- max(hist_1$counts)
breaks = hist_1$breaks


# hist_1
plot_1 <- ggplot(DATA_1,aes( x= DATA_1$KNI)) + 
  geom_histogram(color = "gray90" , fill = "blue3", breaks = breaks) + 
  annotate("text", x = max(DATA_1$KNI)-(max(DATA_1$KNI)*.10), y = freq,
           label = paste("mean = ", round(mean(DATA_1$KNI),2))) +
  annotate("text", x = max(DATA_1$KNI)-(max(DATA_1$KNI)*.10), y = freq*.92,
           label = paste("sd = ", round(sd(DATA_1$KNI), 2))) +
  annotate("text", x = max(DATA_1$KNI)-(max(DATA_1$KNI)*.10), y = freq*.84, 
           label = paste("N = ", length(DATA_1$KNI)))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  xlab ("Knowledge complexity index  (2000-2009)") + ylab ("Frequency") +
  theme(plot.margin=unit(c(1.5,1,0,0),"cm"))
  

print(plot_1)

# Data 2 ------
# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_2 <- read.table("HYDRO_2.txt", sep = "")
DATA_2[2:9] <- lapply(DATA_2[2:9], as.numeric)

#Select variable
DATA_2 <- DATA_2[,c(1,2)]
hist(DATA_2$KNI)

# Change variable name
hist_2 <- hist(DATA_2$KNI, breaks = 50)
freq <- max(hist_2$counts)
breaks = hist_2$breaks


# histo_2
plot_2 <- ggplot(DATA_2,aes( x= DATA_2$KNI)) + 
  geom_histogram(color = "gray90" , fill = "blue3", breaks = breaks) + 
  annotate("text", x = max(DATA_2$KNI)-(max(DATA_2$KNI)*.10), y = freq,
           label = paste("mean = ", round(mean(DATA_2$KNI),2))) +
  annotate("text", x = max(DATA_2$KNI)-(max(DATA_2$KNI)*.10), y = freq*.92,
           label = paste("sd = ", round(sd(DATA_2$KNI), 2))) +
  annotate("text", x = max(DATA_2$KNI)-(max(DATA_2$KNI)*.10), y = freq*.84, 
           label = paste("N = ", length(DATA_2$KNI)))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  xlab ("Knowledge complexity index  (2010-2019)") + ylab ("Frequency") +
  theme(plot.margin=unit(c(1.5,0,0,1),"cm"))



# Data 3 ------
# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_3 <- read.table("HYDRO_1.txt", sep = "")
DATA_3[2:9] <- lapply(DATA_3[2:9], as.numeric)

#Select variable
DATA_3 <- DATA_3[,c(1,3)]
hist(DATA_3$RD)

# Change variable name
hist_3 <- hist(DATA_3$RD, breaks = 50)
freq <- max(hist_3$counts)
breaks = hist_3$breaks


# histo_3
plot_3 <- ggplot(DATA_3,aes( x= DATA_3$RD)) + 
  geom_histogram(color = "gray90" , fill = "blue3", breaks = breaks) + 
  annotate("text", x = max(DATA_3$RD)-(max(DATA_3$RD)*.10), y = freq,
           label = paste("mean = ", round(mean(DATA_3$RD),2))) +
  annotate("text", x = max(DATA_3$RD)-(max(DATA_3$RD)*.10), y = freq*.92,
           label = paste("sd = ", round(sd(DATA_3$RD), 2))) +
  annotate("text", x = max(DATA_3$RD)-(max(DATA_3$RD)*.10), y = freq*.84, 
           label = paste("N = ", length(DATA_3$RD)))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  xlab ("Scientific relatedness (2000-2009)") + ylab ("Frequency") +
  theme(plot.margin=unit(c(1.5,1,0,0),"cm"))




# Data 4 ------
# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_4 <- read.table("HYDRO_2.txt", sep = "")
DATA_4[2:9] <- lapply(DATA_4[2:9], as.numeric)

#Select variable
DATA_4 <- DATA_4[,c(1,3)]
hist(DATA_4$RD)

# Change variable name
hist_4 <- hist(DATA_4$RD, breaks = 50)
freq <- max(hist_4$counts)
breaks = hist_4$breaks


# histo_4
plot_4 <- ggplot(DATA_4,aes( x= DATA_4$RD)) + 
  geom_histogram(color = "gray90" , fill = "blue3", breaks = breaks) + 
  annotate("text", x = max(DATA_4$RD)-(max(DATA_4$RD)*.10), y = freq,
           label = paste("mean = ", round(mean(DATA_4$RD),2))) +
  annotate("text", x = max(DATA_4$RD)-(max(DATA_4$RD)*.10), y = freq*.92,
           label = paste("sd = ", round(sd(DATA_4$RD), 2))) +
  annotate("text", x = max(DATA_4$RD)-(max(DATA_4$RD)*.10), y = freq*.84, 
           label = paste("N = ", length(DATA_4$RD)))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  xlab ("Scientific relatedness (2010-2019)") + ylab ("Frequency") +
  theme(plot.margin=unit(c(1.5,0,0,1),"cm"))




# Data 5 ------
# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_5 <- read.table("HYDRO_1.txt", sep = "")
DATA_5[2:9] <- lapply(DATA_5[2:9], as.numeric)

#Select variable
DATA_5 <- DATA_5[,c(1,4)]
hist(DATA_5$K)

# Change variable name
hist_5 <- hist(DATA_5$K, breaks = 50)
freq <- max(hist_5$counts)
breaks = hist_5$breaks


# histo_5
plot_5 <- ggplot(DATA_5,aes( x= DATA_5$K)) + 
  geom_histogram(color = "gray90" , fill = "blue3", breaks = breaks) + 
  annotate("text", x = max(DATA_5$K)-(max(DATA_5$K)*.10), y = freq,
           label = paste("mean = ", round(mean(DATA_5$K),2))) +
  annotate("text", x = max(DATA_5$K)-(max(DATA_5$K)*.10), y = freq*.92,
           label = paste("sd = ", round(sd(DATA_5$K), 2))) +
  annotate("text", x = max(DATA_5$K)-(max(DATA_5$K)*.10), y = freq*.84, 
           label = paste("N = ", length(DATA_5$K)))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  xlab ("Knowledge accumulated  (2000-2009)") + ylab ("Frequency") +
  theme(plot.margin=unit(c(1.5,1,0,0),"cm"))





# Data 6 ------
# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_6 <- read.table("HYDRO_2.txt", sep = "")
DATA_6[2:9] <- lapply(DATA_6[2:9], as.numeric)

#Select variable
DATA_6 <- DATA_6[,c(1,4)]
hist(DATA_6$K)

# Change variable name
hist_6 <- hist(DATA_6$K, breaks = 50)
freq <- max(hist_6$counts)
breaks = hist_6$breaks


# histo 6
plot_6 <- ggplot(DATA_6,aes( x= DATA_6$K)) + 
  geom_histogram(color = "gray90" , fill = "blue3", breaks = breaks) + 
  annotate("text", x = max(DATA_6$K)-(max(DATA_6$K)*.10), y = freq,
           label = paste("mean = ", round(mean(DATA_6$K),2))) +
  annotate("text", x = max(DATA_6$K)-(max(DATA_6$K)*.10), y = freq*.92,
           label = paste("sd = ", round(sd(DATA_6$K), 2))) +
  annotate("text", x = max(DATA_6$K)-(max(DATA_6$K)*.10), y = freq*.84, 
           label = paste("N = ", length(DATA_6$K)))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  xlab ("Knowledge accumulated  (2010-2019)") + ylab ("Frequency") +
  theme(plot.margin=unit(c(1.5,0,0,1),"cm"))

# top, right, bottom, and left





# Data 7 ------

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_7 <- read.table("HYDRO_1.txt", sep = "")
DATA_7[2:9] <- lapply(DATA_7[2:9], as.numeric)

#Select variable
DATA_7 <- DATA_7[,c(1,5)]
hist(DATA_7$C)

# Change variable name
hist_7 <- hist(DATA_7$C, breaks = 50)
freq <- max(hist_7$counts)
breaks = hist_7$breaks


# hist_7
plot_7 <- ggplot(DATA_7,aes( x= DATA_7$C)) + 
  geom_histogram(color = "gray90" , fill = "blue3", breaks = breaks) + 
  annotate("text", x = max(DATA_7$C)-(max(DATA_7$C)*.10), y = freq,
           label = paste("mean = ", round(mean(DATA_7$C),2))) +
  annotate("text", x = max(DATA_7$C)-(max(DATA_7$C)*.10), y = freq*.92,
           label = paste("sd = ", round(sd(DATA_7$C), 2))) +
  annotate("text", x = max(DATA_7$C)-(max(DATA_7$C)*.10), y = freq*.84, 
           label = paste("N = ", length(DATA_7$C)))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  xlab ("Technological and infrastructural carbon lock-in (2000-2009)") + ylab ("Frequency") +
  theme(plot.margin=unit(c(1.5,1,0,0),"cm"))

print(plot_7)

# Data 8 ------
# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_8 <- read.table("HYDRO_2.txt", sep = "")
DATA_8[2:9] <- lapply(DATA_8[2:9], as.numeric)

#Select variable
DATA_8 <- DATA_8[,c(1,5)]
hist(DATA_8$C)

# Change variable name
hist_8 <- hist(DATA_8$C, breaks = 50)
freq <- max(hist_8$counts)
breaks = hist_8$breaks


# histo_8
plot_8 <- ggplot(DATA_8,aes( x= DATA_8$C)) + 
  geom_histogram(color = "gray90" , fill = "blue3", breaks = breaks) + 
  annotate("text", x = max(DATA_8$C)-(max(DATA_8$C)*.10), y = freq,
           label = paste("mean = ", round(mean(DATA_8$C),2))) +
  annotate("text", x = max(DATA_8$C)-(max(DATA_8$C)*.10), y = freq*.92,
           label = paste("sd = ", round(sd(DATA_8$C), 2))) +
  annotate("text", x = max(DATA_8$C)-(max(DATA_8$C)*.10), y = freq*.84, 
           label = paste("N = ", length(DATA_8$C)))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  xlab ("Technological and infrastructural carbon lock-in  (2010-2019)") + ylab ("Frequency") +
  theme(plot.margin=unit(c(1.5,0,0,1),"cm"))


setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Plots")
png("HYDRO_1.png", width = 800, height = 1050)
grid.arrange(plot_1, plot_2, plot_3, plot_4, plot_7, plot_8, plot_5, plot_6,  ncol = 2, nrow = 4)
dev.off()









# Data 9 ------
# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_9 <- read.table("HYDRO_1.txt", sep = "")
DATA_9[2:9] <- lapply(DATA_9[2:9], as.numeric)

#Select variable
DATA_9 <- DATA_9[,c(1,6)]
hist(DATA_9$CL)

# Change variable name
hist_9 <- hist(DATA_9$CL, breaks = 50)
freq <- max(hist_9$counts)
breaks = hist_9$breaks


# histo_9
plot_9 <- ggplot(DATA_9,aes( x= DATA_9$CL)) + 
  geom_histogram(color = "gray90" , fill = "blue3", breaks = breaks) + 
  annotate("text", x = max(DATA_9$CL)-(max(DATA_9$CL)*.10), y = freq,
           label = paste("mean = ", round(mean(DATA_9$CL),2))) +
  annotate("text", x = max(DATA_9$CL)-(max(DATA_9$CL)*.10), y = freq*.92,
           label = paste("sd = ", round(sd(DATA_9$CL), 2))) +
  annotate("text", x = max(DATA_9$CL)-(max(DATA_9$CL)*.10), y = freq*.84, 
           label = paste("N = ", length(DATA_9$CL)))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  xlab ("Access to complementary knowledge (2000-2009)") + ylab ("Frequency") +
  theme(plot.margin=unit(c(1.5,1,0,0),"cm"))



# Data 10 ------
# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_10 <- read.table("HYDRO_2.txt", sep = "")
DATA_10[2:9] <- lapply(DATA_10[2:9], as.numeric)

#Select variable
DATA_10 <- DATA_10[,c(1,6)]
hist(DATA_10$CL)

# Change variable name
hist_10 <- hist(DATA_10$CL, breaks = 50)
freq <- max(hist_10$counts)
breaks = hist_10$breaks


# histo_10
plot_10 <- ggplot(DATA_10,aes( x= DATA_10$CL)) + 
  geom_histogram(color = "gray90" , fill = "blue3", breaks = breaks) + 
  annotate("text", x = max(DATA_10$CL)-(max(DATA_10$CL)*.10), y = freq,
           label = paste("mean = ", round(mean(DATA_10$CL),2))) +
  annotate("text", x = max(DATA_10$CL)-(max(DATA_10$CL)*.10), y = freq*.92,
           label = paste("sd = ", round(sd(DATA_10$CL), 2))) +
  annotate("text", x = max(DATA_10$CL)-(max(DATA_10$CL)*.10), y = freq*.84, 
           label = paste("N = ", length(DATA_10$CL)))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  xlab ("Access to complementary knowledge (2010-2019)") + ylab ("Frequency") +
  theme(plot.margin=unit(c(1.5,0,0,1),"cm"))




# Data 11 ------
# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_11 <- read.table("HYDRO_1.txt", sep = "")
DATA_11[2:9] <- lapply(DATA_11[2:9], as.numeric)

#Select variable
DATA_11 <- DATA_11[,c(1,7)]
hist(DATA_11$GDP)

# Change variable name
hist_11 <- hist(DATA_11$GDP, breaks = 50)
freq <- max(hist_11$counts)
breaks = hist_11$breaks


# histo_11
plot_11 <- ggplot(DATA_11,aes( x= DATA_11$GDP)) + 
  geom_histogram(color = "gray90" , fill = "blue3", breaks = breaks) + 
  annotate("text", x = max(DATA_11$GDP)-(max(DATA_11$GDP)*.10), y = freq,
           label = paste("mean = ", round(mean(DATA_11$GDP),2))) +
  annotate("text", x = max(DATA_11$GDP)-(max(DATA_11$GDP)*.10), y = freq*.92,
           label = paste("sd = ", round(sd(DATA_11$GDP), 2))) +
  annotate("text", x = max(DATA_11$GDP)-(max(DATA_11$GDP)*.10), y = freq*.84, 
           label = paste("N = ", length(DATA_11$GDP)))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  xlab ("Gross domestic product per capita (2000-2009)") + ylab ("Frequency") +
  theme(plot.margin=unit(c(1.5,1,0,0),"cm"))




# Data 12 ------
# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_12 <- read.table("HYDRO_2.txt", sep = "")
DATA_12[2:9] <- lapply(DATA_12[2:9], as.numeric)

#Select variable
DATA_12 <- DATA_12[,c(1,7)]
hist(DATA_12$GDP)

# Change variable name
hist_12 <- hist(DATA_12$GDP, breaks = 50)
freq <- max(hist_12$counts)
breaks = hist_12$breaks


# histo_12
plot_12 <- ggplot(DATA_12,aes( x= DATA_12$GDP)) + 
  geom_histogram(color = "gray90" , fill = "blue3", breaks = breaks) + 
  annotate("text", x = max(DATA_12$GDP)-(max(DATA_12$GDP)*.10), y = freq,
           label = paste("mean = ", round(mean(DATA_12$GDP),2))) +
  annotate("text", x = max(DATA_12$GDP)-(max(DATA_12$GDP)*.10), y = freq*.92,
           label = paste("sd = ", round(sd(DATA_12$GDP), 2))) +
  annotate("text", x = max(DATA_12$GDP)-(max(DATA_12$GDP)*.10), y = freq*.84, 
           label = paste("N = ", length(DATA_12$GDP)))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  xlab ("Gross domestic product per capita (2010-2019)") + ylab ("Frequency") +
  theme(plot.margin=unit(c(1.5,0,0,1),"cm"))





# Data 13 ------
# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_13 <- read.table("HYDRO_1.txt", sep = "")
DATA_13[2:9] <- lapply(DATA_13[2:9], as.numeric)

#Select variable
DATA_13 <- DATA_13[,c(1,8)]
hist(DATA_13$P)

# Change variable name
hist_13 <- hist(DATA_13$P, breaks = 50)
freq <- max(hist_13$counts)
breaks = hist_13$breaks


# histo_13
plot_13 <- ggplot(DATA_13,aes( x= DATA_13$P)) + 
  geom_histogram(color = "gray90" , fill = "blue3", breaks = breaks) + 
  annotate("text", x = max(DATA_13$P)-(max(DATA_13$P)*.10), y = freq,
           label = paste("mean = ", round(mean(DATA_13$P),2))) +
  annotate("text", x = max(DATA_13$P)-(max(DATA_13$P)*.10), y = freq*.92,
           label = paste("sd = ", round(sd(DATA_13$P), 2))) +
  annotate("text", x = max(DATA_13$P)-(max(DATA_13$P)*.10), y = freq*.84, 
           label = paste("N = ", length(DATA_13$P)))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  xlab ("Population  (2000-2009)") + ylab ("Frequency") +
  theme(plot.margin=unit(c(1.5,1,0,0),"cm"))




# Data 14 ------
# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_14 <- read.table("HYDRO_2.txt", sep = "")
DATA_14[2:9] <- lapply(DATA_14[2:9], as.numeric)

#Select variable
DATA_14 <- DATA_14[,c(1,8)]
hist(DATA_14$P)

# Change variable name
hist_14 <- hist(DATA_14$P, breaks = 50)
freq <- max(hist_14$counts)
breaks = hist_14$breaks


# histo 6
plot_14 <- ggplot(DATA_14,aes( x= DATA_14$P)) + 
  geom_histogram(color = "gray90" , fill = "blue3", breaks = breaks) + 
  annotate("text", x = max(DATA_14$P)-(max(DATA_14$P)*.10), y = freq,
           label = paste("mean = ", round(mean(DATA_14$P),2))) +
  annotate("text", x = max(DATA_14$P)-(max(DATA_14$P)*.10), y = freq*.92,
           label = paste("sd = ", round(sd(DATA_14$P), 2))) +
  annotate("text", x = max(DATA_14$P)-(max(DATA_14$P)*.10), y = freq*.84, 
           label = paste("N = ", length(DATA_14$P)))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  xlab ("Population  (2010-2019)") + ylab ("Frequency") +
  theme(plot.margin=unit(c(1.5,0,0,1),"cm"))




# Data 15 ------
# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_15 <- read.table("HYDRO_1.txt", sep = "")
DATA_15[2:9] <- lapply(DATA_15[2:9], as.numeric)

#Select variable
DATA_15 <- DATA_15[,c(1,9)]
hist(DATA_15$M)

# Change variable name
hist_15 <- hist(DATA_15$M, breaks = 50)
freq <- max(hist_15$counts)
breaks = hist_15$breaks


# histo_15
plot_15 <- ggplot(DATA_15,aes( x= DATA_15$M)) + 
  geom_histogram(color = "gray90" , fill = "blue3", breaks = breaks) + 
  annotate("text", x = max(DATA_15$M)-(max(DATA_15$M)*.10), y = freq,
           label = paste("mean = ", round(mean(DATA_15$M),2))) +
  annotate("text", x = max(DATA_15$M)-(max(DATA_15$M)*.10), y = freq*.92,
           label = paste("sd = ", round(sd(DATA_15$M), 2))) +
  annotate("text", x = max(DATA_15$M)-(max(DATA_15$M)*.10), y = freq*.84, 
           label = paste("N = ", length(DATA_15$M)))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  xlab ("Renewable energy market (2000-2009)") + ylab ("Frequency") +
  theme(plot.margin=unit(c(1.5,1,0,0),"cm"))




# Data 16 ------
# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
DATA_16 <- read.table("HYDRO_2.txt", sep = "")
DATA_16[2:9] <- lapply(DATA_16[2:9], as.numeric)

#Select variable
DATA_16 <- DATA_16[,c(1,9)]
hist(DATA_16$M)

# Change variable name
hist_6 <- hist(DATA_16$M, breaks = 50)
freq <- max(hist_6$counts)
breaks = hist_6$breaks


# histo 16
plot_16 <- ggplot(DATA_16,aes( x= DATA_16$M)) + 
  geom_histogram(color = "gray90" , fill = "blue3", breaks = breaks) + 
  annotate("text", x = max(DATA_16$M)-(max(DATA_16$M)*.10), y = freq,
           label = paste("mean = ", round(mean(DATA_16$M),2))) +
  annotate("text", x = max(DATA_16$M)-(max(DATA_16$M)*.10), y = freq*.92,
           label = paste("sd = ", round(sd(DATA_16$M), 2))) +
  annotate("text", x = max(DATA_16$M)-(max(DATA_16$M)*.10), y = freq*.84, 
           label = paste("N = ", length(DATA_16$M)))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  theme_few() + theme(panel.border = element_rect(colour = "gray")) +
  xlab ("Renewable energy market (2010-2019)") + ylab ("Frequency") +
  theme(plot.margin=unit(c(1.5,0,0,1),"cm"))



setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Plots")
png("HYDRO_2.png", width = 800, height = 1050)
grid.arrange(plot_9, plot_10, plot_11, plot_12, plot_13, plot_14, plot_15, plot_16, ncol = 2, nrow = 4)
dev.off()



