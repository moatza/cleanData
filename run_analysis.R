
run_analysis<-function()
{
  #read test and training data sets 
  
  #read X_train.txt file and save data in a data frame
  fileName=paste0(getwd(),"\\","UCI HAR Dataset\\train\\X_train.txt")
  con1=file(fileName,open="r")
  xtrain<-read.table(con1)
  close(con1)
  colnames(xtrain)<-"Measurements"
  
  #read Y_train.txt file and save data in a data frame
  fileName=paste0(getwd(),"\\","UCI HAR Dataset\\train\\Y_train.txt")
  con2=file(fileName,open="r")
  ytrain<-read.table(con2)
  close(con2)
  colnames(ytrain)<-"activityid"
 
  #read subject_train.txt file and save data in a data frame
  fileName=paste0(getwd(),"\\","UCI HAR Dataset\\train\\subject_train.txt")
  con3=file(fileName,open="r")
  subjtrain<-read.table(con3)
  close(con3)
  colnames(subjtrain)<-"Subject"
  
  #read X_test.txt file and save data in a data frame
  fileName=paste0(getwd(),"\\","UCI HAR Dataset\\test\\X_test.txt")
  con4=file(fileName,open="r")
  xtest<-read.table(con4)
  close(con4)
  colnames(xtest)<-"Measurements"
  
  #read Y_test.txt file and save data in a data frame
  fileName=paste0(getwd(),"\\","UCI HAR Dataset\\test\\Y_test.txt")
  con5=file(fileName,open="r")
  ytest<-read.table(con5)
  close(con5)
  colnames(ytest)<-"activityid"
  
  #read subject_test.txt file and save data in a data frame
  fileName=paste0(getwd(),"\\","UCI HAR Dataset\\test\\subject_test.txt")
  con6=file(fileName,open="r")
  subjtest<-read.table(con6)
  close(con6)
  colnames(subjtest)<-"Subject"
    
  #read features.txt
  fileName=paste0(getwd(),"\\","UCI HAR Dataset\\features.txt")
  con7=file(fileName,open="r")
  features<-read.table(con7)
  close(con7)
  colnames(features)<-c("featureid","featuredescription")

  
  #1.merge dataframes to create one data set
  xtotal<-rbind(xtrain, xtest)
  ytotal<-rbind(ytrain, ytest)
  subjtotal<-rbind(subjtrain, subjtest) 
  
  fulldataset <- cbind(xtotal, ytotal, subjtotal)
  
  #2. Extracts only the measurements on the mean and standard deviation for each measurement.
  
  #get the mean and STD for each measurement
  meanstdindices<-grep("std+|mean+",features[,2] )
  newDS <- fulldataset[,meanstdindices]
  names(newDS) <- features[meanstdindices,2]
  

  #3. Uses descriptive activity names to name the activities in the data set
  
  #read activity_labels.txt
  fileName=paste0(getwd(),"\\","UCI HAR Dataset\\activity_labels.txt")
  con8=file(fileName,open="r")
  act<-read.table(con8)
  close(con8)
 
  colnames(act)<- c("activityid", "activitydescription")
  descAct <- sqldf("SELECT activityid, activitydescription FROM act JOIN ytotal USING(activityid)")
  t<- cbind(descAct$activitydescription, xtotal)
  colnames(t) <- c("Activity", "Measurement")
   
  
  #4. Appropriately labels the data set with descriptive variable names.
  nDS <- fulldataset[,features[,2]]
  names(nDS) <-features[,2]
  nnDS <- cbind(nDS, subjtotal)
  write.table(nnDS, 'fulldata.txt', row.name=FALSE)
  #print(names(nnDS))
  
  #5. Creates a second, independent tidy data set, with the average of each variable for each activity and each subject.
  tidyDataSet <- aggregate(fulldataset, by=list(Subject = fulldataset$Subject, Activity=fulldataset$activityid), FUN=mean, na.rm=TRUE)
  write.table(tidyDataSet, 'tidydata.txt', row.name=FALSE)
  tidyDataSet

  
}



