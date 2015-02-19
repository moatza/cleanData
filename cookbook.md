This file describes the variables, the data, and any transformations or work that I have performed to clean up the data.
•	Data processed by the R script was downloaded from: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The data for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
•	The run_analysis.R script performs the following steps:

o	Read X_train.txt, y_train.txt and subject_train.txt from the "./data/train" folder and store them in xtrain, ytrain and subjtrain variables respectively.
o	Read X_test.txt, y_test.txt and subject_test.txt from the "./data/test" folder and store them in xtest, ytest, subjtest variables respectively.
o	Concatenate xtrain, ytrain, subjtrain, xtest, ytest, subjtest   in fulldataset
o	Read the features.txt file from the "/data" folder and store the data in a variable called features. 
o	Extract the measurements on the mean and standard deviation.
o	Read the activity_labels.txt file from the "./data"" folder and store the data in a variable called act.
o	Transform the values of ytotal according to the act.
o	Combine the fulldataset with features to get a data set with descriptive variable names (nnDS)
o	Generate a second independent tidy data set with the average of each measurement for each activity and each subject and save the info in tidydata.txt
