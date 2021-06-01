

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


# NOTE: 
# # IN this Take 2 EDA we are not doing Playing with Volumes and New Feature Creation
# # We are Also not creating Feature Nifty Yield



# Check Missing value

colSums(is.na(NF))

# Summary 
summary(NF)


attach(NF)


# Histogram  and Skewness / QQ PLOT ; Skewness should be between -1 to 1

library(moments)

# par(mfrow = c(4,3))

hist(Price, main = 'Nifty Index', col = 'aquamarine3')
qqnorm(Price, main = 'Nifty Index', col = 'aquamarine3')
skewness(Price)  

hist(Nifty.Vol, main = 'BUY/SELL Volume', col = 'darkorchid2')
qqnorm(Nifty.Vol, main = 'BUY/SELL Volume', col = 'darkorchid2')
skewness(Nifty.Vol)  # NOT NORMAL

hist(VIXPrice, main = 'Volatility Index', col = 'aquamarine3')
qqnorm(VIXPrice, main = 'Volatility Index', col = 'aquamarine3')
skewness(VIXPrice)  # NOT NORMAL

hist(VIXChg, main = 'Volatility Change in %', col = 'deeppink2')
skewness(VIXChg)  # NOT NORNAL

hist(GSECPrice, main = 'Gov. Bond Index', col = 'aquamarine3')
skewness(GSECPrice)  

hist(GSECChg, main = 'Bond Price Change in %', col = 'deeppink2')
skewness(GSECChg)  # NOT NORMAL

hist(FXPrice, main = 'USD INR Pair', col = 'aquamarine3')
skewness(FXPrice)

hist(FXChg, main = 'USD INR change in %', col = 'deeppink2')
skewness(FXChg)

hist(OilPrice, main = 'Oil Price in INternational Mkt', col = 'aquamarine3')
skewness(OilPrice)

hist(OilChg, main = 'Oil Price Change in %', col = 'deeppink2')
skewness(OilChg)   # NOT NORMAL

hist(FII_BUY, main = 'FII BUY Volume', col = 'darkorchid2')
skewness(FII_BUY)  # NOT NORMAL

hist(FII_SELL, main = 'DII SELL Volume', col = 'darkorchid2')
skewness(FII_SELL)  # NOT NORMAL

hist(DII_BUY, main = 'FII BUY Volume', col = 'darkorchid2')
skewness(DII_BUY)  # NOT NORMAL

hist(DII_SELL, main = 'DII SELL Volume', col = 'darkorchid2')
skewness(DII_SELL)  # NOT NORMAL




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



##############################################################################################

##############################################################################################

# MODEL BUILDING

# Remove highly correlated and non - significant variables. 

# IMP Decision::
# We decised to take All in this model : Open CLose, HIgh, Low (Yes We know Multicollinearity)

# Remove Day, Month, Year

NF <- NF[, -c(1,2,3)]



## Check Most Importan Variables:

# Correlation Plot

library(ggcorrplot)

ggcorrplot(cor(NF), method = 'circle', type = 'lower', lab = TRUE)


# Model building Data

write.csv(NF, 'Modeldata_take2.csv')


#######################################################################################

#######################################################################################
