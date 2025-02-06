# Hierarchical clustering

# Importing the dataset
dataset <- read.csv("Mall_Customers.csv")
dataset <- dataset[, 4:5]

# Using the dendrogram to find the optimal number of clusters
dendrogram <- hclust(dist(dataset, method = 'euclidean'), method = 'ward.D')
plot(dendrogram,
     main = 'Dendrogram',
     xlab = 'Customers',
     ylab = 'Euclidean distances')

# Fitting the hierarchical clustering algorithm to the dataset
hc <- hclust(dist(dataset, method = 'euclidean'), method = 'ward.D')
y_hc <- cutree(hc, 5)

# Visualising the clusters
library(cluster)
clusplot(dataset,
         y_hc,
         lines = 0,
         shade = TRUE,
         color = TRUE,
         labels = 2,
         plotchar = FALSE,
         span = TRUE,
         main = "Clusters of clients",
         xlab = "Annual Income (k$)",
         ylab = "Spending Score (1-100)")
