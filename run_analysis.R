### Read needed data sets
# Assuming ZIP file has been unzipped and according folder called "UCI HAR Dataset" is part of working directory

#test data
testdata <- read.table("./UCI HAR Dataset/test/X_test.txt")
testlabels <- read.table("./UCI HAR Dataset/test/y_test.txt",col.names=c("labels"))
testsubjects <- read.table("./UCI HAR Dataset/test/subject_test.txt",col.names=c("subjects"))
#train data
traindata <- read.table("./UCI HAR Dataset/train/X_train.txt")
trainlabels <- read.table("./UCI HAR Dataset/train/y_train.txt",col.names=c("labels"))
trainsubjects <- read.table("./UCI HAR Dataset/train/subject_train.txt",col.names=c("subjects"))

#####################
### 1.
### "Merge the training and the test sets to create one data set."
testdataall <- cbind(testsubjects,testlabels,testdata)
traindataall <- cbind(trainsubjects,trainlabels,traindata)
dt <- rbind(testdataall,traindataall)

### Add feature names to data set
featurenames <- read.table("./UCI HAR Dataset/features.txt")
names(dt) <- c("subject", "activity", as.vector(featurenames$V2))

#####################
### 2.
### "Extract only the measurements on the mean and standard deviation for each measurement."
dtf <- cbind(dt[,1:2],dt[,grep("mean\\(\\)|std\\(\\)", featurenames$V2)+2])

#####################
### 3.
### "Use descriptive activity names to name the activities in the data set"
activitylabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
# Clean activity labels
activitylabels$V2 <- gsub("_", "", tolower(as.character(activitylabels$V2)))
# Apply labels
for (i in 1:nrow(activitylabels)) {
    dtf$activity[dtf$activity == activitylabels[i,]$V1] <- as.character(activitylabels[i,]$V2)
}

#####################
### 4.
### "Appropriately labels the data set with descriptive variable names."
names <- names(dtf)
names <- sub("BodyBody","Body",names)
names <- sub("^t","time_",names)
names <- sub("^f","frequency_",names)
names <- sub("Acc","accelerometer",names)
names <- sub("Gyro","gyroscope",names)
names <- sub("Mag","magnitude",names)
names <- tolower((names))
names(dtf) <- names

#####################
### 5.
### "Second, independent tidy data set with the average of each variable for each activity and each subject"
subjects <- unique(dtf$subject)
nsub <- length(subjects)
nact <- length(activitylabels$V2)
nvar <- dim(dtf)[2]

# Initiate tidy data set using other data set 
tidyset <- dtf[1:(nsub*nact),]

for (s in 1:nsub){
    for (a in 1:nact){
        row <- ((s-1)*nact)+a
        tidyset$subject[row] <- subjects[s]
        tidyset$activity[row] <- activitylabels$V2[a]
        tidyset[row,3:nvar] <- colMeans(dtf[dtf$subject==subjects[s] & dtf$activity==activitylabels$V2[a],][,3:nvar])
    }
}

# Save tidy dataset
write.table(tidyset, file="tidyset.txt", row.name=FALSE)