if(!file.exists("./Project_dir")){dir.create(file.path(Sys.getenv("Home"),"./Project_dir"))}
 fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
unzip(zipfile="./Project_dir/project_zip_file.zip",exdir="./Project_dir")
list.files(file.path(Sys.getenv("home"),"Project_dir"))
list.files(file.path("Project_dir","UCI HAR Dataset" ))
 project_path<-file.path("./Project_dir","UCI HAR Dataset")
list.files(project_path,recursive=TRUE)

#Reading the Activity file into R
activity_test_Data<-read.table(file.path(file.path("./Project_dir","UCI HAR Dataset"),"test","Y_test.txt"),header=FALSE)

str(activity_test_Data)
activity_train_Data<-read.table(file.path(file.path("./Project_dir","UCI HAR Dataset"),"train","Y_train.txt"),header=FALSE)
str(activity_train_Data)

#Reading the Features files into R

features_train_Data<-read.table(file.path(file.path("./Project_dir","UCI HAR Dataset"),"train","X_train.txt"),header=FALSE)
str(features_train_Data)

features_test_Data<-read.table(file.path(file.path("./Project_dir","UCI HAR Dataset"),"test","X_test.txt"),header=FALSE)
str(features_test_Data)

#Reading the Subject files into R
subject_train_Data<-read.table(file.path(file.path("./Project_dir","UCI HAR Dataset"),"train","subject_train.txt"),header=FALSE)
str(subject_train_Data)

subject_test_Data<-read.table(file.path(file.path("./Project_dir","UCI HAR Dataset"),"test","subject_test.txt"),header=FALSE)
str(subject_test_Data)
#Merges the training and the test sets to create one data set
#Activity Data
activity_Data<-rbind(activity_test_Data,activity_train_Data)
str(activity_Data)
#Features Data
features_Data<-rbind(features_train_Data,features_test_Data)
str(features_Data)

#Subject Data

subject_Data<-rbind(subject_train_Data,subject_test_Data)

Feature<-read.table(file.path(file.path("./Project_dir","UCI HAR Dataset"),"features.txt"),header=FALSE)
names(features_Data)<-Feature$V2
names(subject_Data)<-c("subject")
names(activity_Data)<-c("activity")
Data<-cbind(features_Data,cbind(subject_Data,activity_Data))
str(Data)
#2.Extracts only the measurements on the mean and standard deviation for each measurement. 
s_Feature<-Feature$V2[grep("mean\\(\\)|std\\(\\)", Feature$V2)]
 s_Names<-c(as.character(s_Feature), "subject", "activity" )

 Data<-subset(Data,select=s_Names)
 str(Data)
#3.Uses descriptive activity names to name the activities in the data set
activity_labels<-read.table(file.path(file.path("./Project_dir","UCI HAR Dataset"),"activity_labels.txt"),header=FALSE)

