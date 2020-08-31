##
## Filename: run_analysis.R
## Author: Christopher Lim
## Purpose: Coursera Data Science - Getting and Cleaning Data Course Project
#
## The aim of this project is to demonstrate the author's ability to collect,
## work with, and clean a data set. The source data comes from comes from UCI's
## HAR Using Smartphones Dataset. Below script will perform the necessary cleansing,
## extraction and aggregation before writing the data set into a text file.
##

library(reshape2)

srcDataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
srcDataFile <- "UCI HAR Dataset.zip"
srcDataDir <- "UCI HAR Dataset"

# Download zip file if it does not already exist
if (!file.exists(srcDataFile)) {
  download.file(srcDataUrl, srcDataFile, mode = "wb")
}

# Unpack zip file containing data if data directory does not exist
if (!file.exists(srcDataDir)) {
  unzip(srcDataFile)
}

# Load training data
xTrain <- read.table(file.path(srcDataDir, "train/X_train.txt"))
yTrain <- read.table(file.path(srcDataDir, "train/y_train.txt"))
sTrain <- read.table(file.path(srcDataDir, "train/subject_train.txt"))

# Load testing data
xTest <- read.table(file.path(srcDataDir, "test/X_test.txt"))
yTest <- read.table(file.path(srcDataDir, "test/y_test.txt"))
sTest <- read.table(file.path(srcDataDir, "test/subject_test.txt"))

# Merge the training and testing data set
xData <- rbind(xTrain, xTest)
yData <- rbind(yTrain, yTest)
sData <- rbind(sTrain, sTest)

# Load the `features.txt` for the measurement names
features <- read.table(file.path(srcDataDir, "features.txt"))

# Extract the mean and standard deviation measurements
#reqColumns <- grep("(mean|std)\\(\\)", features[,2])
reqColumns <- grep("(mean|std)", features[,2])
xData <- xData[, reqColumns]

# Load the `activitiy_labels.txt` for the activity names
actLabels <- read.table(file.path(srcDataDir, "activity_labels.txt"))

# Replace the activity IDs from integer values to descriptive names
yData <- actLabels[yData[,1], 2]

# Rename the measurement names into descriptive form
reqColNames <- features[reqColumns, 2]
reqColNames <- gsub("[\\(\\)-]", "", reqColNames)
reqColNames <- gsub("^t", "timeDom", reqColNames)
reqColNames <- gsub("^f", "freqDom", reqColNames)
reqColNames <- gsub("BodyBody", "Body", reqColNames)
reqColNames <- gsub("mean", "Mean", reqColNames)
reqColNames <- gsub("std", "Std", reqColNames)

# Combine the individual data and labels into a single data table
data <- cbind(sData, yData, xData)
colnames(data) <- c("Subject","Activity", reqColNames)

# Creates melted data frame using Subject and Activity as IDs
meltedData <- melt(data, id = c("Subject", "Activity"))

# Generate mean for all measurements grouped by Subject and Activity
tidyData <- dcast(meltedData, Subject + Activity ~ variable, mean)

# Output the tidy data frame into a text file 
write.table(tidyData, "tidy_data.txt", row.names = FALSE, quote = FALSE)

