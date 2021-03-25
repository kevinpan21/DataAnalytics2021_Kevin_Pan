# retrieve the dataset
library("readxl")
getwd()
mann <- read_excel("rollingsales_manhattan.xls", skip = 4)
attach(mann)
View(mann)

# type of patterns or trends
summary(mann)
colnames(mann)

# initializing variables
neighorhood <- mann$NEIGHBORHOOD
zipCode <- mann$`ZIP CODE`
salePrice <- mann$`SALE\nPRICE`
saleDate <- mann$`SALE DATE`
sqrFeet <- mann$`GROSS SQUARE FEET`

# hypothesis: correlation between the sale price and square feet
summary(salePrice)
hist(salePrice)
hist(salePrice, xlim=c(0,1.0e+7), breaks=1000)
boxplot(salePrice)

summary(sqrFeet)
hist(sqrFeet)
boxplot(sqrFeet)


# data cleaning
library(dplyr)
df <- data.frame(salePrice, neighorhood, zipCode, saleDate, sqrFeet)
df <- na.omit(df)
df <- df[df$salePrice != 0,]
df = filter(df,data$salePrice != 0,)
df <- df[df$sqrFeet != 0,]
df = filter(df,data$sqrFeet != 0,)
View(df)

library(caTools)
split = sample.split(df$salePrice, SplitRatio = 0.7)
training_set=subset(df,split==TRUE)
test_set=subset(df,split==FALSE)

# using the models to predict
regressor=lm(formula=training_set$salePrice~., data=training_set)
summary(regressor)
t.test(df$salePrice)


detach(mann)