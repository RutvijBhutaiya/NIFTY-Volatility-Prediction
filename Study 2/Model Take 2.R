
## STYDY 2 : NEXT DAY CHG : DEPENDENT VARIABLE ##
# MANY TIMES, THE IMPACT OF FEATURES LIKE FX, OIL, DO NOT IMPACT NIFTY CHG ON THE SAME DAY, BUT NEXT TRADING SEEEION : NEXT DAY


NFNext = read.csv('Modeldata_take2.csv')

## Removing Nifty related Features Like Volume, Open etc.. 



# Train (70%) and Validation (30%) data set
# For Test dataset we decided to take data from 25th Jan -> till date

indNext <- sample(2, nrow(NFNext), replace = TRUE, prob = c(0.7, 0.3))

trainNext <- NFNext[indNext == 1,]
valNext <- NFNext[indNext ==2,]


#ValActualNext = valNext[, c(3)]

#valNext <- valNext[, -c(3)] # Remove target variable


## Linear Regression Model

modelNext <- lm(Chg ~ ., data = trainNext)  ## Chk the significat variables

modelNext <- lm(Chg ~ VIXOpen + 
                  FII_BUY + FII_SELL + DII_BUY + DII_SELL +
                  Nifty_PE + Nifty_PE, data = trainNext)


summary(modelNext)

# Predict ValNext

pred_testNext <- predict(modelNext, newdata = valNext)


# Evaluate the Model

library(caret)

postResample(pred_testNext, valNext$Chg)



####  

##   *Live Data Test on NIFTY From 1 st FEB to 21st MAY*   ## 
###########################################################


Live <- read.csv('Live_Test_Data.csv')

Actual_Chg <- Live[, c(7)]

Live <- Live[, -c(1,7)]


# Predict Live dataset

pred_live <- predict(modelNext, newdata = Live)


# Evaluate the Prediction Results with Live Data


postResample(pred = pred_live, obs = Actual_Chg)


## Plot Graph 

plot(Actual_Chg, col = 'blue')

plot(pred_live, col  = 'Red')

lines(Actual_Chg, col = 'blue')

lines(pred_live, col  = 'Red')

