### Introduction

The purpose of this project is to produce the tidy data set file from the data collection, which is part of the Course project work.

Reference data for this project is collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 


### run_analysis.R 

This Script does the following. 

    1. Read the data files.
    2. Merge the read data files.
    3. Assign Activity Lables.
    4. Create tidy data file.


 
1.  Read the data set from TEST  and TRAIN folder 


readData <- function(fname_suffix, path_prefix) { 
--------
}

"readData" funcation reads the data from given file patern and folder path. It only extracts measurements on the mean and standard deviation for each measurement. 

"readData" been used for reading TEST and TRAIN data sets ( Function reusability)



2.   Merge both TEST and TRAIN Data sets

<!-- -->

mergeData <- function() {

---

}
 
"mergeData" function is merging the data sets read by "readData" function. It uses "rbind" funtion from R.



3.  Assign the Actity labels

<!-- -->
applyActivityLabel <- function(data) {

---

}

Fucntion "applyActivityLabel " assigns the Activity Labels to the data, label are read from the file "UCI HAR Dataset/activity_labels.txt"




4.  Generate the tidy data set and store in "tidyDataFile.txt"

<!-- -->

createTidyDataFile <- function(fname) {

----

 }


Fucntion createTidyDataFile " creates the tidy data file and stored in the same folder with the name "tidyDataFile.txt"

