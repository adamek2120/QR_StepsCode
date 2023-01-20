
##### Visits Data #####
# Read in Visits data
setwd("C:/Users/jadamek2/Desktop/LAB_NUC/Visits_QR_data/Visits")
wave1_v <- read.csv("wave1_final.csv")
wave2_v <- read.csv("wave2_final.csv")
wave3_v <- read.csv("wave3_final.csv")
wave4_v <- read.csv("wave4_final.csv")
wave5_v <- read.csv("wave5_final.csv")
wave6_v <- read.csv("wave6_final.csv")
# Adds column indicating wave
wave1_v$wave <- rep(1, nrow(wave1_v))
wave2_v$wave <- rep(2, nrow(wave2_v))
wave3_v$wave <- rep(3, nrow(wave3_v))
wave4_v$wave <- rep(4, nrow(wave4_v))
wave5_v$wave <- rep(5, nrow(wave5_v))
wave6_v$wave <- rep(6, nrow(wave6_v))
# Selects columns of interest
wave1_v <- wave1_v[c(3,6,2,5)]
wave2_v <- wave2_v[c(3,6,2,5)]
wave3_v <- wave3_v[c(3,6,2,5)]
wave4_v <- wave4_v[c(3,6,2,5)]
wave5_v <- wave5_v[c(3,6,2,5)]
wave6_v <- wave6_v[c(3,6,2,5)]
# Merges all the waves into a single dataset
visit_master <- rbind(wave1_v, wave2_v, wave3_v, wave4_v, wave5_v, wave6_v)
colnames(visit_master)[4] <- "Keyswipe"  # Changes pricing.option column to keyswipes
visit_master$Keyswipe <- "1"             # Give a value 1 to all valid swipes in dataset

##### QR Data #####
# Read in QR data - for dates
setwd("C:/Users/jadamek2/Desktop/LAB_NUC/Visits_QR_data/QR_data/QR_Cleaned_Processed_Files")
data <- read.csv("QR_CorrectDate.csv")
data <- data[c(1, 10)]

# Read in QR master cleaned 
setwd("C:/Users/jadamek2/Desktop/LAB_NUC/Visits_QR_data/QR_data")
class_clean <- read.csv("QR_master_class_cleaned.csv")

# Merge date format into QR file
qr_merg <- merge(class_clean, data, by.x = "run", by.y = "Run")
qr_master <- qr_merg[c(2,3,20,4)]
colnames(qr_master)[3] <- "Date"
qr_master$Class <- "1"  # Give a value 1 to all valid class attendence in dataset
##### Merging Visits and QR Data #####
final_merged <- merge(qr_master, visit_master, by = c("ID", "Date"), all = TRUE)
final_merged <- final_merged[c(1,3,2,4,5,6)]
setwd("C:/Users/jadamek2/Desktop/LAB_NUC/Visits_QR_data")
write.csv(final_merged, "Final_merged_raw.csv")

##### Aggregating #####

# Get Data
setwd("S:/LAB_Documents/Visits_QR_data")
merg <- read.csv("Final_merged.csv")

# The Below codes aggregates Class and keyswipes
merg_select <- merg[-c(2,3)]                          # Makes dataframe of just the ID's class and keyswipe
merg_select <- aggregate(.~ID, merg_select, sum)               
merg_select$Total_Combined <- rowSums(merg_select[-1])            # This [-1] is to make sure the ID # isn't summed as well

#Waves's
wave1 <- c(100,	101,	102,	103,	104,	105,	106,	107,	108,	109,	110,	111,	112,	113,	114,	115,	116,	117,	118,	120,	121,	122,	123,
           124,	125,	126,	127,	128,	129,	131,	132,	134,	135,	136,	137,	139,	141,	142,	143,	146,	147,	150,	151,	152,	153,	155,
           157,	158,	161,	162)
wave2 <- c(133, 138,  144,  149,  154,  156,  159,  160,  167,  168,  169,  170,  171,  172,  173,  174,  175,  176,  177,  178,  179,  181,  182,
           183, 184,  185,  186,  187,  188,  189,  190,  191,  192,  193,  194,  195,  196,  197,  198,  199,  200,  201,  202,  204,  205,  206)
wave3 <- c(207, 208,  209,  210,  211,  212,  213,  215,  216,  217,  218,  219,  220,  221,  222,  223,  224,  225,  226,  227,  229,  230,  231,
           232, 233,  234,  237,  238,  239,  240,  241,  242,  243,  244,  245,  247,  248,  249,  250,  251,  252,  253,  254,  255,  256,  257, 
           258)
wave4 <- c(214,	259,	260,	261,	262,	263,	264,	265,	266,	267,	268,	269,	271,	273,	274,	275,	277,	278,	279,	280,	281,	282,	283,
           284,	285,	287,	288,	289,	291)
wave5 <- c(292,	293,	294,	295,	296,	297,	298,	299,	300,	301,	302,	303,	304,	305,	306,	307,	308,	309,	310,	311,	312,	313,	314)
wave6 <- c(316,	317,	318,	319,	321,	322,	323,	324,	325,	326,	327,	328,	329,	330,	331,	332,	333,	334,	335,	336,	338,	339,	341,
           342,	343,  344,	345,	347,	348,	349,	350,	351,	353,	354,	355,	356,	357,	358)


#Identifing waves again
merg_select$wave[merg_select$ID %in% wave1] <- 1
merg_select$wave[merg_select$ID %in% wave2] <- 2
merg_select$wave[merg_select$ID %in% wave3] <- 3
merg_select$wave[merg_select$ID %in% wave4] <- 4
merg_select$wave[merg_select$ID %in% wave5] <- 5
merg_select$wave[merg_select$ID %in% wave6] <- 6

merg_select <- merg_select[c(1,5,2,3,4)]

write.csv(merg_select, "Complete_Merged.csv")


