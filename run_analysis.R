setwd("/Users/Tomy/Documents/course_project")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("UCI HAR Dataset.zip")){download.file(fileUrl, 
                                              "UCI HAR Dataset.zip", method="curl")}
if(!file.exists("./UCI HAR Dataset")){unzip("UCI HAR Dataset.zip")}

library(dplyr)
library(tidyr)

##Merges the training and the test sets to create one data set.
##read test set
tab5rows <- read.table("./UCI HAR Dataset/test/subject_test.txt", nrows = 5)
classes <- sapply(tab5rows, class)
testsubjectid <- read.table("./UCI HAR Dataset/test/subject_test.txt", colClasses = classes)
tab5rows <- read.table("./UCI HAR Dataset/test/y_test.txt", nrows = 5)
classes <- sapply(tab5rows, class)
testdatasetlabel <- read.table("./UCI HAR Dataset/test/y_test.txt", colClasses = classes)
tab5rows <- read.table("./UCI HAR Dataset/test/X_test.txt", nrows = 5)
classes <- sapply(tab5rows, class)
testdataset <- read.table("./UCI HAR Dataset/test/X_test.txt", colClasses = classes)
testdf <- cbind(testsubjectid, testdatasetlabel, testdataset)

##read training set
tab5rows <- read.table("./UCI HAR Dataset/train/subject_train.txt", nrows = 5)
classes <- sapply(tab5rows, class)
trainsubjectid <- read.table("./UCI HAR Dataset/train/subject_train.txt", colClasses = classes)
tab5rows <- read.table("./UCI HAR Dataset/train/y_train.txt", nrows = 5)
classes <- sapply(tab5rows, class)
traindatasetlabel <- read.table("./UCI HAR Dataset/train/y_train.txt", colClasses = classes)
tab5rows <- read.table("./UCI HAR Dataset/train/X_train.txt", nrows = 5)
classes <- sapply(tab5rows, class)
traindataset <- read.table("./UCI HAR Dataset/train/X_train.txt", colClasses = classes)
traindf <- cbind(trainsubjectid, traindatasetlabel, traindataset)

AllId <-rbind(testsubjectid, trainsubjectid)
names(AllId)<- "subject"
AllLabel <- rbind(testdatasetlabel, traindatasetlabel)
names(AllLabel) <- "activity"
alldata <- rbind(testdataset, traindataset)
alldata <- tbl_df(alldata)

##Extracts only the measurements on the mean and standard deviation for each measurement.
activitylabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
allfeatures <- read.table("./UCI HAR Dataset/features.txt")
MeanIndex <- as.numeric(grep("mean\\(\\)",allfeatures$V2))
MeanName <- grep("mean\\(\\)",allfeatures$V2,value=TRUE)
MeanRefer <- data.frame(cbind(MeanIndex,MeanName))
MeanRefer <- mutate(MeanRefer,MeanIndex = extract_numeric(MeanIndex))

StdIndex <- grep("std\\(\\)",allfeatures$V2)
StdName <- grep("std\\(\\)",allfeatures$V2,value=TRUE)
StdRefer <- data.frame(cbind(StdIndex,StdName))
StdRefer <- mutate(StdRefer, StdIndex = extract_numeric(StdIndex))

ExtractRefer <- data.frame(rbind(as.matrix(MeanRefer),as.matrix(StdRefer)))
ExtractRefer <- mutate(ExtractRefer, MeanIndex = extract_numeric(MeanIndex))
ExtractRefer <- arrange(ExtractRefer, MeanIndex)
names(ExtractRefer) <- c("index", "names")
ExtractDone <- select(alldata, as.vector(ExtractRefer$index))
names(ExtractDone) <- ExtractRefer$names
ExtractDone <- cbind(AllId, AllLabel,ExtractDone)


##Uses descriptive activity names to name the activities in the data set
ReplaceFullName <- function(x){activitylabels[x,2]}
ExtractDone <- mutate(ExtractDone, activity = sapply(ExtractDone$activity,
                                                  ReplaceFullName))


##Appropriately labels the data set with descriptive variable names.
names(ExtractDone) <- gsub("^t", "time-", names(ExtractDone))
names(ExtractDone) <- gsub("^f", "frequency-", names(ExtractDone))
names(ExtractDone) <- gsub("Acc", "Accelerometer", names(ExtractDone))
names(ExtractDone) <- gsub("Gyro", "Gyroscope", names(ExtractDone))
names(ExtractDone) <- gsub("Mag", "Magnitude", names(ExtractDone))
names(ExtractDone) <- gsub("BodyBody", "Body", names(ExtractDone))
names(ExtractDone) <- gsub("Body", "Body-", names(ExtractDone))
names(ExtractDone) <- gsub("Gravity", "Gravity-", names(ExtractDone))
names(ExtractDone) <- gsub("mean\\(\\)", "mean", names(ExtractDone))
names(ExtractDone) <- gsub("std\\(\\)", "standarddeviation", names(ExtractDone))

##From the data set in step 4, creates a second, independent tidy data 
##set with the average of each variable for each activity and each subject.
##
##Average of each variable except the subject and label. 
##Useing aggregate to group them(subject and label), and mean of other variable.
AvgExtractDone <- tbl_df(aggregate(. ~subject + activity, data=ExtractDone, FUN=mean))
AvgExtractDone <- arrange(AvgExtractDone, subject, activity)
AvgExtractDone <- gather(AvgExtractDone, "key", "average", 3:68) 
AvgExtractDone <- separate(AvgExtractDone, key, into=c("sampling","source",
                                                       "method","statistic","axis"), sep="-")

write.table(AvgExtractDone, file = "tidydata.txt",row.name=FALSE)
