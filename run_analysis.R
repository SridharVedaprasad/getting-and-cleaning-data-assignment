library(dplyr)
#loading dplyr package

filename<-"Coursera_Data.zip"
if(!file.exists(filename)){
  fileURL<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL,filename,method="curl")
}

#checking if the folder exists
if(!file.exists("UCI HAR Dataset")){
  unzip(filename)
}

#assigning dataframes to new variables
features<-read.table("UCI HAR Dataset/features.txt",col.names=c("n","functions"))
activities<-read.table("UCI HAR Dataset/activity_labels.txt",col.names=c("code","activity"))
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt",col.names="subject")
x_test<-read.table("UCI HAR Dataset/test/X_test.txt",col.names=features$functions)
y_test<-read.table("UCI HAR Dataset/test/y_test.txt",col.names="code")
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt",col.names="subject")
x_train<-read.table("UCI HAR Dataset/train/X_train.txt",col.names=features$functions)
y_train<-read.table("UCI HAR Dataset/train/y_train.txt",col.names="code")

#merging to create one data set
x<-rbind(x_train,x_test)
y<-rbind(y_train,y_test)
Subject<-rbind(subject_train,subject_test)
Merged_Data<-cbind(Subject,y,x)

#extracting only the mean and std for each measurement 
TidyData<-Merged_Data %>% select(subject,code,contains("mean"),contains("std"))

#using descriptive variable names for the new dataset
TidyData$code<-activities[TidyData$code,2]

names(TidyData)[2]="activity"
names(TidyData)<-gsub("Acc","Accelerometer",names(TidyData))
names(TidyData)<-gsub("Gyro","Gyroscope",names(TidyData))
names(TidyData)<-gsub("BodyBody","Body",names(TidyData))
names(TidyData)<-gsub("Mag","Magnitude",names(TidyData))
names(TidyData)<-gsub("^t","Time",names(TidyData))
names(TidyData)<-gsub("^f","Frequency",names(TidyData))
names(TidyData)<-gsub("tBody","TimeBody",names(TidyData))
names(TidyData)<-gsub("-mean()","Mean",names(TidyData),ignore.case=TRUE)
names(TidyData)<-gsub("-std()","STD",names(TidyData),ignore.case=TRUE)
names(TidyData)<-gsub("-freq()","Frequency",names(TidyData),ignore.case=TRUE)
names(TidyData)<-gsub("angle","Angle",names(TidyData))
names(TidyData)<-gsub("gravity","Gravity",names(TidyData))

#new independent dataset with the average of each variable for each activity and subject
FinalData<-TidyData %>% 
  group_by(subject,activity) %>% 
  summarise_all(funs(mean))
write.table(FinalData,"FinalData.txt",row.name=FALSE)