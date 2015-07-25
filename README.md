File Name : README.md
Subject: This file explains the code (run_analysis.R) written for claening and preparing the Samsung Device data captured for activities of subjects. More details can be found in CodeBook.md

Read Features Data
trainx <- read.table("train/X_train.txt")
testx <- read.table("test/X_test.txt")

Concatenate Features data by rows
traintestx <- rbind(trainx, testx)

Read Subject Data
trainsub <- read.table("train/subject_train.txt")
testsub <- read.table("test/subject_test.txt")

Concatenate subjects data by rows
traintestsub <- rbind(trainsub, testsub)

Read Activities Data
trainy <- read.table("train/y_train.txt")
testy <- read.table("test/y_test.txt")

Concatenate Activities data by rows
traintesty <- rbind(trainy, testy)
