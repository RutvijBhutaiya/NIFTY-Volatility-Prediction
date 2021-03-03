

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


######################

# FEATURE ENGINEERING

######################



# NiftyCHG = If NIfty change from previous closing % is negative 'Down' else 'Up'

NiftyCHG <-  ifelse(Chg > 0, "Up", "Down")

library(dplyr)
library(zoo)


# Avg2day = Volumes moving average of previous two days, with condition to the lead day. If 2 day Avg is less than lead day 'High' else 'Low'

Avg2day <- ifelse(Nifty.Vol > lead(rollapply(Nifty.Vol, 2, mean, 
                                            partial = TRUE)), 'High', 'Low')

## WilliamsR

# WR_High <- lead(rollapply(Price, 15, max, partial = TRUE))

# WR_Low <- lead(rollapply(Price, 15, min, partial = TRUE))

# WilliamsR <- ((WR_High - Price)/(WR_High - WR_Low)) * (-100)

# NF <- data.frame(NF, WilliamsR)

# VolumeTrend = Trend to check BULL, WEAKBULL market condition based on NiftyCHG and Avg2day
# VolumeTrend to check how Volumes has infulence on Nifty!

VolumeTrend <- ifelse((Avg2day == 'High') & (NiftyCHG == 'Up'), 'BULL', 
                        ifelse((Avg2day == 'High') & (NiftyCHG == 'Down'), 'BEAR',
                               ifelse((Avg2day == 'Low') & (NiftyCHG == 'Up'), 'WEAKBULL', 'WEAKBEAR')))


NF <- data.frame(NF, NiftyCHG, Avg2day, VolumeTrend)
attach(NF)

NF = NF[-3118, ]

attach(NF)


# NIFTY PE and Yield
# Generally, NIFTY Yield is Lower than Gsec bond Yield, Stock Market is overvalued. 


Nifty_Yld = 100/NF$Nifty_PE

NF = data.frame(NF, Nifty_Yld)


# Remove Variables:
# Our objective is not to predict NIFTY moment with Time Series, hence removing time related variables 'Year'

# Hear We decided to keep FII & DII BUY and SELL variables insterad on NET. 
# We believe it would give FII trading volumes and Volatility
# FII_BUY FII_ SELL captured in FII_NET
# DII_BUY DII_ SELL captured in DII_NET

# NiftyCHG is presented by chg

NF <- NF[, c(1,2,4:32,34,35,37,38,39,40,41)] # IMP variables Only


# Check Missing value

colSums(is.na(NF))

# Summary 
summary(NF)


attach(NF)


# Skewness / Histogram

par(mfrow = c(4,3))

hist(Price, main = 'Nifty Index', col = 'aquamarine3')

hist(Nifty.Vol, main = 'BUY/SELL Volume', col = 'darkorchid2')

hist(VIXPrice, main = 'Volatility Index', col = 'aquamarine3')

hist(VIXChg, main = 'Volatility Change in %', col = 'deeppink2')

hist(GSECPrice, main = 'Gov. Bond Index', col = 'aquamarine3')

hist(GSECChg, main = 'Bond Price Change in %', col = 'deeppink2')

hist(FXPrice, main = 'USD INR Pair', col = 'aquamarine3')

hist(FXChg, main = 'USD INR change in %', col = 'deeppink2')

hist(OilPrice, main = 'Oil Price in INternational Mkt', col = 'aquamarine3')

hist(OilChg, main = 'Oil Price Change in %', col = 'deeppink2')

hist(FII_BUY, main = 'FII BUY Volume', col = 'darkorchid2')

hist(FII_SELL, main = 'DII SELL Volume', col = 'darkorchid2')

hist(DII_BUY, main = 'FII BUY Volume', col = 'darkorchid2')

hist(DII_SELL, main = 'DII SELL Volume', col = 'darkorchid2')


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


## Box plot MultiVariable

boxplot(Nifty.Vol ~ VolumeTrend, main = 'Volume Trend and Nifty Volume',  col = 'gold')

boxplot(Nifty.Vol ~ factor(Month), main = 'MOnth wise Nifty Volume', col = 'aquamarine3')


# VIX + VOlume Trend
# VIX should be high for BEAR and BULL, Here it's same. (Means there is no significat diff on Violumes of Nifty)

boxplot(VIXPrice ~ VolumeTrend, main = 'Volume Trend and Nifty Volume',  col = 'gold')

# Hence we decide not to include Nifty Volume as it has NO significant impact. 

# Scattered Plot for VIX and FII

plot(VIXPrice, DII_SELL)



##############################################################################################

##############################################################################################

# MODEL BUILDING

# Remove highly correlated and non - significant variables. 

# IMP Decision::
# We decised to take 'Open' instead of 'Price(close)'
# Chg is alrady reflection of diffrence in % between Open and Close price
# Generally if we place order in morning Open price (Assume immidiately market opens) we can predict the % chg and close price




NF <- NF[ ,c(4,7,8,10,13,15,18,20,23,25,29:34,37,38)]

# Create Dummy Variables for Factor :: VolumeTrend

Nf.matrix <- model.matrix( ~ NF$VolumeTrend -1, data = NF)

NF <- data.frame(NF, Nf.matrix)

NF<- NF[, -c(17)]

attach(NF)


## Check Most Importan Variables:

# Correlation Plot

library(ggcorrplot)

ggcorrplot(cor(NF), method = 'circle', type = 'lower', lab = TRUE)



# Train (70%) and Validation (30%) data set
# For Test dataset we decided to take data from 25th Jan -> till date

ind <- sample(2, nrow(NF), replace = TRUE, prob = c(0.7, 0.3))

train <- NF[ind == 1,]
val <- NF[ind ==2,]


ValActual = val[, c(3)]

val <- val[, -c(3)] # Remove target variable



####################################################################################

## Linear Regression Model

attach(train)


trainlr = lm(Chg ~ train$Open + train$VIXOpen + train$VIXChg + 
                train$GSECChg + train$FXOpen + train$FXChg + 
               train$FII_BUY + train$FII_SELL + train$DII_BUY + train$DII_SELL  + train$Nifty_Yld +
                train$NF.VolumeTrendBULL + train$NF.VolumeTrendWEAKBULL)

print(trainlr)

summary(trainlr)


model = predict(trainlr, data = val)


ValPredict = 