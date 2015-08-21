#Getting and Cleaning data Project

#Data Location and files
All the data should be located in the same directory. When you run the run_analysis.R, it will look for all the files in the same location

The data files that will be read are:
- subject_train.txt
- X_train.txt
- y_train.txt
- activity_labels.txt
- features.txt
- subject_test.txt
- X_test.txt
- y_test.txt

#General script description
An R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set 
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The approach is as follows:
1. Download the training x data
2. Bind the subject y data with the x using cbind()
3. Join the activity y data with the activity description (to satisfy requirement #3)
4. Bind the activity y with description to the x data using cbind()
5. Download the test x data
6. Bind the subject y data with the x using cbind()
3. Join the activity y data with the activity description (to satisfy requirement #3)
4. Bind the activity y with description to the x data using cbind()
5. Finally bind the 2 datasets, training and test using rbind() (to satisfy requirement # 1)
6. Download the features.txt filr to extract the fature names
7. Apply the names to the combined dataset keeping the original names, and adding names for the Subject_ID and Activity (to satisfy requirement # 4)
8. Find the position of the columns that have mean() and std()
9. Subset the entire dataset to extract only those columns using grep() (to satisfy requirement #2)
10. Calculate the mean by Subject_ID and Activity to create the tidy dataset, using meld() and dcast() (to satisfy requirement #5)
