library(readxl)
library(lattice)
# Import dataset and removed the last column
data <- read_excel("Befit_visitdata_MASTER.xlsx")
data <- Befit_visitdata_MASTER
data <- data[-15]
data[data == -999] <- NA

# Created a dataset with just the months and told R that -999 is NA
## Then computes the sum of months 1:12
working <- data[3:14]
working[working == -999] <- NA
working$Total_YTD <- rowSums(working, na.rm = TRUE)

# Places this column back in the main dataset -> data
data$Total_YTD <- working$Total_YTD

# Exports this new dataset with total column as a .csv to be exported into SPSS
write.csv(data, "Befit_visitdata_M.csv")


##### Visualization ###
monthAVG <- colMeans(working, na.rm = TRUE)








x <- data.frame(mean(data$Total_YTD[data$Wave == 1]), mean(data$Total_YTD[data$Wave == 2]), mean(data$Total_YTD[data$Wave == 3]),
           mean(data$Total_YTD[data$Wave == 4]), mean(data$Total_YTD[data$Wave == 5]), mean(data$Total_YTD[data$Wave == 6]))
colnames(x) <- paste("Wave", 1:6, sep=" ")

# Taking the mean of each month by wave
m1 <- rbind(mean(data$M1[data$Wave == 1]), mean(data$M1[data$Wave == 2]), mean(data$M1[data$Wave == 3]),
                 mean(data$M1[data$Wave == 4]), mean(data$M1[data$Wave == 5]), mean(data$M1[data$Wave == 6]))
m2 <- rbind(mean(data$M2[data$Wave == 1]), mean(data$M2[data$Wave == 2]), mean(data$M2[data$Wave == 3]),
            mean(data$M2[data$Wave == 4]), mean(data$M2[data$Wave == 5]), mean(data$M2[data$Wave == 6]))
m3 <- rbind(mean(data$M3[data$Wave == 1]), mean(data$M3[data$Wave == 2]), mean(data$M3[data$Wave == 3]),
                 mean(data$M3[data$Wave == 4]), mean(data$M3[data$Wave == 5]), mean(data$M3[data$Wave == 6]))
m4 <- rbind(mean(data$M4[data$Wave == 1]), mean(data$M4[data$Wave == 2]), mean(data$M4[data$Wave == 3]),
            mean(data$M4[data$Wave == 4]), mean(data$M4[data$Wave == 5]), mean(data$M4[data$Wave == 6]))
m5 <- rbind(mean(data$M5[data$Wave == 1]), mean(data$M5[data$Wave == 2]), mean(data$M5[data$Wave == 3]),
                 mean(data$M5[data$Wave == 4]), mean(data$M5[data$Wave == 5]), mean(data$M5[data$Wave == 6]))
m6 <- rbind(mean(data$M6[data$Wave == 1]), mean(data$M6[data$Wave == 2]), mean(data$M6[data$Wave == 3]),
                 mean(data$M6[data$Wave == 4]), mean(data$M6[data$Wave == 5]), mean(data$M6[data$Wave == 6]))
m7 <- rbind(mean(data$M7[data$Wave == 1]), mean(data$M7[data$Wave == 2]), mean(data$M7[data$Wave == 3]),
                mean(data$M7[data$Wave == 4]), mean(data$M7[data$Wave == 5]), mean(data$M7[data$Wave == 6]))
m8 <- rbind(mean(data$M8[data$Wave == 1]), mean(data$M8[data$Wave == 2]), mean(data$M8[data$Wave == 3]),
                 mean(data$M8[data$Wave == 4]), mean(data$M8[data$Wave == 5]), mean(data$M8[data$Wave == 6]))
m9 <- rbind(mean(data$M9[data$Wave == 1]), mean(data$M9[data$Wave == 2]), mean(data$M9[data$Wave == 3]),
                 mean(data$M9[data$Wave == 4]), mean(data$M9[data$Wave == 5]), mean(data$M9[data$Wave == 6]))
m10 <- rbind(mean(data$M10[data$Wave == 1]), mean(data$M10[data$Wave == 2]), mean(data$M10[data$Wave == 3]),
                 mean(data$M10[data$Wave == 4]), mean(data$M10[data$Wave == 5]), mean(data$M10[data$Wave == 6]))
m11 <- rbind(mean(data$M11[data$Wave == 1]), mean(data$M11[data$Wave == 2]), mean(data$M11[data$Wave == 3]),
                 mean(data$M11[data$Wave == 4]), mean(data$M11[data$Wave == 5]), mean(data$M11[data$Wave == 6]))
m12 <- rbind(mean(data$M12[data$Wave == 1]), mean(data$M12[data$Wave == 2]), mean(data$M12[data$Wave == 3]),
                  mean(data$M12[data$Wave == 4]), mean(data$M12[data$Wave == 5]), mean(data$M12[data$Wave == 6]))
wave <- cbind(m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12)
colnames(wave) <- paste("Month", 1:12)
rownames(wave) <- paste("Wave", 1:6)

wave = data.frame(wave)
cro(wave$Month.1)



# Plotting the data
plot(monthAVG,
     main = "Average visits per Month",
     xlab = "Months",
     ylab = "Average vists",
     ylim = c(0,8),
     pch = 15,
     col = "blue")
legend("topright",legend=c("Average across waves"),
       text.col=c("black"),pch=c(15),col=c("blue"), cex = 1.0)

par(mfrow=c(3,2))
plot(wave[1,],
     main = "Wave 1: Average visits per Month",
     xlab = "Months",
     ylab = "Average vists",
     pch = 15,
     col = "black")
legend("topright",legend=c("January = m12"),
       text.col=c("blue"),pch=c(17),col=c("black"))
plot(wave[2,],
     main = "Wave 2: Average visits per Month",
     xlab = "Months",
     ylab = "Average vists",
     pch = 15,
     col = "red")
legend("topright",legend=c("January = m8"),
       text.col=c("blue"),pch=c(17),col=c("red"))
plot(wave[3,],
     main = "Wave 3: Average visits per Month",
     xlab = "Months",
     ylab = "Average vists",
     pch = 15,
     col = "black")
legend("topright",legend=c("January = m12"),
       text.col=c("blue"),pch=c(17),col=c("black"))
plot(wave[4,],
     main = "Wave 4: Average visits per Month",
     xlab = "Months",
     ylab = "Average vists",
     pch = 15,
     col = "red")
legend("topright",legend=c("January = m8"),
       text.col=c("blue"),pch=c(17),col=c("red"))
plot(wave[5,],
     main = "Wave 5: Average visits per Month",
     xlab = "Months",
     ylab = "Average vists",
     pch = 15,
     col = "black")
legend("topright",legend=c("January = m12"),
       text.col=c("blue"),pch=c(17),col=c("black"))
plot(wave[6,],
     main = "Wave 6: Average visits per Month",
     xlab = "Months",
     ylab = "Average vists",
     pch = 15,
     col = "red")
legend("topright",legend=c("January = m8","Covid: M11 & M12"),
       text.col=c("blue"),pch=c(17),col=c("red"))


## Wider view

par(mfrow=c(2,3))
plot(wave[1,],
     main = "Wave 1: Average visits per Month",
     xlab = "Months",
     ylab = "Average vists",
     pch = 15,
     col = "black")
legend("topright",legend=c("January = m12"),
       text.col=c("blue"),pch=c(17),col=c("black"))
plot(wave[3,],
     main = "Wave 3: Average visits per Month",
     xlab = "Months",
     ylab = "Average vists",
     pch = 15,
     col = "black")
legend("topright",legend=c("January = m12"),
       text.col=c("blue"),pch=c(17),col=c("black"))
plot(wave[5,],
     main = "Wave 5: Average visits per Month",
     xlab = "Months",
     ylab = "Average vists",
     pch = 15,
     col = "black")
legend("topright",legend=c("January = m12"),
       text.col=c("blue"),pch=c(17),col=c("black"))
plot(wave[2,],
     main = "Wave 2: Average visits per Month",
     xlab = "Months",
     ylab = "Average vists",
     pch = 15,
     col = "red")
legend("topright",legend=c("January = m8"),
       text.col=c("blue"),pch=c(17),col=c("red"))
plot(wave[4,],
     main = "Wave 4: Average visits per Month",
     xlab = "Months",
     ylab = "Average vists",
     pch = 15,
     col = "red")
legend("topright",legend=c("January = m8"),
       text.col=c("blue"),pch=c(17),col=c("red"))
plot(wave[6,],
     main = "Wave 6: Average visits per Month",
     xlab = "Months",
     ylab = "Average vists",
     pch = 15,
     col = "red")
legend("topright",legend=c("January = m8","Covid: M11 & M12"),
       text.col=c("blue"),pch=c(17),col=c("red"))