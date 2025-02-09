# Apriori for Association Rule Learning

# Data Preprocessing
library(arules)
dataset <- read.transactions("Market Association Rule Learning (Apriori)//Market_Basket_Optimisation.csv",
                             sep = ",", rm.duplicates = TRUE)
summary(dataset)
itemFrequencyPlot(dataset, topN = 10)

# Training Apriori on the dataset
rules <- apriori(data = dataset, parameter = list(support = 0.004, confidence = 0.2))

# Visualising the results
library(arulesViz)
top_rules <- sort(rules, by = "lift")[1:10]
inspect(top_rules)
plot(top_rules, method = "paracoord", control = list(reorder = TRUE))