####Data Cleaning Project#######
# Set of things that data should do
#1 Merges the training and the test sets to create one data set.
#2 Extracts only the measurements on the mean and standard deviation for each measurement. 
#3 Uses descriptive activity names to name the activities in the data set
#4 Appropriately labels the data set with descriptive variable names
#5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


## Changing the working directory

setwd("C:\\Users\\arorad\\Downloads\\getdata-projectfiles-UCI HAR Dataset")

# Reading the test files

subject_test <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt")
X_test<- read.table(".\\UCI HAR Dataset\\test\\X_test.txt")
Y_test<- read.table(".\\UCI HAR Dataset\\test\\Y_test.txt")


#Reading the train files

subject_train <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt")
X_train <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt")
Y_train <- read.table(".\\UCI HAR Dataset\\train\\Y_train.txt")


## reading the label files(column names)
features_set <- read.delim(".\\UCI HAR Dataset\\features.txt",sep="",header=F)
features <- as.factor(features_set$V2)
## reading in the activity labels

activity_labels <- read.delim(".\\UCI HAR Dataset\\activity_labels.txt",sep="",header=F)
names(activity_labels) <- c("Activity_ID","Activity_Name")
## creating labels as factors

act_labels <- as.factor(activity_labels$V2)

## creating the col names for test and train datasets

names(X_test) <- features
names(X_train) <- features

names(Y_train) <- c("Activity_ID")
names(Y_test) <- c("Activity_ID")

names(subject_test) <- c("Subject_ID")
names(subject_train) <- c("Subject_ID")

### C BINDING TEST AND TRAIN DATA

data_test <- cbind(subject_test,X_test,Y_test)
data_train <-cbind(subject_train,X_train, Y_train)

## Creating final data set
data <- rbind(data_train,data_test)


## Extracting only the measures with mean and std.

## Using the pattern matching an replacment functions.


reqcol <- grep("mean|std", features_set[,2])
### Taking the step below because in the dataframe named data I have included subject id in col 1 and hence adding +1 to reqcol
reqcol <-reqcol+1

data1 <- data[,c(1,reqcol,563)]


#Uses descriptive activity names to name the activities in the data set##

library(data.table)
#converting frames to data.table to apply merge
data1 <- data.table(data1)
activity_labels <- data.table(activity_labels)

##setting the key

setkey(data1,Activity_ID); setkey(activity_labels,Activity_ID)

data2<-merge(data1,activity_labels)

##creating summarized dataset and wrting the file back
library(stats)

datafinal <- aggregate(data2,by=list(activity=data2$Activity_Name,subject=data2$Subject_ID),mean)
## Cleaning the final data fram before writing
## removing the colnumns Activity_Name Activity_ID and subject

datafinal<-datafinal[,-c(2,3,84)]

write.table(datafinal,file="./data_final.txt",row.name=FALSE)

