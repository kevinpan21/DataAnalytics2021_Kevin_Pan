install.packages('MASS')
data(Boston, package="MASS")

help(prcomp)
pca_out <- prcomp(Boston,scale. = T)
pca_out
plot(pca_out)
biplot(pca_out, scale = 0)
boston_pc <- pca_out$x
boston_pc
head(boston_pc)
summary(boston_pc)
