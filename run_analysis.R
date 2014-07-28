##
## file:     run_analysis.R 
## context:  getdatacoursera project
## author:   skilchen
## date:     Thursday, July 24, 2014
##

FIELD_SEPARATOR <- ","

download_and_unzip_data <- function(download_dir) {
  #
  # downloads the data from the url in the course project description
  # and unzips the data into download_dir
  # you need write permissions in download_dir
  # 
  message(date(), " start download_and_unzip_data")
  
  url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
  dest_file  <- file.path(download_dir, "UCIHARDataset.zip")
  
  if (!file.exists(dest_file)) {
    download.file(url=url, destfile=dest_file, method="curl")
  }
  unzip(dest_file, exdir=download_dir, overwrite=TRUE)
  
  message(date(), " end   download_and_unzip_data")
}

merge_data <- function(base_dir, merge_dir) {
  #
  # let the OS do the merging using file.copy and file.append
  # write the merged data into merge_dir below base_dir
  #
  message(date(), " start merge_data")
    
  # where the merged data will be written
  dest_dir <- file.path(base_dir, merge_dir)
  
  # the downloaded dataset contains subdirectories
  # for train and test data
  train_dir <- file.path(base_dir, "train")
  test_dir <- file.path(base_dir, "test")
  
  if(!file.exists(train_dir) || !file.exists(test_dir)) {
    stop("no data available in ", base_dir)
  }
  
  if(!file.exists(dest_dir)) {
    if(!dir.create(dest_dir, recursive=TRUE)) {
      stop("can't create ", dest_dir)
    }
  }
  
  for(fname in c("activity_labels.txt", "features.txt")) {
    src <- file.path(base_dir, fname)
    dst <- file.path(dest_dir, fname)
    if(!file.copy(from=src, to=dst, overwrite=TRUE)) {
      stop("required file ", src, " can't be copied to ", dst)
    }
  }
  
  src <- file.path(train_dir, "X_train.txt")
  dst <- file.path(dest_dir, "X.txt")
  if (!file.copy(from=src, to=dst, overwrite=TRUE)) {
    stop("required file ", src, " can't be copied to ", dst)
  }
  src <- file.path(test_dir, "X_test.txt")
  if(!file.append(dst, src)) {
    stop("required file ", src, " can't be appended to ", dst)
  }
  
  src <- file.path(train_dir, "y_train.txt")
  dst <- file.path(dest_dir, "y.txt")
  if (!file.copy(from=src, to=dst, overwrite=TRUE)) {
    stop("required file ", src, " can't be copied to ", dst)
  }
  src <- file.path(test_dir, "y_test.txt")
  if(!file.append(dst, src)) {
    stop("required file ", src, " can't be appended to ", dst)
  }
  
  src <- file.path(train_dir, "subject_train.txt")
  dst <- file.path(dest_dir, "subject.txt")
  if (!file.copy(from=src, to=dst, overwrite=TRUE)) {
    stop("required file ", src, " can't be copied to ", dst)
  }
  src <- file.path(test_dir, "subject_test.txt")
  if (!file.append(dst, src)) {
    stop("required file ", src, " can't be appended to ", dst)
  }
  
  message(date(), " end   merge_data")
}

read_subjects <- function(base_dir) {
  #
  # read the merged subject.txt into a numeric vector
  # so that later it can be combined with the selected
  # features
  #
  message(date(), " start read_subjects")
  full_path <- file.path(base_dir, "subject.txt")
  fp <- file(full_path, open="r")
  subjects <- as.numeric(readLines(fp))
  close(fp)

  message(date(), " end   read_subjects")
  return(subjects)
}

read_activity_labels <- function(base_dir) {
  # read the activity labels (activity_labels.txt) 
  # into a data.frame, so that the labels can be
  # attached to the activity numbers using slicing
  # return a data.frame with V1 = activity_number
  # and V2 = activity_label
  message(date(), " start read_activity_labels")
  activity_labels <- read.table(file.path(base_dir, "activity_labels.txt"),
                                header = FALSE, stringsAsFactors = FALSE)
  message(date(), " end   read_activity_labels")
  return(activity_labels)
}

read_activities <- function(base_dir, activity_labels) {
  #
  # read the merged activities (y.txt) and into 
  # a data.frame, so that the labels can be
  # attached to the numbers using slicing.
  # return a data.frame with V1 = activity_number
  # and V2 = activity_label
  #
  message(date(), " start read_activities")
  
  activities <- read.table(file.path(base_dir, "y.txt"),
                           header = FALSE, stringsAsFactors = FALSE)
  
  labeled_activities <- activity_labels[activities$V1,]
  
  message(date(), " end   read_activities")
  return(labeled_activities)
}

read_selected_features <- function(base_dir) {
  #
  # read the feature names into a data.frame and
  # select only those who contain either "mean()" 
  # or "std()".
  # return a data.frame with:
  # V1 = the column index of the selected features
  # V2 = somewhat tidied feature labels
  #
  message(date(), " start read_selected_features")
  features <- read.table(file.path(base_dir, "features.txt"),
                         header = FALSE, stringsAsFactors = FALSE)
  selected_features <- features[grep("mean\\(\\)|std\\(\\)", features$V2),]
  selected_features$V2 <- gsub("-", ".", gsub("[()]", "", selected_features$V2))
  message(date(), " end   read_selected_features")
  return(selected_features)
}

process_data <- function(base_dir, subjects, activities, selected_features, output_file) {
  #
  # read the merged data file (X.txt in base_dir) line by line,
  # slice the desired columns (selected_features),
  # write the sliced measurements together with 
  # subject number (subjects) and 
  # activity_label (activities) to a temporary
  # output_file containing tidy data ...
  #
  # it is intentionally not done in R style
  #
  
  message(date(), " start process_data")
  x_file = file.path(base_dir, "X.txt")
  fp <- file(x_file, open="r")
  ofp = file(output_file, open="w")
  
  # create header line for output_file
  header <- c("Subject", "Activity", selected_features$V2)
  cat(header, file=ofp, sep=FIELD_SEPARATOR)
  cat("\n", file=ofp)
  
  # read and process the X data line by line
  # (should run in constant space, but unfortunately much slower than
  # other tools - such as python - can handle similar tasks)
  #
  i <- 0
  while(length(oneLine <- readLines(fp, n = 1, warn = FALSE)) > 0) {
    flds <- as.numeric(strsplit(gsub("^\\s+|\\s+$", "", oneLine), "\\s+")[[1]][selected_features$V1])
    i <- i + 1
    out_line <- c(subjects[i], activities[i,"V2"], flds)
    cat(out_line, file=ofp, sep=FIELD_SEPARATOR)
    cat("\n", file=ofp)
  }
  close(fp)
  close(ofp)
  message(date(), " end   process_data")
}

write_aggregate_data <- function(activity_labels,
                                 input_file="tidy_data_all.txt", 
                                 output_dir=".", 
                                 output_file="tidy_data_per_activity_and_subject.txt") {
  #
  # takes the activity_labels, the input_file produced 
  # by process_data and writes output_file into output_dir
  # with averages aggregated per activity and subject
  # 
  # returns the aggregated data.frame
  #
  message(date(), " start write_aggregate_data")
  
  df <- read.table(input_file, header=TRUE, sep=FIELD_SEPARATOR)
  df$Subject <- as.factor(df$Subject)
  
  df$Activity <- factor(df$Activity, levels=activity_labels$V2)
  
  aggregated <- aggregate(df[,3:ncol(df)], 
                          by = list(Activity = df$Activity, Subject = df$Subject),
                          FUN = mean)
  
  outputfile <- file.path(output_dir, output_file)
  message("outputfile: ", outputfile)
  write.table(aggregated, file=outputfile, sep=FIELD_SEPARATOR, row.names=FALSE)
  
  message(date(), " end   write_aggregate_data")
  return(aggregated)
}
  
run_analysis <- function(base_dir, merge_dir="merged", 
                         output_file_1="tidy_data_all.txt",
                         output_file_2="tidy_data.txt") {
  # 
  # call the processing steps defined above
  # it looks in base_dir for the UCI HAR data
  # it writes the merged train/test data to merge_dir
  # it produces a output file named output_file
  #
  message(date(), " start run_analysis")
  
  merge_data(base_dir, merge_dir)
  merge_dir <- file.path(base_dir, merge_dir)
  
  subjects <- read_subjects(merge_dir)
  
  activity_labels <- read_activity_labels(merge_dir)
  labeled_activities <- read_activities(merge_dir, activity_labels)
  
  selected_features <- read_selected_features(merge_dir)
  
  process_data(merge_dir, subjects, labeled_activities, selected_features, output_file_1)
  
  aggregated = write_aggregate_data(activity_labels, output_file_1, ".", output_file_2)
  
  message(date(), " end   run_analysis")
  return(aggregated)
}

main <- function(download=FALSE) {
  #
  # helper function the start the analysis
  # with default parameters as specified below
  #
  
  # as long as the data are available on the course project
  # website, you can run main(download=TRUE) without any
  # further requirement other than that you have write 
  # permissions in download_dir and in the current working
  # directory.
  
  # if you let main download the dataset, 
  # it will be stored here
  download_dir <- "."
  
  # the zipped dataset contains a directory structure
  # starting at the subdirectory "UCI HAR Dataset"
  # if you don't let main download the zipped dataset,
  # the unzipped data with the directory structure
  # below "UCI HAR Dataset" are searched in base_dir.
  # specifying a different base_dir is only possible,
  # if you yourself first put the data there
  base_dir <- file.path(download_dir, "UCI HAR Dataset")
  #base_dir <- "/tmp/blabla"
  if (!download) {
    message("searching data in ", base_dir)
  }

  # the name of the output_file with all tidy data
  output_file_1 <- "tidy_data_all.txt"
  
  # the name of to the output_file with the data
  # aggregated by activity and subject.
  output_file_2 <- "tidy_data_per_activity_and_subject.txt"
  
  if (download) {
    base_dir <- file.path(download_dir, "UCI HAR Dataset")
    download_and_unzip_data(download_dir)
    message("searching data in ", base_dir)
  }
  
  aggregated <- run_analysis(base_dir=base_dir, 
                             merge_dir="merged",
                             output_file_1=output_file_1,
                             output_file_2=output_file_2)
  # do whatever you would like with the aggregated data
  # e.g. summary(aggregated)
  # for now we are only interested in the written output_file
}
