# Course_Project
Project for getting and cleaning data, relevant files being uploaded to the repo

This ReadME file is a description of what the data is, how it was collected and how it is prepared to be in this single format. 

###################################################################################################################################
														INTRODUCTION											
###################################################################################################################################
											
This part describes the initial data that was collected
and how this was stored, this was directly copied from the original source

==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

###################################################################################################################################
													Capturing all the relevant Data from text files											
###################################################################################################################################

1) The first step was to bring all of this data into R data frames and then use these to create a single dataset inside of R
2) To do this each individual file was read into R as a separate dataset and these were used for preparing the data
3) To do this the training data was combined, followed by the testing data set, which were then just placed together into one single dataset
4) The X_train, Y_Train and subject_train datasets  were joined using a 'cbind' statement under the assumption that the rows correspond directly between these data sets; the resulting dataset was simply called training_data
5) A similar process was followed for the testing datasets X_test, y_Test and Subject_test and were joined to create a dataset called testing_data
6) The training and testing datasets were then used to update the column names from the features.txt file
7) Also, the appropriate activity name was added using a merge between these files and the activity_labels text file

###################################################################################################################################
																Data Preparation											
###################################################################################################################################

1) The training_data and tetsing_data were joined by stacking them together using the 'rbind' statement
2) The next step was to extract only the measurements on the mean and standard deviation for each measurement
3) This was done by using the grep function to look for 'mean' and 'std' irrespective of case and extracting this data into a single dataset
4) The next step was to use descriptive activity names, this was already done in the seventh step of the Data capturing phase
5) The next step was to create descriptive names for the variables. As part of this, certain parts of individual measurements had been replaced: 
		i) 	gyro with gyroscope
		ii) acc with acceleration
		iii)mag with magnitude
		iv) parantheses () were removed
		v)	commas (,) have been replaced with underscore (_) to standardize the column names
		vi) Column names starting with 't' and 'f' have been replaced with Time and Freq for better understandability
6) The next step was to create an independent tidy data set with the average for each variable for each activity. This was done using the aggregate function and aggregated by ActivityName and SubjectID
7) The last step was to write this tidy data to a text file so that this can be used for further analysis.