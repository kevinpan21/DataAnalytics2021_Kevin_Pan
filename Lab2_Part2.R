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
abalone <- read.csv("abalone.csv")
attach(abalone)
colnames(abalone) <- c("sex","length",'diameter','height','whole_weight','shucked_wieght','viscera_wieght','shell_weight', 'rings' )
summary(abalone)
str(abalone)
summary(abalone$rings)
abalone$rings <- as.numeric(abalone$rings)
abalone$rings <- cut(abalone$rings, br=c(-1,8,11,35), labels = c("young", 'adult', 'old'))
abalone$rings <- as.factor(abalone$rings)
summary(abalone$rings)
aba <- abalone
aba$sex <- NULL
normalize <- function(x) {
  return ((x - min(x)) / (max(x) - min(x)))
}
aba[1:7] <- as.data.frame(lapply(aba[1:7], normalize))
summary(aba$shucked_wieght)
ind <- sample(2, nrow(aba), replace=TRUE, prob=c(0.7, 0.3))
KNNtrain <- aba[ind==1,]
KNNtest <- aba[ind==2,]
sqrt(2918)
library(class)
KNNpred <- knn(train = KNNtrain[1:7], test = KNNtest[1:7], cl = KNNtrain$rings, k = 55)
KNNpred
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

