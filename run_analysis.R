setwd("~/Desktop/Data Science/GetData Assignment/UCI HAR Dataset")
library(dplyr)

#Read labels and variable names
activities<-read.table("~/Desktop/Data Science/GetData Assignment/UCI HAR Dataset/activity_labels.txt")
features<-read.table("~/Desktop/Data Science/GetData Assignment/UCI HAR Dataset/features.txt")
features<-features[,2]

#Find columns to be kept (those containing the strings mean or std)
mean.ind<-grepl("mean",features)
std.ind<-grepl("std",features)
ind<-as.logical(std.ind+mean.ind)

##Adjust to keep activity and subject columns which are added in later steps
ind[3:563]<-ind[1:561]
ind[1:2]<-TRUE
ind[564]<-FALSE

#Read test data
x_test<-read.table("~/Desktop/Data Science/GetData Assignment/UCI HAR Dataset/test/X_test.txt",col.names=features)
y_test<-read.table("~/Desktop/Data Science/GetData Assignment/UCI HAR Dataset/test/y_test.txt",col.names="activity")
subject_test<-read.table("~/Desktop/Data Science/GetData Assignment/UCI HAR Dataset/test/subject_test.txt",col.names="subject")

#Read training data
x_train<-read.table("~/Desktop/Data Science/GetData Assignment/UCI HAR Dataset/train/X_train.txt",col.names=features)
y_train<-read.table("~/Desktop/Data Science/GetData Assignment/UCI HAR Dataset/train/y_train.txt", col.names="activity")
subject_train<-read.table("~/Desktop/Data Science/GetData Assignment/UCI HAR Dataset/train/subject_train.txt",col.names="subject")

#Combine data sets
test<-cbind(subject_test,y_test,x_test)
train<-cbind(subject_train,y_train,x_train)
data<-rbind(test,train)
rm(x_test,y_test,subject_test,x_train,y_train,subject_train,test,train,features,mean.ind, std.ind)

#Replace activity numbers with names
data$activity<-as.factor(data$activity)
data<-merge(data,activities,by.x="activity",by.y="V1")
data$activity<-data$V2
rm(activities)

#Filter columns
col.f<-colnames(data[,ind])
data.f<-subset(data,select=ind)

#Make new tidy data set of averages for each feature by activity and subject
tidy<-aggregate(data[,3] ~ data$activity + data$subject, FUN= "mean")
for(i in 4:82){
    temp<-aggregate(data[,i] ~ data$activity + data$subject, FUN= "mean")
    tidy[,i]<-temp[,3]
}
colnames(tidy)<-colnames(data.f)

#Write tidy data set to file
write.table(tidy,file="AveragesBySubjectAndActivity.txt",row.name=FALSE)