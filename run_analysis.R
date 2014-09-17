run_analysis <- function()
{
## First, we get the features file, read it into R, then we select the position of the required
## variables by selecting all the features that have "-mean()" or "-std()"

features <- read.table(file="C:\\Users\\oelrafei\\My Documents\\UCI HAR Dataset\\features.txt", header=FALSE, sep="")
mean_pos <- grep("-mean()", features$V2, fixed = TRUE)
std_pos <- grep("-std()", features$V2, fixed = TRUE)
positions <- c(mean_pos,std_pos) ## have the required features name locations. 
 
## Now we read in 3 files for both train and test:
## 1.X_train
## 2.y_lable
## 3.activity_label
## Then we merge them all together.
 
data_train <- read.table(file="C:\\Users\\oelrafei\\My Documents\\UCI HAR Dataset\\train\\X.txt", header=FALSE, sep="") ## reading each test file in a table.
data_train_filtered <- data_train[,positions]
train_activity <- read.table(file="C:\\Users\\oelrafei\\My Documents\\UCI HAR Dataset\\train\\activity.txt", header=FALSE, sep="")
train_subject <- read.table(file="C:\\Users\\oelrafei\\My Documents\\UCI HAR Dataset\\train\\subject.txt", header=FALSE, sep="")
data_test <- read.table(file="C:\\Users\\oelrafei\\My Documents\\UCI HAR Dataset\\test\\X.txt", header=FALSE, sep="") ## reading each test file in a table.
data_test_filtered <- data_test[,positions]
test_activity <- read.table(file="C:\\Users\\oelrafei\\My Documents\\UCI HAR Dataset\\test\\activity.txt", header=FALSE, sep="")
test_subject <- read.table(file="C:\\Users\\oelrafei\\My Documents\\UCI HAR Dataset\\test\\subject.txt", header=FALSE, sep="")
    
train_all <- cbind(train_subject,train_activity,data_train_filtered)
test_all <- cbind(test_subject,test_activity,data_test_filtered)

overall <- rbind(train_all,test_all) ## merged data with mean and standard deviation only.

## In this section, we will start naming the data frame columns.
header <- vector() ## vector to get the correct names from the features data frame.
for (i in 1:length(positions))
{
  header[i] <- toString(features[positions[i],2]) ## here we get the names from the features data frame that correspond to the filtered variables.
}

names(overall) <- c("subject","activity",header) ## we now label all the columns according to the correct names.

## here we begin to build the tidy dataset for activity.

splitted_activity <- split(overall, overall$activity) ## split by activity
tidy_activity <- vector()
for (i in 1:length(splitted_activity))
{
  x <- sapply(splitted_activity[[i]][,3:68],mean) ## calculate the mean for each variable for specific activity.
  tidy_activity <- rbind(tidy_activity,x) ## binding all the activity data together
     
}

## here we begin to build the tidy dataset for subject.

splitted_subject <- split(overall, overall$subject) ## split by subject
tidy_subject <- vector()
for (i in 1:length(splitted_subject))
{
  y <- sapply(splitted_subject[[i]][,3:68],mean) ## calculate the mean for each variable for specific subject.
  tidy_subject <- rbind(tidy_subject,y) ##binding all the subject data together.

}

## writing tidy data set into a file.


tidy <- rbind(tidy_activity,tidy_subject) ## merging activity and subject data
write.table(tidy, file = "C:\\Users\\oelrafei\\My Documents\\UCI HAR Dataset\\tidy.txt", append = FALSE, sep = " ", row.names = FALSE) ## writing the output to tidy.txt

}
