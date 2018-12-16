# "Getting and Cleaning Data Course" Assignment
################################################

##############
# Housekeeping
##############
# setting working directories
setwd("C:/Users/Gonçalo/Desktop/R") # Change to preferred work directory
if(!file.exists("./data")){dir.create("./data")}

# Downloading data
if(!file.exists("./data/UCI HAR Dataset")){
        library(downloader)
        download("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", 
                 dest="./data/UCI HAR Dataset.zip", mode = "wb")
        unzip("./data/UCI HAR Dataset.zip",
              exdir = "./data")
}

#######################
# Reading required data
#######################

# Reading train data
subjects_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header = F, encoding = 'UTF-8') # Subjects
values_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header = F, encoding = 'UTF-8') # Measurement readings
activity_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header = F, encoding = 'UTF-8') # Activity performed by subject 

# Reading test data
subjects_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header = F, encoding = 'UTF-8') # Subjects
values_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header = F, encoding = 'UTF-8') # Measurement readings
activity_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header = F, encoding = 'UTF-8') # Activity performed by subject

# Reading the feature labels for each column of the values_train and values_test datasets
features <- read.table("./data/UCI HAR Dataset/features.txt", header = F, encoding = 'UTF-8')

# Reading activity labels data
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", header = F, encoding = 'UTF-8')

###########
# Cleaning
##########

# Setting column names in subjects and activity datasets
library(dplyr)
subjects_train <- rename(subjects_train, subject = V1)
subjects_test <- rename(subjects_test, subject = V1)

activity_train <- rename(activity_train, activity = V1)
activity_test <- rename(activity_test, activity = V1)

# Setting the variables name in values datasets according to the names in the features dataset
names(values_train) <- features$V2 
names(values_test) <- features$V2

# Adding subjects and activity train and test vectors to corresponding values datasets
train_data <- cbind(subjects_train,activity_train,values_train)
test_data <- cbind(subjects_test,activity_test,values_test)

# Merge (appending) train and test datasets 
data <- rbind(train_data,test_data)
#(STEP 1 COMPLETE)

# Subsetting means and standard deviation measurements; Appending subsetted datasets
data_sub <- data[,grep("mean\\(\\)|std\\(\\)",names(data))]
data <- cbind(data$subject,data$activity,data_sub)
data <- rename(data, subject = 1)
data <- rename(data, activity = 2)
#(STEP 2 COMPLETE)

# Sorting the data
data <- arrange(data, subject, activity)

# Labelling activities
data$activity <- factor(data$activity,
                        levels = activity_labels$V1,
                        labels = activity_labels$V2)
#(STEPS 3 and 4 COMPLETE)

# Final labelled dataset before tidying
data <- as.data.frame(data)


#########
# Tidying
########
library(reshape2)
data1 <- melt(data,id=c("subject","activity")) # Reshaping the data to transpose measurement identifiers to rows
tidy_data <- dcast(data1, subject + activity ~ variable,mean) # Reshaping; Getting the mean of each measurement by subject and activity
# (STEP 5 COMPLETE)

# Writting off the data
write.table(tidy_data,"./data/tidy_UCI.txt", row.names = FALSE, col.names=TRUE, fileEncoding = "UTF-8") # Text file
write.table(tidy_data,"./data/tidy_UCI.csv", row.names = FALSE, col.names=TRUE,sep = ",") # CSV file


