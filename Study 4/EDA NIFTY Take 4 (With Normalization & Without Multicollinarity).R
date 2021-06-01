

# Feature taken into study: 

# Oil Price movement
# GSEC (Indian Government Bond price movement)
# VIX (Volatility INDEX)
# FII (Foreign Institutional Investors) and DII (Domestic Institutional Investors) 
# FX (USD INR currency pair movement)
# Nifty Volumes (Buy and Sell of Shares of top 50 companies on NSE)

# Objective: To predict Nifty change in %

#NOTE: Nifty changes also depends on events like UNion Budget, global crisis, economic performance, companies news etc..  

# Load the dateset

NF <- read.csv('Nifty.csv')


#View(NF)

attach(NF)


## REMOVE MULTICOLLINARITY LIke OPEN, HIGH, LOW

NF <- NF[, c(4,8,9,10,14,15,19,20,24,25,30,31,32,34,35,37),]


######################

# FEATURE ENGINEERING

######################


# NOTE: 
# # IN this Take 2 EDA we are not doing Playing with Volumes and New Feature Creation
# # We are Also not creating Feature Nifty Yield



# Check Missing value

colSums(is.na(NF))

# Summary 
summary(NF)


attach(NF)



## Box Plot / Outliers

par(mfrow = c(1,1))

boxplot(Price, main = 'Nifty Index', col = 'aquamarine3')

boxplot(Nifty.Vol, main = 'BUY/SELL Volume', col = 'darkorchid2')

boxplot(VIXPrice, main = 'Volatility Index', col = 'aquamarine3')

boxplot(VIXChg, main = 'Volatility Change in %', col = 'deeppink2')

boxplot(GSECPrice, main = 'Gov. Bond Index', col = 'aquamarine3')

boxplot(GSECChg, main = 'Bond Price Change in %', col = 'deeppink2')

boxplot(FXPrice, main = 'USD INR Pair', col = 'aquamarine3')

boxplot(FXChg, main = 'USD INR change in %', col = 'deeppink2')

boxplot(OilPrice, main = 'Oil Price in INternational Mkt', col = 'aquamarine3')

boxplot(OilChg, main = 'Oil Price Change in %', col = 'deeppink2')

boxplot(FII_BUY, main = 'FII BUY Volume', col = 'darkorchid2')

boxplot(FII_SELL, main = 'DII SELL Volume', col = 'darkorchid2')

boxplot(DII_BUY, main = 'FII BUY Volume', col = 'darkorchid2')

boxplot(DII_SELL, main = 'DII SELL Volume', col = 'darkorchid2')




# Histogram  and Skewness / QQ PLOT ; Skewness should be between -1 to 1

library(moments)
library(forecast)
library(MASS)

# par(mfrow = c(4,3))

####

hist(Price, main = 'Nifty Index', col = 'aquamarine3')
qqnorm(Price, main = 'Nifty Index', col = 'aquamarine3')
skewness(Price)  



####

hist(GSECChg, main = 'Bond Price Change in %', col = 'deeppink2')
skewness(GSECChg)  # NOT NORMAL : NOT REQUIRED After Outlier Removed

# Remove One Super Outlier @ 2913 Row
NF <- NF[-c(2913), ]
attach(NF)



#### 

hist(OilChg, main = 'Oil Price Change in %', col = 'deeppink2')
skewness(OilChg)   # NOT NORMAL : NOT REQUIRED : After Removed Outlier

summary(OilChg)
quantile(OilChg, 0.01)

# TWO Outliers Removed: HandPicked
NF <- NF[-c(193,192),]
attach(NF)


#### 

hist(Nifty.Vol, main = 'BUY/SELL Volume', col = 'darkorchid2')
qqnorm(Nifty.Vol, main = 'BUY/SELL Volume', col = 'darkorchid2')
skewness(Nifty.Vol)  # NOT NORMAL

BoxCox.lambda(Nifty.Vol)
Nifty.Vol <- log(Nifty.Vol)

####

hist(VIXPrice, main = 'Volatility Index', col = 'aquamarine3')
qqnorm(VIXPrice, main = 'Volatility Index', col = 'aquamarine3')
skewness(VIXPrice)  # NOT NORMAL

BoxCox.lambda(VIXPrice)
VIXPrice <- 1/VIXPrice

####

hist(VIXChg, main = 'Volatility Change in %', col = 'deeppink2')
skewness(VIXChg)  # NOT NORNAL: NOT REQUIRED : After CAPPING @ 99.5%

summary(VIXChg)
quantile(VIXChg, 0.995)

#Capping the Feature with 99.5% 
VIXChg <- ifelse(VIXChg > 0.256, 0.256, VIXChg)


####

hist(GSECPrice, main = 'Gov. Bond Index', col = 'aquamarine3')
skewness(GSECPrice)  



####

hist(FXPrice, main = 'USD INR Pair', col = 'aquamarine3')
skewness(FXPrice)

####

hist(FXChg, main = 'USD INR change in %', col = 'deeppink2')
skewness(FXChg)

####

hist(OilPrice, main = 'Oil Price in INternational Mkt', col = 'aquamarine3')
skewness(OilPrice)


####

hist(FII_BUY, main = 'FII BUY Volume', col = 'darkorchid2')
skewness(FII_BUY)  # NOT NORMAL

BoxCox.lambda(FII_BUY)
FII_BUY <- log(FII_BUY)

####
hist(FII_SELL, main = 'DII SELL Volume', col = 'darkorchid2')
skewness(FII_SELL)  # NOT NORMAL

BoxCox.lambda(FII_SELL)
FII_SELL <- log(FII_SELL)

####

hist(DII_BUY, main = 'FII BUY Volume', col = 'darkorchid2')
skewness(DII_BUY)  # NOT NORMAL

BoxCox.lambda(DII_BUY)
DII_BUY <- log(DII_BUY)

####

hist(DII_SELL, main = 'DII SELL Volume', col = 'darkorchid2')
skewness(DII_SELL)  # NOT NORMAL

BoxCox.lambda(DII_SELL)
DII_SELL <- log(DII_SELL)


##### ADJUST DATA FRAME WITH NEW NORMALIZED FEATURE #####

NF <- NF[, -c(2,4,5,12:15)]
attach(NF)

NF <- data.frame(NF, Nifty.Vol, VIXChg, VIXPrice, FII_BUY, FII_SELL, DII_BUY, DII_SELL)

attach(NF)

##############################################################################################

##############################################################################################



## Check Most Importan Variables:

# Correlation Plot

library(ggcorrplot)

ggcorrplot(cor(NF), method = 'circle', type = 'lower', lab = TRUE)


# Model building Data

write.csv(NF, 'Modeldata_take3.csv')


#######################################################################################

#######################################################################################
