# Decision Tree Classification

# Importing the datasets
dataset <- read.csv("Social_Network_Ads.csv")

# Encoding the target feature as a factor
dataset$Purchased <- factor(dataset$Purchased, levels = c(0, 1))

# Splitting the dataset into Training Set and Test Set
library(caTools)
set.seed(123)
split <- sample.split(dataset$Purchased, SplitRatio = 0.75)
training_set <- subset(dataset, split == TRUE)
test_set <- subset(dataset, split == FALSE)

# Feature Scaling
training_set[, -3] <- scale(training_set[, -3])
test_set[, -3] <- scale(test_set[, -3])

# Fitting the Decision Tree Classifier to the Training Set
library(rpart)
classifier <- rpart(formula = Purchased ~ .,
                    data = training_set)

# Predicting new results
y_pred <- predict(classifier, newdata = test_set[, -3], type = "class")

# Making Confusion Matrix
cm <- table(test_set[, 3], y_pred)
cm

# Visualising Training Set results
library(ElemStatLearn)
set <- training_set
X1 <- seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 <- seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
grid_set <- expand.grid(X1, X2)
colnames(grid_set) <- c("Age", "EstimatedSalary")
y_grid <- predict(classifier, newdata = grid_set, type = "class")
plot(set[, -3],
     main = "Decision Tree Classification (Training Set)",
     xlab = "Age", ylab = "Estimated Salary",
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = ".", col = ifelse(y_grid == 1, "dodgerblue", "salmon"))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, "dodgerblue3", "salmon3"))

# Visualising Test Set results
library(ElemStatLearn)
set <- test_set
X1 <- seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 <- seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
grid_set <- expand.grid(X1, X2)
colnames(grid_set) <- c("Age", "EstimatedSalary")
y_grid <- predict(classifier, newdata = grid_set, type = "class")
plot(set[, -3],
     main = "Decision Tree Classification (Test Set)",
     xlab = "Age", ylab = "Estimated Salary",
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = ".", col = ifelse(y_grid == 1, "dodgerblue", "salmon"))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, "dodgerblue3", "salmon3"))

# Visualising the Decision Tree Classifier
plot(classifier, main = "Decision Tree Classifier")
text(classifier)
