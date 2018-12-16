# Getting and Cleaning Data Assignment - Week 4

This repo was created to complete the assignment for week 4 of the "Getting and Cleaning Data" Coursera course.

## Generating tidy dataset
1. Download and unzip the data file into your R working directory.
2. Download the R source code into your R working directory.
3. Execute R source code to generate tidy data file.

The new generated dataset contained variables calculated based on the mean and standard deviation. Each row of the dataset is an average of each activity type for all subjects.

## How tidy data was prepared?
1. All relevant data (subjects, activity and measurements for both train and test sets) are first downloaded and read, using unzip, download and read.table commands.
2. Column names are set in subjects and activity datasets (subject; activity), using the rename command, in dplyr package.
3. Variable names in the measurements datasets are set according to the labels dataset provided with the raw data.
4. Subjects and activity train and test vectors are binded to corresponding measurements datasets, using cbind command.
5. Resutling train and test datasets are appended into a single dataset, using rbind command.
6. Resulting dataset is subsetted to only measurements of means and standard deviations (std()), using grep command to get column indexes for variable names containing "mean()" or "std()".
7. Each activity performed by subejct is labelled with descriptive variable names according to an activity labeller file provided with the raw data.
8. The data is reshaped by getting the mean of each measurement in the dataset by subject and activity, by using melt and dcast commands with reshape2 package.

## Original study design and data processing
Raw data comes from the project "Human Activity Recognition Using Smartphones Dataset". The study was conducted by George L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio and Luca Oneto.
Experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.
For each record it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

### How does the raw data translate into the tidy dataset?
Only meausurements estimated from mean and standard deviation were kept in the tidy dataset. Each row has averaged variable by subject and activity. Subjects are sequantially numebered from 1 to 30. Activitity has 6 types: walking, walking upstairs, walking downstairs, sitting, standing and laying.

###Collection of the raw data
Raw data was collected from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

###Notes on the original (raw) data 
The original raw dataset includes the following files:

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels. 
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

Raw files are available for the train and test data. Their descriptions are equivalent. 
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis.
- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. - 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Other notes on the raw dataset:
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

##Sources
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

