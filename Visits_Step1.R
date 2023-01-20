
library(dplyr)
library(tidyr)

# Set working directory and read in data
setwd("C:/Users/jadamek2/Desktop/Visits")
wave1 <- read.csv("wave1_cleaned.csv")
wave2 <- read.csv("wave2_cleaned.csv")
wave3 <- read.csv("wave3_cleaned.csv")
wave4 <- read.csv("wave4_cleaned.csv")
wave5 <- read.csv("wave5_cleaned.csv")
wave6 <- read.csv("wave6_cleaned.csv")

# Determining which ID's have duplicate check-In Dates
check <- wave1 %>% group_by(ID,Date) %>% count(Date)
w1d <- with(check, check[n > 1, ])

check <- wave2 %>% group_by(ID,Date) %>% count(Date)
w2d <- with(check, check[n > 1, ])

check <- wave3 %>% group_by(ID,Date) %>% count(Date)
w3d <- with(check, check[n > 1, ])

check <- wave4 %>% group_by(ID,Date) %>% count(Date)
w4d <- with(check, check[n > 1, ])

check <- wave5 %>% group_by(ID,Date) %>% count(Date)
w5d <- with(check, check[n > 1, ])

check <- wave6 %>% group_by(ID,Date) %>% count(Date)
w6d <- with(check, check[n > 1, ])

# Writing file of all duplicate ID's to be checked
write.csv(w1d, "wave1_duplicates.csv")
write.csv(w2d, "wave2_duplicates.csv")
write.csv(w3d, "wave3_duplicates.csv")
write.csv(w4d, "wave4_duplicates.csv")
write.csv(w5d, "wave5_duplicates.csv")
write.csv(w6d, "wave6_duplicates.csv")

##### See Data Processing Visits.docx 4.c ####
# duplicate swipes on same day was checked for 4 hour rule

# read in files after removing duplicates ####
setwd("C:/Users/jadamek2/Desktop/Visits")
wave1 <- read.csv("wave1_final.csv")
wave2 <- read.csv("wave2_final.csv")
wave3 <- read.csv("wave3_final.csv")
wave4 <- read.csv("wave4_final.csv")
wave5 <- read.csv("wave5_final.csv")
wave6 <- read.csv("wave6_final.csv")