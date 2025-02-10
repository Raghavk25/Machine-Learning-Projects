# Eclat

# Data Preprocessing
library(arules)
dataset <- read.transactions("Market Association Rule Learning (Eclat)//Market_Basket_Optimisation.csv",
                             sep = ",", rm.duplicates = TRUE)
summary(dataset)
itemFrequencyPlot(dataset, topN = 10)

# Training Eclat on the dataset
rules <- eclat(data = dataset, parameter = list(support = 0.004, minlen = 2))

# Visualising the results
library(arulesViz)
top_rules <- sort(rules, by = "support")[1:10]
inspect(top_rules)
plot(top_rules, method = "paracoord", control = list(reorder = TRUE))