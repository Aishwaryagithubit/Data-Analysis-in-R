teens <- read.csv("C:/Users/ASUS/Downloads/snsdata(1)(1).csv", stringsAsFactors = T)
str(teens)

interests <- teens[5:40]
interests_z <- as.data.frame(lapply(interests, scale))
set.seed("123")
teen_clusters <- kmeans(interests_z, 5, nstart=5, iter.max = 50)

teen_clusters$size
teen_clusters$centers

set.seed(123)
wss<-NULL
#generate 10 clustering models with up to 10 clusters.
#extract total.withinss for each model
for (i in 1:10)
{
  tot_wss<-kmeans(interests_z, i)$tot.withinss
  wss<-c(wss,tot_wss)
}
plot(1:10, wss, type="b", xlab="Number of Clusters",ylab="Within groups sum of squares")
k3<- kmeans(interests_z, centers = 3, nstart = 5)
k4 <- kmeans(interests_z, centers = 4, nstart = 5)
k5 <- kmeans(interests_z, centers = 5, nstart = 5)
k6 <- kmeans(interests_z, centers = 6, nstart = 5)
# plots to compare
install.packages("factoextra")
library(factoextra)
p0 <- fviz_cluster(k3, geom = "point", data = interests_z,) + ggtitle("k = 3")
p1 <- fviz_cluster(k4, geom = "point", data = interests_z,) + ggtitle("k = 4")
p2 <- fviz_cluster(k5, geom = "point", data = interests_z) + ggtitle("k = 5")
p3 <- fviz_cluster(k6, geom = "point", data = interests_z) + ggtitle("k = 6")
install.packages("gridExtra")
library(gridExtra)
grid.arrange(p0,p1, p2, p3, nrow = 2)

distance<-dist(iris[, 1:4])
distance

set.seed("123")
clusters <- hclust(distance)
plot(clusters)

plot(clusters)
abline(h=3, col="red")
abline(h=4, col="red")

clusterCut <- cutree(clusters, 3)
clusterCut

table(clusterCut, iris$Species)

set.seed("2222")
clusters <- hclust(distance, method = 'average')
plot(clusters, hang = -1, cex = 0.6)

plot(clusters, hang = -1, cex = 0.6)
rect.hclust(clusters, k = 3)

clusterCut <- cutree(clusters, 3)
clusterCut

table(clusterCut, iris$Species)

library(ggplot2)
ggplot(iris, aes(Petal.Length, Petal.Width, color =Species)) +
  geom_point(alpha = 0.4, size = 3.5) + geom_point(col = clusterCut) +
  scale_color_manual(values = c('black', 'red', 'green'))
