

##### LINEAR REGRESSION #####

## STYDY 4 :  WITH NORMALIZATION ##


NF = read.csv('Modeldata_take3.csv')

NF <- NF[, -c(1)]



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


trainlr <- lm(Chg ~ VIXChg + GSECChg + FXChg + OilChg + 
                FII_BUY + FII_SELL + DII_BUY + DII_SELL,
                data = train)


#print(trainlr)

summary(trainlr)


# Chk VIF : Inflation Factor : Lesser the better : Chk Online

library(car)

vif(trainlr)


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

#######################################################################################
