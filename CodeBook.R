The run_analysis.R script performs the data preparation and then followed by the 5 steps required as describec 
in the course project's definition.

1. Download the dataset
Dataset downloaded and extracted under the folder called UCI HAR Dataset. The data can be downloaded from <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

2. Assign each data to variables
features<-features.txt 561 rows, 2 columns
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals 
tAcc-XYZ and tGyro-XYZ

activities <- activity_labels.txt : 6 rows, 2 columns 
List of activities performed when the corresponding measurements were taken and its codes (labels)

subject_test <- test/subject_test.txt : 2947 rows, 1 column 
contains test data of 9/30 volunteer test subjects being observed

x_test <- test/X_test.txt : 2947 rows, 561 columns 
contains recorded features test data

y_test <- test/y_test.txt : 2947 rows, 1 columns 
contains test data of activities’code labels

subject_train <- test/subject_train.txt : 7352 rows, 1 column 
contains train data of 21/30 volunteer subjects being observed

x_train <- test/X_train.txt : 7352 rows, 561 columns 
contains recorded features train data

y_train <- test/y_train.txt : 7352 rows, 1 columns 
contains train data of activities’code labels

3. Merge the training and test datasets
x(10299 rows and 561 columns) created by merging x_train and x_test using rbind() function
y(10299 rows and 1 column) created by merging y_train and y_test using rbind() function
Subject(10299 rows and 1 column) created by merging subject_train and subject_test using rbind() function
Merged_Data(10299 rows and 563 column) created by merging Subject,y and x using cbind() function

4. Extracts only the measurements on mean and std for each measurement
TidyData(10299 rows and 88 columns) created by subsetting Merged_Data, selecting only subject, code and the measurements on the mean and standard deviation(std) columns for each measurement

5.Name the activity variables descripitively
Entire numbers in code column of TidyData replaced with corresponding activity taken from the second column of activities variable

6. Descriptive variable names for all variables
code column in TidyData renamed to activities
Acc -> Accelerometer
Gyro -> Gyroscope
BodyBody -> Body
Mag -> Magnitude
f -> Frequency
t -> Time

7. Create a second independent dataset with the average of each variable for each activity and each subject
FinalData(180 rows and 88 columns) created by summarizing TidyData taking the mean of each variable of each activity and subject and grouping by subject and activity
Export FinalData into FinalData.txt file