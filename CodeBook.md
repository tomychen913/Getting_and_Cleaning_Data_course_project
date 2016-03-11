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

###Notes: 
* Features are normalized and bounded within [-1,1].  
* For more information about this dataset contact: activityrecognition@smartlab.ws  

###Data source
* Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012.  
* This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.  
* Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.  
