EPI_data <- read.csv('EPI_data.csv')
# viewing the data in another window
View(EPI_data)
# set the default object
attach(EPI_data)
fix(EPI_data)
# assign values and filter out the null objects
EPI <- EPI_data$EPI[!is.na(EPI)]
DALY <- EPI_data$DALY[!is.na(DALY)]
# filters out NA values, new array
summary(EPI)
summary(DALY)
# summary statistic
mean(EPI, na.rm = "TRUE")
median(EPI, na.rm = "TRUE")
mean(DALY, na.rm = "TRUE")
median(DALY, na.rm = "TRUE")
# box plot and qqplot
boxplot(EPI, DALY)
qqplot(EPI, DALY)


######################## for the 2010 EPI dataset #####################
EPI_data_2010 <- read.csv('2010EPI_data.csv',skip=1)
attach(EPI_data_2010)
fix(EPI_data_2010)
# assign values and filter out the null objects
EPI_2010 <- EPI_data_2010$EPI[!is.na(EPI)]
DALY_2021 <- EPI_data_2010$DALY[!is.na(DALY)]
mean(EPI_2010, na.rm = "TRUE")
median(EPI_2010, na.rm = "TRUE")
mean(DALY_2021, na.rm = "TRUE")
median(DALY_2021, na.rm = "TRUE")
# histograms
hist(EPI_2010)
hist(DALY_2021)


