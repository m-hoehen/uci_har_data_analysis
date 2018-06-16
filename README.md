# Coursera - Getting and Cleaning Data Course Project
## UCI HAR Dataset - Analysis via script

This repo contains the required script "run_analysis.R" for analyzing the UCI HAR Dataset, which can be found here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

**Before starting the script "run_analysis.R", please unzip the source file and place the according folder called "UCI HAR Dataset" into your working directory**

As per programming assignment in week 4 of the Coursera - Getting and Cleaning Data Course, the "run_analysis.R" does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.