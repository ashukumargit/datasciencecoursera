File Name : README.md

-------
This file explains the code (run_analysis.R) written for claening and preparing the Samsung Device data captured for activities of subjects. More details can be found in CodeBook.md

---------
Read Features Data

trainx <- read.table("train/X_train.txt")
testx <- read.table("test/X_test.txt")

-----------
Concatenate Features data by rows

traintestx <- rbind(trainx, testx)

--------
Read Subject Data

trainsub <- read.table("train/subject_train.txt")
testsub <- read.table("test/subject_test.txt")

---
Concatenate Subjects data by rows

traintestsub <- rbind(trainsub, testsub)

-------
Read Activities Data

trainy <- read.table("train/y_train.txt")
testy <- read.table("test/y_test.txt")

-----
Concatenate Activities data by rows

traintesty <- rbind(trainy, testy)

-----
Set Names

names(traintestsub)<-c("subject")
names(traintesty)<-c("activity")
features<-read.table("features.txt")
names(traintestx)<-features$V2

---
Merge Columns to get the full data set in data frame

mergedata <- cbind(traintestsub,traintesty)
totdata <- cbind(traintestx,mergedata)

---
Subset Name of Features by measurements on the mean and standard deviation

subfeatures<-features$V2[grep("mean\\(\\)|std\\(\\)", features$V2)]
selectednames<-c(as.character(subfeatures), "subject", "activity" )
subdata<-subset(totdata,select=selectednames)

--
Read activity names 
activitytype <- read.table("activity_labels.txt")

--
Labeling the data with descriptive names

names(subdata)<-gsub("Acc", "Accelrometer", names(subdata))
names(subdata)<-gsub("Gyro", "Gyroscope", names(subdata))
names(subdata)<-gsub("Mag", "Magnitude", names(subdata))
names(subdata)<-gsub("BodyBody", "Body", names(subdata))
names(subdata)<-gsub("^t", "time", names(subdata))
names(subdata)<-gsub("^f", "frequency", names(subdata))

--
Sub-setting the data with averages and writing it in a file

tidydata<-aggregate(. ~subject + activity, subdata, mean)
tidydata<-tidydata[order(tidydata$subject,tidydata$activity),]
write.table(tidydata, file = "tidydata.txt",row.name=FALSE)
