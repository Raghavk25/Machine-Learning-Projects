# Multiple Linear Regression

# Importing datasets
dataset = read.csv('Profit Prediction (based on spends)//50_Startups.csv')

# Encoding categorical variable
dataset$State = factor(dataset$State,
                       levels = c('New York', 'California', 'Florida'),
                       labels = c(1, 2, 3))

# Splitting the dataset into Training set and Test set
library(caTools)
set.seed(123)
split = sample.split(dataset$Profit, SplitRatio = 0.8)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Fitting Multiple Linear Regression to Training set
regressor = lm(formula = Profit ~ .,
               data = training_set)

# Description of our regressor
print(summary(regressor))

# Predicting the Test set results
y_pred = predict(regressor, newdata = test_set)

# Building an optimal model through Backward Elimination
regressor = lm(formula = Profit ~ R.D.Spend + Administration + 
               Marketing.Spend +  State,
               data = dataset)
print(summary(regressor))

# Now, since the State variable has the highest P-value that is also above significance level (0.05), we eliminate it.
# Then we rebuild our model without the State variable.
regressor = lm(formula = Profit ~ R.D.Spend + Administration + 
               Marketing.Spend,
               data = dataset)
print(summary(regressor))

# Now, we remove the next variable with the highest P-value i.e. Administration
# Then we rebuild our model without the Administration variable.
regressor = lm(formula = Profit ~ R.D.Spend + 
               Marketing.Spend,
               data = dataset)
print(summary(regressor))

# Now, we remove the next variable with the highest P-value i.e. Marketing Spend
# Then we rebuild our model without the Marketing Spend variable.
regressor = lm(formula = Profit ~ R.D.Spend,
               data = dataset)
print(summary(regressor))

# Now, the other variables have P-values lower than our significance level of 0.05, so we finish here.
# Hence, our optimal model is ready with the help of Backward Elimination.