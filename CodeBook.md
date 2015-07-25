Document: CodeBook.md
Background:
One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data used in this code is collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
Data Source:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Goals and Objectives:
The goal is to prepare a tidy data set that can be used for later analysis with the following steps:
1.	Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
3.	Uses descriptive activity names to name the activities in the data set
4.	Appropriately labels the data set with descriptive variable names. 
5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
Files, variables, the data, and transformations:
File Name: run_analysis.r
Data retrieved from the source and unzipped in directory samsungdata
•	README.txt'
•	'features_info.txt': Shows information about the variables used on the feature vector.
•	'features.txt': List of all features.
•	'activity_labels.txt': Links the class labels with their activity name.
•	'train/X_train.txt': Training set.
•	'train/y_train.txt': Training labels.
•	train/subject_train.txt : Training Subjects
•	'test/X_test.txt': Test set.
•	'test/y_test.txt': Test labels.
Variables
•	trainx to read training data
•	testx to read test data
•	traintestx to hold merged rows for training and test data
•	trainsub to read subject data
•	testsub to read subject labels
•	traintestsub to hold merged rows for subject data
•	trainy to read training labels
•	testy to read test lables
•	traintesty to hold merged row data
•	features to read and hold features data
•	mergedata to hold column merge data for training and subject
•	totdata to hold the complete set of data with all merged columns
•	subdata to hold sub set of data after extracting only the measurements on the mean and standard deviation for each measurement.
Logic and Transformations

Extracts only the measurements on the mean and standard deviation for each measurement. 
subfeatures<-features$V2[grep("mean\\(\\)|std\\(\\)", features$V2)]
selectednames<-c(as.character(subfeatures), "subject", "activity" )
subdata<-subset(totdata,select=selectednames)

Uses descriptive activity names to name the activities in the data set
activitytype <- read.table("activity_labels.txt")
head(totdata$activity)

Appropriately labels the data set with descriptive variable names

names(subdata)<-gsub("Acc", "Accelrometer", names(subdata))
names(subdata)<-gsub("Gyro", "Gyroscope", names(subdata))
names(subdata)<-gsub("Mag", "Magnitude", names(subdata))
names(subdata)<-gsub("BodyBody", "Body", names(subdata))
names(subdata)<-gsub("^t", "time", names(subdata))
names(subdata)<-gsub("^f", "frequency", names(subdata))

extracting independent tidy data set with the average of each variable for each activity and each subject.

tidydata<-aggregate(. ~subject + activity, subdata, mean)
tidydata<-tidydata[order(tidydata$subject,tidydata$activity),]
write.table(tidydata, file = "tidydata.txt",row.name=FALSE)
