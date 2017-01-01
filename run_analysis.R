####
# Load the libraries necessary to run the script #
####

library(reshape2)
library(plyr)


# # Downloading the zip file and reading the data into individual data tables
# url<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# download.file(url, dest = "data.zip")
# unzip(zipfile="data.zip")
# xTest <- read.table("UCI HAR DataSet/test/X_test.txt")
# yTest <- read.table("UCI HAR DataSet/test/Y_test.txt")
# subjTest <- read.table("UCI HAR DataSet/test/subject_test.txt")
# xTrain <- read.table("UCI HAR DataSet/train/X_train.txt")
# yTrain <- read.table("UCI HAR DataSet/train/Y_train.txt")
# subjTrain <- read.table("UCI HAR DataSet/train/subject_train.txt")
# features <- read.table("UCI HAR DataSet/features.txt")
# activity <- read.table("UCI HAR DataSet/activity_labels.txt")
# 
# 
# #Assigning invdividual column names to the different datasets
# colnames(xTrain)<-features[,2]
# colnames(xTest)<-features[,2]
# colnames(yTest)<- "ActivityID"
# colnames(yTrain)<- "ActivityID"
# colnames(subjTest)<- "SubjectID"
# colnames(subjTrain)<- "SubjectID"
# colnames(activity[1,]) <- "ActivityID"
# colnames(activity[2,]) <- "ActivityName"
# colnames(activity) <- c('ActivityID','ActivityName')

#Merging data sets to create a single usable data set

Activity_train<-merge(yTrain, activity, by = "ActivityID")
training_data <- cbind(subjTrain, Activity_train, xTrain)
Activity_test<-merge(yTest, activity, by = "ActivityID")
test_data <- cbind(subjTest, Activity_test, xTest)
final_data<-rbind(training_data, test_data)

# 1. final_data is the combined data set

####### Using the final_data to create 
col_names_mean_std <- grep("mean",tolower(names(final_data)), value = FALSE)
col_names_mean_std<-append(col_names_mean_std, grep("std",tolower(names(final_data)), value = FALSE))
final_data[col_names_mean_std]
mean_and_std_obs[,"SubjectID"] <- as.data.frame(final_data$SubjectID)
mean_and_std_obs[,"ActivityID"] <-final_data$ActivityID
mean_and_std_obs[,"ActivityName"] <-final_data$ActivityName
mean_and_std_obs <- cbind(mean_and_std_obs, final_data[col_names_mean_std])

# 2. mean_and_std_obs is the measurements of mean and std deviation
# 3. The activity names are also set to use Descriptive names in the data set

#Creating the final data set

tidy_Data <- aggregate(final_data[col_names_mean_std], 
                       list(Subj_ID = mean_and_std_obs$SubjectID, 
                            activity = mean_and_std_obs$ActivityName), mean)

names(tidy_Data) <- gsub("Acc", "Acceleration",names(tidy_Data))
names(tidy_Data) <- gsub("()", "",names(tidy_Data))
names(tidy_Data) <- gsub("\\(|\\)", "",names(tidy_Data))
names(tidy_Data) <- gsub("Gyro", "Gyroscope",names(tidy_Data))
names(tidy_Data) <- gsub("Mag", "Magnitude",names(tidy_Data))
names(tidy_Data) <- gsub("mean", "Mean",names(tidy_Data))
names(tidy_Data) <- gsub("std", "Std_Dev",names(tidy_Data))
names(tidy_Data) <- gsub("^t", "Time_",names(tidy_Data))
names(tidy_Data) <- gsub("^f", "Freq_",names(tidy_Data))
names(tidy_Data) <- gsub(",", "_",names(tidy_Data))

# 4. Labels are properly updated in the given data set and are more comprehensible


#Creating the final data set

# Creating an output file to be uploaded into GitHub

tidy_Data <- aggregate(final_data[col_names_mean_std], 
                        list(Subj_ID = mean_and_std_obs$SubjectID, 
                        activity = mean_and_std_obs$ActivityName), mean)

write.table(tidy_Data, file = "tidy_Data.txt", row.names = FALSE)

# 5. The final data set appropriately named tidy_Data is now written into a txt file