

# REGRESSION ANALYSIS (RAW VERSION) #

# Loading packages and establishing working directory 
library(dplyr)
library(MASS)
library(car)
library(moments)

# ----------------TECH 1 # ----------------------------------------------------------



# REGRESION ANALYSIS# -------------------------------------------------------
setwd("~/OneDrive - UNIVERSIDAD NACIONAL AUTÓNOMA DE MÉXICO/MSc Innovation Sciences/Thesis/Data analysis/Regression")

TECH_DATA <- read.table("OCEAN_1.txt", sep = "")


TECH_DATA[2:9] <- lapply(TECH_DATA[2:9], as.numeric)
str(TECH_DATA)

DATA <- TECH_DATA[2:9]

cor <- round(cor(DATA),2)

# Skewness
round(skewness(TECH_DATA$KNI), digits = 1)
round(skewness(TECH_DATA$RD), digits = 1)
round(skewness(TECH_DATA$K), digits = 1)
round(skewness(TECH_DATA$C), digits = 1)
round(skewness(TECH_DATA$CL), digits = 1)
round(skewness(TECH_DATA$GDP), digits = 1)
round(skewness(TECH_DATA$P), digits = 1)
round(skewness(TECH_DATA$M), digits = 1)

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



##### MODELS


test <- lm(TECH_DATA$KNI ~ TECH_DATA$RD)
summary(test)


test_a <- lm(log(TECH_DATA$KNI) ~ TECH_DATA$RD)
summary(test_a)

# Model A: all variables
model_A <- lm(TECH_DATA$KNI ~ TECH_DATA$RD + TECH_DATA$K + TECH_DATA$C + 
                TECH_DATA$CL + TECH_DATA$GDP +  TECH_DATA$P + TECH_DATA$M)

summary(model_A)
vif(model_A)
plot(model_A)


# Model a: response variables
model_a <-  lm(TECH_DATA$KNI ~ TECH_DATA$RD + TECH_DATA$K + TECH_DATA$C + 
                 TECH_DATA$CL) 
summary(model_a)
plot(model_a)

# Model aa: control variables
model_aa <- lm(TECH_DATA$KNI ~  TECH_DATA$GDP +  TECH_DATA$P + TECH_DATA$M)

summary(model_aa)
vif(model_aa)
plot(model_aa)




# LOGARITHIMC TRANSFORMATION
#Model C= all 
model_C <- lm(log(TECH_DATA$KNI) ~ log(TECH_DATA$RD +1) + log(TECH_DATA$K +1) + TECH_DATA$C + 
                log(TECH_DATA$CL +1) + TECH_DATA$GDP +  TECH_DATA$P + log(TECH_DATA$M+1))
summary(model_C)
vif(model_C)

# Model c: most relevant
model_c <- lm(log(TECH_DATA$KNI) ~ TECH_DATA$RD + log(TECH_DATA$K +1) +  TECH_DATA$C +
                log(TECH_DATA$CL +1) + TECH_DATA$GDP + log(TECH_DATA$P) + log(TECH_DATA$M+1))

summary(model_c)
plot(model_c)
vif(model_c)

# Model d: most relevant
model_d <- lm(TECH_DATA$KNI ~ log(TECH_DATA$RD) + log(TECH_DATA$K +1) +  TECH_DATA$C +
                log(TECH_DATA$CL +1) + TECH_DATA$GDP + log(TECH_DATA$P) + TECH_DATA$M)

summary(model_d)
plot(model_d)
vif(model_d)


# Model d: most relevant
model_e <- lm(log(TECH_DATA$KNI) ~ log(TECH_DATA$RD) + log(TECH_DATA$K +1) +  TECH_DATA$C +
                log(TECH_DATA$CL +1) + TECH_DATA$GDP + log(TECH_DATA$P) + TECH_DATA$M)

summary(model_e)
plot(model_e)
vif(model_e)

# STANDARIZATION 
DATA <- TECH_DATA[,(2:9)]
TECH_DATA_SCALED <- scale(DATA)
TECH_DATA_SCALED <- as.data.frame(TECH_DATA_SCALED)
TECH_DATA_SCALED <- cbind(TECH_DATA$Region,  TECH_DATA_SCALED)
DATA_SCALED <- TECH_DATA_SCALED[,2:9]
colnames(TECH_DATA_SCALED)[1] <- "Region"


model_B <- lm(TECH_DATA_SCALED$KNI ~ TECH_DATA_SCALED$RD + TECH_DATA_SCALED$K + TECH_DATA_SCALED$K + 
                TECH_DATA_SCALED$C + TECH_DATA_SCALED$CL + TECH_DATA_SCALED$GDP +  TECH_DATA_SCALED$P + TECH_DATA_SCALED$M)

summary(model_B)

