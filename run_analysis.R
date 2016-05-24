## Assignment: Getting and Cleaning Data Course Project
## loading necesarylibraries amd initializations
library(dplyr)
workingDirectoryPath<-"~/Desktop/R_WD/Curso3/Week 4/Getting and Cleaning Data - Project/UCI HAR Dataset"

## Read data: test and train
y_test <- tbl_df(read.table(file.path(workingDirectoryPath,"test/y_test.txt"), quote="\"", comment.char="", stringsAsFactors=FALSE))
X_test <- tbl_df(read.table(file.path(workingDirectoryPath,"test/X_test.txt"), quote="\"", comment.char="", stringsAsFactors=FALSE))
subject_test <- tbl_df(read.table(file.path(workingDirectoryPath,"test/subject_test.txt"), quote="\"", comment.char="", stringsAsFactors=FALSE))

y_train <- tbl_df(read.table(file.path(workingDirectoryPath,"train/y_train.txt"), quote="\"", comment.char="", stringsAsFactors=FALSE))
X_train <- tbl_df(read.table(file.path(workingDirectoryPath,"train/X_train.txt"), quote="\"", comment.char="", stringsAsFactors=FALSE))
subject_train <- tbl_df(read.table(file.path(workingDirectoryPath,"train/subject_train.txt"), quote="\"", comment.char="", stringsAsFactors=FALSE))

features <- tbl_df(read.table(file.path(workingDirectoryPath,"features.txt"), quote="\"", comment.char="", stringsAsFactors=FALSE))
activity_labels <- tbl_df(read.table(file.path(workingDirectoryPath,"activity_labels.txt"), quote="\"", comment.char="", col.names = c("id","activity")))

#### Prepare each dataset before merging 
X_test<- mutate(X_test, set = "test")                           ## Adding column with set value ("test")
test<- mutate(X_test, activityId = unlist(y_test[,1]))          ## Adding column with activities 
test <- mutate(test, subject = unlist(subject_test[,1]))        ## Adding column with subjects
rm(X_test, y_test)          ## Cleaning

X_train <- mutate(X_train,set = "train")                        ## Adding column with set value ("train")
train <- mutate(X_train, activityId = unlist(y_train[,1]))      ## Adding column with activities 
train <- mutate(train, subject = unlist(subject_train[,1]))     ## Adding column with subjects
rm(X_train, y_train)        ## Cleaning

######### 1. Merges the train and test sets 
allData <- tbl_df(rbind(test,train))
rm(test,train)              ## Cleaning        


#### 
allData$set <- factor(allData$set)                        ## Defining the correct class for set variable
allData$activity <- factor(allData$activity)              ## Defining the correct class for activity variable
allData$subject <-factor(allData$subject)                 ## Defining the correct class for subject variable


######### 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
reqCol<-grep("mean|std",features$V2)
reqData1 <- select(allData,reqCol,562,563,564)
rm(allData)


######### 3. Uses descriptive activity names to name the activities in the data set
reqData1 <- merge(reqData1,activity_labels,by.x = "activityId",by.y = "id")
reqData1 <- select(reqData1, -activityId)
rm(activity_labels)

######### 4. Appropriately labels the data set with descriptive variable names.
appropieateLabels <-features[reqCol,]
appropieateLabels[80,1]<-562; appropieateLabels[80,2]<-"set"
appropieateLabels[81,1]<-563; appropieateLabels[81,2]<-"subject"
appropieateLabels[82,1]<-564; appropieateLabels[82,2]<-"activity"
rm(features)

names(reqData1)<-appropieateLabels$V2
rm(appropieateLabels)

### CleanUp variable names
names(reqData1)<-tolower(names(reqData1))
names(reqData1) <-gsub("\\(\\)","",names(reqData1))
names(reqData1) <-gsub("\\-","_",names(reqData1))

### Reordering columns
reqData1 <- select(reqData1,set,activity,tbodyacc_mean_x:fbodybodygyrojerkmag_meanfreq,subject)


######### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
reqData2 <- group_by(reqData1,activity,subject)
sumaryReqData2 <- summarise(reqData2,mean(tbodyacc_mean_x:fbodybodygyrojerkmag_meanfreq,na.rm = TRUE))


