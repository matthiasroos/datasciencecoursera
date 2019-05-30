

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "./UCI_HAR_Dataset.zip")
unzip("./UCI_HAR_Dataset.zip", exdir = "./", overwrite = TRUE)
system("mv 'UCI\ HAR\ Dataset/' UCI_HAR_Dataset/")