---
title: "Exploratory Data Analysis"
author: "Student Name: Aishwarya Sah"
date: "2026-05-01"

#library 
library(ggplot2)  
# Load dataset
data <- read.csv("C:/Users/ASUS/Desktop/RProgram/Frauddata.csv")

# View first few rows to understand structure
head(data)

# Structure of dataset
str(data)

# Summary statistics
summary(data)

# Dimensions
dim(data)

#Count missing values in each column
colSums(is.na(data))

# Count number of fraud and non-fraud cases
table(data$isFraud)

# Calculate proportion of each class
prop.table(table(data$isFraud))

# Visualise class imbalance
ggplot(data, aes(x = as.factor(isFraud))) +
  geom_bar() +
  labs(title = "Distribution of Fraud vs Non Fraud Transactions",
       x = "Fraud (0 = Legitimate, 1 = Fraud)",
       y = "Count")



