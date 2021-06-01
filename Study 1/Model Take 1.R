

##### LINEAR REGRESSION #####

## STYDY 1 : SAME DAY CHG : DEPENDENT VARIABLE ##


NF = read.csv('Modeldata.csv')

NF <- NF[, -c(1)]

## Removed Nifty Related Fetures like Volumes, Price, Open etc.. 

NF <- NF[, -c(1,2)]


## Chk the ANOVA:


ANOVA <- aov(Chg ~ VIXChg + GSECChg + FXChg + OilChg + 
                FII_BUY + FII_SELL + DII_BUY + DII_SELL + Nifty_PE + Nifty_Yld)

summary(ANOVA)

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


trainlr <- lm(Chg ~ VIXOpen + VIXChg  + GSECChg 
              + FXChg + OilChg + FII_BUY + FII_SELL + DII_BUY + DII_SELL + 
                Nifty_Yld + NF.VolumeTrendBEAR + NF.VolumeTrendWEAKBEAR,
                data = train)


#print(trainlr)

summary(trainlr)

# Chk VIF : Inflation Factor

library(car)

vif(trainlr)



# Check the Confidence Interval:
# Everytime in Regression equation don't take slope bliendly, 
# we can also choose based on Factor and modify slop accordingly on lower or higher side

confint(trainlr, "OilChg")
confint(trainlr, "FxChg")
confint(trainlr, "FII_SELL")


## ALSO CHK ANOVA DIRECTLY FOR THE BUILT MODEL 

anova(trainlr)


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

