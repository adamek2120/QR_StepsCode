# Aggregating and formating data #
##### Pulling in the data #####
# Get wave 1 data
setwd("C:/Users/jadamek2/Desktop/LAB_NUC/QR_data/Wave1")
w1_data <- read.csv("wave1_qr_clean.csv")
# Get wave 2 data
setwd("C:/Users/jadamek2/Desktop/LAB_NUC/QR_data/Wave2")
w2_data <- read.csv("wave2_qr_clean.csv")
# Get wave 3 data
setwd("C:/Users/jadamek2/Desktop/LAB_NUC/QR_data/Wave3")
w3_data <- read.csv("wave3_qr_clean.csv")
# Get wave 4 data
setwd("C:/Users/jadamek2/Desktop/LAB_NUC/QR_data/Wave4")
w4_data <- read.csv("wave4_qr_clean.csv")
# Get wave 5 data
setwd("C:/Users/jadamek2/Desktop/LAB_NUC/QR_data/Wave5")
w5_data <- read.csv("wave5_qr_clean.csv")
# Get wave 6 data
setwd("C:/Users/jadamek2/Desktop/LAB_NUC/QR_data/Wave6")
w6_data <- read.csv("wave6_qr_clean.csv")

##### Preparing and Processing the data to aggregate #####

# The Below codes aggregates each months class attendance by ID. Final variable includes 1 row for each ID with month totals 
w1_final <- w1_data[-c(1,3,4,5,6)]                          # Makes dataframe of just the ID's and months
w1_final <- aggregate(.~ID, w1_final, sum)               # aggregates total for each month and YTD
w1_final$Total_YTD <- rowSums(w1_final[-1])            # This [-1] is to make sure the ID # isn't summed as well

w2_final <- w2_data[-c(1,3,4,5,6)]                         
w2_final <- aggregate(.~ID, w2_final, sum)              
w2_final$Total_YTD <- rowSums(w2_final[-1])            

w3_final <- w3_data[-c(1,3,4,5,6)]                         
w3_final <- aggregate(.~ID, w3_final, sum)              
w3_final$Total_YTD <- rowSums(w3_final[-1]) 

w4_final <- w4_data[-c(1,3,4,5,6)]                         
w4_final <- aggregate(.~ID, w4_final, sum)              
w4_final$Total_YTD <- rowSums(w4_final[-1]) 

w5_final <- w5_data[-c(1,3,4,5,6)]                         
w5_final <- aggregate(.~ID, w5_final, sum)              
w5_final$Total_YTD <- rowSums(w5_final[-1]) 

w6_final <- w6_data[-c(1,3,4,5,6)]                         
w6_final <- aggregate(.~ID, w6_final, sum)              
w6_final$Total_YTD <- rowSums(w6_final[-1]) 

# Adds column indicating wave
w1_final$wave <- rep(1, nrow(w1_final))
w2_final$wave <- rep(2, nrow(w2_final))
w3_final$wave <- rep(3, nrow(w3_final))
w4_final$wave <- rep(4, nrow(w4_final))
w5_final$wave <- rep(5, nrow(w5_final))
w6_final$wave <- rep(6, nrow(w6_final))

# Labels Month 1, month 2 ... for each wave
colnames(w1_final) <- c("ID", "Month1", "Month2", "Month3", "Month4", "Month5", "Month6", "Month7", "Month8", "Month9", "Month10", "Month11", "Month12", "YearAVG", "wave")
colnames(w3_final) <- c("ID", "Month1", "Month2", "Month3", "Month4", "Month5", "Month6", "Month7", "Month8", "Month9", "Month10", "Month11", "Month12", "YearAVG", "wave")
colnames(w5_final) <- c("ID", "Month1", "Month2", "Month3", "Month4", "Month5", "Month6", "Month7", "Month8", "Month9", "Month10", "Month11", "Month12", "YearAVG", "wave")
colnames(w2_final) <- c("ID", "Month9", "Month10", "Month11", "Month12", "Month1", "Month2", "Month3", "Month4", "Month5", "Month6", "Month7", "Month8", "YearAVG", "wave")
colnames(w4_final) <- c("ID", "Month9", "Month10", "Month11", "Month12", "Month1", "Month2", "Month3", "Month4", "Month5", "Month6", "Month7", "Month8", "YearAVG", "wave")
colnames(w6_final) <- c("ID", "Month9", "Month10", "Month11", "Month12", "Month1", "Month2", "Month3", "Month4", "Month5", "Month6", "Month7", "Month8", "YearAVG", "wave")

# Puts Waves 2,4,6 columns in correct order ("month1, month2...) and puts "wave" into the 2nd column position
w1_final <- w1_final[c(1,15,2,3,4,5,6,7,8,9,10,11,12,13,14)]
w2_final <- w2_final[c(1,15,6,7,8,9,10,11,12,13,2,3,4,5,14)]
w3_final <- w3_final[c(1,15,2,3,4,5,6,7,8,9,10,11,12,13,14)]
w4_final <- w4_final[c(1,15,6,7,8,9,10,11,12,13,2,3,4,5,14)]
w5_final <- w5_final[c(1,15,2,3,4,5,6,7,8,9,10,11,12,13,14)]
w6_final <- w6_final[c(1,15,6,7,8,9,10,11,12,13,2,3,4,5,14)]




# Creates a master file and saves it
master <- rbind(w1_final, w2_final, w3_final, w4_final, w5_final, w6_final)
setwd("C:/Users/jadamek2/Desktop/LAB_NUC/QR_data")
write.csv(master, "QR_master.csv")

# Writes final data as a csv.
write.csv(w1_final, "w1_final.csv")
write.csv(w2_final, "w2_final.csv")
write.csv(w3_final, "w3_final.csv")
write.csv(w4_final, "w4_final.csv")
write.csv(w5_final, "w5_final.csv")
write.csv(w6_final, "w6_final.csv")


########## Visualization ############

data <- master
# Taking the mean of each month by wave
m1 <- rbind(mean(data$Month1[data$wave == 1]), mean(data$Month1[data$wave == 2]), mean(data$Month1[data$wave == 3]),
            mean(data$Month1[data$wave == 4]), mean(data$Month1[data$wave == 5]), mean(data$Month1[data$wave == 6]))
m2 <- rbind(mean(data$Month2[data$wave == 1]), mean(data$Month2[data$wave == 2]), mean(data$Month2[data$wave == 3]),
            mean(data$Month2[data$wave == 4]), mean(data$Month2[data$wave == 5]), mean(data$Month2[data$wave == 6]))
m3 <- rbind(mean(data$Month3[data$wave == 1]), mean(data$Month3[data$wave == 2]), mean(data$Month3[data$wave == 3]),
            mean(data$Month3[data$wave == 4]), mean(data$Month3[data$wave == 5]), mean(data$Month3[data$wave == 6]))
m4 <- rbind(mean(data$Month4[data$wave == 1]), mean(data$Month4[data$wave == 2]), mean(data$Month4[data$wave == 3]),
            mean(data$Month4[data$wave == 4]), mean(data$Month4[data$wave == 5]), mean(data$Month4[data$wave == 6]))
m5 <- rbind(mean(data$Month5[data$wave == 1]), mean(data$Month5[data$wave == 2]), mean(data$Month5[data$wave == 3]),
            mean(data$Month5[data$wave == 4]), mean(data$Month5[data$wave == 5]), mean(data$Month5[data$wave == 6]))
m6 <- rbind(mean(data$Month6[data$wave == 1]), mean(data$Month6[data$wave == 2]), mean(data$Month6[data$wave == 3]),
            mean(data$Month6[data$wave == 4]), mean(data$Month6[data$wave == 5]), mean(data$Month6[data$wave == 6]))
m7 <- rbind(mean(data$Month7[data$wave == 1]), mean(data$Month7[data$wave == 2]), mean(data$Month7[data$wave == 3]),
            mean(data$Month7[data$wave == 4]), mean(data$Month7[data$wave == 5]), mean(data$Month7[data$wave == 6]))
m8 <- rbind(mean(data$Month8[data$wave == 1]), mean(data$Month8[data$wave == 2]), mean(data$Month8[data$wave == 3]),
            mean(data$Month8[data$wave == 4]), mean(data$Month8[data$wave == 5]), mean(data$Month8[data$wave == 6]))
m9 <- rbind(mean(data$Month9[data$wave == 1]), mean(data$Month9[data$wave == 2]), mean(data$Month9[data$wave == 3]),
            mean(data$Month9[data$wave == 4]), mean(data$Month9[data$wave == 5]), mean(data$Month9[data$wave == 6]))
m10 <- rbind(mean(data$Month10[data$wave == 1]), mean(data$Month10[data$wave == 2]), mean(data$Month10[data$wave == 3]),
             mean(data$Month10[data$wave == 4]), mean(data$Month10[data$wave == 5]), mean(data$Month10[data$wave == 6]))
m11 <- rbind(mean(data$Month11[data$wave == 1]), mean(data$Month11[data$wave == 2]), mean(data$Month11[data$wave == 3]),
             mean(data$Month11[data$wave == 4]), mean(data$Month11[data$wave == 5]), mean(data$Month11[data$wave == 6]))
m12 <- rbind(mean(data$Month12[data$wave == 1]), mean(data$Month12[data$wave == 2]), mean(data$Month12[data$wave == 3]),
             mean(data$Month12[data$wave == 4]), mean(data$Month12[data$wave == 5]), mean(data$Month12[data$wave == 6]))

# Prepare the variables to be plotted
wave <- cbind(m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12)
colnames(wave) <- paste("Month", 1:12)
rownames(wave) <- paste("Wave", 1:6)
master <- master[, -c(1,2,15)]
monthAVGc <- colMeans(master, na.rm = TRUE)

# Plotting the main master plot
plot(monthAVGc,
     main = "Average CLASSES per Month",
     xlab = "Months",
     ylab = "Average vists",
     sub = "Across all waves", 
     pch = 15,
     col = "blue")
legend("topright",legend=c("Average across waves"),
       text.col=c("black"),pch=c(15),col=c("blue"))

# Plotting the data
par(mfrow=c(2,3))
plot(wave[1,],
     main = "Wave 1: Average CLASSES per Month",
     xlab = "Months",
     ylab = "Average CLASSES",
     pch = 15,
     col = "black")
legend("topright",legend=c("January = M12"),
       text.col=c("blue"),pch=c(17),col=c("black"))
axis(1, seq(1,12,1))
plot(wave[3,],
     main = "Wave 3: Average CLASSES per Month",
     xlab = "Months",
     ylab = "Average CLASSES",
     pch = 15,
     col = "black")
legend("topright",legend=c("January = M12"),
       text.col=c("blue"),pch=c(17),col=c("black"))
axis(1, seq(1,12,1))
plot(wave[5,],
     main = "Wave 5: Average CLASSES per Month",
     xlab = "Months",
     ylab = "Average CLASSES",
     pch = 15,
     col = "black")
legend("topright",legend=c("January = M12"),
       text.col=c("blue"),pch=c(17),col=c("black"))
axis(1, seq(1,12,1))
plot(wave[2,],
     main = "Wave 2: Average CLASSES per Month",
     xlab = "Months",
     ylab = "Average CLASSES",
     pch = 15,
     col = "red")
legend("topright",legend=c("January = M8"),
       text.col=c("blue"),pch=c(17),col=c("red"))
axis(1, seq(1,12,1))
plot(wave[4,],
     main = "Wave 4: Average CLASSES per Month",
     xlab = "Months",
     ylab = "Average CLASSES",
     pch = 15,
     col = "red")
legend("topright",legend=c("January = M8"),
       text.col=c("blue"),pch=c(17),col=c("red"))
axis(1, seq(1,12,1))
plot(wave[6,],
     main = "Wave 6: Average CLASSES per Month",
     xlab = "Months",
     ylab = "Average CLASSES",
     pch = 15,
     col = "red")
legend("topright",legend=c("Covid: M11 & M12"),
       text.col=c("blue"),pch=c(17),col=c("red"))
axis(1, seq(1,12,1))

