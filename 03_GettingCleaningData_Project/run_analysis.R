
library(dplyr)

## step 0: load train and test data sets
# load train data set
train_data <- read.table("./UCI_HAR_Dataset/train/X_train.txt")
train_subject <- read.table("./UCI_HAR_Dataset/train/subject_train.txt")
train_activity <- read.table("./UCI_HAR_Dataset/train/y_train.txt")

# add subject and activity information to the data set
train_data <- bind_cols(train_data, train_subject)
train_data <- bind_cols(train_data, train_activity)

# load test data set
test_data <- read.table("./UCI_HAR_Dataset/test/X_test.txt")
test_subject <- read.table("./UCI_HAR_Dataset/test/subject_test.txt")
test_activity <- read.table("./UCI_HAR_Dataset/test/y_test.txt")

# add subject and activity information to the data set
test_data <- bind_cols(test_data, test_subject)
test_data <- bind_cols(test_data, test_activity)


## step 1: merge train and test data sets
all_data <- bind_rows(train_data, test_data)


## step 2: extract the measurements on the mean and standard deviation
# read features (data in each column)
features <- read.table("./UCI_HAR_Dataset/features.txt")
feature_indizes <- grep("(mean\\(\\)|std\\(\\))", features$V2)

# add last two column numbers to list of indizes (subject + activity)
len1 <- length(all_data)
feature_indizes <- append(feature_indizes, (len1-1))
feature_indizes <- append(feature_indizes, len1)
relevant_data <- all_data[, feature_indizes]

## step 3: name activities descriptively
# read activity names
activities <- read.table("./UCI_HAR_Dataset/activity_labels.txt")
# replace number with activity name
col_activ <- ncol(relevant_data)
relevant_data[, col_activ] <- sapply(activities[relevant_data[, col_activ], 2], as.factor)

## step 4: label columns appropriately
relevant_features = features[grep("(mean\\(\\)|std\\(\\))", features$V2), ]
# rename all measurement columns
relevant_data <- rename_at(relevant_data, vars(1:(col_activ-2)), funs(as.factor(relevant_features$V2)))
# reorder columns: activity, subject, all measurements
len2 <- length(relevant_data)
relevant_data <- relevant_data[, c(len2, (len2-1), 1:(len2-2))]
# rename acitivity and subject column
relevant_data <- rename(relevant_data, activity = 1, subject = 2)

## step 5: calculate average for each subject and each activity
by_subject_activity = group_by(relevant_data, activity, subject)
rel_data_mean <- summarise_all(by_subject_activity, mean)

# write data set from step 5
write.table(rel_data_mean, file = "step5_dataset.txt", row.names=FALSE)


