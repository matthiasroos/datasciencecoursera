# Overview od scripts

* getRawData.R
* run_analysis.R

#  Description of the scripts
## getRawData.R

This scripts downloads the original data and unzips them.

## run_analysis.R

This scripts loads the train and test data set and combines them.
With the information from the features.txt the measurements of mean and
standard deviation is extracted and accordingly labeled. The labels in 
activity_labels.txt are used better describe the kind of activity.

The mean of all measurements grouped for all activities and subjects
is calculated and written to the file step5_dataset.txt.


