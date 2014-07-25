## Course Project: Getting and Cleaning Data

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  

One of the most exciting areas in all of data science right now is wearable computing - see for example  this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

Here are the data for the project: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The R script called run_analysis.R does the following.  

1. Merges the training and the test sets to create one data set in a subdirectory.  

2.  Extracts only the measurements on the mean and standard deviation for each measurement. The selected measurements have either "mean()" or "std()" in their name.  

3. Uses descriptive activity names (from activity_labels.txt in the dataset) to name the activities in the data set.  

4. Appropriately labels the data set with descriptive variable names. The variable names are taken from features.txt in the dataset. For my purposes the "()" in the original variable names are removed. The "-" are replaced by ".".

5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. I intentionally use a programming style typical for scripting languages and not for R.  

6. To try: source("run_analysis.R") and then call main() or if you want to download the data from the course website, call main(download=TRUE) 



