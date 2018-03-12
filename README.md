---
title: "Getting and Cleaning Data Course Project"
author: "QUOC"
date: "March 11, 2018"
output: html_document
---
__________________________________________________________
This project seeks to combine multiple datasets from the UCI HAR Dataset into one single dataset. An independent dataset will also be derived from the combined data set. The independent dataset will consist of the all the variable averages base on subject and activity type. 
__________________________________________________________
The data sets to be combined are: 
features.txt, activity_labels.txt, X_train.txt, y_train.txt, X_test.txt, and y_test.txt. 
__________________________________________________________
run_analysis Workflow
The measurement names from the features.txt dataset is extracted and used to label the column names of X_test.txt and X_train.txt when read into R. 
After y_train.txt and y_test.txt are read into R, they combine with their respective counterparts (ie. X_test with y_test) before combining into one dataset.
Using the grep function, the massive dataset is filtered to contain only the columns containing "mean()"" or "std()" in their name as well as the Activity Number and Subject Number.
Using merge with the activity_labels.txt the Activity Numbers column is replaced with the Activity Names.
The massive dataset is then reorganized to have the Activity Names and Subject Numbers as the first two columns. 
__________________________________________________________
Independent Dataset Workflow
The independent data set is created using the dplyr package. The data set is grouped by Activity Names and Subject Numbers and the data is then summarized by mean using the summarize.all.  
__________________________________________________________