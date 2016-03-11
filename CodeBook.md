##Code book

This code book descripts the variables of tidydata.txt

###Structure of data set
```R
Classes ‘tbl_df’, ‘tbl’ and 'data.frame':	11880 obs. of  8 variables:
 $ subject  : int  1 1 1 1 1 1 2 2 2 2 ...
 $ activity : Factor w/ 6 levels "LAYING","SITTING",..: 1 2 3 4 5 6 1 2 3 4 ...
 $ sampling : chr  "time" "time" "time" "time" ...
 $ source   : chr  "Body" "Body" "Body" "Body" ...
 $ method   : chr  "Accelerometer" "Accelerometer" "Accelerometer" "Accelerometer" ...
 $ statistic: chr  "mean" "mean" "mean" "mean" ...
 $ axis     : chr  "X" "X" "X" "X" ...
 $ average  : num  0.222 0.261 0.279 0.277 0.289 ... 
```
###Variable Description
* __subject__ - _The identity number of test subject_  
  * value: 1 to 30(numeric)
* __activity__ - _Test subject's activity type_  
  * value: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
* __sampling__ - _The measurement domain_
  * value: time, frequency
* __source__ - _Body and gravity acceleration signals_
  * value: body, gravity
* __method__ - _Eigenvalue of acceleration and gyroscope, including jerk and magnitude calculation_
  * value: Accelerometer, AccelerometerJerk, Gyroscope, GyroscopeJerk, AccelerometerMagnitude, AccelerometerJerkMagnitude, GyroscopeMagnitude, GyroscopeJerkMagnitude    
* __statistic__ - _Statistic method(mean and standard deviation)_
  * vlaue: mean, std
* __axis__ - _The Dimension of acceleration sensor_
  * value: X, Y, Z, NA 
* __average__ - _The summarize mean of measurements from group by subject and activity_
