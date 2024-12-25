# Simple Linear Regression

# Importing the datasets
dataset = read.csv('Salary Prediction\\Salary_Data.csv')

# Splitting the dataset into Training set and Test set
library(caTools)
set.seed(123)
split = sample.split(dataset$Salary, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Fitting Simple Linear Regression to the Training set
regressor = lm(formula = Salary ~ YearsExperience, 
               data = training_set)

# Description of the regressor
print(summary(regressor))

# Predicting the Test set results
y_pred = predict(regressor, newdata = test_set)

# Visualizing the Training set results
library(ggplot2)
ggplot() + 
    geom_point(aes(x = training_set$YearsExperience, y = training_set$Salary),
    colour = 'red') +
    geom_line(aes(x = training_set$YearsExperience, y = predict(regressor, new_data = training_set)),
    colour = 'blue') +
    ggtitle('Salary vs Experience (training set)') +
    xlab('Years of Experience') +
    ylab('Salary')

# Visualising the Test set results
library(ggplot2)
ggplot() + 
    geom_point(aes(x = test_set$YearsExperience, y = test_set$Salary),
    colour = 'red') +
    geom_line(aes(x = training_set$YearsExperience, y = predict(regressor, new_data = training_set)),
    colour = 'blue') +
    ggtitle('Salary vs Experience (test set)') +
    xlab('Years of Experience') +
    ylab('Salary')

