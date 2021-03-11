# loading in any 5 datasets (2,3,4,5,6)
# loading in the needed variables
getwd()
nyt2 <- read.csv("nyt2.csv")
attach(nyt2)
Imp2 = nyt2$Impressions
Age2 = nyt2$Age
Cli2 = nyt2$Clicks
Sign2 = nyt2$Signed_In
detach(nyt2)

nyt3 <- read.csv("nyt3.csv")
attach(nyt3)
Imp3 = nyt3$Impressions
Age3 = nyt3$Age
Cli3 = nyt2$Clicks
Sign3 = nyt2$Signed_In
detach(nyt3)

nyt4 <- read.csv("nyt4.csv")
attach(nyt4)
Imp4 = nyt4$Impressions
Age4 = nyt4$Age
detach(nyt4)

nyt5 <- read.csv("nyt5.csv")
attach(nyt5)
Imp5 = nyt5$Impressions
Age5 = nyt5$Age
detach(nyt5)

nyt6 <- read.csv("nyt6.csv")
attach(nyt6)
Imp6 = nyt6$Impressions
Age6 = nyt6$Age
detach(nyt6)


# creating boxplots
boxplot(Age2,Age3,Age4,Age5,Age6,names = c("nyt2","nyt3","nyt4","nyt5","nyt6"), ylab = "Age")
boxplot(Imp2,Imp3,Imp4,Imp5,Imp6,names = c("nyt2","nyt3","nyt4","nyt5","nyt6"), ylab = "Impressions")

# creating histograms
par(mfrow=c(1,2))
hist(Age2, main="Age for nyt2")
hist(Imp2, main="Impression for nyt2")

par(mfrow=c(1,2))
hist(Age3, main="Age for nyt3")
hist(Imp3, main="Impression for nyt3")

par(mfrow=c(1,2))
hist(Age4, main="Age for nyt4")
hist(Imp4, main="Impression for nyt4")

par(mfrow=c(1,2))
hist(Age5, main="Age for nyt5")
hist(Imp5, main="Impression for nyt5")

par(mfrow=c(1,2))
hist(Age6, main="Age for nyt6")
hist(Imp6, main="Impression for nyt6")


# creating Empirical Cumulative Distribution Function
par(mfrow=c(1,2))
plot(ecdf(Age2), main="Age for nyt2")
plot(ecdf(Imp2), main="Impression for nyt2")
qqplot(Age2, Imp2)

par(mfrow=c(1,2))
plot(ecdf(Age3), main="Age for nyt3")
plot(ecdf(Imp3), main="Impression for nyt3")
qqplot(Age3, Imp3)

par(mfrow=c(1,2))
plot(ecdf(Age4), main="Age for nyt4")
plot(ecdf(Imp4), main="Impression for nyt4")
qqplot(Age4, Imp4)

par(mfrow=c(1,2))
plot(ecdf(Age5), main="Age for nyt5")
plot(ecdf(Imp5), main="Impression for nyt5")
qqplot(Age5, Imp5)

par(mfrow=c(1,2))
plot(ecdf(Age6), main="Age for nyt6")
plot(ecdf(Imp6), main="Impression for nyt6")
qqplot(Age6, Imp6)

# performing significance test
cor.test(Age2, Imp2)
cor.test(Age3, Imp3)
cor.test(Age4, Imp4)
cor.test(Age5, Imp5)
cor.test(Age6, Imp6)

# repeating the above but with other variables
# creating histograms
par(mfrow=c(1,2))
hist(Cli2, main="Clicks for nyt2")
hist(Sign2, main="Sign_In for nyt2")
par(mfrow=c(1,2))
hist(cli3, main="Clicks for nyt3")
hist(Sign3, main="Sign_In for nyt3")

# creating Empirical Cumulative Distribution Function
par(mfrow=c(1,2))
plot(ecdf(Cli2), main="Clicks for nyt2")
plot(ecdf(Sign2), main="Sign_In for nyt2")
par(mfrow=c(1,2))
plot(ecdf(Cli3), main="Clicks for nyt3")
plot(ecdf(Sign3), main="Sign_In for nyt3")

# performing significance test
cor.test(Cli2, Sign3)
cor.test(Cli2, Sign3)

