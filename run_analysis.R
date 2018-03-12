  ## run_analysis 
  ## downloading and unzipping file; if Datasets are not available.
  fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileurl, destfile = "./UCI Har Dataset.zip")
  unzip("./UCI Har Dataset.zip")
  
  library(reshape2)
  library(dplyr)
  
  ## Extracts the measurement names from the features.txt
  measurement_names <- read.table("./UCI Har Dataset/features.txt", 
                                  col.names = c("Measurement_Number", "Measurement_Labels"))
  Measurement_Names_Listed <- as.character(measurement_names$Measurement_Labels)
  
  ## Reading the datasets into R
  xtest_labeled <- read.table("./UCI Har Dataset/test/X_test.txt", 
                              col.names = Measurement_Names_Listed)
  xtrain_labeled <- read.table("./UCI Har Dataset/train/X_train.txt", 
                               col.names = Measurement_Names_Listed)
  ytest <- read.table("./UCI Har Dataset/test/y_test.txt", 
                      col.names = "Activity_Number")
  ytrain <- read.table("./UCI Har Dataset/train/y_train.txt", 
                       col.names = "Activity_Number" )
  subject_test <- read.table("./UCI Har Dataset/test/subject_test.txt", 
                             col.names = "Subject_Number")
  subject_train <- read.table("./UCI Har Dataset/train/subject_train.txt", 
                              col.names = "Subject_Number")
  
  
  ## Combining the test and train data sets together 
  ## separately first before combining all into one dataset
  complete_test_set <- cbind(xtest_labeled, ytest, subject_test)
  complete_train_set <- cbind(xtrain_labeled,ytrain, subject_train)
  activity_collected <- rbind(complete_train_set, complete_test_set)
  
  ## Extracts only the measurements on the mean and standard 
  ## deviation for each measurement.
  mean_std_only <- grep("Activity_Number|Subject_Number|mean|std", names(activity_collected), value = TRUE)
  activity_mean_and_std <- activity_collected[mean_std_only]
  
  ## Uses descriptive activity names to name the activities in 
  ## the data set
  default_activity_names <- read.table("./UCI Har Dataset/activity_labels.txt", col.names = c("Activity_Number","Activity_Name"), sep = " " )
  merged_activity_Names <- merge(default_activity_names, activity_mean_and_std, by.x="Activity_Number", by.y="Activity_Number", all = TRUE)
  
  ## Removes Activity_Number Column
  merged_activity_Names$Activity_Number <- NULL
  
  ## Moves Activity_Name and Subject_Number to column 1 and 2
  merged_activity_Names <- merged_activity_Names[,c(1,81,2:80)]

  ## From the data set in step 4, creates a second, independent 
  ## tidy data set with the average of each variable for each 
  ## activity and each subject.
  final_data_averaged <- merged_activity_Names %>% 
    group_by(Activity_Name, Subject_Number) %>% 
    summarise_all(mean)
