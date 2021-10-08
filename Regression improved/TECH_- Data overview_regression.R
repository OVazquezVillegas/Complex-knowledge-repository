

# REGRESSION ANALYSIS (RAW VERSION) #

# Loading packages and establishing working directory 
library(dplyr)
library(MASS)
library(car)
library(moments)

# ----------------TECH 1 # ----------------------------------------------------------



# REGRESION ANALYSIS# -------------------------------------------------------
setwd("C:/Users/6674828/OneDrive - Universiteit Utrecht/Thesis-research paper/Complex-knowledge-repository/Regression improved")
TECH_DATA <- read.table("HYDRO_1.txt", sep = "")


TECH_DATA[2:9] <- lapply(TECH_DATA[2:9], as.numeric)
str(TECH_DATA)

DATA <- TECH_DATA[2:9]

cor <- round(cor(DATA),2)
print(cor) #More than 0.80 multicollinearity 

# Skewness (less than -1 or greater than 1 is highly skewed)
round(skewness(TECH_DATA$KNI), digits = 1) #yes
round(skewness(TECH_DATA$RD), digits = 1) 
round(skewness(TECH_DATA$K), digits = 1) #yes
round(skewness(TECH_DATA$C), digits = 1)
round(skewness(TECH_DATA$CL), digits = 1) #yes
round(skewness(TECH_DATA$GDP), digits = 1)
round(skewness(TECH_DATA$P), digits = 1) #yes
round(skewness(TECH_DATA$M), digits = 1) #yes

# Distribution
par(mfrow=c(2,2))
hist(TECH_DATA$KNI)
hist(TECH_DATA$RD)
hist(TECH_DATA$K)
hist(TECH_DATA$C)

par(mfrow=c(2,2))
hist(TECH_DATA$CL)
hist(TECH_DATA$GDP)
hist(TECH_DATA$P)
hist(TECH_DATA$M)


# Plots relationship 
par(mfrow=c(2,2))
plot(TECH_DATA$KNI, TECH_DATA$RD) #linear
plot(TECH_DATA$KNI, TECH_DATA$K) #log
plot(TECH_DATA$KNI, TECH_DATA$C) #no rel (nat)
plot(TECH_DATA$KNI, TECH_DATA$CL) #log

par(mfrow=c(2,2))
plot(TECH_DATA$KNI, TECH_DATA$GDP) #no rel (nat)
plot(TECH_DATA$KNI, TECH_DATA$P) #log
plot(TECH_DATA$KNI, TECH_DATA$M) #no rel (nat)





# REGRESION ANALYSIS# -------------------------------------------------------
setwd("C:/Users/6674828/OneDrive - Universiteit Utrecht/Thesis-research paper/Complex-knowledge-repository/Regresion improved")

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


# Model TECH_1: most relevant
model_TECH_1 <- lm(TECH_DATA_SCALED$KNI ~ TECH_DATA_SCALED$RD + TECH_DATA_SCALED$C +  TECH_DATA_SCALED$K +
                      TECH_DATA_SCALED$CL + TECH_DATA_SCALED$GDP + TECH_DATA_SCALED$P + TECH_DATA_SCALED$M)


print(model_HYDRO_1)


