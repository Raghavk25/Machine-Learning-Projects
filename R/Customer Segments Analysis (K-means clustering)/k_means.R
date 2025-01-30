# K-means clustering

# Importing the dataset
dataset <- read.csv('Customer Segments Analysis (K-means clustering)//Mall_Customers.csv')
X <- dataset[, 4:5]

# Using the elbow method to find the optimal number of clusters
set.seed(0)
wcss <- vector()
for (i in 1:10) {
    wcss[i] <- sum(kmeans(X, i)$withinss)
}
plot(1:10, wcss, type = "b", main = "Clusters of clients", 
     xlab = "Number of clusters", ylab = "WCSS")

# Fitting K-means clustering to the dataset
set.seed(123)
kmeans <- kmeans(X, 5, iter.max = 300, nstart = 10)

# Visualising the clusters
library(cluster)
clusplot(X,
         kmeans$cluster,
         lines = 0,
         shade = TRUE,
         color = TRUE,
         labels = 2,
         plotchar = FALSE,
         span = TRUE,
         main = "Clusters of clients",
         xlab = "Annual Income (k$)",
         ylab = "Spending Score (1-100)")
