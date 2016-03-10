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
```
setwd("/Users/Tomy/Documents/course_project")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
```  
download and unzip file
```
if(!file.exists("UCI HAR Dataset.zip")){download.file(fileUrl, 
                                              "UCI HAR Dataset.zip", method="curl")}
if(!file.exists("./UCI HAR Dataset")){unzip("UCI HAR Dataset.zip")}
```
make sure the directory structure like this
```
dir(recursive =TRUE)
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
