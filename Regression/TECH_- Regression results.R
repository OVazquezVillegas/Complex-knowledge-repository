

# REGRESSION ANALYSIS  #

# Loading packages and establishing working directory 
library(dplyr)
library(MASS)
library(car)
library(moments)
library(stargazer)


# REGRESION ANALYSIS# -------------------------------------------------------
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")

TECH_DATA <- read.table("HYDRO_1.txt", sep = "")
TECH_DATA[2:9] <- lapply(TECH_DATA[2:9], as.numeric)
str(TECH_DATA)

# LOG TRANSFORMATION
DATA <- TECH_DATA[2:9]
DATA$KNI <- log(DATA$KNI)
DATA$K <- log(DATA$K)
DATA$CL <- log(DATA$CL +1)
DATA$P <- log(DATA$P)
DATA$M <- log(DATA$M +1)


# STANDARIZATION 
TECH_DATA_SCALED <- scale(DATA)
TECH_DATA_SCALED <- as.data.frame(TECH_DATA_SCALED)
TECH_DATA_SCALED <- cbind(TECH_DATA$Region,  TECH_DATA_SCALED)
colnames(TECH_DATA_SCALED)[1] <- "Region"


# Model HYDRO_1: most relevant
model_HYDRO_1 <- lm(TECH_DATA_SCALED$KNI ~ TECH_DATA_SCALED$RD + TECH_DATA_SCALED$C +  TECH_DATA_SCALED$K +
                    TECH_DATA_SCALED$CL + TECH_DATA_SCALED$GDP + TECH_DATA_SCALED$P + TECH_DATA_SCALED$M)




# REGRESION ANALYSIS# -------------------------------------------------------
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")

TECH_DATA <- read.table("HYDRO_2.txt", sep = "")
TECH_DATA[2:9] <- lapply(TECH_DATA[2:9], as.numeric)
str(TECH_DATA)

# LOG TRANSFORMATION
DATA <- TECH_DATA[2:9]
DATA$KNI <- log(DATA$KNI)
DATA$K <- log(DATA$K)
DATA$CL <- log(DATA$CL +1)
DATA$P <- log(DATA$P)
DATA$M <- log(DATA$M +1)


# STANDARIZATION 
TECH_DATA_SCALED <- scale(DATA)
TECH_DATA_SCALED <- as.data.frame(TECH_DATA_SCALED)
TECH_DATA_SCALED <- cbind(TECH_DATA$Region,  TECH_DATA_SCALED)
colnames(TECH_DATA_SCALED)[1] <- "Region"

# Model HYDRO_2: most relevant
model_HYDRO_2 <- lm(TECH_DATA_SCALED$KNI ~ TECH_DATA_SCALED$RD + TECH_DATA_SCALED$C +  TECH_DATA_SCALED$K +
                      TECH_DATA_SCALED$CL + TECH_DATA_SCALED$GDP + TECH_DATA_SCALED$P + TECH_DATA_SCALED$M)

# REGRESION ANALYSIS# -------------------------------------------------------
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")

TECH_DATA <- read.table("GEO_1.txt", sep = "")
TECH_DATA[2:9] <- lapply(TECH_DATA[2:9], as.numeric)
str(TECH_DATA)

# LOG TRANSFORMATION
DATA <- TECH_DATA[2:9]
DATA$KNI <- log(DATA$KNI)
DATA$K <- log(DATA$K)
DATA$CL <- log(DATA$CL +1)
DATA$P <- log(DATA$P)
DATA$M <- log(DATA$M +1)


# STANDARIZATION 
TECH_DATA_SCALED <- scale(DATA)
TECH_DATA_SCALED <- as.data.frame(TECH_DATA_SCALED)
TECH_DATA_SCALED <- cbind(TECH_DATA$Region,  TECH_DATA_SCALED)
colnames(TECH_DATA_SCALED)[1] <- "Region"
model_GEO_1 <- lm(TECH_DATA_SCALED$KNI ~ TECH_DATA_SCALED$RD + TECH_DATA_SCALED$C +  TECH_DATA_SCALED$K +
                    TECH_DATA_SCALED$CL + TECH_DATA_SCALED$GDP + TECH_DATA_SCALED$P + TECH_DATA_SCALED$M)


# REGRESION ANALYSIS# -------------------------------------------------------
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")

TECH_DATA <- read.table("GEO_2.txt", sep = "")
TECH_DATA[2:9] <- lapply(TECH_DATA[2:9], as.numeric)
str(TECH_DATA)

# LOG TRANSFORMATION
DATA <- TECH_DATA[2:9]
DATA$KNI <- log(DATA$KNI)
DATA$K <- log(DATA$K)
DATA$CL <- log(DATA$CL +1)
DATA$P <- log(DATA$P)
DATA$M <- log(DATA$M +1)


# STANDARIZATION 
TECH_DATA_SCALED <- scale(DATA)
TECH_DATA_SCALED <- as.data.frame(TECH_DATA_SCALED)
TECH_DATA_SCALED <- cbind(TECH_DATA$Region,  TECH_DATA_SCALED)
colnames(TECH_DATA_SCALED)[1] <- "Region"

model_GEO_2 <- lm(TECH_DATA_SCALED$KNI ~ TECH_DATA_SCALED$RD + TECH_DATA_SCALED$C +  TECH_DATA_SCALED$K +
                    TECH_DATA_SCALED$CL + TECH_DATA_SCALED$GDP + TECH_DATA_SCALED$P + TECH_DATA_SCALED$M)


# REGRESION ANALYSIS# -------------------------------------------------------
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")

TECH_DATA <- read.table("PV_1.txt", sep = "")
TECH_DATA[2:9] <- lapply(TECH_DATA[2:9], as.numeric)
str(TECH_DATA)

# LOG TRANSFORMATION
DATA <- TECH_DATA[2:9]
DATA$KNI <- log(DATA$KNI)
DATA$K <- log(DATA$K)
DATA$CL <- log(DATA$CL +1)
DATA$P <- log(DATA$P)
DATA$M <- log(DATA$M +1)


# STANDARIZATION 
TECH_DATA_SCALED <- scale(DATA)
TECH_DATA_SCALED <- as.data.frame(TECH_DATA_SCALED)
TECH_DATA_SCALED <- cbind(TECH_DATA$Region,  TECH_DATA_SCALED)
colnames(TECH_DATA_SCALED)[1] <- "Region"

model_PV_1 <- lm(TECH_DATA_SCALED$KNI ~ TECH_DATA_SCALED$RD + TECH_DATA_SCALED$C +  TECH_DATA_SCALED$K +
                   TECH_DATA_SCALED$CL + TECH_DATA_SCALED$GDP + TECH_DATA_SCALED$P + TECH_DATA_SCALED$M)


# REGRESION ANALYSIS# -------------------------------------------------------
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")

TECH_DATA <- read.table("PV_2.txt", sep = "")
TECH_DATA[2:9] <- lapply(TECH_DATA[2:9], as.numeric)
str(TECH_DATA)

# LOG TRANSFORMATION
DATA <- TECH_DATA[2:9]
DATA$KNI <- log(DATA$KNI)
DATA$K <- log(DATA$K)
DATA$CL <- log(DATA$CL +1)
DATA$P <- log(DATA$P)
DATA$M <- log(DATA$M +1)


# STANDARIZATION 
TECH_DATA_SCALED <- scale(DATA)
TECH_DATA_SCALED <- as.data.frame(TECH_DATA_SCALED)
TECH_DATA_SCALED <- cbind(TECH_DATA$Region,  TECH_DATA_SCALED)
colnames(TECH_DATA_SCALED)[1] <- "Region"

model_PV_2 <- lm(TECH_DATA_SCALED$KNI ~ TECH_DATA_SCALED$RD + TECH_DATA_SCALED$C +  TECH_DATA_SCALED$K +
                   TECH_DATA_SCALED$CL + TECH_DATA_SCALED$GDP + TECH_DATA_SCALED$P + TECH_DATA_SCALED$M)





# REGRESION ANALYSIS# -------------------------------------------------------
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")

TECH_DATA <- read.table("WIND_1.txt", sep = "")
TECH_DATA[2:9] <- lapply(TECH_DATA[2:9], as.numeric)
str(TECH_DATA)

# LOG TRANSFORMATION
DATA <- TECH_DATA[2:9]
DATA$KNI <- log(DATA$KNI)
DATA$K <- log(DATA$K)
DATA$CL <- log(DATA$CL +1)
DATA$P <- log(DATA$P)
DATA$M <- log(DATA$M +1)


# STANDARIZATION 
TECH_DATA_SCALED <- scale(DATA)
TECH_DATA_SCALED <- as.data.frame(TECH_DATA_SCALED)
TECH_DATA_SCALED <- cbind(TECH_DATA$Region,  TECH_DATA_SCALED)
colnames(TECH_DATA_SCALED)[1] <- "Region"

model_WIND_1 <- lm(TECH_DATA_SCALED$KNI ~ TECH_DATA_SCALED$RD + TECH_DATA_SCALED$C +  TECH_DATA_SCALED$K +
                     TECH_DATA_SCALED$CL + TECH_DATA_SCALED$GDP + TECH_DATA_SCALED$P + TECH_DATA_SCALED$M)


# REGRESION ANALYSIS# -------------------------------------------------------
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")

TECH_DATA <- read.table("WIND_2.txt", sep = "")
TECH_DATA[2:9] <- lapply(TECH_DATA[2:9], as.numeric)
str(TECH_DATA)

# LOG TRANSFORMATION
DATA <- TECH_DATA[2:9]
DATA$KNI <- log(DATA$KNI)
DATA$K <- log(DATA$K)
DATA$CL <- log(DATA$CL +1)
DATA$P <- log(DATA$P)
DATA$M <- log(DATA$M +1)


# STANDARIZATION 
TECH_DATA_SCALED <- scale(DATA)
TECH_DATA_SCALED <- as.data.frame(TECH_DATA_SCALED)
TECH_DATA_SCALED <- cbind(TECH_DATA$Region,  TECH_DATA_SCALED)
colnames(TECH_DATA_SCALED)[1] <- "Region"

model_WIND_2 <- lm(TECH_DATA_SCALED$KNI ~ TECH_DATA_SCALED$RD + TECH_DATA_SCALED$C +  TECH_DATA_SCALED$K +
                     TECH_DATA_SCALED$CL + TECH_DATA_SCALED$GDP + TECH_DATA_SCALED$P + TECH_DATA_SCALED$M)


# REGRESION ANALYSIS# -------------------------------------------------------
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")

TECH_DATA <- read.table("THERMAL_1.txt", sep = "")
TECH_DATA[2:9] <- lapply(TECH_DATA[2:9], as.numeric)
str(TECH_DATA)

# LOG TRANSFORMATION
DATA <- TECH_DATA[2:9]
DATA$KNI <- log(DATA$KNI)
DATA$K <- log(DATA$K)
DATA$CL <- log(DATA$CL +1)
DATA$P <- log(DATA$P)
DATA$M <- log(DATA$M +1)


# STANDARIZATION 
TECH_DATA_SCALED <- scale(DATA)
TECH_DATA_SCALED <- as.data.frame(TECH_DATA_SCALED)
TECH_DATA_SCALED <- cbind(TECH_DATA$Region,  TECH_DATA_SCALED)
colnames(TECH_DATA_SCALED)[1] <- "Region"

model_THERMAL_1 <- lm(TECH_DATA_SCALED$KNI ~ TECH_DATA_SCALED$RD + TECH_DATA_SCALED$C +  TECH_DATA_SCALED$K +
                        TECH_DATA_SCALED$CL + TECH_DATA_SCALED$GDP + TECH_DATA_SCALED$P + TECH_DATA_SCALED$M)



# REGRESION ANALYSIS# -------------------------------------------------------
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")

TECH_DATA <- read.table("THERMAL_2.txt", sep = "")
TECH_DATA[2:9] <- lapply(TECH_DATA[2:9], as.numeric)
str(TECH_DATA)

# LOG TRANSFORMATION
DATA <- TECH_DATA[2:9]
DATA$KNI <- log(DATA$KNI)
DATA$K <- log(DATA$K)
DATA$CL <- log(DATA$CL +1)
DATA$P <- log(DATA$P)
DATA$M <- log(DATA$M +1)


# STANDARIZATION 
TECH_DATA_SCALED <- scale(DATA)
TECH_DATA_SCALED <- as.data.frame(TECH_DATA_SCALED)
TECH_DATA_SCALED <- cbind(TECH_DATA$Region,  TECH_DATA_SCALED)
colnames(TECH_DATA_SCALED)[1] <- "Region"


model_THERMAL_2 <- lm(TECH_DATA_SCALED$KNI ~ TECH_DATA_SCALED$RD + TECH_DATA_SCALED$C +  TECH_DATA_SCALED$K +
                        TECH_DATA_SCALED$CL + TECH_DATA_SCALED$GDP + TECH_DATA_SCALED$P + TECH_DATA_SCALED$M)



# REGRESION ANALYSIS# -------------------------------------------------------
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")

TECH_DATA <- read.table("OCEAN_1.txt", sep = "")
TECH_DATA[2:9] <- lapply(TECH_DATA[2:9], as.numeric)
str(TECH_DATA)

# LOG TRANSFORMATION
DATA <- TECH_DATA[2:9]
DATA$KNI <- log(DATA$KNI)
DATA$K <- log(DATA$K)
DATA$CL <- log(DATA$CL +1)
DATA$P <- log(DATA$P)
DATA$M <- log(DATA$M +1)


# STANDARIZATION 
TECH_DATA_SCALED <- scale(DATA)
TECH_DATA_SCALED <- as.data.frame(TECH_DATA_SCALED)
TECH_DATA_SCALED <- cbind(TECH_DATA$Region,  TECH_DATA_SCALED)
colnames(TECH_DATA_SCALED)[1] <- "Region"


model_OCEAN_1 <- lm(TECH_DATA_SCALED$KNI ~ TECH_DATA_SCALED$RD +  TECH_DATA_SCALED$C + TECH_DATA_SCALED$K + 
                      TECH_DATA_SCALED$CL + TECH_DATA_SCALED$GDP + TECH_DATA_SCALED$P + TECH_DATA_SCALED$M)


# REGRESION ANALYSIS# -------------------------------------------------------
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")

TECH_DATA <- read.table("OCEAN_2.txt", sep = "")
TECH_DATA[2:9] <- lapply(TECH_DATA[2:9], as.numeric)
str(TECH_DATA)

# LOG TRANSFORMATION
DATA <- TECH_DATA[2:9]
DATA$KNI <- log(DATA$KNI)
DATA$K <- log(DATA$K)
DATA$CL <- log(DATA$CL +1)
DATA$P <- log(DATA$P)
DATA$M <- log(DATA$M +1)


# STANDARIZATION 
TECH_DATA_SCALED <- scale(DATA)
TECH_DATA_SCALED <- as.data.frame(TECH_DATA_SCALED)
TECH_DATA_SCALED <- cbind(TECH_DATA$Region,  TECH_DATA_SCALED)
colnames(TECH_DATA_SCALED)[1] <- "Region"


model_OCEAN_2 <- lm(TECH_DATA_SCALED$KNI ~ TECH_DATA_SCALED$RD +   TECH_DATA_SCALED$C + TECH_DATA_SCALED$K +
                      TECH_DATA_SCALED$CL + TECH_DATA_SCALED$GDP + TECH_DATA_SCALED$P + TECH_DATA_SCALED$M)


table_1 <- stargazer(model_HYDRO_1, model_GEO_1, model_PV_1, model_WIND_1, model_THERMAL_1,
                     model_OCEAN_1, type = "html", out = "table_1.htm", column.labels = 
                       c("Hydropower", "Geothermal", "Solar photovoltaics", "Wind power",
                         "Concentrated solar power", "Ocean energy"), covariate.labels 
                     = c("Scientific relatedness", 
                         "Carbon lock-in","Knowledge accumulation(log)",
                         "Complementary knowledge (log)", 
                         "GDP", "Population (log)", "Installed capacity", 
                         "Constant"), dep.var.labels = c("Knowledge complexity index (log)"),
                         notes.label = c(" Notes: ***, **, * statistically significant at 
                                         .01 percent, .05 percent and .1 percent, respectively"),
                     notes = c("Notes: Carbon lock-in = Technological and infrastructural carbon lock-in (CL); Complementary knowledge = Access to complementary knowldge"),
                     notes.align = "r",font.size = "small")


table_2 <- stargazer(model_HYDRO_2, model_GEO_2, model_PV_2, model_WIND_2, model_THERMAL_2,
                     model_OCEAN_2, type = "html", out = "table_2.htm", column.labels = 
                       c("Hydropower", "Geothermal", "Solar photovoltaics", "Wind power",
                         "Concentrated solar power", "Ocean energy"), covariate.labels 
                     = c("Scientific relatedness", 
                         "Carbon lock-in", "Knowledge accumulation(log)",
                         "Complementary knowledge (log)", 
                         "GDP", "Population (log)", "Installed capacity (log)", 
                         "Constant"), dep.var.labels = c("Knowledge complexity index (log)"),
                     notes.label = c(";***, **, * statistically significant at 
                                         .01 percent, .05 percent and .1 percent, respectively"),
                     notes = c("Notes: Carbon lock-in = Technological and infrastructural carbon lock-in (CL); Complementary knowledge = Access to complementary knowldge"),
                     notes.align = "r", font.size = "small")




# KNI & RD 
(exp(0.316)-1)*100