features <- read.table("features.txt")
names(features) <- c("FeatureId","FeatureName")

activity_labels <- read.table("activity_labels.txt")
names(activity_labels) <- c("ActivityId","ActivityName")

TestSubject <- read.table("test\\subject_test.txt")
names(TestSubject) <- c("SubjectId")

TestFeatureValues <- read.table("test\\X_test.txt")
names(TestFeatureValues) <- features[,2]

TestLables <- read.table("test\\y_test.txt")
names(TestLables) <- c("ActivityId")

TrainSubject <- read.table("train\\subject_train.txt")
names(TrainSubject) <- c("SubjectId")

TrainFeatureValues <- read.table("train\\X_train.txt")
names(TrainFeatureValues) <- features[,2]

TrainLables <- read.table("train\\y_train.txt")
names(TrainLables) <- c("ActivityId")

PartialData <- rbind(cbind(TestSubject,TestLables,TestFeatureValues[,features[grep("mean|std",features$FeatureName),1]]),cbind(TrainSubject,TrainLables,TrainFeatureValues[,features[grep("mean|std",features$FeatureName),1]]))
TidyData1 <- merge(PartialData,activity_labels,by="ActivityId")
TidyData1<-TidyData1[,!(colnames(TidyData1) %in% c("ActivityId"))]


FullData <- rbind(cbind(TestSubject,TestLables,TestFeatureValues),cbind(TrainSubject,TrainLables,TrainFeatureValues))
x <- merge(FullData,activity_labels,by="ActivityId")
x<-x[,!(colnames(x) %in% c("ActivityId"))]
y<- aggregate(x,by=list(x$SubjectId,x$ActivityName),FUN=mean,na.rm=TRUE)
y<-y[,!(colnames(y) %in% c("ActivityName","SubjectId"))]

write.table(TidyData1,file="TidyData1.txt")
write.table(y,file="TidyData2.txt")



