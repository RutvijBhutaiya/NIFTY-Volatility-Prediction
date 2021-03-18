

##### LINEAR REGRESSION #####

## STYDY 1 : SAME DAY CHG : DEPENDENT VARIABLE ##


NF = read.csv('Modeldata.csv')


# Train (70%) and Validation (30%) data set
# For Test dataset we decided to take data from 25th Jan -> till date

ind <- sample(2, nrow(NF), replace = TRUE, prob = c(0.7, 0.3))

train <- NF[ind == 1,]
val <- NF[ind ==2,]


#ValActual = val[, c(3)]

#val <- val[, -c(3)] # Remove target variable


####################################################################################

## Linear Regression Model

trainlr <- lm(Chg ~ VIXOpen + VIXChg +
               GSECChg + FXOpen + FXChg + OilChg +
               FII_BUY + FII_SELL  + DII_SELL  + Nifty_Yld +
               NF.VolumeTrendBULL + NF.VolumeTrendWEAKBULL, data = train)

#print(trainlr)

summary(trainlr)


# Predict val dataset

pred_test <- predict(trainlr, newdata = val)


# Evaluate the Prediction Results with Actual

library(caret)

postResample(pred = pred_test, obs = val$Chg)


## Plot a chart Actual vs. Predicted Nifty Change

backtest = data.frame(pred_test, val)

plot(val$Chg, col = 'blue')

plot(pred_test, col  = 'Red')

lines(val$Chg, col = 'blue')

lines(pred_test, col  = 'Red')

#######################################################################################

######################################################################################


## STYDY 2 : NEXT DAY CHG : DEPENDENT VARIABLE ##
# MANY TIMES, THE IMPACT OF FEATURES LIKE FX, OIL, DO NOT IMPACT NIFTY CHG ON THE SAME DAY, BUT NEXT TRADING SEEEION : NEXT DAY


NFNext = read.csv('ModeldataNextDay.csv')



# As we shifted Chg resutlts to Next day, last row got NA for Chg feature and hence removing the row

NFNext = NFNext[-3117,]


# Train (70%) and Validation (30%) data set
# For Test dataset we decided to take data from 25th Jan -> till date

indNext <- sample(2, nrow(NFNext), replace = TRUE, prob = c(0.7, 0.3))

trainNext <- NFNext[indNext == 1,]
valNext <- NFNext[indNext ==2,]


#ValActualNext = valNext[, c(3)]

#valNext <- valNext[, -c(3)] # Remove target variable


## Linear Regression Model

modelNext <- lm(Chg ~ VIXChg + GSECOpen + 
                  FII_BUY + FII_SELL + DII_BUY + DII_SELL +
                  Nifty_PE + Nifty_Yld, data = trainNext)


summary(modelNext)

# Predict ValNext

pred_testNext <- predict(modelNext, newdata = valNext)

postResample(pred_testNext, valNext$Chg)
