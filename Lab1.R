EPI_data <- read.csv('C:/Users/Kevin Pan/Desktop/Graduate/DataAnalytics/Labs/Lab1/2010EPI_data.csv', skip=1)

# viewing the data in another window
View(EPI_data)

# set the default object
attach(EPI_data)

fix(EPI_data)

# prints out values EPI_data$EPI
EPI <- EPI_data$EPI

# records True values if the value is NA
tf <- is.na(EPI)

# filters out NA values, new array
E <- EPI[!tf]

# statistic summary
summary(EPI)

# five number summary
fivenum(EPI,na.rm=TRUE)

# stem and leaf plot
stem(EPI)

# histogram
hist(EPI)
hist(EPI, seq(30., 95., 1.0), prob=TRUE)

# or try bw="SJ"
lines(density(EPI,na.rm=TRUE,bw=1.)) 

rug(EPI) 

# Cumulative density function
plot(ecdf(EPI), do.points=FALSE, verticals=TRUE) 

# Quantile-Quantile
par(pty="s") 
qqnorm(EPI); qqline(EPI)

# Make a Q-Q plot against the generating distribution by: x<-seq(30,95,1)
qqplot(qt(ppoints(250), df = 5), x, xlab = "Q-Q plot for t dsn")
qqline(x)

# finding the DALY attribute
DALY <- EPI_data$DALY
boxplot(EPI,DALY) 

qqplot(EPI,DALY)



# filtering
EPILand<-EPI[!Landlock]
Eland <- EPILand[!is.na(EPILand)]
hist(ELand)
hist(ELand, seq(30., 95., 1.0), prob=TRUE)

# filtering on EPI_regions 
filtered_by_regions <- EPI[EPI_regions == "Europe"]
filtered_by_regions

# filtering on GEO_subregion
filtered_by_subregion <- EPI[GEO_subregion == "Western Europe"]
filtered_by_subregion


