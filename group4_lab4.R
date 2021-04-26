require(ggplot2)        # or load package first
data(diamonds)
head(diamonds)          # look at the data!
#
ggplot(diamonds, aes(clarity, fill=cut)) + geom_bar()
ggplot(diamonds, aes(clarity)) + geom_bar() + facet_wrap(~ cut)
ggplot(diamonds) + geom_histogram(aes(x=price)) + geom_vline(xintercept=12000)

ggplot(data = diamonds, mapping = aes(color = cut_number(carat, 5), x = price)) + geom_freqpoly() + labs(x = "Price", y = "Count", color = "Carat")

ggplot(diamonds, aes(x = cut_number(price, 10), y = carat)) + geom_boxplot() + coord_flip() + xlab("Price")

ggplot(diamonds, aes(x = cut_number(carat, 5), y = price, colour = cut)) + geom_boxplot()


# Work on the Textbook (Intro to Statistical Learning with R - 7th Edition) Chapter 4.6.3 on 
# Linear Discriminant Analysis Lab example 
library(MASS)
library(ISLR)

data("Smarket")
attach(Smarket)
head(Smarket)
# data set consists of percentage returns for the S&P 500 stock index over 1, 250 days, from the
# beginning of 2001 until the end of 2005
names(Smarket)
str(Smarket)
dim(Smarket)
.
train <- (Year < 2005)
Smarket.2005 = Smarket[!train,]
dim(Smarket.2005)
Direction.2005 <- Direction[!train]

# We fit the model using only the observations before 2005.

lda.fit <- lda(Direction ~ Lag1 + Lag2, data = Smarket, subset = train)
lda.fit

lda.pred <- predict(lda.fit, Smarket.2005)
names(lda.pred)
lda.class <- lda.pred$class
table(lda.class,Direction.2005)
mean(lda.class == Direction.2005)

