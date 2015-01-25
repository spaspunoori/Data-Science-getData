# Reads data under given folder with merging all the files under the folder.
# Subsetting is done early on to help reduce memory requirements.

#Extracts only the measurements on the mean and standard deviation for each measurement. As mentioned in the course project.

# path_prefix - Folder Name  
# The fname_suffix  - file name suffix.
readData <- function(fname_suffix, path_prefix) {

  fpath <- file.path(path_prefix, paste0("y_", fname_suffix, ".txt"))
  
  y_data <- read.table(fpath, header=F, col.names=c("ActivityID"))
  
  fpath <- file.path(path_prefix, paste0("subject_", fname_suffix, ".txt"))
  
  subject_data <- read.table(fpath, header=F, col.names=c("SubjectID"))
  
  # read the column names
  data_cols <- read.table("UCI HAR Dataset/features.txt", header=F, as.is=T, col.names=c("MeasureID", "MeasureName"))
  
  # read the X data file
  fpath <- file.path(path_prefix, paste0("X_", fname_suffix, ".txt"))
  data <- read.table(fpath, header=F, col.names=data_cols$MeasureName)
  
  # names of subset columns required
  subset_data_cols <- grep(".*mean\\(\\)|.*std\\(\\)", data_cols$MeasureName)
  
  # subset the data (done early to save memory)
  data <- data[,subset_data_cols]
  
  # append the activity id and subject id columns
  data$ActivityID <- y_data$ActivityID
  data$SubjectID <- subject_data$SubjectID
  
  # return the data
  data
}
# read test data set from test folder under UCI HAR Dataset folder 
readTestData <- function() {
  print("Read the date from UCI HAR Dataset/test...")
  readData("test", "UCI HAR Dataset/test")
}
# read train data set from test folder under UCI HAR Dataset folder
readTrainData <- function() {
  print("Read the date from UCI HAR Dataset/train...")
  readData("train", "UCI HAR Dataset/train")
}

# Merge test and train data files.
mergeData <- function() {
  print("Merging tidy dataset as tidy.txt...")
  data <- rbind(readTestData(), readTrainData())
  data
}
# Add the activity names as another column
applyActivityLabel <- function(data) {
  activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", header=F, as.is=T, col.names=c("ActivityID", "ActivityName"))
  activity_labels$ActivityName <- as.factor(activity_labels$ActivityName)
  data_labeled <- merge(data, activity_labels)
  data_labeled
}
# Combine training and test data sets and add the activity label as another column
getMergedLabeledData <- function() {
  applyActivityLabel(mergeData())
}
# Create a tidy data set that has the average of each variable for each activity and each subject.
getTidyData <- function(merged_labeled_data) {
  print("Generating tidy dataset ...")
  library(reshape2)
  # melt the dataset
  id_vars = c("ActivityID", "ActivityName", "SubjectID")
  measure_vars = setdiff(colnames(merged_labeled_data), id_vars)
  melted_data <- melt(merged_labeled_data, id=id_vars, measure.vars=measure_vars)
  # recast
  dcast(melted_data, ActivityName + SubjectID ~ variable, mean)
}
# Create the tidy data set and save it on to the named file
createTidyDataFile <- function(fname) {
  print("Creating tidy dataset as tidy.txt...")
  tidy_data <- getTidyData(getMergedLabeledData())
  write.table(tidy_data, fname)
}
print("Creating tidy dataset as tidyDataFile.txt...")
createTidyDataFile("tidyDataFile.txt")
