# Random Forest
# Nov 2013

setwd("/Users/saravera/Desktop")
library(randomForest)

# Read in new dataset derived from K-means cluster analysis
# data<-read.csv("fit.cluster.short.csv", head = TRUE)

data<-read.csv("fit_cluster.csv", head = TRUE)

data[1,]
str(data) # fit.cluster needs to be a factor for classification, numeric or integer for regression

summary(data)
dim(data)

as.data.frame(names(data))
data <- na.omit(data)
dim(data)

# Subtract the outcome variable from cluster analysis and run randomForest
rf <- randomForest(data[,-24], data$fit_cluster)
# rf <- randomForest(fit.cluster ~., data = data, ntree = 50, mtry = 15, importance = TRUE)
# rf <- randomForest(data[,!grep1("fit.cluster", names(data))], data$fit.cluster, ntree = 51, maxnodes = 30, importance = FALSE, localImp = FALSE, proximity = FALSE, keep.inbag = FALSE)
data$fit_cluster <- as.factor(data$fit_cluster)

# rf <- randomForest(data, y=data$fit.cluster, data= data, na.action= na.omit, importance= TRUE, ntree= 201, mtry= if (!is.null(y) && !is.factor(y)) max(floor(ncol(data)/3), 1) else floor(sqrt(ncol(data))), replace= TRUE, maxnodes= 10)


getTree(rf, 1)

# How to interpret importance? 
importance(rf)






###########################################################################################################
################ Example from http://cran.r-project.org/web/packages/randomForest/randomForest.pdf ########
############################################################################################################
data(iris)
iris.rf <- randomForest(iris[,-5], iris[,5], prox=TRUE)
iris.p <- classCenter(iris[,-5], iris[,5], iris.rf$prox)
plot(iris[,3], iris[,4], pch=21, xlab=names(iris)[3], ylab=names(iris)[4],
bg=c("red", "blue", "green")[as.numeric(factor(iris$Species))],
main="Iris Data with Prototypes")
points(iris.p[,3], iris.p[,4], pch=21, cex=2, bg=c("red", "blue", "green"))

############################################################################################################
install.packages('mlogit')
library(mlogit)

reg_data <- data
str(reg_data)

reg_data$gender <- as.factor(reg_data$gender)
reg_data$getting_connected <- as.factor(reg_data$getting_connected)
reg_data$has_fb <- as.factor(reg_data$has_fb)

reg_data$fit_cluster <- as.factor(reg_data$fit_cluster)


logit_results <- mlogit(fit_cluster ~ ., reg_data)