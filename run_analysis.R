> getwd()
[1] "C:/Users/Greg Pak/Documents"
> setwd("C:/Users/Greg Pak/Documents/"C:/Users/Greg Pak/Documents")
> setwd("C:/Users/Greg Pak/Documents/UCI HAR Dataset")
> getwd()
[1] "C:/Users/Greg Pak/Documents/UCI HAR Dataset"
## sets working directory to the downloaded file

> if (!require("data.table")) {
+   install.packages("data.table")
 ## installs package
> if (!require("reshape2")) {
+   install.packages("reshape2")
## installs package

> require("data.table")
> require("reshape2")
> activity_labels <- read.table("./activity_labels.txt")[,2]
> features <- read.table("./features.txt")[,2]
> extract_features <-grepl("mean|std", features)
> X_test <- read.table("./test/X_test.txt")
## reads the X_test text file as a table

> y_test <- read.table("./test/y_test.txt")
## reads the y_test text file as a table

> subject_test <- read.table("./test/subject_test.txt")
## reads the subject_test text file as a table

> names(X_test) = features
> X_test = X_test[,extract_features]
> y_test[,2] = activity_labels[y_test[,1]]
> names(y_test) = c("Activity_ID", "Activity_Label")
> names(subject_test) = "subject"
> test_data <- cbind(as.data.table(subject_test), y_test, X_test)
> X_train <- read.table("./train/X_train.txt")
> y_train <- read.table("./train/y_train.txt")
> subject_train <- read.table("./train/subject_train.txt")
> names(X_train) = features
> X_train = X_train[,extract_features]
> y_train[,2] = activity_labels[y_train[,1]]
> names(y_train) = c("Activity_ID", "Activity_Label")
> names(subject_train) = "subject"
> train_data <- cbind(as.data.table(subject_train), y_train, X_train)
> data = rbind(test_data, train_data)
> id_labels = c("subject", "Activity_ID", "Activity_Label")
## create a vector with labels to be used below

> data_labels = setdiff(colnames(data), id_labels)
> melt_data = melt(data, id = id_labels, measure.vars = data_labels)
## melts the data set together

> tidy_data = dcast(melt_data, subject + Activity_Label ~ variable, mean)
## finished data table

> write.table(tidy_data, file = "./tidy_data.txt")
## writes the table and saves it on working directory as the text file "tidy_data"

