# Getting-and-Cleaning-Data
Programming Assignment of Coursera's Data Science Course


This R script was written during the programming assignment of the coursera course "Getting and Cleaning Data". It gets and cleans the "Human Activity Recognition Using Smartphones Data Set" from the Machine Learning Repository of the UC Irvine.


The packages "data.table" and "plyr" are required to run this script. 

The script run_analysis.R does the following:

1. creats a "./data" folder, downloads a zip file containing the data sets, and unzips the required data to ./data/UCI HAR Dataset

2. reads the files X_train.txt, and y_train.txt of the training set in ./data/UCI HAR Dataset/train/ and does the same for the test set

3. generates data frames from each file and binds the activites values (from y_train.txt and y_test.txt) to the data frames of the training and test sets

4. merges the data frames of the training and test sets

5. renames the columns by descriptive variable names (from ./data/UCI HAR Dataset/features.txt)

6. uses descriptive activity names by matching the IDs with the activity labels (from ./data/UCI HAR Dataset/activity_labels.txt)

7. adds the subject data for the training and test data set

8. calculates the average of each variable by subsetting the resulting data frame (subData) by the subject and the activity