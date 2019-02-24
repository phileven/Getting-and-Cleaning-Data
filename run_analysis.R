# Load packages
library(data.table)
library(plyr)

# Check if data folder exists
if(!file.exists("data")){
        dir.create("data")
}

# Define working data
zip <- "./data/dataset.zip"

# Download file if it's not existing
if(!file.exists(zip)){
        fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl1, destfile = zip, method = "curl")
}

# Path do data files
path <- "./data/UCI HAR Dataset"

# Unzip data if folder doesn't exist
if(!file.exists(path)){
        unzip(zip,exdir="./data")
}

# Define path to train and test sets
X_train <- paste0(path,"/train/X_train.txt")
y_train <- paste0(path,"/train/y_train.txt")
X_test <- paste0(path,"/test/X_test.txt")
y_test <- paste0(path,"/test/y_test.txt")

# Define path to activity labels
labels <- paste0(path,"/activity_labels.txt")

# Define path to feature list
features <- paste0(path,"/features.txt")

# Read train data and corresponding activites
DataTrainX <- read.table(X_train)
DataTrainY <- read.table(y_train)

# Change column name of activity column
names(DataTrainY) <- "V562"

# Add activity column to train data frame
DataTrain <- cbind(DataTrainX, DataTrainY)

# Read test data and corresponding activites
DataTestX <- read.table(X_test)
DataTestY <- read.table(y_test)

# Change column name of activity column
names(DataTestY) <- "V562"

# Add activity column to test data frame
DataTest <- cbind(DataTestY,DataTestX)

# Read activity label list
DataActivity <- read.table(labels)
#TestActivity <- replace(DataTestY, c(1:6), DataActivity)

# Read feature list aka column names
DataFeat <- read.table(features)

# Merge data frames
data <- merge(DataTrain,DataTest,all=TRUE)

# Set names of data frame
ColumnNames <- c(as.vector(DataFeat$V2),"activity")
names(data) <- ColumnNames

# Grep means and std from feature list
subNames <- grep("mean|std|activity",ColumnNames,value=TRUE)

# Subset data frame by subNames list
subData <- subset(data,select=subNames)

# Match activity IDs with activity labels
subData$activity <- DataActivity$V2[match(subData$activity, DataActivity$V1)]

# Define path to subject data
subject_train <- paste0(path,"/train/subject_train.txt")
subject_test <- paste0(path,"/test/subject_test.txt")

# Read subject data
subTrain <- read.table(subject_train)
subTest <- read.table(subject_test)

# Merge subject data sets and change column name
subjects <- merge(subTrain,subTest,all=TRUE)
names(subjects) <- "subject"

# Add subjects to subData data frame
subData <- cbind(subData,subjects)

# Subset data frame by subject and activity and calculate means
subData <- ddply(subData, .(subject, activity), numcolwise(mean))

# Write table to file
write.table(subData, file="./data/output.txt", row.name=FALSE)