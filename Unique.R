setwd("S:/LAB_Documents/Visits_QR_data")
uniq <- read.csv("Final_merged.csv")

# If class is 1 but no overlap new column is a 1 otherwise its a 2
uniq$unique_class <- ifelse(uniq$Class == 1 & uniq$Keyswipe == 0,  1, 0)


uniq_ <- uniq[-c(2,3)]                          
uniq_ <- aggregate(.~ID, uniq_, sum)              

write.csv(uniq_, "Complete_Merged_unique.csv")
