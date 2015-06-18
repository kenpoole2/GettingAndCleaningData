GettingAndCleaningData
Course project for Getting And Cleaning Data
run_analysis Script

This script assumes that the following files are in your working directory:
1) X_train.txt
2) y_train.txt
3) subject_train.txt
4) X_test.txt
5) y_test.txt
6) subject_test.txt
7) features.txt
8) activity_labels.txt


The first section of code imports the data files from your working directory into R.

The second section merges the different training and test sets together.

The following section analyzes the feature list and extracts all features that
are related to the mean and standard deviation. It then adds the column names to the 
combined X dataset. These are the measurements. It then removes all measurements not
related to a mean or standard deviation

The next section adds meaningful names to the subject and activity files and then merges
the subject and activity data with the measurements

The following section groups the data by subject & activity combinations
The remianing sections calculate the mean of each of the measurement columns.

The final output is a single observation for each subject and activity combination with the 
mean of all of the measurements.