
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
#MAPS - RD
# Importing map
mapdata <- get_eurostat_geospatial(output_class = "df", resolution = "10", nuts_level = "2", year = "2021")
colnames(mapdata)[8] <- "Region"

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_1 <- read.table("HYDRO_1.txt", sep = "")
TECH_DATA_1[2:9] <- lapply(TECH_DATA_1[2:9], as.numeric)


#Choose variable
TECH_1 <- TECH_DATA_1[,c(1,3)]

#Join variable
mapdataTECH_1 <- left_join(mapdata, TECH_1, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_1$RD <- as.numeric(mapdataTECH_1$RD)
mapdataTECH_1 <- mutate(mapdataTECH_1, cat = cut_to_classes(RD, n = 3, style = "quantile", decimals = 6))

map_1 <- ggplot(mapdataTECH_1, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "BuGn") +                                    
  labs(title = "Relatedness density scores 
       in hydropower technology (2010-2019)",                 
       fill = "Score") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) +
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_1$Region))) +   theme(legend.position="bottom")+    borders(database = "world", colour = "gray56") +   xlim(c(-30,60)) + ylim(c(0,100))+      geom_label_repel(data = mapdataTECH_1 %>% filter(order ==5) %>%  arrange(KNI)%>% top_n(5,KNI),                    aes(x=long, y=lat, group = group, label=Region), label.size = 0.005, alpha =0.6, nudge_x = -0.02)



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_2 <- read.table("HYDRO_2.txt", sep = "")
TECH_DATA_2[2:9] <- lapply(TECH_DATA_2[2:9], as.numeric)


#Choose variable
TECH_2 <- TECH_DATA_2[,c(1,3)]

#Join variable
mapdataTECH_2 <- left_join(mapdata, TECH_2, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_2$RD <- as.numeric(mapdataTECH_2$RD)
mapdataTECH_2 <- mutate(mapdataTECH_2, cat = cut_to_classes(RD, n = 3, style = "quantile", decimals = 6))

map_2 <- ggplot(mapdataTECH_2, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "BuGn")+
  labs(title = "Relatedness density scores  
       in hydropower technology (2010-2019)", fill = "Score") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71)) + 
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) +
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_12Region))) +   theme(legend.position="bottom")+    borders(database = "world", colour = "gray56") +   xlim(c(-30,60)) + ylim(c(0,100))+      geom_label_repel(data = mapdataTECH_1 %>% filter(order ==5) %>%  arrange(KNI)%>% top_n(5,KNI),                    aes(x=long, y=lat, group = group, label=Region), label.size = 0.005, alpha =0.6, nudge_x = -0.02)




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_3 <- read.table("GEO_1.txt", sep = "")
TECH_DATA_3[2:9] <- lapply(TECH_DATA_3[2:9], as.numeric)

#Choose variable
TECH_3 <- TECH_DATA_3[,c(1,3)]

#Join variable
mapdataTECH_3 <- left_join(mapdata, TECH_3, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_3$RD <- as.numeric(mapdataTECH_3$RD)
mapdataTECH_3 <- mutate(mapdataTECH_3, cat = cut_to_classes(RD, n = 3, style = "quantile", decimals = 6))

map_3 <- ggplot(mapdataTECH_3, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Reds") +                                    
  labs(title = "Relatedness density scores 
       in geothermal power technology (2000-2009)",                 
       fill = "Score") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_3$Region)))




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_4 <- read.table("GEO_2.txt", sep = "")
TECH_DATA_4[2:9] <- lapply(TECH_DATA_4[2:9], as.numeric)

#Choose variable
TECH_4 <- TECH_DATA_4[,c(1,3)]

#Join variable
mapdataTECH_4 <- left_join(mapdata, TECH_4, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_4$RD <- as.numeric(mapdataTECH_4$RD)
mapdataTECH_4 <- mutate(mapdataTECH_4, cat = cut_to_classes(RD, n = 3, style = "quantile", decimals = 6))

map_4 <- ggplot(mapdataTECH_4, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Reds") +                                    
  labs(title = "Relatedness density scores 
       in geothermal power technology (2010-2019)",                 
       fill = "Score") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_4$Region)))




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_5 <- read.table("PV_1.txt", sep = "")
TECH_DATA_5[2:9] <- lapply(TECH_DATA_5[2:9], as.numeric)

#Choose variable
TECH_5 <- TECH_DATA_5[,c(1,3)]

#Join variable
mapdataTECH_5 <- left_join(mapdata, TECH_5, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_5$RD <- as.numeric(mapdataTECH_5$RD)
mapdataTECH_5 <- mutate(mapdataTECH_5, cat = cut_to_classes(RD, n = 3, style = "quantile", decimals = 6))

map_5 <- ggplot(mapdataTECH_5, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "YlOrRd", na.value = "gray50") +                                    
  labs(title = "Relatedness density scores 
       in solar photovoltaic (PV) technology (2000-2009)",                 
       fill = "Score") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_5$Region)))




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_6 <- read.table("PV_2.txt", sep = "")
TECH_DATA_6[2:9] <- lapply(TECH_DATA_4[2:9], as.numeric)

#Choose variable
TECH_6 <- TECH_DATA_6[,c(1,3)]

#Join variable
mapdataTECH_6 <- left_join(mapdata, TECH_6, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_6$RD <- as.numeric(mapdataTECH_6$RD)
mapdataTECH_6 <- mutate(mapdataTECH_6, cat = cut_to_classes(RD, n = 3, style = "quantile", decimals = 6))

map_6 <- ggplot(mapdataTECH_6, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "YlOrRd") +                                    
  labs(title = "Relatedness density scores
        in solar photovoltaic (PV) technology (2010-2019)",                 
       fill = "Score") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_6$Region)))



setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Plots")
png("map_RD_1.png", width = 800, height = 1100)
grid.arrange(map_1, map_2, map_3, map_4, map_5, map_6, ncol = 2, nrow = 3)
dev.off()







# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_7 <- read.table("WIND_1.txt", sep = "")
TECH_DATA_7[2:9] <- lapply(TECH_DATA_7[2:9], as.numeric)

#Choose variable
TECH_7 <- TECH_DATA_7[,c(1,3)]

#Join variable
mapdataTECH_7 <- left_join(mapdata, TECH_7, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_7$RD <- as.numeric(mapdataTECH_7$RD)
mapdataTECH_7 <- mutate(mapdataTECH_7, cat = cut_to_classes(RD, n = 3, style = "quantile", decimals = 6))

map_7 <- ggplot(mapdataTECH_7, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Blues", na.value = "gray50") +                                    
  labs(title = "Relatedness density scores 
       in wind power technology (2000-2009)",                 
       fill = "Score") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_7$Region)))




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_8 <- read.table("WIND_2.txt", sep = "")
TECH_DATA_8[2:9] <- lapply(TECH_DATA_4[2:9], as.numeric)

#Choose variable
TECH_8 <- TECH_DATA_8[,c(1,3)]

#Join variable
mapdataTECH_8 <- left_join(mapdata, TECH_8, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_8$RD <- as.numeric(mapdataTECH_8$RD)
mapdataTECH_8 <- mutate(mapdataTECH_8, cat = cut_to_classes(RD, n = 3, style = "quantile", decimals = 6))

map_8 <- ggplot(mapdataTECH_8, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Blues") +                                    
  labs(title = "Relatedness density scores
        in wind power technology (2010-2019)",                 
       fill = "Score") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_8$Region)))




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_9 <- read.table("THERMAL_1.txt", sep = "")
TECH_DATA_9[2:9] <- lapply(TECH_DATA_9[2:9], as.numeric)

#Choose variable
TECH_9 <- TECH_DATA_9[,c(1,3)]

#Join variable
mapdataTECH_9 <- left_join(mapdata, TECH_9, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_9$RD <- as.numeric(mapdataTECH_9$RD)
mapdataTECH_9 <- mutate(mapdataTECH_9, cat = cut_to_classes(RD, n = 3, style = "quantile", decimals = 6))

map_9 <- ggplot(mapdataTECH_9, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Oranges", na.value = "gray50") +                                    
  labs(title = "Relatedness density scores 
       in concentrated solar power (CSP) technology (2000-2009)",                 
       fill = "Score") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_9$Region)))




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_10 <- read.table("THERMAL_2.txt", sep = "")
TECH_DATA_10[2:9] <- lapply(TECH_DATA_4[2:9], as.numeric)

#Choose variable
TECH_10 <- TECH_DATA_10[,c(1,3)]

#Join variable
mapdataTECH_10 <- left_join(mapdata, TECH_10, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_10$RD <- as.numeric(mapdataTECH_10$RD)
mapdataTECH_10 <- mutate(mapdataTECH_10, cat = cut_to_classes(RD, n = 3, style = "quantile", decimals = 6))

map_10 <- ggplot(mapdataTECH_10, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Oranges") +                                    
  labs(title = "Relatedness density scores
        in concentrated solar power (CSP) technology (2010-2019)",                 
       fill = "Score") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_10$Region)))




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_11 <- read.table("OCEAN_1.txt", sep = "")
TECH_DATA_11[2:9] <- lapply(TECH_DATA_11[2:9], as.numeric)

#Choose variable
TECH_11 <- TECH_DATA_11[,c(1,3)]

#Join variable
mapdataTECH_11 <- left_join(mapdata, TECH_11, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_11$RD <- as.numeric(mapdataTECH_11$RD)
mapdataTECH_11 <- mutate(mapdataTECH_11, cat = cut_to_classes(RD, n = 3, style = "quantile", decimals = 6))

map_11 <- ggplot(mapdataTECH_11, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Purples", na.value = "gray50") +                                    
  labs(title = "Relatedness density scores 
       in ocean energy technology (2000-2009)",                 
       fill = "Score") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_11$Region)))




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_12 <- read.table("OCEAN_2.txt", sep = "")
TECH_DATA_12[2:9] <- lapply(TECH_DATA_4[2:9], as.numeric)

#Choose variable
TECH_12 <- TECH_DATA_12[,c(1,3)]

#Join variable
mapdataTECH_12 <- left_join(mapdata, TECH_12, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_12$RD <- as.numeric(mapdataTECH_12$RD)
mapdataTECH_12 <- mutate(mapdataTECH_12, cat = cut_to_classes(RD, n = 3, style = "quantile", decimals = 6))

map_12 <- ggplot(mapdataTECH_12, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Purples") +                                    
  labs(title = "Relatedness density scores
        in ocean energy technology (2010-2019)",                 
       fill = "Score") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_12$Region)))




setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Plots")
png("map_RD_2.png", width = 800, height = 1100)
grid.arrange(map_7, map_8, map_9, map_10, map_11, map_12, ncol = 2, nrow = 3)
dev.off()




# - - - -  - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - 
#MAPS - K
# Importing map
mapdata <- get_eurostat_geospatial(output_class = "df", resolution = "10", nuts_level = "2", year = "2021")
colnames(mapdata)[8] <- "Region"

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_1 <- read.table("HYDRO_1.txt", sep = "")
TECH_DATA_1[2:9] <- lapply(TECH_DATA_1[2:9], as.numeric)


#Choose variable
TECH_1 <- TECH_DATA_1[,c(1,4)]

#Join variable
mapdataTECH_1 <- left_join(mapdata, TECH_1, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_1$K <- as.numeric(mapdataTECH_1$K)
mapdataTECH_1 <- mutate(mapdataTECH_1, cat = cut_to_classes(K, n = 3, style = "quantile", decimals = 6))

map_1 <- ggplot(mapdataTECH_1, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "BuGn") +                                    
  labs(title = "Knowledge accumulated 
       in hydropower technology (2010-2019)",                 
       fill = "Publications (citations)") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) +
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_1$Region))) +   theme(legend.position="bottom")+    borders(database = "world", colour = "gray56") +   xlim(c(-30,60)) + ylim(c(0,100))+      geom_label_repel(data = mapdataTECH_1 %>% filter(order ==5) %>%  arrange(KNI)%>% top_n(5,KNI),                    aes(x=long, y=lat, group = group, label=Region), label.size = 0.005, alpha =0.6, nudge_x = -0.02)



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_2 <- read.table("HYDRO_2.txt", sep = "")
TECH_DATA_2[2:9] <- lapply(TECH_DATA_2[2:9], as.numeric)


#Choose variable
TECH_2 <- TECH_DATA_2[,c(1,4)]

#Join variable
mapdataTECH_2 <- left_join(mapdata, TECH_2, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_2$K <- as.numeric(mapdataTECH_2$K)
mapdataTECH_2 <- mutate(mapdataTECH_2, cat = cut_to_classes(K, n = 3, style = "quantile", decimals = 6))

map_2 <- ggplot(mapdataTECH_2, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "BuGn")+
  labs(title = "Knowledge accumulated  
       in hydropower technology (2010-2019)", fill = "Publications (citations)") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71)) + 
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) +
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_12Region))) +   theme(legend.position="bottom")+    borders(database = "world", colour = "gray56") +   xlim(c(-30,60)) + ylim(c(0,100))+      geom_label_repel(data = mapdataTECH_1 %>% filter(order ==5) %>%  arrange(KNI)%>% top_n(5,KNI),                    aes(x=long, y=lat, group = group, label=Region), label.size = 0.005, alpha =0.6, nudge_x = -0.02)




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_3 <- read.table("GEO_1.txt", sep = "")
TECH_DATA_3[2:9] <- lapply(TECH_DATA_3[2:9], as.numeric)

#Choose variable
TECH_3 <- TECH_DATA_3[,c(1,4)]

#Join variable
mapdataTECH_3 <- left_join(mapdata, TECH_3, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_3$K <- as.numeric(mapdataTECH_3$K)
mapdataTECH_3 <- mutate(mapdataTECH_3, cat = cut_to_classes(K, n = 3, style = "quantile", decimals = 6))

map_3 <- ggplot(mapdataTECH_3, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Reds") +                                    
  labs(title = "Knowledge accumulated 
       in geothermal power technology (2000-2009)",                 
       fill = "Publications (citations)") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_3$Region)))




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_4 <- read.table("GEO_2.txt", sep = "")
TECH_DATA_4[2:9] <- lapply(TECH_DATA_4[2:9], as.numeric)

#Choose variable
TECH_4 <- TECH_DATA_4[,c(1,4)]

#Join variable
mapdataTECH_4 <- left_join(mapdata, TECH_4, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_4$K <- as.numeric(mapdataTECH_4$K)
mapdataTECH_4 <- mutate(mapdataTECH_4, cat = cut_to_classes(K, n = 3, style = "quantile", decimals = 6))

map_4 <- ggplot(mapdataTECH_4, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Reds") +                                    
  labs(title = "Knowledge accumulated 
       in geothermal power technology (2010-2019)",                 
       fill = "Publications (citations)") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_4$Region)))




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_5 <- read.table("PV_1.txt", sep = "")
TECH_DATA_5[2:9] <- lapply(TECH_DATA_5[2:9], as.numeric)

#Choose variable
TECH_5 <- TECH_DATA_5[,c(1,4)]

#Join variable
mapdataTECH_5 <- left_join(mapdata, TECH_5, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_5$K <- as.numeric(mapdataTECH_5$K)
mapdataTECH_5 <- mutate(mapdataTECH_5, cat = cut_to_classes(K, n = 3, style = "quantile", decimals = 6))

map_5 <- ggplot(mapdataTECH_5, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "YlOrRd", na.value = "gray50") +                                    
  labs(title = "Knowledge accumulated 
       in solar photovoltaic (PV) technology (2000-2009)",                 
       fill = "Publications (citations)") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_5$Region)))




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_6 <- read.table("PV_2.txt", sep = "")
TECH_DATA_6[2:9] <- lapply(TECH_DATA_4[2:9], as.numeric)

#Choose variable
TECH_6 <- TECH_DATA_6[,c(1,4)]

#Join variable
mapdataTECH_6 <- left_join(mapdata, TECH_6, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_6$K <- as.numeric(mapdataTECH_6$K)
mapdataTECH_6 <- mutate(mapdataTECH_6, cat = cut_to_classes(K, n = 3, style = "quantile", decimals = 6))

map_6 <- ggplot(mapdataTECH_6, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "YlOrRd") +                                    
  labs(title = "Knowledge accumulated
        in solar photovoltaic (PV) technology (2010-2019)",                 
       fill = "Publications (citations)") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_6$Region)))



setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Plots")
png("map_K_1.png", width = 800, height = 1100)
grid.arrange(map_1, map_2, map_3, map_4, map_5, map_6, ncol = 2, nrow = 3)
dev.off()







# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_7 <- read.table("WIND_1.txt", sep = "")
TECH_DATA_7[2:9] <- lapply(TECH_DATA_7[2:9], as.numeric)

#Choose variable
TECH_7 <- TECH_DATA_7[,c(1,4)]

#Join variable
mapdataTECH_7 <- left_join(mapdata, TECH_7, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_7$K <- as.numeric(mapdataTECH_7$K)
mapdataTECH_7 <- mutate(mapdataTECH_7, cat = cut_to_classes(K, n = 3, style = "quantile", decimals = 6))

map_7 <- ggplot(mapdataTECH_7, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Blues", na.value = "gray50") +                                    
  labs(title = "Knowledge accumulated 
       in wind power technology (2000-2009)",                 
       fill = "Publications (citations)") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_7$Region)))




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_8 <- read.table("WIND_2.txt", sep = "")
TECH_DATA_8[2:9] <- lapply(TECH_DATA_4[2:9], as.numeric)

#Choose variable
TECH_8 <- TECH_DATA_8[,c(1,4)]

#Join variable
mapdataTECH_8 <- left_join(mapdata, TECH_8, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_8$K <- as.numeric(mapdataTECH_8$K)
mapdataTECH_8 <- mutate(mapdataTECH_8, cat = cut_to_classes(K, n = 3, style = "quantile", decimals = 6))

map_8 <- ggplot(mapdataTECH_8, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Blues") +                                    
  labs(title = "Knowledge accumulated
        in wind power technology (2010-2019)",                 
       fill = "Publications (citations)") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_8$Region)))




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_9 <- read.table("THERMAL_1.txt", sep = "")
TECH_DATA_9[2:9] <- lapply(TECH_DATA_9[2:9], as.numeric)

#Choose variable
TECH_9 <- TECH_DATA_9[,c(1,4)]

#Join variable
mapdataTECH_9 <- left_join(mapdata, TECH_9, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_9$K <- as.numeric(mapdataTECH_9$K)
mapdataTECH_9 <- mutate(mapdataTECH_9, cat = cut_to_classes(K, n = 3, style = "quantile", decimals = 6))

map_9 <- ggplot(mapdataTECH_9, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Oranges", na.value = "gray50") +                                    
  labs(title = "Knowledge accumulated 
       in concentrated solar power (CSP) technology (2000-2009)",                 
       fill = "Publications (citations)") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_9$Region)))




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_10 <- read.table("THERMAL_2.txt", sep = "")
TECH_DATA_10[2:9] <- lapply(TECH_DATA_4[2:9], as.numeric)

#Choose variable
TECH_10 <- TECH_DATA_10[,c(1,4)]

#Join variable
mapdataTECH_10 <- left_join(mapdata, TECH_10, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_10$K <- as.numeric(mapdataTECH_10$K)
mapdataTECH_10 <- mutate(mapdataTECH_10, cat = cut_to_classes(K, n = 3, style = "quantile", decimals = 6))

map_10 <- ggplot(mapdataTECH_10, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Oranges") +                                    
  labs(title = "Knowledge accumulated
        in concentrated solar power (CSP) technology (2010-2019)",                 
       fill = "Publications (citations)") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_10$Region)))




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_11 <- read.table("OCEAN_1.txt", sep = "")
TECH_DATA_11[2:9] <- lapply(TECH_DATA_11[2:9], as.numeric)

#Choose variable
TECH_11 <- TECH_DATA_11[,c(1,4)]

#Join variable
mapdataTECH_11 <- left_join(mapdata, TECH_11, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_11$K <- as.numeric(mapdataTECH_11$K)
mapdataTECH_11 <- mutate(mapdataTECH_11, cat = cut_to_classes(K, n = 3, style = "quantile", decimals = 6))

map_11 <- ggplot(mapdataTECH_11, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Purples", na.value = "gray50") +                                    
  labs(title = "Knowledge accumulated 
       in ocean energy technology (2000-2009)",                 
       fill = "Publications (citations)") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_11$Region)))




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_12 <- read.table("OCEAN_2.txt", sep = "")
TECH_DATA_12[2:9] <- lapply(TECH_DATA_4[2:9], as.numeric)

#Choose variable
TECH_12 <- TECH_DATA_12[,c(1,4)]

#Join variable
mapdataTECH_12 <- left_join(mapdata, TECH_12, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_12$K <- as.numeric(mapdataTECH_12$K)
mapdataTECH_12 <- mutate(mapdataTECH_12, cat = cut_to_classes(K, n = 3, style = "quantile", decimals = 6))

map_12 <- ggplot(mapdataTECH_12, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Purples") +                                    
  labs(title = "Knowledge accumulated
        in ocean energy technology (2010-2019)",                 
       fill = "Publications (citations)") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_12$Region)))




setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Plots")
png("map_K_2.png", width = 800, height = 1100)
grid.arrange(map_7, map_8, map_9, map_10, map_11, map_12, ncol = 2, nrow = 3)
dev.off()







# - - - -  - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - 
#MAPS - C
# Importing map
mapdata <- get_eurostat_geospatial(output_class = "df", resolution = "10", nuts_level = "2", year = "2021")
colnames(mapdata)[8] <- "Region"

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_1 <- read.table("HYDRO_1.txt", sep = "")
TECH_DATA_1[2:9] <- lapply(TECH_DATA_1[2:9], as.numeric)


#Choose variable
TECH_1 <- TECH_DATA_1[,c(1,5)]

#Join variable
mapdataTECH_1 <- left_join(mapdata, TECH_1, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_1$C <- as.numeric(mapdataTECH_1$C)
mapdataTECH_1 <- mutate(mapdataTECH_1, cat = cut_to_classes(C, n = 3, style = "quantile", decimals = 6))

map_1 <- ggplot(mapdataTECH_1, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "BuGn") +                                    
  labs(title = "Electricity from fossil fuels (share) 
       in hydropower technology (2010-2019)",                 
       fill = "Share") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) +
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_1$Region))) +   theme(legend.position="bottom")+    borders(database = "world", colour = "gray56") +   xlim(c(-30,60)) + ylim(c(0,100))+      geom_label_repel(data = mapdataTECH_1 %>% filter(order ==5) %>%  arrange(KNI)%>% top_n(5,KNI),                    aes(x=long, y=lat, group = group, label=Region), label.size = 0.005, alpha =0.6, nudge_x = -0.02)



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_2 <- read.table("HYDRO_2.txt", sep = "")
TECH_DATA_2[2:9] <- lapply(TECH_DATA_2[2:9], as.numeric)


#Choose variable
TECH_2 <- TECH_DATA_2[,c(1,5)]

#Join variable
mapdataTECH_2 <- left_join(mapdata, TECH_2, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_2$C <- as.numeric(mapdataTECH_2$C)
mapdataTECH_2 <- mutate(mapdataTECH_2, cat = cut_to_classes(C, n = 3, style = "quantile", decimals = 6))

map_2 <- ggplot(mapdataTECH_2, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "BuGn")+
  labs(title = "Electricity from fossil fuels (share)  
       in hydropower technology (2010-2019)", fill = "Share") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71)) + 
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) +
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_12Region))) +   theme(legend.position="bottom")+    borders(database = "world", colour = "gray56") +   xlim(c(-30,60)) + ylim(c(0,100))+      geom_label_repel(data = mapdataTECH_1 %>% filter(order ==5) %>%  arrange(KNI)%>% top_n(5,KNI),                    aes(x=long, y=lat, group = group, label=Region), label.size = 0.005, alpha =0.6, nudge_x = -0.02)




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_3 <- read.table("GEO_1.txt", sep = "")
TECH_DATA_3[2:9] <- lapply(TECH_DATA_3[2:9], as.numeric)

#Choose variable
TECH_3 <- TECH_DATA_3[,c(1,5)]

#Join variable
mapdataTECH_3 <- left_join(mapdata, TECH_3, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_3$C <- as.numeric(mapdataTECH_3$C)
mapdataTECH_3 <- mutate(mapdataTECH_3, cat = cut_to_classes(C, n = 3, style = "quantile", decimals = 6))

map_3 <- ggplot(mapdataTECH_3, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Reds") +                                    
  labs(title = "Electricity from fossil fuels (share) 
       in geothermal power technology (2000-2009)",                 
       fill = "Share") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_3$Region)))




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_4 <- read.table("GEO_2.txt", sep = "")
TECH_DATA_4[2:9] <- lapply(TECH_DATA_4[2:9], as.numeric)

#Choose variable
TECH_4 <- TECH_DATA_4[,c(1,5)]

#Join variable
mapdataTECH_4 <- left_join(mapdata, TECH_4, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_4$C <- as.numeric(mapdataTECH_4$C)
mapdataTECH_4 <- mutate(mapdataTECH_4, cat = cut_to_classes(C, n = 3, style = "quantile", decimals = 6))

map_4 <- ggplot(mapdataTECH_4, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Reds") +                                    
  labs(title = "Electricity from fossil fuels (share) 
       in geothermal power technology (2010-2019)",                 
       fill = "Share") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_4$Region)))




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_5 <- read.table("PV_1.txt", sep = "")
TECH_DATA_5[2:9] <- lapply(TECH_DATA_5[2:9], as.numeric)

#Choose variable
TECH_5 <- TECH_DATA_5[,c(1,5)]

#Join variable
mapdataTECH_5 <- left_join(mapdata, TECH_5, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_5$C <- as.numeric(mapdataTECH_5$C)
mapdataTECH_5 <- mutate(mapdataTECH_5, cat = cut_to_classes(C, n = 3, style = "quantile", decimals = 6))

map_5 <- ggplot(mapdataTECH_5, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "YlOrRd", na.value = "gray50") +                                    
  labs(title = "Electricity from fossil fuels (share) 
       in solar photovoltaic (PV) technology (2000-2009)",                 
       fill = "Share") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_5$Region)))




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_6 <- read.table("PV_2.txt", sep = "")
TECH_DATA_6[2:9] <- lapply(TECH_DATA_4[2:9], as.numeric)

#Choose variable
TECH_6 <- TECH_DATA_6[,c(1,5)]

#Join variable
mapdataTECH_6 <- left_join(mapdata, TECH_6, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_6$C <- as.numeric(mapdataTECH_6$C)
mapdataTECH_6 <- mutate(mapdataTECH_6, cat = cut_to_classes(C, n = 3, style = "quantile", decimals = 6))

map_6 <- ggplot(mapdataTECH_6, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "YlOrRd") +                                    
  labs(title = "Electricity from fossil fuels (share)
        in solar photovoltaic (PV) technology (2010-2019)",                 
       fill = "Share") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_6$Region)))



setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Plots")
png("map_C_1.png", width = 800, height = 1100)
grid.arrange(map_1, map_2, map_3, map_4, map_5, map_6, ncol = 2, nrow = 3)
dev.off()







# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_7 <- read.table("WIND_1.txt", sep = "")
TECH_DATA_7[2:9] <- lapply(TECH_DATA_7[2:9], as.numeric)

#Choose variable
TECH_7 <- TECH_DATA_7[,c(1,5)]

#Join variable
mapdataTECH_7 <- left_join(mapdata, TECH_7, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_7$C <- as.numeric(mapdataTECH_7$C)
mapdataTECH_7 <- mutate(mapdataTECH_7, cat = cut_to_classes(C, n = 3, style = "quantile", decimals = 6))

map_7 <- ggplot(mapdataTECH_7, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Blues", na.value = "gray50") +                                    
  labs(title = "Electricity from fossil fuels (share) 
       in wind power technology (2000-2009)",                 
       fill = "Share") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_7$Region)))




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_8 <- read.table("WIND_2.txt", sep = "")
TECH_DATA_8[2:9] <- lapply(TECH_DATA_4[2:9], as.numeric)

#Choose variable
TECH_8 <- TECH_DATA_8[,c(1,5)]

#Join variable
mapdataTECH_8 <- left_join(mapdata, TECH_8, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_8$C <- as.numeric(mapdataTECH_8$C)
mapdataTECH_8 <- mutate(mapdataTECH_8, cat = cut_to_classes(C, n = 3, style = "quantile", decimals = 6))

map_8 <- ggplot(mapdataTECH_8, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Blues") +                                    
  labs(title = "Electricity from fossil fuels (share)
        in wind power technology (2010-2019)",                 
       fill = "Share") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_8$Region)))




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_9 <- read.table("THERMAL_1.txt", sep = "")
TECH_DATA_9[2:9] <- lapply(TECH_DATA_9[2:9], as.numeric)

#Choose variable
TECH_9 <- TECH_DATA_9[,c(1,5)]

#Join variable
mapdataTECH_9 <- left_join(mapdata, TECH_9, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_9$C <- as.numeric(mapdataTECH_9$C)
mapdataTECH_9 <- mutate(mapdataTECH_9, cat = cut_to_classes(C, n = 3, style = "quantile", decimals = 6))

map_9 <- ggplot(mapdataTECH_9, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Oranges", na.value = "gray50") +                                    
  labs(title = "Electricity from fossil fuels (share) 
       in concentrated solar power (CSP) technology (2000-2009)",                 
       fill = "Share") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_9$Region)))




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_10 <- read.table("THERMAL_2.txt", sep = "")
TECH_DATA_10[2:9] <- lapply(TECH_DATA_4[2:9], as.numeric)

#Choose variable
TECH_10 <- TECH_DATA_10[,c(1,5)]

#Join variable
mapdataTECH_10 <- left_join(mapdata, TECH_10, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_10$C <- as.numeric(mapdataTECH_10$C)
mapdataTECH_10 <- mutate(mapdataTECH_10, cat = cut_to_classes(C, n = 3, style = "quantile", decimals = 6))

map_10 <- ggplot(mapdataTECH_10, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Oranges") +                                    
  labs(title = "Electricity from fossil fuels (share)
        in concentrated solar power (CSP) technology (2010-2019)",                 
       fill = "Share") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_10$Region)))




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_11 <- read.table("OCEAN_1.txt", sep = "")
TECH_DATA_11[2:9] <- lapply(TECH_DATA_11[2:9], as.numeric)

#Choose variable
TECH_11 <- TECH_DATA_11[,c(1,5)]

#Join variable
mapdataTECH_11 <- left_join(mapdata, TECH_11, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_11$C <- as.numeric(mapdataTECH_11$C)
mapdataTECH_11 <- mutate(mapdataTECH_11, cat = cut_to_classes(C, n = 3, style = "quantile", decimals = 6))

map_11 <- ggplot(mapdataTECH_11, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Purples", na.value = "gray50") +                                    
  labs(title = "Electricity from fossil fuels (share) 
       in ocean energy technology (2000-2009)",                 
       fill = "Share") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_11$Region)))




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_12 <- read.table("OCEAN_2.txt", sep = "")
TECH_DATA_12[2:9] <- lapply(TECH_DATA_4[2:9], as.numeric)

#Choose variable
TECH_12 <- TECH_DATA_12[,c(1,5)]

#Join variable
mapdataTECH_12 <- left_join(mapdata, TECH_12, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_12$C <- as.numeric(mapdataTECH_12$C)
mapdataTECH_12 <- mutate(mapdataTECH_12, cat = cut_to_classes(C, n = 3, style = "quantile", decimals = 6))

map_12 <- ggplot(mapdataTECH_12, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Purples") +                                    
  labs(title = "Electricity from fossil fuels (share)
        in ocean energy technology (2010-2019)",                 
       fill = "Share") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_12$Region)))




setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Plots")
png("map_C_2.png", width = 800, height = 1100)
grid.arrange(map_7, map_8, map_9, map_10, map_11, map_12, ncol = 2, nrow = 3)
dev.off()




# - - - -  - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - 
#MAPS - M
# Importing map
mapdata <- get_eurostat_geospatial(output_class = "df", resolution = "10", nuts_level = "2", year = "2021")
colnames(mapdata)[8] <- "Region"

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_1 <- read.table("HYDRO_1.txt", sep = "")
TECH_DATA_1[2:9] <- lapply(TECH_DATA_1[2:9], as.numeric)


#Choose variable
TECH_1 <- TECH_DATA_1[,c(1,9)]

#Join variable
mapdataTECH_1 <- left_join(mapdata, TECH_1, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_1$M <- as.numeric(mapdataTECH_1$M)
mapdataTECH_1 <- mutate(mapdataTECH_1, cat = cut_to_classes(M, n = 3, style = "kmeans", decimals = 6))

map_1 <- ggplot(mapdataTECH_1, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "BuGn") +                                    
  labs(title = "Installed capacity (share) 
       in hydropower technology (2000-2009)",                 
       fill = "Share") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) +
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_1$Region))) +   theme(legend.position="bottom")+    borders(database = "world", colour = "gray56") +   xlim(c(-30,60)) + ylim(c(0,100))+      geom_label_repel(data = mapdataTECH_1 %>% filter(order ==5) %>%  arrange(KNI)%>% top_n(5,KNI),                    aes(x=long, y=lat, group = group, label=Region), label.size = 0.005, alpha =0.6, nudge_x = -0.02)



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_2 <- read.table("HYDRO_2.txt", sep = "")
TECH_DATA_2[2:9] <- lapply(TECH_DATA_2[2:9], as.numeric)


#Choose variable
TECH_2 <- TECH_DATA_2[,c(1,9)]

#Join variable
mapdataTECH_2 <- left_join(mapdata, TECH_2, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_2$M <- as.numeric(mapdataTECH_2$M)
mapdataTECH_2 <- mutate(mapdataTECH_2, cat = cut_to_classes(M, n = 3, style = "kmeans", decimals = 6))

map_2 <- ggplot(mapdataTECH_2, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "BuGn")+
  labs(title = "Installed capacity (share)  
       in hydropower technology (2010-2019)", fill = "Share") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71)) + 
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) +
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_12Region))) +   theme(legend.position="bottom")+    borders(database = "world", colour = "gray56") +   xlim(c(-30,60)) + ylim(c(0,100))+      geom_label_repel(data = mapdataTECH_1 %>% filter(order ==5) %>%  arrange(KNI)%>% top_n(5,KNI),                    aes(x=long, y=lat, group = group, label=Region), label.size = 0.005, alpha =0.6, nudge_x = -0.02)




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_3 <- read.table("GEO_1.txt", sep = "")
TECH_DATA_3[2:9] <- lapply(TECH_DATA_3[2:9], as.numeric)

#Choose variable
TECH_3 <- TECH_DATA_3[,c(1,9)]

#Join variable
mapdataTECH_3 <- left_join(mapdata, TECH_3, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_3$M <- as.numeric(mapdataTECH_3$M)
mapdataTECH_3 <- mutate(mapdataTECH_3, cat = cut_to_classes(M, n = 3, style = "kmeans", decimals = 6))

map_3 <- ggplot(mapdataTECH_3, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Reds") +                                    
  labs(title = "Installed capacity (share) 
       in geothermal power technology (2000-2009)",                 
       fill = "Share") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_3$Region)))




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_4 <- read.table("GEO_2.txt", sep = "")
TECH_DATA_4[2:9] <- lapply(TECH_DATA_4[2:9], as.numeric)

#Choose variable
TECH_4 <- TECH_DATA_4[,c(1,9)]

#Join variable
mapdataTECH_4 <- left_join(mapdata, TECH_4, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_4$M <- as.numeric(mapdataTECH_4$M)
mapdataTECH_4 <- mutate(mapdataTECH_4, cat = cut_to_classes(M, n = 3, style = "kmeans", decimals = 6))

map_4 <- ggplot(mapdataTECH_4, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Reds") +                                    
  labs(title = "Installed capacity (share) 
       in geothermal power technology (2010-2019)",                 
       fill = "Share") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_4$Region)))




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_5 <- read.table("PV_1.txt", sep = "")
TECH_DATA_5[2:9] <- lapply(TECH_DATA_5[2:9], as.numeric)

#Choose variable
TECH_5 <- TECH_DATA_5[,c(1,9)]

#Join variable
mapdataTECH_5 <- left_join(mapdata, TECH_5, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_5$M <- as.numeric(mapdataTECH_5$M)
mapdataTECH_5 <- mutate(mapdataTECH_5, cat = cut_to_classes(M, n = 3, style = "kmeans", decimals = 6))

map_5 <- ggplot(mapdataTECH_5, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "YlOrRd", na.value = "gray50") +                                    
  labs(title = "Installed capacity (share) 
       in solar photovoltaic (PV) technology (2000-2009)",                 
       fill = "Share") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_5$Region)))




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_6 <- read.table("PV_2.txt", sep = "")
TECH_DATA_6[2:9] <- lapply(TECH_DATA_4[2:9], as.numeric)

#Choose variable
TECH_6 <- TECH_DATA_6[,c(1,9)]

#Join variable
mapdataTECH_6 <- left_join(mapdata, TECH_6, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_6$M <- as.numeric(mapdataTECH_6$M)
mapdataTECH_6 <- mutate(mapdataTECH_6, cat = cut_to_classes(M, n = 3, style = "kmeans", decimals = 6))

map_6 <- ggplot(mapdataTECH_6, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "YlOrRd") +                                    
  labs(title = "Installed capacity (share)
        in solar photovoltaic (PV) technology (2010-2019)",                 
       fill = "Share") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_6$Region)))



setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Plots")
png("map_M_1.png", width = 800, height = 1100)
grid.arrange(map_1, map_2, map_3, map_4, map_5, map_6, ncol = 2, nrow = 3)
dev.off()







# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_7 <- read.table("WIND_1.txt", sep = "")
TECH_DATA_7[2:9] <- lapply(TECH_DATA_7[2:9], as.numeric)

#Choose variable
TECH_7 <- TECH_DATA_7[,c(1,9)]

#Join variable
mapdataTECH_7 <- left_join(mapdata, TECH_7, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_7$M <- as.numeric(mapdataTECH_7$M)
mapdataTECH_7 <- mutate(mapdataTECH_7, cat = cut_to_classes(M, n = 3, style = "kmeans", decimals = 6))

map_7 <- ggplot(mapdataTECH_7, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Blues", na.value = "gray50") +                                    
  labs(title = "Installed capacity (share) 
       in wind power technology (2000-2009)",                 
       fill = "Share") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_7$Region)))




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_8 <- read.table("WIND_2.txt", sep = "")
TECH_DATA_8[2:9] <- lapply(TECH_DATA_4[2:9], as.numeric)

#Choose variable
TECH_8 <- TECH_DATA_8[,c(1,9)]

#Join variable
mapdataTECH_8 <- left_join(mapdata, TECH_8, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_8$M <- as.numeric(mapdataTECH_8$M)
mapdataTECH_8 <- mutate(mapdataTECH_8, cat = cut_to_classes(M, n = 3, style = "kmeans", decimals = 6))

map_8 <- ggplot(mapdataTECH_8, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Blues") +                                    
  labs(title = "Installed capacity (share)
        in wind power technology (2010-2019)",                 
       fill = "Share") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_8$Region)))




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_9 <- read.table("THERMAL_1.txt", sep = "")
TECH_DATA_9[2:9] <- lapply(TECH_DATA_9[2:9], as.numeric)

#Choose variable
TECH_9 <- TECH_DATA_9[,c(1,9)]

#Join variable
mapdataTECH_9 <- left_join(mapdata, TECH_9, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_9$M <- as.numeric(mapdataTECH_9$M)
mapdataTECH_9 <- mutate(mapdataTECH_9, cat = cut_to_classes(mapdataTECH_9$M, n = 3, style = "kmeans", decimals = 6))

map_9 <- ggplot(mapdataTECH_9, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Oranges", na.value = "gray50") +                                    
  labs(title = "Installed capacity (share) 
       in concentrated solar power (CSP) technology (2000-2009)",                 
       fill = "Share") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_9$Region)))




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_10 <- read.table("THERMAL_2.txt", sep = "")
TECH_DATA_10[2:9] <- lapply(TECH_DATA_4[2:9], as.numeric)

#Choose variable
TECH_10 <- TECH_DATA_10[,c(1,9)]

#Join variable
mapdataTECH_10 <- left_join(mapdata, TECH_10, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_10$M <- as.numeric(mapdataTECH_10$M)
mapdataTECH_10 <- mutate(mapdataTECH_10, cat = cut_to_classes(M, n = 3, style = "kmeans", decimals = 6))

map_10 <- ggplot(mapdataTECH_10, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Oranges") +                                    
  labs(title = "Installed capacity (share)
        in concentrated solar power (CSP) technology (2010-2019)",                 
       fill = "Share") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_10$Region)))




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_11 <- read.table("OCEAN_1.txt", sep = "")
TECH_DATA_11[2:9] <- lapply(TECH_DATA_11[2:9], as.numeric)

#Choose variable
TECH_11 <- TECH_DATA_11[,c(1,9)]

#Join variable
mapdataTECH_11 <- left_join(mapdata, TECH_11, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_11$M <- as.numeric(mapdataTECH_11$M)
mapdataTECH_11 <- mutate(mapdataTECH_11, cat = cut_to_classes(M, n = 3, style = "kmeans", decimals = 10))

map_11 <- ggplot(mapdataTECH_11, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Purples", na.value = "gray50") +                                    
  labs(title = "Installed capacity (share) 
       in ocean energy technology (2000-2009)",                 
       fill = "Share") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_11$Region)))




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_12 <- read.table("OCEAN_2.txt", sep = "")
TECH_DATA_12[2:9] <- lapply(TECH_DATA_12[2:9], as.numeric)

#Choose variable
TECH_12 <- TECH_DATA_12[,c(1,9)]

#Join variable
mapdataTECH_12 <- left_join(mapdata, TECH_12, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_12$M <- as.numeric(mapdataTECH_12$M)
mapdataTECH_12 <- mutate(mapdataTECH_12, cat = cut_to_classes(M, n = 3, style = "kmeans", decimals = 10))

map_12 <- ggplot(mapdataTECH_12, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Purples") +                                    
  labs(title = "Installed capacity (share)
        in ocean energy technology (2010-2019)",                 
       fill = "Share") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_12$Region)))




setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Plots")
png("map_M_2.png", width = 800, height = 1100)
grid.arrange(map_7, map_8, map_9, map_10, map_11, map_12, ncol = 2, nrow = 3)
dev.off()






