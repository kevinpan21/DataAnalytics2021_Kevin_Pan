#################### exercise1 ####################
multiReg <- read.csv("dataset_multipleRegression.csv")
attach(multiReg)
View(multiReg)
# using the linear model
linearModel <- lm(ROLL ~ UNEM + HGRAD)
UNEM = c(7)
HGRAD = c(90000)
INC = c(25000)
UNEM_HGRAD <- data.frame(UNEM,HGRAD)
predictedRoll1 <- predict(linearModel, UNEM_HGRAD, interval='prediction')
predictedRoll1
UNEM_HGRAD_INC <- data.frame(UNEM, HGRAD, INC)
predictedRoll2 <- predict(linearModel, UNEM_HGRAD_INC, interval='prediction')
predictedRoll2
detach(multiReg)

#################### exercise2 ####################
library(class)
abalone <- read.csv("abalone.csv")
attach(abalone)
View(abalone)
abalone$Rings <- as.numeric(abalone$Rings)
abalone$Sex <- NULL
ind <- sample(2,nrow(abalone), replace=TRUE, prob = c(0.8, 0.2))
trainData <- abalone[ind==1,]
testData <- abalone[ind==2,]
# using the knn model
KNNpred <- knn(train=trainData[1:7],test=testData[1:7],cl=trainData$Rings,k=55)
table(KNNpred)
detach(abalone)

#################### exercise3 ####################
library(ggplot2)
View(iris)
sapply(iris[,-5],var)
k.max<-10
wss <- sapply(1:k.max,function(k){kmeans(iris[,3:4],k,nstart=20,iter.max=1000)$tot.withinss})
wss
plot(1:k.max,wss,type="b",xlab = "Number of clusters(k)",ylab="within cluster sum of squares")
icluster<-kmeans(iris[,3:4],3,nstart=20)
table(icluster$cluster,iris$Species)

