## Getting and Cleaning Data Project

Course project for Coursera Data Science Specialisation "Getting and Cleaning Data" module. The aim of this project is to demonstrate the author's ability to collect, work with, and clean a data set.

In this project, data collected from the embedded accelerometer and gyroscope of a smartphone strapped on the waist of 30 volunteers while performing six daily living activities was employed.

The Human Activity Recognition Using Smartphones Data Set used can be downloaded below:

[UCI HAR Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

Full description of the data set is available at the following website: 

[UCI Machine Learning Repository: Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

  
### Repository Files 

This repository contains the following files:

- `README.md` : Provides an overview of the project, source data and steps taken to create the data set

- `CodeBook.md` : Describes the variables, data and transformations performed to clean up and generate the required details

- `run_analysis.R` : R script used to to generate the final data set

- `tidy_data.txt` : The final data set file

  
### Data Set Creation

The data set can be created using the `run_analysis.R` script. It will check whether the "UCI HAR Dataset" folder exist (assuming data set present if so) before attempting to retrieve it from the web.

Following high level steps are taken by the script to generate final data set:

- Download and unpack the dataset if it does not exist.
- Merge the training and the test data sets to form a single data set
- Extract only the mean and standard deviation measurements for each measurement.
- Replace the activity IDs in the data set with descriptive names.
- Appropriately label the data set with descriptive variable names.
- Create an independent tidy data set with the average of each variable for each activity and each subject.
- Output the data set into the `tidy_data.txt` file.

Please refer to `CodeBook.md` for details of the transformation performed. R version 4.0.2 on Windows 10 64-bit edition and reshape2 package version 1.4.4 was used.

  
### References
1.	Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz.
	Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine.
	International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

