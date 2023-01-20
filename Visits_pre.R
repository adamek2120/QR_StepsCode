##### Libraries #####
library(readxl)
library(plyr)    # for binding multiple files
library(dplyr)
library(stringr) # for function str_replace_all


##### Loading in multiple files and binding together ####
setwd("C:/Users/jadamek2/Desktop/Visits/wave1")
wave1 <- list.files(pattern = "*.xlsx", full.names = T)
wave1 <- sapply(wave1, read_excel, simplify=FALSE) %>% bind_rows(.id = "ID")  # binding files together in one dataframe

setwd("C:/Users/jadamek2/Desktop/Visits/wave2")
wave2 <- list.files(pattern = "*.xlsx", full.names = T)
wave2 <- sapply(wave2, read_excel, simplify=FALSE) %>% bind_rows(.id = "Client")

setwd("C:/Users/jadamek2/Desktop/Visits/wave3")
wave3 <- list.files(pattern = "*.xlsx", full.names = T)
wave3 <- sapply(wave3, read_excel, simplify=FALSE) %>% bind_rows(.id = "Client")

setwd("C:/Users/jadamek2/Desktop/Visits/wave4")
wave4 <- list.files(pattern = "*.xlsx", full.names = T)
wave4 <- sapply(wave4, read_excel, simplify=FALSE) %>% bind_rows(.id = "Client")

setwd("C:/Users/jadamek2/Desktop/Visits/wave5")
wave5 <- list.files(pattern = "*.xlsx", full.names = T)
wave5 <- sapply(wave5, read_excel, simplify=FALSE) %>% bind_rows(.id = "Client")

setwd("C:/Users/jadamek2/Desktop/Visits/wave6")
wave6 <- list.files(pattern = "*.xlsx", full.names = T)
wave6 <- sapply(wave6, read_excel, simplify=FALSE) %>% bind_rows(.id = "Client")

##### Data Cleaning ####

# Converts class type for Date to character for wave 1 so that its the same as wave 2-6
wave1$Date <- as.character(wave1$Date)

# Changes column name from Client to ID
colnames(wave2)[5] <- "ID"
colnames(wave3)[5] <- "ID"
colnames(wave4)[5] <- "ID"
colnames(wave5)[5] <- "ID"
colnames(wave6)[5] <- "ID"

# Clean ID column to only show ID# and not file extension 
wave1$ID <- gsub(".*D","", wave1$ID)                # Removes everything before the number | gsub =before
wave1$ID <- wave1$ID %>% str_replace_all('\\.', '') # Removes the period in the column
wave1$ID <- sub("xlsx","", wave1$ID)                # Removes everything after the number   | sub = after

wave2$ID <- gsub("/", "", wave2$ID)                 # Removes the / before the data
wave2$ID <- wave2$ID %>% str_replace_all('\\.', '') 
wave2$ID <- sub("xlsx","", wave2$ID)

wave3$ID <- gsub("/","", wave3$ID)                
wave3$ID <- wave3$ID %>% str_replace_all('\\.', '') 
wave3$ID <- sub("xlsx","", wave3$ID) 

wave4$ID <- gsub("/", "", wave4$ID)                
wave4$ID <- wave4$ID %>% str_replace_all('\\.', '') 
wave4$ID <- sub("xlsx","", wave4$ID) 

wave5$ID <- gsub("/", "", wave5$ID)                
wave5$ID <- wave5$ID %>% str_replace_all('\\.', '') 
wave5$ID <- sub("xlsx","", wave5$ID) 

wave6$ID <- gsub("/", "", wave6$ID)                
wave6$ID <- wave6$ID %>% str_replace_all('\\.', '') 
wave6$ID <- sub("xlsx","", wave6$ID) 

# Removes the extra noise in the Time column
## (.*) looks for any character 0 or more times until the first space, (?) is what makes it stop at the first space
wave1$Time <- gsub(".*? ", " ", wave1$Time) 

# Changes column "Check-In Time" to "Time" to remain consistent with the other waves
colnames(wave1)[8] <- "Pricing Option"
colnames(wave2)[6] <- "Time"
colnames(wave3)[6] <- "Time"
colnames(wave4)[6] <- "Time"
colnames(wave5)[6] <- "Time"
colnames(wave6)[6] <- "Time"

# Select the needed columns (date,time,ID,Payment) then ensures dataset contains only those in Befit study
w1 <- wave1[,c(1,3,2,8)]
w1 <- subset(w1, `Pricing Option` == "Be Fit Study")

w2 <- wave2[,c(1,5,6,7)]
w2 <- subset(w2, `Pricing Option` == "Be Fit Study")

w3 <- wave3[,c(1,5,6,7)]
w3 <- subset(w3, `Pricing Option` == "Be Fit Study")

w4 <- wave4[,c(1,5,6,7)]
w4 <- subset(w4, `Pricing Option` == "Be Fit Study")

w5 <- wave5[,c(1,5,6,7)]
w5 <- subset(w5, `Pricing Option` == "Be Fit Study")

w6 <- wave6[,c(1,5,6,7)]
w6 <- subset(w6, `Pricing Option` == "Be Fit Study")

# Writes the cleaned file to Visits folder
setwd("C:/Users/jadamek2/Desktop/Visits")
write.csv(w1, "wave1_cleaned.csv")
write.csv(w2, "wave2_cleaned.csv")
write.csv(w3, "wave3_cleaned.csv")
write.csv(w4, "wave4_cleaned.csv")
write.csv(w5, "wave5_cleaned.csv")
write.csv(w6, "wave6_cleaned.csv")
