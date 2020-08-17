##1.Merging the training and the test sets.
##1)Reading files

Train <- read.table("./train/X_train.txt",header=FALSE)
Test <- read.table("./test/X_test.txt",header=FALSE)
subtrain <- read.table("./train/subject_train.txt",header=FALSE)
subtest <- read.table("./test/subject_test.txt", header =FALSE)
actrain <- read.table("./train/y_train.txt",header= FALSE,colClasses = "character")
actest <- read.table("./test/y_test.txt",header = FALSE,colClasses = "character")

features <- read.table("./features.txt",header=FALSE,colClasses="character")
features <- features[,2]

##merging Train set and Test set into one set
dat<-rbind(Train, Test)
subdat <- rbind(subtrain, subtest)
actdat<-rbind(actrain, actest)
names(dat) <- features
names(subdat) <- "Subject"


##2. Extracting mean and std


a<-grep("mean",names(dat))
b<-grep("std",names(dat))
c<-grep("Freq",names(dat))
d<-grep("angle",names(dat))
##Since Freq and angle are derived,not measured, exclude them from found mean and std
selfeatures <- setdiff(union(a,b),union(c,d))

dat <- dat[,selfeatures]
dat <- cbind(dat, subdat)
##3.Uses descriptive activity names to name the activities in the data set
names(actdat)<-"activitylabels"

##2)properly labeling them with correct names
actdat$activitylabels <- gsub("1","WALKING",actdat$activitylabels)
actdat$activitylabels <-gsub("2","WALKING_UPSTAIRS",actdat$activitylabels)
actdat$activitylabels <-gsub("3", "WALKING_DOWNSTAIRS",actdat$activitylabels)
actdat$activitylabels <-gsub("4", "SITTING",actdat$activitylabels)
actdat$activitylabels <-gsub("5", "STANDING",actdat$activitylabels)
actdat$activitylabels <-gsub("6", "LAYING",actdat$activitylabels)
##3)merge it with the dat
dat<-cbind(dat, actdat)

##4Appropriately labels the data set with descriptive variable names.
names(dat) <- gsub("^t","time",names(dat))
names(dat) <- gsub("^f","frequency",names(dat))
names(dat) <- gsub("Acc","accelorometer",names(dat))
names(dat) <- gsub("Gyro","gyroscope",names(dat))
names(dat) <- gsub("Mag","magnitude",names(dat))
names(dat) <- gsub("BodyBody","body",names(dat))
names(dat) <- gsub("-","",names(dat))
names(dat) <- gsub("[:():]","",names(dat))
names(dat)<-tolower(names(dat))

##5. From the data set in step 4, creates a second, independent
##tidy data set with the average of each variable for each activity 
##and each subject.

library(plyr)
library(dplyr)


tidat <- dat %>%
  group_by(activitylabels,subject) %>%
  summarise_each(funs(mean))

write.table(tidat,"./tidyset.txt",row.names=FALSE)
  


  

