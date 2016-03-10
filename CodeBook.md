##Code book

This code book descripts the variables of tidydata.txt

###Structure of data set
Classes ‘tbl_df’, ‘tbl’ and 'data.frame':	11880 obs. of  8 variables:  
 $ subject  : int  1 1 1 1 1 1 2 2 2 2 ...  
 $ activity : Factor w/ 6 levels "LAYING","SITTING",..: 1 2 3 4 5 6 1 2 3 4 ...  
 $ sampling : chr  "time" "time" "time" "time" ...  
 $ source   : chr  "Body" "Body" "Body" "Body" ...  
 $ method   : chr  "Accelerometer" "Accelerometer" "Accelerometer" "Accelerometer" ...  
 $ statistic: chr  "mean" "mean" "mean" "mean" ...  
 $ axis     : chr  "X" "X" "X" "X" ...  
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
  * 
* statistic - Statistic method(mean and standard deviation)
  * vlaue: mean, std
* axis - The Dimension of acceleration sensor
  * value: X, Y, Z, NA 
* average - The summarize of mean group by subject and activity
