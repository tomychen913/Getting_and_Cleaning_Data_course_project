# Getting_and_Cleaning_Data_course_project

##Description
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

##Processing steps
1. Merges the training and the test sets to create one data set.  
2. Extracts only the measurements on the mean and standard deviation for each measurement.  
3. Uses descriptive activity names to name the activities in the data set.  
4. Appropriately labels the data set with descriptive variable names.  
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  

##R script comment
First, set working directory and file download url  
```R
setwd("/Users/Tomy/Documents/course_project")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
```  
Download and unzip file
```R
if(!file.exists("UCI HAR Dataset.zip")){download.file(fileUrl, 
                                              "UCI HAR Dataset.zip", method="curl")}
if(!file.exists("./UCI HAR Dataset")){unzip("UCI HAR Dataset.zip")}
```
Make sure the directory structure like this
```R
dir(recursive = TRUE)
 [1] "run_analysis.R"                                              
 [2] "UCI HAR Dataset.zip"                                         
 [3] "UCI HAR Dataset/activity_labels.txt"                         
 [4] "UCI HAR Dataset/features_info.txt"                           
 [5] "UCI HAR Dataset/features.txt"                                
 [6] "UCI HAR Dataset/README.txt"                                  
 [7] "UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt"   
 [8] "UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt"   
 [9] "UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt"   
[10] "UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt"  
[11] "UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt"  
[12] "UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt"  
[13] "UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt"  
[14] "UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt"  
[15] "UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt"  
[16] "UCI HAR Dataset/test/subject_test.txt"                       
[17] "UCI HAR Dataset/test/X_test.txt"                             
[18] "UCI HAR Dataset/test/y_test.txt"                             
[19] "UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt" 
[20] "UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt" 
[21] "UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt" 
[22] "UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt"
[23] "UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt"
[24] "UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt"
[25] "UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt"
[26] "UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt"
[27] "UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt"
[28] "UCI HAR Dataset/train/subject_train.txt"                     
[29] "UCI HAR Dataset/train/X_train.txt"                           
[30] "UCI HAR Dataset/train/y_train.txt"
```
###Stpe 1: merge data set
This step we merges the training and the test sets to create one data set.  
The tip is assigning colClasses to speed up read.table function.  
Read test data set by column,and cbind them.  
|| testsubjectid ||  testdatasetlabel || testdataset
```R
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
```
Read train data set by column,and cbind them.  
|| trainsubjectid ||  traindatasetlabel || traindataset  

```R
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
```
Now, we can combine test and train data set. And assign descriptive names.  
|| testsubjectid  ||  
|| trainsubjectid ||
```R
AllId <-rbind(testsubjectid, trainsubjectid)
names(AllId)<- "subject"
```
|| testdatasetlabel  ||  
|| traindatasetlabel ||
```R
AllLabel <- rbind(testdatasetlabel, traindatasetlabel)
names(AllLabel) <- "activity"
```
|| testdataset  ||  
|| traindataset ||
```
alldata <- rbind(testdataset, traindataset)
alldata <- tbl_df(alldata)
```

###Stpe 2: Extracts measurements names(mean and std)

Read all features name to __allfeatures__.  
Create __MeanRefer__ data frame:  
|| MeanIndex || MeanName ||
```R
activitylabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
allfeatures <- read.table("./UCI HAR Dataset/features.txt")
MeanIndex <- as.numeric(grep("mean\\(\\)",allfeatures$V2))
MeanName <- grep("mean\\(\\)",allfeatures$V2,value=TRUE)
MeanRefer <- data.frame(cbind(MeanIndex,MeanName))
MeanRefer <- mutate(MeanRefer,MeanIndex = extract_numeric(MeanIndex))
```
Create __StdRefer__ data frame:  
|| StdIndex || StdName ||
```R
StdIndex <- grep("std\\(\\)",allfeatures$V2)
StdName <- grep("std\\(\\)",allfeatures$V2,value=TRUE)
StdRefer <- data.frame(cbind(StdIndex,StdName))
StdRefer <- mutate(StdRefer, StdIndex = extract_numeric(StdIndex))
```
Conbine __MeanRefer__ and __StdRefer__.  
```R
ExtractRefer <- data.frame(rbind(as.matrix(MeanRefer),as.matrix(StdRefer)))
ExtractRefer <- mutate(ExtractRefer, MeanIndex = extract_numeric(MeanIndex))
ExtractRefer <- arrange(ExtractRefer, MeanIndex)
names(ExtractRefer) <- c("index", "names")
```
Filter __alldata__ value to __ExtractDone__.  
```R
ExtractDone <- select(alldata, as.vector(ExtractRefer$index))
names(ExtractDone) <- ExtractRefer$names
ExtractDone <- cbind(AllId, AllLabel,ExtractDone)
```

###Stpe 3: Replace descriptive activity names

The __ExtractDone__ stored the descriptive nemes of activity.  
Use sapply to looking for and replace it.  
```R
ReplaceFullName <- function(x){activitylabels[x,2]}
ExtractDone <- mutate(ExtractDone, activity = sapply(ExtractDone$activity,
                                                  ReplaceFullName))
```

###Stpe 4: Appropriately variable names
Use gsub substitute text.
```R
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
```

###Stpe 5: Average of each variable
Tidying __ExtractDone__ to calculate mean of each measurements.  
Store result in __AvgExtractDone__,and separate each variable.  
```R
AvgExtractDone <- tbl_df(aggregate(. ~subject + activity, data=ExtractDone, FUN=mean))
AvgExtractDone <- arrange(AvgExtractDone, subject, activity)
AvgExtractDone <- gather(AvgExtractDone, "key", "average", 3:68) 
AvgExtractDone <- separate(AvgExtractDone, key, into=c("sampling","source",
                                                       "method","statistic","axis"), sep="-")
```
Convert characher to factor.  
```R
AvgExtractDone <- mutate(AvgExtractDone, sampling = as.factor(sampling))
AvgExtractDone <- mutate(AvgExtractDone, source = as.factor(source))
AvgExtractDone <- mutate(AvgExtractDone, method = as.factor(method))
AvgExtractDone <- mutate(AvgExtractDone, statistic = as.factor(statistic))
AvgExtractDone <- mutate(AvgExtractDone, axis = as.factor(axis))
```

Export txt file, named __tidydata.txt__.
```R
write.table(AvgExtractDone, file = "tidydata.txt",row.name=FALSE)
```
