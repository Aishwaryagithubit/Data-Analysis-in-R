# Read the CSV file "wisc_bc_data.csv" into a data frame named wbcd.
wbcd <- read.csv("C:/Users/ASUS/Desktop/RProgram/wisc_bc_data.csv", stringsAsFactors = FALSE)
str(wbcd)

# Set the row names of the wbcd data frame to the values in the "id" column.
# This means each row will now be identified by the corresponding "id" value.
rownames(wbcd) <- wbcd$id
wbcd<-wbcd[,-1]
dim(wbcd)
str(wbcd)

# Create a frequency table for the "diagnosis" column in the wbcd data frame.
# This counts the occurrences of each unique value (e.g., "M" for malignant, "B" for benign).
table(wbcd$diagnosis)

# Convert the "diagnosis" column into a factor with specific levels and labels.
# "B" is mapped to "Benign" and "M" is mapped to "Malignant".
# This makes the data more readable and useful for analysis.
wbcd$diagnosis <- factor(wbcd$diagnosis, levels = c("B", "M"),
                         labels = c("Benign", "Malignant"))

# Create a frequency table for the "diagnosis" column.
table_counts <- table(wbcd$diagnosis)
# Convert the counts into proportions (relative frequencies).
prop_table <- prop.table(table_counts)
# Multiply by 100 to get percentages.
percentages <- prop_table * 100
# Round the percentages to one decimal place for better readability.
round(percentages, digits = 1)

selected_var<-c("radius_mean", "area_mean", "smoothness_mean")
summary(wbcd[selected_var])

# Define a function named "normalize" that performs Min-Max normalization.
normalize <- function(x) {
  # Subtract the minimum value of x from each element, then divide by the range (max - min).
  # This scales the values between 0 and 1.
  return ((x - min(x)) / (max(x) - min(x)))
}

normalize(c(1, 2, 3, 4, 5))
normalize(c(10, 20, 30, 40, 50))

# Apply the "normalize" function to columns 2 to 31 of the wbcd data frame.
# The "lapply" function applies "normalize" to each column individually.
# "as.data.frame" converts the output back into a data frame.
wbcd_norm <- as.data.frame(lapply(wbcd[2:31], normalize))

summary(wbcd_norm$area_mean)
summary(wbcd_norm$perimeter_mean)


library(caret)

# Split the data into training and testing sets using createDataPartition.
# "y = wbcd$diagnosis" specifies the target variable for partitioning (diagnosis).
# "p = 0.8" means 80% of the data will be used for training and 20% for testing.
# "list = FALSE" ensures the result is a vector of row indices instead of a list.
indxTrain <- createDataPartition(y = wbcd$diagnosis, p = 0.8, list = FALSE)
# Create the training dataset by selecting rows based on the training indices.
# "wbcd_norm[indxTrain,]" selects the normalized features for the training set.
wbcd_train <- wbcd_norm[indxTrain,]
# Create the training labels (target variable) by selecting the corresponding values from the diagnosis# "wbcd$diagnosis[indxTrain]" selects the diagnosis labels for the training set.
wbcd_train_label <- wbcd$diagnosis[indxTrain]
# Create the testing dataset by selecting the remaining rows (those not in the training set).
# "wbcd_norm[-indxTrain,]" selects the normalized features for the testing set.
wbcd_test <- wbcd_norm[-indxTrain,]
# Create the testing labels by selecting the corresponding values from the diagnosis column.
# "wbcd$diagnosis[-indxTrain]" selects the diagnosis labels for the testing set.
wbcd_test_label <- wbcd$diagnosis[-indxTrain]
# Check the first few values of the wbcd_train_label to verify the labels in the training set.
head(wbcd_train_label) #80% of the dataset
# Check the distribution of labels in the wbcd_train_label to see how the classes are distributed.
table(wbcd_train_label)
# Check the first few values of the wbcd_test_label to verify the labels in the testing set.
head(wbcd_test_label)
# Check the distribution of labels in the wbcd_test_label to see how the classes are distributed.
table(wbcd_test_label) #20% of the dataset

library(class)

# Compute the value of k using the square root of the number of records in the training dataset.
# This is a common heuristic for selecting k in k-Nearest Neighbors (k-NN).
k_n <- sqrt(nrow(wbcd_train))
# Apply the k-NN algorithm to classify the test data.
# "train = wbcd_train" specifies the training feature set.
# "test = wbcd_test" specifies the test feature set.
# "cl = wbcd_train_label" provides the class labels for the training set.
# "k = k_n" sets the number of nearest neighbors to use for classification.
wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test, cl = wbcd_train_label, k = k_n)

# Merge the training feature set with the corresponding labels into a new dataset "wbcd_train_2".
# "cbind()" combines the feature columns from "wbcd_train" with the labels from "wbcd_train_label".
wbcd_train_2 <- cbind(wbcd_train, wbcd_train_label)
# Rename the last column (which contains the labels) to "Diagnosis" for better readability.
names(wbcd_train_2)[ncol(wbcd_train_2)] <- "Diagnosis"
wbcd_train_2 # check the last column renamed as Diagnosis
Now we can fit the model:
  # Create a training control object for cross-validation.
  # "method = 'cv'" specifies k-fold cross-validation.
  # "number = 5" sets the number of folds to 5 (i.e., 5-fold cross-validation).
  ctrl <- trainControl(method = "cv", number = 5)
# Train a k-Nearest Neighbors (k-NN) model using cross-validation.
# "Diagnosis ~ ." specifies that we are predicting "Diagnosis" using all other columns as features.
# "data = wbcd_train_2" specifies the dataset containing both features and labels.
# "method = 'knn'" tells caret to use the k-NN algorithm.
# "trControl = ctrl" applies the 5-fold cross-validation settings.
knnFit <- train(Diagnosis ~ ., data = wbcd_train_2, method = "knn", trControl = ctrl)
# Print the trained k-NN model, showing details like accuracy and best k value.
knnFit

# Use the trained k-NN model to make predictions on the test dataset.
# "knnFit" is the trained model from the previous step.
# "newdata = wbcd_test" specifies the test feature set for which predictions will be made.
knnPredict <- predict(knnFit, newdata = wbcd_test)
# This allows you to evaluate the model’s performance by comparing knnPredict with the actual test labe# Display the predicted class labels for the test dataset.
knnPredict

confusionMatrix(knnPredict, wbcd_test_label)

knnPredict <- predict(knnFit, newdata = wbcd_test, type = "prob")
# Display the predicted class probabilities for each test sample.
knnPredict






