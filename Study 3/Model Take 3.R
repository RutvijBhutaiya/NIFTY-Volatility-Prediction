

##### LINEAR REGRESSION #####

## STYDY 3 : RAW DATA ##


NF = read.csv('Modeldata_take3.csv')

NF <- NF[, -c(1)]

# Removing Nifty Related Features like Open, Volume, High etc.. 

#NF <- NF[, -c(1:5)]

attach(NF)

######  CHOOSE SIGNIFICANT VARIABLES  ######
############################################  

# Train (70%) and Validation (30%) data set
# For Test dataset we decided to take data from 25th Jan -> till date

ind <- sample(2, nrow(NF), replace = TRUE, prob = c(0.7, 0.3))

train <- NF[ind == 1,]
val <- NF[ind ==2,]


#ValActual = val[, c(3)]

#val <- val[, -c(3)] # Remove target variable


####################################################################################

## Linear Regression Model

# Chk the significant Vars

trainlr <- lm(Chg ~ ., data = train)


trainlr <- lm(Chg ~ VIXOpen + VIXHigh + VIXChg + GSECChg + GSECPrice + 
                GSECOpen + GSECLow +GSECChg + GSECHigh +
                FXHigh + FXChg + FXOpen +  OilOpen + OilLow + OilChg + OilHigh +
                FII_BUY + FII_SELL + DII_SELL + DII_BUY + Nifty_PE,
                data = train)


#print(trainlr)

summary(trainlr)


# Chk VIF : Inflation

#library(car)

#vif(trainlr)



## Val Dataset

val_chg  <- val[, c(6)]

val <- val[, -c(6)]


# Predict val dataset

pred_test <- predict(trainlr, newdata = val)


# Evaluate the Prediction Results with Actual

library(caret)

postResample(pred = pred_test, obs = val_chg)


## Plot a chart Actual vs. Predicted Nifty Change


plot(val_chg, col = 'blue')

plot(pred_test, col  = 'Red')

lines(val_chg, col = 'blue')

lines(pred_test, col  = 'Red')

#######################################################################################

#######################################################################################



##   *Live Data Test on NIFTY From 1 st FEB to 21st MAY*   ## 
###########################################################


Live <- read.csv('Live_Test_Data.csv')

Actual_Chg <- Live[, c(7)]

Live <- Live[, -c(1,7)]


# Predict Live dataset

pred_live <- predict(trainlr, newdata = Live)


# Evaluate the Prediction Results with Live Data


postResample(pred = pred_live, obs = Actual_Chg)


## Plot Graph 

plot(Actual_Chg, col = 'blue')

plot(pred_live, col  = 'Red')

lines(Actual_Chg, col = 'blue')

lines(pred_live, col  = 'Red')

