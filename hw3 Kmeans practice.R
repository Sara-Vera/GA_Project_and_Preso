# Cluster Analysis, 300K users who've taken action in the last 3 mo.
# Nov 2013

rm(list = ls())

setwd("/Users/saravera/Desktop")

library(cluster)
# install.packages('chron')
library(chron)

data<-read.csv("cluster.csv", head = TRUE)
data[1,]
head(data)
# data[data == 'NULL'] <- 0
head(data)

summary(data)
dim(data)

wss <- (nrow(data)-1)*sum(apply(data,2,var))

data[!complete.cases(data),]
data <- na.omit(data)

mydata<-data[,2:28]
as.data.frame(names(mydata))
head(mydata)

mydata[!complete.cases(mydata),]
is.na(mydata)

mydata <- subset(mydata, select = -c(3,6,7)) # get rid of a few variables (dates, country, Null values in signup method)
as.data.frame(names(mydata))

dim(mydata)
str(mydata)

as.data.frame(table(mydata$age)) 

mydata$age[mydata$age == 0] = 43
mydata$age[mydata$age == 2013] = 43
mydata$age <- as.integer(mydata$age)

# Gender: F=1, M=0
mydata$gender <- factor(mydata$gender, levels=c("F", "M"), labels = c(1,0))
mydata$gender <- as.integer(as.character(mydata$gender))

mydata$signup_method <- factor(mydata$signup_method, levels=c("D", "E", "F", "NULL"), labels = c(1,2,3,0))
mydata$signup_method <- as.integer(as.character(mydata$signup_method))

head(mydata)
str(mydata)
summary(mydata)


mydata <- na.omit(mydata) # Can't run the elbow test without dropping NAs
dim(mydata)

write.csv(mydata, file = 'mydata.csv')

# How many clusters? Do an Elbow Test
wss <- (nrow(mydata)-1)*sum(apply(mydata,2,var))
for (i in 2:15) wss[i] <- sum(kmeans(mydata,centers=i)$withinss) 
plot(1:15, wss, type="b", xlab="Number of Clusters", ylab="Within groups sum of squares")

############################# SCALED DATA #################################
scale.mydata <- scale(mydata, center = TRUE, scale = TRUE) # This run without centered data just to see

str(scale.mydata)
head(scale.mydata)
dim(scale.mydata)
summary(scale.mydata)


fit<-kmeans(scale.mydata, 5, iter.max = 1000, nstart = 100)  # 5 cluster solution  ?nstart
aggregate(scale.mydata,by=list(fit$cluster),FUN=mean)  # get cluster means

scale.mydata1 <- data.frame(mydata, fit$cluster) # append cluster assignment
table(scale.mydata1$fit.cluster) # See how many cases per cluster


#plot the clusters
clusplot(scale.mydata1, fit$cluster, color=TRUE, shade=TRUE, labels=2, lines=0) # This look CRAZY
write.csv(scale.mydata1, file = 'fit.cluster.csv') # new data frame with cluster


 ############################ UNSCALED DATA K-Means ####################


wss <- (nrow(mydata)-1)*sum(apply(mydata,2,var))
mydata <- na.omit(mydata)
for (i in 2:15) wss[i] <- sum(kmeans(mydata,centers=i)$withinss) 
plot(1:15, wss, type="b", xlab="Number of Clusters", ylab="Within groups sum of squares")

# 6 Clusters
fit<-kmeans(mydata, 6, iter.max = 1000, nstart = 100)  # 6 cluster solution  ?nstart
mydata6.summary <- aggregate(mydata,by=list(fit$cluster),FUN=mean)  # get cluster means
mydata6.summary

mydata6 <- data.frame(mydata, fit$cluster) # append cluster assignment
table(mydata6$fit.cluster) # Basically 1 giant cluster and 5 miniscule clusters

#plot the clusters
clusplot(mydata6, fit$cluster, color=TRUE, shade=TRUE, labels=2, lines=0)
write.table(mydata6, file = 'cluster6.csv', sep = ',') # new data frame with cluster



