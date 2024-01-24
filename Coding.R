getwd()
setwd("C:/Users/HP 15/Documents/R")
list.files()

#2)	Load the data into R. 
dbt<- read.csv("AAMD.csv")

#3) Convert the variable Outcome into a factor variable
str(dbt)
dbt$Outcome <- as.factor(dbt$Outcome)

#4) Removing the Random Variable
dbt <- dbt[,-c(10)]

#splitting data into training and testing
Train <- dbt[1:500,]
Test <- dbt[501:768,]

#training a logistic regression model
modeldbt <- glm(formula=Outcome~.,
                data = Train,
                family = "binomial")
summary(modeldbt)

#running a stepwise regression
stepmodel <- step(modeldbt, direction="backward",scope=(modeldbt),trace=0)
summary(stepmodel)

#generating predictions on training and testing model
trainpreds <- stepmodel$fitted.values
testpreds <- predict(stepmodel,Test,type="response")
allpreds <- c(trainpreds, testpreds)

#ROC Curve for Training data
library(PRROC)
roc.train <- roc.curve(scores.class0 = stepmodel$fitted.values, 
                 weights.class0 = as.numeric(as.character(Train$Outcome)),curve = T)
print(roc.train)
plot(roc.train)

#ROC curve for Testing data
roc.test <- roc.curve(scores.class0 = predict(stepmodel,Test,type="response"), 
                 weights.class0 = as.numeric(as.character(Test$Outcome)),curve = T)
print(roc.test)
plot(roc.test)

#PR Curve for Training data
prcurve.train <- pr.curve(scores.class0 = stepmodel$fitted.values, 
                          weights.class0 = as.numeric(as.character(Train$Outcome)),curve = T)
print(prcurve.train)
plot(prcurve.train)

#PR Curve for Testing data
prcurve.test <- pr.curve(scores.class0 = predict(stepmodel,Test,type="response"), 
                         weights.class0 = as.numeric(as.character(Test$Outcome)),curve = T)
print(prcurve.test)
plot(prcurve.test)


#downloading file
write.csv (allpreds, file = "Outcome prediction for train and test.csv")
