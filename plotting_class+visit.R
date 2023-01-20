# Pulling in and preparing the VISITS and CLASS data for plotting
## Visits data
setwd("C:/Users/jadamek2/Desktop/LAB_NUC/Visit_data")
data <- read_excel("Befit_visitdata_MASTER.xlsx")
data <- data[-15]
data[data == -999] <- NA
working <- data[3:14]
working[working == -999] <- NA
working$Total_YTD <- rowSums(working, na.rm = TRUE)
monthAVG <- colMeans(working, na.rm = TRUE)
monthAVG <- monthAVG[-13]
##Class data
setwd("C:/Users/jadamek2/Desktop/LAB_NUC/QR_data")
datac <- read.csv("QR_master.csv")
datac <- datac[, -c(1,2,3,16)]
monthAVGc <- colMeans(datac, na.rm = TRUE)


# Plot
par(mar = c(5, 4, 4, 6))
plot(monthAVG,
     ylab = "",
     xlab = "",
     main = "Averge Month Visits + Class Attendence",
     pch = 17,
     type = "b",
     col = "blue",
     axes = FALSE)
mtext("Visits", side = 2 , line = 2.5)
box()
par(new=TRUE)
plot(monthAVGc,
     xlab = "",
     ylab = "",
     pch = 18,
     type = "b",
     col ="orangered",
     axes = FALSE)
mtext("Classes", side = 4, col="orangered", line = 2.5)
axis(1, 1:12)
mtext("Models (1 - 12)", side=1, col="black", line =2.5)
legend("topright",legend=c("Visits","Classes"),
       text.col=c("blue","orangered"),pch=c(17,18),col=c("blue", "orangered"), cex = 0.75)