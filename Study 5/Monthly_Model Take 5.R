

## NIFTY MOMENT BAsed on MONTHLY DATA 


NiftyMTD <- read.csv('ModelData_Monthly.csv')


# Train (80%) and Validation (20%) -- Due to liited data. 

# For Testing Data set we decided to Take Jan 2021 till latest month data


ind <- sample(2, nrow(NiftyMTD), replace = TRUE, prob = c(0.8, 0.2))

MTDTrain <- NiftyMTD[ind == 1,]
MTDVal <- NiftyMTD[ind ==2,]

## Model Building 

trainlr <- lm(NFChg ~ ., data = MTDTrain)

summary(trainlr)


# Predict Val dataset

pred_val <- predict(trainlr, newdata = MTDVal)


# Evaluate the Prediction Results

library(caret)

postResample(pred = pred_val, obs = MTDVal$NFChg)





