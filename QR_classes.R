##### Libraries #####
library(dplyr)

##### Side Task: Prepare separate file containing only classes #####
# Creates a file containing ID, month, day, year, class for each wave 
## Pulls in each waves data
setwd("C:/Users/jadamek2/Desktop/LAB_NUC/QR_data/Wave1")
w1_class <- read.csv("wave1_qr_clean.csv")
setwd("C:/Users/jadamek2/Desktop/LAB_NUC/QR_data/Wave2")
w2_class <- read.csv("wave2_qr_clean.csv")
setwd("C:/Users/jadamek2/Desktop/LAB_NUC/QR_data/Wave3")
w3_class <- read.csv("wave3_qr_clean.csv")
setwd("C:/Users/jadamek2/Desktop/LAB_NUC/QR_data/Wave4")
w4_class <- read.csv("wave4_qr_clean.csv")
setwd("C:/Users/jadamek2/Desktop/LAB_NUC/QR_data/Wave5")
w5_class <- read.csv("wave5_qr_clean.csv")
setwd("C:/Users/jadamek2/Desktop/LAB_NUC/QR_data/Wave6")
w6_class <- read.csv("wave6_qr_clean.csv")

# Adds column indicating wave
w1_class$wave <- rep(1, nrow(w1_class))
w2_class$wave <- rep(2, nrow(w2_class))
w3_class$wave <- rep(3, nrow(w3_class))
w4_class$wave <- rep(4, nrow(w4_class))
w5_class$wave <- rep(5, nrow(w5_class))
w6_class$wave <- rep(6, nrow(w6_class))

# Puts Waves 2,4,6 columns in correct order ("month1, month2...) and puts "wave" into the 2nd column position
w1_class <- w1_class[c(1,2,19,3,4,5,6,7,8,9,10,11,12,13,14,18,16,17,18)]
w2_class <- w2_class[c(1,2,19,3,4,5,6,11,12,13,14,15,16,17,18,7,8,9,10)]
w3_class <- w3_class[c(1,2,19,3,4,5,6,7,8,9,10,11,12,13,14,18,16,17,18)]
w4_class <- w4_class[c(1,2,19,3,4,5,6,11,12,13,14,15,16,17,18,7,8,9,10)]
w5_class <- w5_class[c(1,2,19,3,4,5,6,7,8,9,10,11,12,13,14,18,16,17,18)]
w6_class <- w6_class[c(1,2,19,3,4,5,6,11,12,13,14,15,16,17,18,7,8,9,10)]

# Labels Month 1, month 2 ... for each wave
colnames(w1_class) <- c("run", "ID", "wave", "Class","Month", "day", "year", "Month1", "Month2", "Month3", "Month4", "Month5", "Month6", "Month7", "Month8", "Month9", "Month10", "Month11", "Month12")
colnames(w3_class) <- c("run", "ID", "wave", "Class","Month", "day", "year", "Month1", "Month2", "Month3", "Month4", "Month5", "Month6", "Month7", "Month8", "Month9", "Month10", "Month11", "Month12")
colnames(w5_class) <- c("run", "ID", "wave", "Class","Month", "day", "year", "Month1", "Month2", "Month3", "Month4", "Month5", "Month6", "Month7", "Month8", "Month9", "Month10", "Month11", "Month12")
colnames(w2_class) <- c("run", "ID", "wave", "Class","Month", "day", "year", "Month1", "Month2", "Month3", "Month4", "Month5", "Month6", "Month7", "Month8", "Month9", "Month10", "Month11", "Month12")
colnames(w4_class) <- c("run", "ID", "wave", "Class","Month", "day", "year", "Month1", "Month2", "Month3", "Month4", "Month5", "Month6", "Month7", "Month8", "Month9", "Month10", "Month11", "Month12")
colnames(w6_class) <- c("run", "ID", "wave", "Class","Month", "day", "year", "Month1", "Month2", "Month3", "Month4", "Month5", "Month6", "Month7", "Month8", "Month9", "Month10", "Month11", "Month12")


# Creates master dataframe of all waves and tallys them
masterclass <- rbind(w1_class, w2_class, w3_class, w4_class, w5_class, w6_class)
QR_count_bywave <- masterclass %>% count(wave, Class)


## Saves file to directory #####
setwd("C:/Users/jadamek2/Desktop/LAB_NUC/QR_data")
write.csv(w1_class, "w1_class.csv")
write.csv(w2_class, "w2_class.csv")
write.csv(w3_class, "w3_class.csv")
write.csv(w4_class, "w4_class.csv")
write.csv(w5_class, "w5_class.csv")
write.csv(w6_class, "w6_class.csv")
write.csv(masterclass, "QR_master_class.csv")

##### Cleaning the "other" class responses as per SPM rules (see document) ####
## File QR_master_class.csv was open externally and classes were cleaned and saved as: QR_master_class_clean.csv
## See QR_Class_Data_Processing.docx and List of classes removed & recoded.xlsx

##### Importing cleanned class file back in ####
setwd("S:/LAB_Documents/Visits_QR_data/QR_data/QR_Cleaned_Processed_Files")
class_clean <- read.csv("QR_master_class_cleaned.csv")

QR_count_bywave <- class_clean %>% count(wave, Class)
QR_count_overall <- class_clean %>% count(Class)
write.csv(QR_count_bywave, "Class_frequency_bywave.csv")
write.csv(QR_count_overall, "Class_frequency_overall.csv")

john <- data.frame(unique(class_clean$Class))
colnames(john) <- "Classes"
write.csv(john, "class_Descr.csv")
