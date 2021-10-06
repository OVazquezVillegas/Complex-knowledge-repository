###################################
####                          #####
####       Visualizations     #####
####                          ##### 
###################################

# ==================== #
#   Data preparation   # ----------------------------------------------------------------

## Reading packages 
library(readxl) 
library(countrycode)
library(dplyr)
library(ggplot2)
library(eurostat)
library(ggthemes) # Load
library(ggrepel)
library(gridExtra)


# - - - -  - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - 
# RANKINGS
NUTS <- read_excel("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data/NUTS.xlsx")
colnames(NUTS) <- c("Region", "Label")
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/NUTS counts")
tech <- read.delim("PV_2.txt")
# 1.1 Dataframe NUTS - country
tech$country_iso_alpha3_code <- countrycode(tech$country_iso_alpha3_code, origin = "iso3c", destination = "iso2c", nomatch = NULL)
tech$country_iso_alpha3_code <-   gsub("GB", "UK", tech$country_iso_alpha3_code )
NUTS_country <- tech[,1:2]
colnames(NUTS_country) <- c("Region", "Country")
NUTS_country <- unique(NUTS_country)
NUTS_country <- inner_join(NUTS_country, NUTS, by = "Region")
NUTS_country <- NUTS_country[,c(1,3,2)]

#Change TECH
RANK_TECH <- inner_join(TECH_12, NUTS_country, by = "Region") 
RANK_TECH <-head(arrange(RANK_TECH, desc(RANK_TECH$KNI)), n= 10)
colnames(RANK_TECH)[1] <- "TIME"
RANK_TECH_TABLE <- RANK_TECH[1:5,c(1,3,2)]
RANK_TECH_TABLE$KNI <- round(RANK_TECH_TABLE$KNI, 2)



RANK_TECH_PLUS <- inner_join(RANK_TECH, POP_2, by = "TIME")

# - - - -  - - - - - - - - - - - - - - - - -  - - - - - - - - - - - - - - - - - 
#MAPS - KNI
# Importing map
mapdata <- get_eurostat_geospatial(output_class = "df", resolution = "10", nuts_level = "2", year = "2021")
colnames(mapdata)[8] <- "Region"

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_1 <- read.table("HYDRO_1.txt", sep = "")
TECH_DATA_1[2:9] <- lapply(TECH_DATA_1[2:9], as.numeric)


#Choose variable
TECH_1 <- TECH_DATA_1[,c(1,2)]

#Join variable
mapdataTECH_1 <- left_join(mapdata, TECH_1, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_1$KNI <- as.numeric(mapdataTECH_1$KNI)
mapdataTECH_1 <- mutate(mapdataTECH_1, cat = cut_to_classes(KNI, n = 3, style = "quantile", decimals = 2))

map_1 <- ggplot(mapdataTECH_1, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "BuGn") +                                    
  labs(title = "Knowledge complexity scores 
       in hydropower technology (2000-2009)",                 
       fill = "Score") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) +
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_1$Region))) +   theme(legend.position="bottom")+   
borders(database = "world", colour = "gray56") +   xlim(c(-30,60)) + ylim(c(0,100))+   
  geom_label_repel(data = mapdataTECH_1 %>% filter(order ==5) %>%  arrange(KNI)%>% top_n(5,KNI),
                   aes(x=long, y=lat, group = group, label=Region), label.size = 0.005, alpha =0.6, nudge_x = -0.02)

print(map_1)

# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_2 <- read.table("HYDRO_2.txt", sep = "")
TECH_DATA_2[2:9] <- lapply(TECH_DATA_2[2:9], as.numeric)


#Choose variable
TECH_2 <- TECH_DATA_2[,c(1,2)]

#Join variable
mapdataTECH_2 <- left_join(mapdata, TECH_2, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_2$KNI <- as.numeric(mapdataTECH_2$KNI)
mapdataTECH_2 <- mutate(mapdataTECH_2, cat = cut_to_classes(KNI, n = 3, style = "quantile", decimals = 2))

map_2 <- ggplot(mapdataTECH_2, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "BuGn")+
  labs(title = "Knowledge complexity scores  
       in hydropower technology (2010-2019)", fill = "Score") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71)) + 
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) +
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_2$Region))) +   
  theme(legend.position="bottom")+   borders(database = "world", colour = "gray56") +   
  xlim(c(-30,60)) + ylim(c(0,100))+    
  geom_label_repel( data = mapdataTECH_2 %>% filter(order ==5) %>%  arrange(KNI)%>% top_n(5,KNI),
                    aes(x=long, y=lat, group = group, label=Region), label.size = 0.005, alpha =0.6, nudge_x = -0.02)


setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Plots")
png("map_KNI_1.png", width = 800, height = 500)
grid.arrange(map_1, map_2, ncol = 2, nrow = 1)
dev.off()


# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_3 <- read.table("GEO_1.txt", sep = "")
TECH_DATA_3[2:9] <- lapply(TECH_DATA_3[2:9], as.numeric)

#Choose variable
TECH_3 <- TECH_DATA_3[,c(1,2)]

#Join variable
mapdataTECH_3 <- left_join(mapdata, TECH_3, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_3$KNI <- as.numeric(mapdataTECH_3$KNI)
mapdataTECH_3 <- mutate(mapdataTECH_3, cat = cut_to_classes(KNI, n = 3, style = "quantile", decimals = 2))

map_3 <- ggplot(mapdataTECH_3, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Reds") +                                    
  labs(title = "Knowledge complexity scores 
       in geothermal power technology (2000-2009)",                 
       fill = "Score") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_3$Region))) +   
  theme(legend.position="bottom")+   borders(database = "world", colour = "gray56") +   
  xlim(c(-30,60)) + ylim(c(0,100))+   
  geom_label_repel( data = mapdataTECH_3 %>% filter(order ==5) %>%  arrange(KNI)%>% top_n(5,KNI),                    
                   aes(x=long, y=lat, group = group, label=Region), label.size = 0.005, alpha =0.6, nudge_x = -0.02)





# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_4 <- read.table("GEO_2.txt", sep = "")
TECH_DATA_4[2:9] <- lapply(TECH_DATA_4[2:9], as.numeric)

#Choose variable
TECH_4 <- TECH_DATA_4[,c(1,2)]

#Join variable
mapdataTECH_4 <- left_join(mapdata, TECH_4, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_4$KNI <- as.numeric(mapdataTECH_4$KNI)
mapdataTECH_4 <- mutate(mapdataTECH_4, cat = cut_to_classes(KNI, n = 3, style = "quantile", decimals = 2))

map_4 <- ggplot(mapdataTECH_4, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Reds") +                                    
  labs(title = "Knowledge complexity scores 
       in geothermal power technology (2010-2019)",                 
       fill = "Score") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_4$Region))) +   
  theme(legend.position="bottom")+   borders(database = "world", colour = "gray56") +   
  xlim(c(-30,60)) + ylim(c(0,100))+  
  geom_label_repel( data = mapdataTECH_4 %>% filter(order ==5) %>%  arrange(KNI)%>% top_n(5,KNI),                    
                   aes(x=long, y=lat, group = group, label=Region), label.size = 0.005, alpha =0.6, nudge_x = -0.02)




setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Plots")
png("map_KNI_2.png", width = 800, height = 500)
grid.arrange(map_3, map_4, ncol = 2, nrow = 1)
dev.off()


# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_5 <- read.table("PV_1.txt", sep = "")
TECH_DATA_5[2:9] <- lapply(TECH_DATA_5[2:9], as.numeric)

#Choose variable
TECH_5 <- TECH_DATA_5[,c(1,2)]

#Join variable
mapdataTECH_5 <- left_join(mapdata, TECH_5, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_5$KNI <- as.numeric(mapdataTECH_5$KNI)
mapdataTECH_5 <- mutate(mapdataTECH_5, cat = cut_to_classes(KNI, n = 3, style = "quantile", decimals = 2))

map_5 <- ggplot(mapdataTECH_5, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "YlOrRd", na.value = "gray50") +                                    
  labs(title = "Knowledge complexity scores 
       in solar photovoltaic (PV) technology (2000-2009)",                 
       fill = "Score") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_5$Region))) +   
  theme(legend.position="bottom")+   borders(database = "world", colour = "gray56") +   
  xlim(c(-30,60)) + ylim(c(0,100))+   
  geom_label_repel( data = mapdataTECH_5 %>% filter(order ==5) %>%  arrange(KNI)%>% top_n(5,KNI),                    
                   aes(x=long, y=lat, group = group, label=Region), label.size = 0.005, alpha =0.6, nudge_x = -0.02)




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_6 <- read.table("PV_2.txt", sep = "")
TECH_DATA_6[2:9] <- lapply(TECH_DATA_4[2:9], as.numeric)

#Choose variable
TECH_6 <- TECH_DATA_6[,c(1,2)]

#Join variable
mapdataTECH_6 <- left_join(mapdata, TECH_6, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_6$KNI <- as.numeric(mapdataTECH_6$KNI)
mapdataTECH_6 <- mutate(mapdataTECH_6, cat = cut_to_classes(KNI, n = 3, style = "quantile", decimals = 2))

map_6 <- ggplot(mapdataTECH_6, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "YlOrRd") +                                    
  labs(title = "Knowledge complexity scores
        in solar photovoltaic (PV) technology (2010-2019)",                 
       fill = "Score") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_6$Region))) +  
  theme(legend.position="bottom")+   borders(database = "world", colour = "gray56") +   
  xlim(c(-30,60)) + ylim(c(0,100))+  
  geom_label_repel( data = mapdataTECH_6 %>% filter(order ==5) %>%  arrange(KNI)%>% top_n(5,KNI),                    
                   aes(x=long, y=lat, group = group, label=Region), label.size = 0.005, alpha =0.6, nudge_x = -0.02)






setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Plots")
png("map_KNI_3.png", width = 800, height = 500)
grid.arrange(map_5, map_6, ncol = 2, nrow = 1)
dev.off()




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_7 <- read.table("WIND_1.txt", sep = "")
TECH_DATA_7[2:9] <- lapply(TECH_DATA_7[2:9], as.numeric)

#Choose variable
TECH_7 <- TECH_DATA_7[,c(1,2)]

#Join variable
mapdataTECH_7 <- left_join(mapdata, TECH_7, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_7$KNI <- as.numeric(mapdataTECH_7$KNI)
mapdataTECH_7 <- mutate(mapdataTECH_7, cat = cut_to_classes(KNI, n = 3, style = "quantile", decimals = 2))

map_7 <- ggplot(mapdataTECH_7, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Blues", na.value = "gray50") +                                    
  labs(title = "Knowledge complexity scores 
       in wind power technology (2000-2009)",                 
       fill = "Score") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_7$Region))) +   
  theme(legend.position="bottom")+   borders(database = "world", colour = "gray56") +   
  xlim(c(-30,60)) + ylim(c(0,100))+   
  geom_label_repel( data = mapdataTECH_7 %>% filter(order ==5) %>%  arrange(KNI)%>% top_n(5,KNI),                    
                   aes(x=long, y=lat, group = group, label=Region), label.size = 0.005, alpha =0.6, nudge_x = -0.02)




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_8 <- read.table("WIND_2.txt", sep = "")
TECH_DATA_8[2:9] <- lapply(TECH_DATA_4[2:9], as.numeric)

#Choose variable
TECH_8 <- TECH_DATA_8[,c(1,2)]

#Join variable
mapdataTECH_8 <- left_join(mapdata, TECH_8, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_8$KNI <- as.numeric(mapdataTECH_8$KNI)
mapdataTECH_8 <- mutate(mapdataTECH_8, cat = cut_to_classes(KNI, n = 3, style = "quantile", decimals = 2))

map_8 <- ggplot(mapdataTECH_8, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Blues") +                                    
  labs(title = "Knowledge complexity scores
        in wind power technology (2010-2019)",                 
       fill = "Score") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_8$Region))) +   
  theme(legend.position="bottom")+   borders(database = "world", colour = "gray56") +   
  xlim(c(-30,60)) + ylim(c(0,100))+   
  geom_label_repel( data = mapdataTECH_8 %>% filter(order ==5) %>%  arrange(KNI)%>% top_n(5,KNI),                    
                   aes(x=long, y=lat, group = group, label=Region), label.size = 0.005, alpha =0.6, nudge_x = -0.02)



setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Plots")
png("map_KNI_4.png", width = 800, height = 500)
grid.arrange(map_7, map_8, ncol = 2, nrow = 1)
dev.off()




# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_9 <- read.table("THERMAL_1.txt", sep = "")
TECH_DATA_9[2:9] <- lapply(TECH_DATA_9[2:9], as.numeric)

#Choose variable
TECH_9 <- TECH_DATA_9[,c(1,2)]

#Join variable
mapdataTECH_9 <- left_join(mapdata, TECH_9, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_9$KNI <- as.numeric(mapdataTECH_9$KNI)
mapdataTECH_9 <- mutate(mapdataTECH_9, cat = cut_to_classes(KNI, n = 3, style = "quantile", decimals = 2))

map_9 <- ggplot(mapdataTECH_9, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Oranges", na.value = "gray50") +                                    
  labs(title = "Knowledge complexity scores 
       in concentrated solar power (CSP) technology (2000-2009)",                 
       fill = "Score") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_9$Region))) +  
  theme(legend.position="bottom")+   borders(database = "world", colour = "gray56") +  
  xlim(c(-30,60)) + ylim(c(0,100))+   
  geom_label_repel( data = mapdataTECH_9 %>% filter(order ==5) %>%  arrange(KNI)%>% top_n(5,KNI),                    
                   aes(x=long, y=lat, group = group, label=Region), label.size = 0.005, alpha =0.6, nudge_x = -0.02)





# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_10 <- read.table("THERMAL_2.txt", sep = "")
TECH_DATA_10[2:9] <- lapply(TECH_DATA_4[2:9], as.numeric)

#Choose variable
TECH_10 <- TECH_DATA_10[,c(1,2)]

#Join variable
mapdataTECH_10 <- left_join(mapdata, TECH_10, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_10$KNI <- as.numeric(mapdataTECH_10$KNI)
mapdataTECH_10 <- mutate(mapdataTECH_10, cat = cut_to_classes(KNI, n = 3, style = "quantile", decimals = 2))

map_10 <- ggplot(mapdataTECH_10, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Oranges") +                                    
  labs(title = "Knowledge complexity scores
        in concentrated solar power (CSP) technology (2010-2019)",                 
       fill = "Score") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_10$Region))) +   
  theme(legend.position="bottom")+   borders(database = "world", colour = "gray56") +   
  xlim(c(-30,60)) + ylim(c(0,100))+   
  geom_label_repel( data = mapdataTECH_10 %>% filter(order ==5) %>%  arrange(KNI)%>% top_n(5,KNI),                    
                   aes(x=long, y=lat, group = group, label=Region), label.size = 0.005, alpha =0.6, nudge_x = -0.02)






setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Plots")
png("map_KNI_5.png", width = 800, height = 500)
grid.arrange(map_9, map_10, ncol = 2, nrow = 1)
dev.off()



# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_11 <- read.table("OCEAN_1.txt", sep = "")
TECH_DATA_11[2:9] <- lapply(TECH_DATA_11[2:9], as.numeric)

#Choose variable
TECH_11 <- TECH_DATA_11[,c(1,2)]

#Join variable
mapdataTECH_11 <- left_join(mapdata, TECH_11, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_11$KNI <- as.numeric(mapdataTECH_11$KNI)
mapdataTECH_11 <- mutate(mapdataTECH_11, cat = cut_to_classes(KNI, n = 3, style = "quantile", decimals = 2))

map_11 <- ggplot(mapdataTECH_11, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Purples", na.value = "gray50") +                                    
  labs(title = "Knowledge complexity scores 
       in ocean energy technology (2000-2009)",                 
       fill = "Score") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_11$Region))) +   
  theme(legend.position="bottom")+   borders(database = "world", colour = "gray56") +   
  xlim(c(-30,60)) + ylim(c(0,100))+  
  geom_label_repel( data = mapdataTECH_11 %>% filter(order ==5) %>%  arrange(KNI)%>% top_n(5,KNI),                    
                   aes(x=long, y=lat, group = group, label=Region), label.size = 0.005, alpha =0.6, nudge_x = -0.02)





# Load data
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")
TECH_DATA_12 <- read.table("OCEAN_2.txt", sep = "")
TECH_DATA_12[2:9] <- lapply(TECH_DATA_4[2:9], as.numeric)

#Choose variable
TECH_12 <- TECH_DATA_12[,c(1,2)]

#Join variable
mapdataTECH_12 <- left_join(mapdata, TECH_12, by = "Region")                          # use left_join to match the data sets. 

# Create categories
mapdataTECH_12$KNI <- as.numeric(mapdataTECH_12$KNI)
mapdataTECH_12 <- mutate(mapdataTECH_12, cat = cut_to_classes(KNI, n = 3, style = "quantile", decimals = 2))

map_12 <- ggplot(mapdataTECH_12, aes(x = long, y = lat, group = group)) +                    
  geom_polygon(aes(fill = cat), color="grey", size = .1) +                    
  scale_fill_brewer(palette = "Purples") +                                    
  labs(title = "Knowledge complexity scores
        in ocean energy technology (2010-2019)",                 
       fill = "Score") + 
  coord_map(xlim = c(-22,42), ylim = c(35,71))+
  theme_few() + theme(panel.border = element_rect(colour = "gray"))+
  theme(axis.title = element_text(size = 10, colour = 'gray32', hjust =0.5)) + 
  theme(plot.title = element_text(size = 12, colour = 'gray28', hjust = 0.5))+
  annotate("text", x = Inf, y = Inf, hjust=1.2,vjust=2,
           label = paste("N = ", length(TECH_12$Region))) +   
  theme(legend.position="bottom")+   borders(database = "world", colour = "gray56") +   
  xlim(c(-30,60)) + ylim(c(0,100))+  
  geom_label_repel( data = mapdataTECH_12 %>% filter(order ==5) %>%  arrange(KNI)%>% top_n(5,KNI),                    
                   aes(x=long, y=lat, group = group, label=Region), label.size = 0.005, alpha =0.6, nudge_x = -0.02)




setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Plots")
png("map_KNI_6.png", width = 800, height = 500)
grid.arrange(map_11, map_12, ncol = 2, nrow = 1)
dev.off()


