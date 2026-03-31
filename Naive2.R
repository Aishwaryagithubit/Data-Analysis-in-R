library(mlbench)
install.packages("caret")
install.packages("caret")
install.packages("caret")
library(caret)
library(e1071)
library(pROC)

#load data
data(PimaIndiansDiabetes2, package = "mlbench")
df <- PimaIndiansDiabetes2

#Quick inspection
cat("Dataset structure:\n")
str(df)

cat("\nMissing Values per column:\n")
print(colSums(is.na(df)))

cat("\nClass distribution:\n")
print(prop.table(table(df$diabetes)))

#3 train-test split
set.seed(123)
train_index <- createDataPartition(df$diabetes, p = 0.8, list = FALSE)
train_data <- df[train_index, ]
test_data <- df[-train_index, ]

#4.preprocessing : median imputation + centering + scaling
preproc <- preProcess(
  train_data[, setdiff(names(train_data), "diabetes")],
  method = c("medianImpute", "center", "scale")
)

train_x <- predict(preproc, train_data[, setdiff(names(train_data),"diabetes")])
test_x <- predict(preproc, test_data[, setdiff(names(test_data),"diabetes")])

train_processed <- cbind(train_x, diabetes = train_data$diabetes)
test_processed <- cbind(test_x, diabetes = test_data$diabetes)

#train naive bayes model
nb_model <- naiveBayes(diabetes ~ ., data = train_processed)

cat("\nNaive Bayes model summary:\n")
print(nb_model)

#6. Predict class labels and probabilities
pred_class <- predict(nb_model, newdata = test_processed)
pred_prob <- predict(nb_model, newdata = test_processed, type = "raw")

#7 confusion matrix
conf_mat <- confusionMatrix(
  data = pred_class,
  refrence = test_processed$diabetes,
  positive = "pos"
)

cat("\nConfusion Matrix:\n")
print(conf_mat)

#8. ROC and AUC
roc_obj <- roc(
  response = test_processed$diabetes,
  predictor = pred_prob[, "pos"],
  levels = c("neg", "pos"),
  direction = "<"
)

#9 ROC plot
plot(roc_obj, main = "ROC Curve - Naive Bayes on Pima Indians Diabetes")
abline(a = 0, b = 1,lty = 2)

#10 optional : inspect first few predictions
results <- data.frame(
  Actual = test_processed$diabetes,
  Predicted = pred_class,
  Prob_Neg = pred_prob[, "neg"],
  Prob_Pos = pred_prob[, "pos"]
)

cat()
print()





