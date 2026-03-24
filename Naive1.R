install.packages("e1071")
library(e1071)

data(iris)
str(iris)
summary(iris)

set.seed(42) #random sample

train_idx <- sample(seq_len(nrow(iris)), size = 0.8 * nrow(iris))
train_data <- iris[train_idx, ]
test_data <- iris[-train_idx, ]

nb_model <- naiveBayes(Species ~ ., data = train_data)

test_pred <- predict(nb_model,test_data[, -5])
test_prob <- predict(nb_model,test_data[, -5], type = "raw")

cat("Confusion matrix:\n")
print(table(Predicted = test_pred, Actual = test_data$Species))

cat("\nAccuracy:\n")
print(mean(test_pred == test_data$Species))

cat("\nFirst 6 posterior probability rows:\n")
print(head(test_prob))
