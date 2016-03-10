##Code book

This code book descripts the variables of tidydata.txt

###Structure of data set
Classes ‘tbl_df’, ‘tbl’ and 'data.frame':	11880 obs. of  8 variables:  
 $ subject  : int  1 1 1 1 1 1 2 2 2 2 ...  
 $ activity : Factor w/ 6 levels "LAYING","SITTING",..: 1 2 3 4 5 6 1 2 3 4 ...  
 $ sampling : Factor w/ 2 levels "frequency","time": 2 2 2 2 2 2 2 2 2 2 ...  
 $ source   : Factor w/ 2 levels "Body","Gravity": 1 1 1 1 1 1 1 1 1 1 ...  
 $ method   : Factor w/ 8 levels "Accelerometer",..: 1 1 1 1 1 1 1 1 1 1 ...  
 $ statistic: Factor w/ 2 levels "mean","StandardDeviation": 1 1 1 1 1 1 1 1 1 1 ...  
 $ axis     : Factor w/ 3 levels "X","Y","Z": 1 1 1 1 1 1 1 1 1 1 ...  
 $ average  : num  0.222 0.261 0.279 0.277 0.289 ...  

###Variable Description
* subject - The identity number of test subject  
* activity - Test subject's activity type  
  * value: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
* sampling - The measurement mode
  * value: time, frequency
* source - Body and gravity acceleration signals
  * value: body, gravity
* method - Eigenvalue of acceleration or gyroscope, including jerk and magnitude calculation
  * value: Accelerometer, AccelerometerJerk, Gyroscope, GyroscopeJerk, AccelerometerMagnitude, AccelerometerJerkMagnitude, GyroscopeMagnitude, GyroscopeJerkMagnitude    
* statistic - Statistic method(mean and standard deviation)
  * vlaue: mean, std
* axis - The Dimension of acceleration sensor
  * value: X, Y, Z, NA 
* average - The summarize of mean from group by subject and activity
