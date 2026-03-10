#Install the package 
install.packages("mlbench")
#load package
library(mlbench)

#load datasets
data("PimaIndiansDiabetes2")

#assign variables
diabetes <- PimaIndiansDiabetes2

#check datasets
head(diabetes)

#Task1
dim(diabetes)
str(diabetes)
summary(diabetes)

#Task2
# calculate average of missingness
t <- apply(diabetes, 2, function(x) sum(is.na(x))) / nrow(diabetes)
mean(t)

install.packages("Amelia")
library(Amelia)

# plot missingness (only when students run interactively)
missmap(diabetes)

#task3
install.packages("mice")
library(mice)
mice_mod <- mice(diabetes[, c("glucose","pressure","triceps","insulin","mass")], method='rf')
mice_complete <- complete(mice_mod)
#Update variable values
diabetes$glucose<-mice_complete$glucose
diabetes$pressure<-mice_complete$pressure
diabetes$triceps<-mice_complete$triceps
diabetes$insulin<-mice_complete$insulin
diabetes$mass<-mice_complete$mass
# Plot missingness map — only when running interactively (not during knitting)
library(Amelia)
missmap(diabetes)

#glm()
logit <- glm(diabetes~glucose, family = binomial,data = diabetes)
summary(logit)

install.packages("tidyverse")
library(tidyverse)

# Use mutate() from the dplyr (tidyverse) package to add a new column to the dataset
# The dataset 'diabetes' is our original data
train2 <- mutate(diabetes,
                 # Create a new column called 'prob'
                 # The ifelse() function checks each value in the variable 'diabetes'
                 # If the value equals "pos" (positive case), it assigns 1
                 # Otherwise (negative case), it assigns 0
                 prob = ifelse(diabetes == "pos", 1, 0))
# The result is a new dataset 'train2' that includes all original columns
# plus one additional numeric column 'prob' (1 = positive, 0 = negative)
ggplot(train2, aes(glucose, prob)) +
  geom_point(alpha = 0.2) +
  geom_smooth(method = "glm", method.args = list(family = "binomial")) +
  labs(
    title = "Logistic Regression Model",
    x = "Plasma Glucose Concentration",
    y = "Probability of being diabete-pos"
  )

# Create a small dataset (data frame) with one variable: glucose
# We want to test the model on two new glucose values: 20 and 180
newdata <- data.frame(glucose = c(20, 180))
# Use the trained logistic regression model 'logit' to make predictions
# The argument 'newdata' tells R which data to use for prediction
# The argument 'type = "response"' means we want predicted probabilities (values between 0 and 1)
# If we don’t use 'type = "response"', it will return log-odds instead
probabilities <- predict(logit, newdata, type = "response")
# Display the predicted probabilities
# This shows the probability of having diabetes (positive outcome) for each glucose value
probabilities


# The threshold is set at 0.5:
# - If probability > 0.5 → classify as "pos" (positive case)
# - Otherwise → classify as "neg" (negative case)
predicted.classes <- ifelse(probabilities > 0.5, "pos", "neg")
# Display the predicted classes
predicted.classes

diabetes.predicted<-logit$fitted.values
diabetes.classes <- ifelse(diabetes.predicted > 0.5, "pos", "neg")

# Create a confusion matrix using the table() function
# 'diabetes.classes' contains the predicted classes from the model ("pos" or "neg")
# 'diabetes$diabetes' contains the actual classes from the dataset ("pos" or "neg")
table(diabetes.classes, diabetes$diabetes)

#To calculate proportion of corerctly classified observation 

mean(diabetes.classes == diabetes$diabetes)



