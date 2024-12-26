# Polynomial Linear Regression

# Importing the dataset
dataset = read.csv('Position_Salaries.csv')
dataset = dataset[2:3]

# Fitting Linear Regression to the dataset
linear_regressor = lm(formula = Salary ~ ., 
                      data = dataset)

# Description of linear_regressor
print(summary(linear_regressor))

# Fitting Polynomial Regression to the dataset
dataset$Level2 = dataset$Level^2
dataset$Level3 = dataset$Level^3
dataset$Level4 = dataset$Level^4
polynomial_regressor = lm(formula = Salary ~ ., 
                          data = dataset)

# Description of polynomial_regressor
print(summary(polynomial_regressor))

# Visualising the Linear Regression results
library(ggplot2)
ggplot() +
    geom_point(aes(x = dataset$Level, y = dataset$Salary), colour = 'red') +
    geom_line(aes(x = dataset$Level, y = predict(linear_regressor, newdata = dataset)), colour = 'blue') +
    ggtitle('Truth or Bluff (Linear Regression)') +
    xlab('Level') +
    ylab('Salary')

# Visualising the Polynomial Regression results
library(ggplot2)
ggplot() +
    geom_point(aes(x = dataset$Level, y = dataset$Salary), colour = 'red') +
    geom_line(aes(x = dataset$Level, y = predict(polynomial_regressor, newdata = dataset)), colour = 'blue') +
    ggtitle('Truth or Bluff (Polynomial Regression)') +
    xlab('Level') +
    ylab('Salary')

# Visualising the Polynomial Regression results (for higher resolution and smoother curve)
library(ggplot2)
x_grid = seq(min(dataset$Level), max(dataset$Level), 0.1)
ggplot() +
    geom_point(aes(x = dataset$Level, y = dataset$Salary), colour = 'red') +
    geom_line(aes(x = x_grid, y = predict(polynomial_regressor,
                                          newdata = data.frame(Level = x_grid,
                                                               Level2 = x_grid^2,
                                                               Level3 = x_grid^3,
                                                               Level4 = x_grid^4))),
            colour = 'blue') +
    ggtitle('Truth or Bluff (Polynomial Regression in High Resolution)') +
    xlab('Level') +
    ylab('Salary')

# Predicting a new result with Linear Regression
y_pred = predict(linear_regressor, newdata = data.frame(Level = 6.5))
print(y_pred)

# Predicting a new result with Polynomial Regression
y_pred1 = predict(polynomial_regressor, newdata = data.frame(Level = 6.5,
                                                            Level2 = 6.5^2,
                                                            Level3 = 6.5^3,
                                                            Level4 = 6.5^4))
print(y_pred1)

