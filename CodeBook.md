# Getting and Cleaning Data Project Code Book

This document consist of two main sections namely Study Design and Code Book. The former provide background on the data sets while the latter describe final data set, variables and the transformation that were carried out to clean up the data.


## Study Design

The source data set was obtained from the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). Below quoted passage from [UCI HAR Website](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) describes how the data was initially collected:

*The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.*

From the source data, the training and test data was merged together to create a single data set and the mean and standard deviation for each measurement extracted. Then the average of each measurement for each activity and each subject was generated to from the data set.


## Code Book

The data set pertaining to this code book is the `tidy_data.txt` file with the following characteristics:

* Space sepearated value text file
* Variable names in the header row
* 181 rows (with header) and 81 columns


### Variables

* Column 1 : Subject

    ID number of subject. **Integer** ranges from 1 to 30.

* Column 2 : Activity

    Activity performed by the subject. **String** with following values:

    + `LAYING`
    + `SITTING`
    + `STANDING`
    + `WALKING`
    + `WALKING_DOWNSTAIRS`
    + `WALKING_UPSTAIRS`
    
* Columns 3-81 : Features Mean & Standard Deviation

    Variables names have the following pattern **[t|f][features][mean|std|meanFreq][X|Y|Z]**

    + [timeDom|freqDom] - `Time domain or frequency domain respectively`
    + [features] - `Names of the type of measurement captured`
    + [mean|std|meanFreq]
        - mean - `Mean value`
        - std - `Standard deviation`
        - meanFreq - `Weighted average of the frequency components to obtain a mean frequency`
    + [X|Y|Z] - `3-axial signals in the X, Y and Z directions (Optional)`
    
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals *tAccXYZ* and *tGyroXYZ*. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (*tBodyAccXYZ* and *tGravityAccXYZ*) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerkXYZ and tBodyGyroJerkXYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (*tBodyAccMag*, *tGravityAccMag*, *tBodyAccJerkMag*, *tBodyGyroMag*, *tBodyGyroJerkMag*).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerkXYZ, fBodyGyroXYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

Features are normalized and bounded within [-1,1]


### Transformations

The following transformation were applied to the original data:

1. Merge the training and the test data in a single data set

2. Load the `features.txt` for the measurement names and extract the mean and standard deviation columns with "mean" and "std" string  

3. Load the `activitiy_labels.txt` for the activity names and replace IDs in activity data from integer values to descriptive names

4. Rename the measurement names into descriptive form as follows:
	- Remove the special characters `(`, `)`, and `-`
	- Replace the initial `f` and `t` with `freqDom` and `timeDom` respectively
	- Remove the duplicated `Body` in feature name found in row 516 to 554 
	- Capitalise first letter of `mean` and `std` for CamelCase convention 

5. Combine the individual data and labels into a single data table as follows:
	- Column joint subject, activity and measurement data in order 
	- Update first two column names as "Subject" and "Activity"
	- Update the remaining column names with descriptive form

6. Creates a melted data frame using Subject and Activity as IDs

7. Generate mean for all measurements grouped by Subject and Activity using `dcast()` function

8. Output the tidy data frame into a text file

The collection of the source data and the transformations listed above were implemented by the `run_analysis.R` R script (see `README.md` file for usage instructions).
