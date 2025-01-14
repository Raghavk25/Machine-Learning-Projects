# Decision Tree Regression

# Importing the dataset
dataset <- read.csv('Position_Salaries.csv')
dataset <- dataset[2:3]

# Training the Decision Tree Regressor to the dataset
library(rpart)
regressor <- rpart(formula = Salary ~ .,
                  data = dataset,
                  control = rpart.control(minsplit = 1))

# Predicting new results
y_pred <- predict(regressor, data.frame(Level = 6.5))
print(y_pred)

# Visualising the results (with high resolution)
library(ggplot2)
X_grid <- seq(min(dataset$Level), max(dataset$Level), 0.01)
ggplot() +
    geom_point(aes(x = dataset$Level, y = dataset$Salary), colour = 'red') +
    geom_line(aes(x = X_grid, y = predict(regressor, newdata = data.frame(Level = X_grid))), colour = 'blue') +
    ggtitle('Truth or Bluff (Decision Tree Regressor)') +
    xlab('Level') +
    ylab('Salary')
