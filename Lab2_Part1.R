##################### Lab2 Part1 a) #####################
EPI_data <- read.csv('EPI_data.csv')
View(EPI_data)
attach(EPI_data)
fix(EPI_data)
EPI <- EPI_data$EPI[!is.na(EPI)]
DALY <- EPI_data$DALY[!is.na(DALY)]
summary(EPI)
summary(DALY)

# central tendency
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}
print(getmode(EPI))
print(getmode(DALY))

# summary statistic
mean(EPI, na.rm = "TRUE")
median(EPI, na.rm = "TRUE")
mean(DALY, na.rm = "TRUE")
median(DALY, na.rm = "TRUE")

# histogram
hist(EPI)
hist(DALY)

# box plot and qqplot
boxplot(EPI, DALY)
qqplot(EPI, DALY)

##################### Lab2 Part1 b) #####################
EPI_data <- subset(EPI_data, EPI_regions=="Europe", na.rm=TRUE)
DALY <- EPI_data$DALY
ENVHEALTH <- EPI_data$ENVHEALTH
AIR_H <- EPI_data$AIR_H
WATER_H <- EPI_data$WATER_H
boxplot(ENVHEALTH,DALY,AIR_H,WATER_H)
ImENVH <- lm(ENVHEALTH~DALY+AIR_H+WATER_H)
ImENVH
summary(ImENVH)
cENVH<-coef(lmENVH)
cENVH
DALYNEW<-c(seq(1,39,1))
AIR_HNEW<-c(seq(1,39,1))
WATER_HNEW<-c(seq(1,39,1))
NEW <-data.frame(DALYNEW,AIR_HNEW,WATER_HNEW)
pENV<-na.omit(predict(lmENVH,NEW,interval="prediction"))
cENV<-na.omit(predict(lmENVH,NEW,interval="confidence"))
pENV
cENV

# repeat for AIR_E
AIR_E <- EPI_data$AIR_E
boxplot(AIR_E,DALY,AIR_H,WATER_H)
lmENVH <- lm(AIR_E~DALY+AIR_H+WATER_H)
ImENVH
summary(ImENVH)
cENVH<-coef(lmENVH)
cENVH
DALYNEW<-c(seq(1,39,1))
AIR_HNEW<-c(seq(1,39,1))
WATER_HNEW<-c(seq(1,39,1))
NEW <-data.frame(DALYNEW,AIR_HNEW,WATER_HNEW)
pENV<-na.omit(predict(lmENVH,NEW,interval="prediction"))
cENV<-na.omit(predict(lmENVH,NEW,interval="confidence"))
pENV
cENV


# repeat for CLIMATE
CLIMATE <- EPI_data$CLIMATE
boxplot(CLIMATE,DALY,AIR_H,WATER_H)
lmENVH <- lm(CLIMATE~DALY+AIR_H+WATER_H)
ImENVH
summary(ImENVH)
cENVH<-coef(lmENVH)
cENVH
DALYNEW<-c(seq(1,39,1))
AIR_HNEW<-c(seq(1,39,1))
WATER_HNEW<-c(seq(1,39,1))
NEW <-data.frame(DALYNEW,AIR_HNEW,WATER_HNEW)
pENV<-na.omit(predict(lmENVH,NEW,interval="prediction"))
cENV<-na.omit(predict(lmENVH,NEW,interval="confidence"))
pENV
cENV




