# Natural Language Processing

# Importing the dataset
dataset <- read.delim("Sentiment Analysis (Restaurant Reviews)//Restaurant_Reviews.tsv",
                      quote = '', stringsAsFactors = FALSE)

# Cleaning the texts
library(tm)
library(SnowballC)
corpus <- VCorpus(VectorSource(dataset$Review))
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeWords, stopwords())
corpus <- tm_map(corpus, stemDocument)
corpus <- tm_map(corpus, stripWhitespace)

# Creating Bag of Words model
dtm <- DocumentTermMatrix(corpus)
dtm <- removeSparseTerms(dtm, 0.999)
dataset2 <- as.data.frame(as.matrix(dtm))
dataset2$Liked <- dataset$Liked

# Encoding the categorical variable
dataset2$Liked <- factor(dataset2$Liked, levels = c(0, 1))

# Splitting the dataset into Training Set and Test Data
library(caTools)
set.seed(123)
split <- sample.split(dataset2$Liked, SplitRatio = 0.8)
training_set <- subset(dataset2, split == TRUE)
test_set <- subset(dataset2, split == FALSE)

# Fitting the Random Forest classifier to the Training Set
library(randomForest)
classifier <- randomForest(x = training_set[-692],
                           y = training_set$Liked,
                           ntree = 10)

# Predicting the Test Set results
y_pred <- predict(classifier, newdata = test_set[-692])

# Making the Confusion Matrix
cm <- table(test_set[, 692], y_pred)
cm
accuracy <- (cm[1, 1] + cm[2, 2])/(cm[1, 1] + cm[2, 2] + cm[1, 2] + cm[2, 1])
accuracy

# Predicting if a single review is positive or negative.
# Positive Review
# Use our model to predict if the following review is positive or negative:
# "I absolutely love this place."
# Solution: We just repeat the same text preprocessing process we did before, but this time with a single review.
new_review <- "I absolutely loved this place."
cleaned_review <- VCorpus(VectorSource(new_review))
cleaned_review <- tm_map(cleaned_review, content_transformer(tolower))
cleaned_review <- tm_map(cleaned_review, removeNumbers)
cleaned_review <- tm_map(cleaned_review, removePunctuation)
cleaned_review <- tm_map(cleaned_review, removeWords, stopwords())
cleaned_review <- tm_map(cleaned_review, stemDocument)
cleaned_review <- tm_map(cleaned_review, stripWhitespace)
dtm2 <- DocumentTermMatrix(cleaned_review, control = list(dictionary = Terms(dtm)))
cleaned_review <- as.data.frame((as.matrix(dtm2)))
cat(paste0(new_review, ": The review is ", ifelse(predict(classifier, newdata = cleaned_review) == 1, "positive.\n", "negative.\n")))

# Predicting if a single review is positive or negative.
# Negative Review
# Use our model to predict if the following review is positive or negative:
# "I absolutely hated this place."
# Solution: We just repeat the same text preprocessing process we did before, but this time with a single review.
new_review2 <- "I absolutely hated this place."
cleaned_review2 <- VCorpus(VectorSource(new_review2))
cleaned_review2 <- tm_map(cleaned_review2, content_transformer(tolower))
cleaned_review2 <- tm_map(cleaned_review2, removeNumbers)
cleaned_review2 <- tm_map(cleaned_review2, removePunctuation)
cleaned_review2 <- tm_map(cleaned_review2, removeWords, stopwords())
cleaned_review2 <- tm_map(cleaned_review2, stemDocument)
cleaned_review2 <- tm_map(cleaned_review2, stripWhitespace)
dtm3 <- DocumentTermMatrix(cleaned_review2, control = list(dictionary = Terms(dtm)))
cleaned_review2 <- as.data.frame((as.matrix(dtm3)))
cat(paste0(new_review2, ": The review is ", ifelse(predict(classifier, newdata = cleaned_review2) == 1, "positive.", "negative.")))