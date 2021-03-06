heartdata <- read.csv("heart-disease.csv")
head(heartdata)
heartdata[heartdata == "?"] <- NA
heartdata[heartdata$sex == 0,]$sex < "F"
heartdata[heartdata$sex == 1,]$sex > "M"
heartdata$sex <- as.factor(heartdata$sex)
heartdata$cp <- as.factor(heartdata$cp)
heartdata$fbs <- as.factor(heartdata$fbs)
heartdata$restecg <- as.factor(heartdata$restecg)
heartdata$exang <- as.factor(heartdata$exang)
heartdata$slope <- as.factor(heartdata$slope)
heartdata$ca <- as.integer(heartdata$ca)
heartdata$ca <- as.factor(heartdata$ca)
heartdata$thal <- as.integer(heartdata$thal)
heartdata$thal <- as.factor(heartdata$thal)
heartdata$hd <- iselse(test = heartdata$hd ==0, yes = "Healthy", no = "Unhealthy")
heartdata$hd <- as.factor(heartdata$hd)
nrow(heartdata[is.na(heartdata) | is.na(heartdata$thal),])
heartdata[is,na(heartdata$ca) | is.na(heartdata$thal),]
xtabs(~heartdata$hd + heartdata$sex, data = data)
xtabs(~heartdata$hd + heartdata$cp, data = data)
xtabs(~ heartdata$hd + heartdata$fbs, data=heartdata)
xtabs(~ heartdata$hd + heartdata$restecg, data=heartdata)
logis <- glm(heartdata$hd ~ heartdata$sex, data=heartdata, family = "binomial")
summary(logis)
