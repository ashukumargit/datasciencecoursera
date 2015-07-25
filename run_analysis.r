## Script: run_analysis.r
## For deatils, see CodeBook.md and Readme.mdn_


## Merges the training and the test sets to create one data set:

trainx <- read.table("train/X_train.txt")
testx <- read.table("test/X_test.txt")
traintestx <- rbind(trainx, testx)

trainsub <- read.table("train/subject_train.txt")
testsub <- read.table("test/subject_test.txt")
traintestsub <- rbind(trainsub, testsub)

trainy <- read.table("train/y_train.txt")
testy <- read.table("test/y_test.txt")
traintesty <- rbind(trainy, testy)

names(traintestsub)<-c("subject")
names(traintesty)<-c("activity")
features<-read.table("features.txt")
names(traintestx)<-features$V2

mergedata <- cbind(traintestsub,traintesty)
totdata <- cbind(traintestx,mergedata)

## Extracts only the measurements on the mean and standard deviation for each measurement. 

subfeatures<-features$V2[grep("mean\\(\\)|std\\(\\)", features$V2)]
selectednames<-c(as.character(subfeatures), "subject", "activity" )
subdata<-subset(totdata,select=selectednames)

## Uses descriptive activity names to name the activities in the data set

activitytype <- read.table("activity_labels.txt")
head(totdata$activity)


## Appropriately labels the data set with descriptive variable names


names(subdata)<-gsub("Acc", "Accelrometer", names(subdata))
names(subdata)<-gsub("Gyro", "Gyroscope", names(subdata))
names(subdata)<-gsub("Mag", "Magnitude", names(subdata))
names(subdata)<-gsub("BodyBody", "Body", names(subdata))
names(subdata)<-gsub("^t", "time", names(subdata))
names(subdata)<-gsub("^f", "frequency", names(subdata))

## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidydata<-aggregate(. ~subject + activity, subdata, mean)
tidydata<-tidydata[order(tidydata$subject,tidydata$activity),]
write.table(tidydata, file = "tidydata.txt",row.name=FALSE)
