##### Pulling in the data #####
setwd("C:/Users/jadamek2/Desktop/LAB_NUC/QR_data/QR_Cleaning_Processing_Files")
data <- read_excel("Qualtrics_cleaning.xlsx")
library(tidyr)
##### Formatting and Preparing the data ####
# Separates The column by data and time
data <- separate(data, StartDate, into=c("sdate","stime"), sep = " ")
data <- separate(data, EndDate, into=c("Edate","Etime"), sep = " ")
data <- separate(data, RecordedDate, into=c("Rdate","Rtime"), sep = " ")

# Removes the time columns
data <- data[-c(5,7,9)]

# Converts class type from chr to date
data$sdate <- gsub("-","", data$sdate)
data$Edate <- gsub("-","", data$Edate)
data$Rdate <- gsub("-","", data$Rdate)
data$TodaysDate <- gsub("-","", data$TodaysDate)
data$sdate <- as.Date(data$sdate, format="%Y%m%d")
data$Edate <- as.Date(data$Edate, format="%Y%m%d")
data$Rdate <- as.Date(data$Rdate, format="%Y%m%d")
data$TodaysDate <- as.Date(data$TodaysDate, format="%Y%m%d")

##### Cleaning the Data for instances where Today's Date and Recorded Date does not match ####

# Identifies which Recorded dates are before Todays dates and changes Todays Date to Recorded Date
R_before <- with(data, data[Rdate < TodaysDate, ])
R_before$TodaysDate <- R_before$Rdate

# Identifies which Recorded dates are before Todays dates 
R_after <- with(data, data[Rdate > TodaysDate, ])
# Saves this file to csv. to manually check for whether these were errors in typing the date or not (see data processing steps and/or screen recording)
write.csv(R_after, "rafter.csv")
# Imports the cleanned rafter file
R_after_cl <- read.csv("rafter_clean.csv")

# This matches the data on RUN and merges data from R_before and R_after_cl into main data set with others
data$r_before <- R_before$TodaysDate[match(data$Run, R_before$Run)]
data$r_after <- R_after_cl$TodaysDate[match(data$Run, R_after_cl$Run)]

# Writes the data to file
write.csv(data, "QR_cleanned_07312020.csv")

##### End of Step 1: Notes to be done before opening QR_step2.R ####
# After this process I opened the new csv file to ensure accuracy by checking the columns: r_before and r_after
# The changed dates were then merged into a final CorrectDate column.
# When this is completed I continued data cleaning in QR_ID_cleanning