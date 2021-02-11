plot(mtcars$wt, mtcars$mpg)
library(ggplot2)
qplot(mtcars$wt,mtcars$mpg)
qplot(wt,mpg,data = mtcars)
ggplot(mtcars, aes(x=wt,y=mpg)) + geom_point()
plot(pressure$temperature, pressure$pressure, type="l")
points(pressure$temperature,pressure$pressure)

lines(pressure$temperature, pressure$pressure/2, col="red")
points(pressure$temperature,pressure$pressure/2, col="blue")
library(ggplot2)
qplot(pressure$temperature,pressure$pressure, geom="line")
qplot(temperature,pressure,data=pressure,geom="line")
ggplot(pressure,aes(x=temperature, y=pressure)) + geom_line() + geom_point()
ggplot(pressure, aes(x=temperature, y=pressure)) + geom_line() + geom_point()

# creating Bar graphs
barplot(BOD$demand,names.org = BOD$Time)
table(mtcars$cyl)
barplot(table(mtcars$cyl)) # generate a table of counts
gplot(mtcars$cyl) # treat cyl as discrete

# Bar graph of counts
qplot(factor(cyl), data = mtcars)
ggplot(mtcars, aes(x=factor(cyl))) + geom_bar()

# creating a Histogram
hist(mtcars$mpg) 
hist(mtcars$mpg,breaks=10)
hist(mtcars$mpg,breaks=5)
hist(mtcars$mpg,breaks=12)
qplot(mpg,data=mtcars,binwidth=4)
ggplot(mtcars, es(x=mpg)) + geom_histogram(binwidth=4)
ggplot(mtcars, aes(x=mpg)) + geom_histogram(binwidth = 5)

# creating Box-plots using ggplot
plot(ToothGrowth$supp, ToothGrowth$len)
boxplot(len ~ supp, data=ToothGrowth)
boxplot(len ~ supp + dose, data=ToothGrowth)
library(ggplot2)
qplot(ToothGrowth$supp, ToothGrowth$len, geom="boxplot")
qplot(supp, len, data=ToothGrowth, geom="boxplot")
ggplot(ToothGrowth, aes(x=supp, y=len)) + geom_boxplot()
qplot(interaction(ToothGrowth$supp, ToothGrowth$dose), ToothGrowth$len, geom="boxplot")
qplot(interaction(supp,dose), len, data=ToothGrowth, geom="boxplot")
ggplot(ToothGrowth, aes(x=iteraction(supp,dose), y=len)) + geom_boxplot()

# visualizaion exercise
# Chapter 3, Bar-Graphs, R Graphics cookbook.
# You have a data frame where one column represents the x position of each bar, and
# another column represents the vertical (y) height of each bar.
library(gcookbook) # for the dataset. pg_mean dataset is avialbe in this library.
ggplot(pg_mean, aes(x=group, y=weight)) + geom_bar(stat = "identity")
BOD # there is not entry for Time == 6 ... did you see that ? 
# Time is numeric (continuous)
str(BOD)
ggplot(BOD, aes(x=Time, y=demand)) + geom_bar(stat = "identity")
# Convert Time to a discrete (categorical) variable with factor() function.
ggplot(BOD, aes(x=factor(Time), y=demand)) + geom_bar(stat = "identity")
# change the color of the bars and add an outline to the bars
# NOTE: In ggplot2, the default is to use the British spelling, colour, instead of
# the American spelling, color.
ggplot(pg_mean, aes(x=group, y=weight)) +geom_bar(stat = "identity", fill="lightblue", colour = "red")
ggplot(BOD, aes(x=factor(Time), y=demand)) +geom_bar(stat = "identity", fill="orange", colour = "red")
# Grouping Bars Together
# You want to group bars together by a second variable.
# In this example we'll use the cabbage_exp data set, which has two categorical variables,
# Cultivar and Date, and one continuous variable, Weight:

ggplot(diamonds, aes(x=carat)) + geom_histogram()
# Taking Top 10 States 
library(gcookbook) # for the dataset
ups <- subset(uspopchange, rank(Change)>40)
ups
# Now we can make the graph, mapping Region to fill
ggplot(ups, aes(x=Abb, y= Change, fill=Region)) + geom_bar(stat = "identity")
# Do an Experiment with followings ... :=) 
ggplot(ups, aes(x=Abb, y=Change, fill=Region)) +geom_bin2d()
ggplot(ups, aes(x=Abb, y=Change, fill=Region)) + geom_col()
ggplot(ups, aes(x=reorder(Abb,Change), y=Change, fill=Region)) + geom_bar(stat = "identity", colour= "red") +
scale_fill_manual(values=c("#669933", "#FFCC66")) + xlab("US-States")
ggplot(ups, aes(x=reorder(Abb,Change), y=Change, fill=Region)) + geom_bar(stat = "identity", color = "purple") +
scale_fill_manual(values=c("#224455","#DDCC33"))

library(gcookbook)
csub <- subset(climate, source="Berkeley" & Year >= 1900)
csub$pos <- csub$Anomaly10y >=0
ggplot(csub, aes(x=Year, y=Anomaly10y, fill= pos)) + geom_bar(stat = "identity", position = "identity")
# changing the color with scale_fill_manual
ggplot(csub, aes(x=Year, y=Anomaly10y, fill=pos)) + geom_bar(stat="identity", colour="black", size=0.25) +
scale_fill_manual(values=c("#CCEEFF", "#FFDDDD"), guide=FALSE)
library(gcookbook) # for the datset
ggplot(pg_mean, aes(x=group, y=weight)) +geom_bar(stat="identity")
# Narrow Bars
ggplot(pg_mean, aes(x=group, y=weight)) +geom_bar(stat="identity", width = 0.5)
# Wider bars, maximum width = 1
ggplot(pg_mean, aes(x=group, y=weight)) +geom_bar(stat = "identity", width = 0.95)
# Different bar widths
ggplot(cabbage_exp, aes(x=Date, y= Weight, fill=Cultivar)) + geom_bar(stat = "identity", width = 0.5, position = "dodge")
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) + geom_bar(stat = "identity", width = 0.5, position = position_dodge(0.7))
# Making a Sketched Bar Graph
library(gcookbook) # for the dataset
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) + geom_bar(stat = "identity")
cabbage_exp
ggplot(cabbage_exp, aes(x= Date, y= Weight, fill=Cultivar)) + geom_bar(stat = "identity") + guides(fill=guide_legend(reverse = TRUE))
# Adding Lables to your Graphs
library(gcookbook) # For the data set
ggplot(cabbage_exp, aes(x=interaction(Date,Cultivar), y=Weight)) +geom_bar(stat = "identity") + geom_text(aes(label=Weight),vjust=1.5,colour="white")
library(ggplot2)
# Adjust y limits to be a little higher
ggplot(cabbage_exp, aes(x=interaction(Date, Cultivar), y=Weight)) +
geom_bar(stat="identity") +
geom_text(aes(label=Weight), vjust=-0.2) +
ylim(0, max(cabbage_exp$Weight) * 1.05)

# Map y positions slightly above bar top - y range of plot will auto-adjust
ggplot(cabbage_exp, aes(x=interaction(Date, Cultivar), y=Weight)) +
geom_bar(stat="identity") +
geom_text(aes(y=Weight+0.1, label=Weight))

ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) +
geom_bar(stat="identity", position="dodge") +
geom_text(aes(label=Weight), vjust=1.5, colour="white",
position=position_dodge(.9), size=3)

# make a Cleveland dot plot
#The simplest way to create a dot plot is to use geom_point() function
library(gcookbook) # For the data set
tophit <- tophitters2001[1:25,] # take top 25 top hitters
tophit
ggplot(tophit, aes(x=avg, y=name)) + geom_point()
tophit[,c("name","lg","avg")]
ggplot(tophit, aes(x=avg, y= reorder(name,avg))) + geom_point(size=3, colour="red") + theme_bw() +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(colour ="grey60",linetype="dashed"))

ggplot(tophit, aes(x=avg, y=reorder(name,avg))) + geom_point(size=2.5, colour="blue") + theme_classic() +
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(colour = "grey60", linetype = twodash))
# Get the names sorted by lg, then by avg
nameorder <- tophit$name[order(tophit$lg, tophit$avg)]
# Turn the name into factor, with levels in the order of nameorder
tophit$name <- factor(tophit$name, levels = nameorder)
ggplot(tophit, aes(x=avg, y=name)) +
geom_segment(aes(yend=name), xend=0, colour="grey70")+
geom_point(size=3, aes(colour=lg)) +
scale_color_brewer(palette="Set1", limits=c("NL","AL")) + theme_bw() +
  theme(panel.grid.major.y = element_blank(),
  legend.position = c(1,0.55),
  legend.justification = c(1,0.5))

ggplot(tophit, aes(x=avg, y=name)) +
  geom_segment(aes(yend=name), xend=0, colour="grey40") +
  geom_point(size=3, aes(colour=lg)) +
  scale_color_brewer(palette="Set1", limits=c("NL","AL"), guide=FALSE) +
  theme_bw() +
  theme(panel.grid.major.y = element_blank()) +
  facet_grid(lg ~ ., scales = "free_y", space="free_y")

library(gcookbook) # For the data set
library(ggplot2)
ggplot(cabbage_exp, aes(x=Date, fill=Cultivar)) + geom_bar(position = "dodge")

library(gcookbook) # For the data set
ggplot(cabbage_exp, aes(x=Date, y=Weight, fill=Cultivar)) + geom_bar(stat="identity")

# Making Bar Graph of Counts
ggplot(diamonds, aes(x=cut)) +geom_bar() # this is equvalent to using geom_bar(stat="bin)
data("diamonds")
ggplot(diamonds,aes(x=carat)) + geom_bar()
# It turns out that in this case, the result is the same as if we had used geom_histogram() instead of geom_bar()

