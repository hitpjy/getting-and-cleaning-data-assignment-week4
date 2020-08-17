READ ME. MD

 This readme explains how analysis.R work and how lines are connected.

 The objectives of this assignment on writing the 'run_analysis.R' script are suggested as follows;

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



 The script followed above direction step by step. 

 First it reads files in both train set and test set-inertia signals are excluded, since they are not needed for this assignment- along with features.txt. Then it merges the training and the test sets to create one data. Data of subjects and activities are not merged on this phase, for convenience.



 Second, it extracts the measurements on the mean and standard deviation using grep function and some simple set theory. Also variables are named using features.txt.

 

 Third, descriptive activity names are used to label, using gsub function



 Fourth, using gsub function with tolower, script changes variable names appropriately.

 Last, using plyr and dplyr packages, it creates independent tidy data set with the average of each variable for each activity and each subject using group by and summarize functions.

