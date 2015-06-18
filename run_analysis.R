run_analysis <- function(){
  #This function assumes that the require data files are in your working directory
  #Check if the dplyr package is installed. if not we install it
  if(!is.element("dplyr", installed.packages()[,1])){install.packages("dplyr")}
  library(dplyr)
 
  
  #Read in the data
  train_x <- read.table(".//X_train.txt")
  train_y <- read.table(".//y_train.txt")
  train_s <- read.table(".//subject_train.txt")
  test_x <- read.table(".//X_test.txt")
  test_y <- read.table(".//y_test.txt")
  test_s <- read.table(".//subject_test.txt")
  features <- read.table(".//features.txt")
  activity_labels <- read.table(".//activity_labels.txt")
  
  
  
 #Merge the training a test datasets into a single dataset
 x_data <- bind_rows(train_x, test_x)
 y_data <- bind_rows(train_y, test_y)
 subjects <- bind_rows(train_s, test_s)
 
 #Keep only measurements on mean and standard deviation
 means <- grep("mean()", features$V2, fixed = TRUE)
 stds <- grep("std()", features$V2, fixed = TRUE) 
 keep <- filter(features, V1 %in% means | V1 %in% stds)
 colnames(x_data) <- features$V2
 keep_names <- as.vector(keep$V2)
 kept_measurements <- x_data[,keep_names]
 
 #Merge other data files and create names
 activity_data <- left_join(y_data, activity_labels)
 colnames(activity_data) <- c("activity_code", "activity_label")
 colnames(subjects) <- "subjects"
 complete_data <- bind_cols(subjects, activity_data, kept_measurements)
 data_table <- tbl_df(complete_data)
 data_table <- select(data_table, -activity_code)
 
 
 #We calculate the mean of all measurements for each subject, activity combination
 grouped <- group_by(data_table, subjects, activity_label)
 
 #Get list of columns we will take the mean of
 cols <- names(grouped)[-(1:2)]
 
 #Create a function to calculate the means
 group_mean_func <- sapply(cols, function(x) substitute(mean(x), list(x=as.name(x))))
 
 #Generate the tidy data of subject, activity means
 tidy_data <- do.call(summarise, c(list(.data=grouped), group_mean_func))
 
 tidy_data

}