setwd("/Users/Phil/Documents/Getting and Cleaning Data/Assignment")

Activity_Labels <- read.table("activity_labels.txt")
Features <- read.table("features.txt")


## Load Test dataset
Subject_test <- read.table("./test/subject_test.txt")
X_train_test <- read.table("./test/X_test.txt")
Y_train_test <- read.table("./test/Y_test.txt")

colnames(X_train_test) <- Features[,2]
colnames(Subject_test) <- "Subject"
colnames(Y_train_test) <- "Activity"

Test_Data <- cbind(Subject_test, Y_train_test, X_train_test)

## Load Train dataset
Subject_train <- read.table("./train/subject_train.txt")
X_train_train <- read.table("./train/X_train.txt")
Y_train_train <- read.table("./train/Y_train.txt")

colnames(X_train_train) <- Features[,2]
colnames(Subject_train) <- "Subject"
colnames(Y_train_train) <- "Activity"

Train_Data <- cbind(Subject_train, Y_train_train, X_train_train)

##Combine test and train data sets
Full_Data <- rbind(Train_Data, Test_Data)

##Find columns with mean() and std() in them and add to new data table
Summary_Data <- Full_Data[,1:2]

for (i in 3:ncol(Full_Data)) {
      
      if (length(grep("mean()",colnames(Full_Data[i]))) > 0 | length(grep("std()",colnames(Full_Data[i]))) > 0) {
            Summary_Data <- cbind(Summary_Data, Full_Data[,i])
            Sum_Col <- ncol(Summary_Data)
            colnames(Summary_Data)[Sum_Col] <- colnames(Full_Data[i])
      }
}

#Replace Acrivity number in each data set with string description
Summary_Data$Activity <- sapply(Summary_Data$Activity,switch, '1'="WALKING" , '2' ="WALKING_UPSTAIRS" , '3' = "WALKING_DOWNSTAIRS", '4' = "SITTING", '5' = "STANDING", '6' = "LAYING")
Full_Data$Activity <- sapply(Summary_Data$Activity,switch, '1'="WALKING" , '2' ="WALKING_UPSTAIRS" , '3' = "WALKING_DOWNSTAIRS", '4' = "SITTING", '5' = "STANDING", '6' = "LAYING")

##Summarise data 
library(dplyr)

Tidy_Data <- Full_Data[,unique(colnames(Full_Data))]

Tidy_Data <- group_by(Tidy_Data, Subject, Activity) %>%
                        summarise_each(funs(mean))

write.table(Tidy_Data, row.names = FALSE, file = "Tidy_Data.txt")



