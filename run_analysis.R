#for complete information on how the script works read the readme.md file in the repository

train<-read.table("./train/X_train.txt") #opens the training data
test<-read.table("./test/X_test.txt") #opens the test data
features<-read.table("./features.txt") #opens the feature.txt file

library(dplyr)

features<-tbl_df(features)

#below code removes duplicate column names

features[303:316,]<-mutate(features[303:316,],V2=paste(V2,",X",sep=""))
features[317:330,]<-mutate(features[317:330,],V2=paste(V2,",Y",sep=""))
features[331:344,]<-mutate(features[331:344,],V2=paste(V2,",Z",sep=""))

features[382:395,]<-mutate(features[382:395,],V2=paste(V2,",X",sep=""))
features[396:409,]<-mutate(features[396:409,],V2=paste(V2,",Y",sep=""))
features[410:423,]<-mutate(features[410:423,],V2=paste(V2,",Z",sep=""))


features[461:474,]<-mutate(features[461:474,],V2=paste(V2,",X",sep=""))
features[475:488,]<-mutate(features[475:488,],V2=paste(V2,",Y",sep=""))
features[489:502,]<-mutate(features[489:502,],V2=paste(V2,",Z",sep=""))

#add column names to train and test datasets loaded previously

names(test)<-features$V2
names(train)<-features$V2


train<-tbl_df(train)
test<-tbl_df(test)
lbl<-read.table("./activity_labels.txt")#reads the 6 activity labels

#add columns labels and subject to test dataset. labels are the descriptive aactivity names.
lbl_test<-read.table("./test/y_test.txt")
lbl_test<-mutate(lbl_test,label=lbl$V2[lbl_test$V1])

test<-mutate(test,label=lbl_test$label)
sub_test<-read.table("./test/subject_test.txt")
test<-mutate(test,subject=sub_test$V1)


#add columns labels and subject to train dataset. labels are the descriptive aactivity names.
lbl_train<-read.table("./train/y_train.txt")
lbl_train<-mutate(lbl_train,label=lbl$V2[lbl_train$V1])

train<-mutate(train,label=lbl_train$label)
sub_train<-read.table("./train/subject_train.txt")
train<-mutate(train,subject=sub_train$V1)


merged<-rbind(train,test)#merge the test and train dataset into one

#reorder the columns of the table so as to have labels and subject first followed by the variables
merged<-select(merged,562:563,1:561)

#Extracts only the measurements on the mean and standard deviation for each measurement
#into new table mean_std from merged and reorder them.
mean_std<-merged[,grep("mean()|std()",names(merged))]
mean_std<-mutate(mean_std,label=merged$label,subject=merged$subject)
mean_std<-select(mean_std,80:81,1:79)#reordering so as to have labels and subject first.

#creates a new independent tidy data set with the average of each variable for each activity and each subject.
newTidyData<-group_by(mean_std,subject,label)%>%summarise_if(is.numeric,mean)
write.table(new,"./newTidyData.txt",row.names = FALSE)


#if the new dataset was to be created on the entire merged dataset then uncomment the below line and run.
#newTidyData<-group_by(merged,subject,label)%>%summarise_if(is.numeric,mean)