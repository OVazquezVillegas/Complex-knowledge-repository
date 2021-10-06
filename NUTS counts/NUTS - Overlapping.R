
# Loading packages and establishing working directory 
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/NUTS")
library(purrr)

# PERIOD 1
# Reading files
Hydro1 <- read.delim("Hydro1.txt")
Geo1 <- read.delim("Geo1.txt")
PV1 <- read.delim("PV1.txt")
Ocean1 <- read.delim("Ocean1.txt")
Thermal1 <- read.delim("Thermal1.txt")
Wind1 <- read.delim("Wind1.txt")

Period1_unique <- rbind(Hydro1, Geo1, PV1, Ocean1, Thermal1, Wind1)
Period1_unique <- unique(Period1_unique) #322
Period1 <- list(Hydro1, Geo1, Ocean1, PV1, Ocean1, Thermal1, Wind1) %>% reduce(inner_join, by = "nuts2") #67 


# PERIOD 2
# Reading files
Hydro2 <- read.delim("Hydro2.txt")
Geo2 <- read.delim("Geo2.txt")
PV2 <- read.delim("PV2.txt")
Ocean2 <- read.delim("Ocean2.txt")
Thermal2 <- read.delim("Thermal2.txt")
Wind2 <- read.delim("Wind2.txt")

Period2_unique <- rbind(Hydro2, Geo2, PV2, Ocean2, Thermal2, Wind2)
Period2_unique <- unique(Period2_unique) #322
Period2 <- list(Hydro2, Geo2, Ocean2, PV2, Ocean2, Thermal2, Wind2) %>% reduce(inner_join, by = "nuts2") #67 

