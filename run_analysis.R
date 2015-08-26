library(plyr)
library(reshape2)

########################################################################################
## 1 Merge training and test data

## This script automates the process of loading the test and training data, combining them
## and summarizing the data

## Common functions
        ##Read txt file and load
read_data <- function(filename, sep = ""){  
        read.table(filename,sep = sep) 
}
## Load data

## Load training data
filename<-"X_train.txt"
trainx <- read_data(filename)

##Load the corespondent subject ID for the training data
filename<-"subject_train.txt"
trainsub <- read_data(filename)

##Load the activity description
filename<-"activity_labels.txt"
actdesc <- read_data(filename)

##Load the activity associated with each observation
filename<-"y_train.txt"
trainy <- read_data(filename)

## Join the activity obervation with the description in actdesc
trainy <- join(trainy,actdesc,by="V1")

## Extract only the description
trainy <- trainy[,2]

## bind the training dataset (x) with the data that has the subject ID for each observation and
## the activity tag
train_data <- cbind(trainsub,trainy,trainx)


## Load test data
filename<-"X_test.txt"
testx <- read_data(filename)

##Load the corespondent subject ID for the training data
filename<-"subject_test.txt"
testsub <- read_data(filename)

##Load the activity description
filename<-"activity_labels.txt"
actdesc <- read_data(filename)

##Load the activity associated with each observation
filename<-"y_test.txt"
testy <- read_data(filename)

## Join the activity obervation with the description in actdesc
testy <- join(testy,actdesc,by="V1")

########################################################################################
## 3 Uses descriptive activity names to name the activities in the data set

## Extract only the description
testy <- testy[,2]

## bind the test dataset (x) with the data that has the subject ID for each observation and
## the activity tag
test_data <- cbind(testsub,testy,testx)


##Combine train and test data
names(train_data)<-names(test_data) ## make the names of the columns the same
combined_data <-rbind(train_data,test_data)

########################################################################################
##4. Appropriately labels the data set with descriptive variable names.

## Load feature names
filename<-"features.txt"
featurename <- read_data(filename,sep=" ")
##extract only name column
featurename <- featurename[,2]
##add column names for subject, activity
featurename <- as.vector(featurename) ##coerce to vector from factor
featurename <- c("Subject_ID","Activity",featurename)

##change column names of dataset
colnames(combined_data)<-featurename

########################################################################################
##2 Extracts only the measurements on the mean and standard deviation for each measurement

##Subset entire dataset to include only features that calculate mean and standard deviation (mean() and std())

##extract column position for both mean() and std()
colmean <- grep("mean\\()",featurename)
colstd <- grep("std\\()",featurename)
selectfields <-c(1,2,colmean,colstd)

## Subset dataset extracting only desired columns
combined_data <- combined_data[,selectfields]

########################################################################################
## 5. Creates a second, independent tidy data set with the average of each
##    variable for each activity and each subject
melt_data <- melt(combined_data,id.vars = c("Subject_ID","Activity"))
tidy_data <- dcast(a, Subject_ID + Activity ~ variable,mean)
