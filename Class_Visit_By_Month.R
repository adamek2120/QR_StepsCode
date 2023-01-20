# Library
library(tidyverse)

##### Aggregating #####

# Get Data
setwd("S:/LAB_Documents/Befit_Data_Processing/Visits_QR_data")
merg <- read_csv("Final_merged.csv")
head(merg)
head(merg_1)

# Split Date column into month, day, year
merg_1 <- separate(merg, Date, into=c("Month","Day", "year"), sep = "/")

# Create's unique class and keyswipe
merg_1 <- merg_1 %>% 
  mutate(
    unique_class = ifelse(Class == 1 & Keyswipe == 0, 1, 0),
    unique_keyswipe = ifelse(Class == 0 & Keyswipe == 1, 1, 0))

# Changes month # to appropriate month according to wave
merg_1_odd <- merg_1 %>% 
  filter(Wave == 1 | Wave == 3 | Wave == 5) %>% 
  mutate(Month=recode(Month, '2' = 'Month1', '3' = 'Month2', '4' = 'Month3', '5' = 'Month4', '6' = 'Month5', '7' = 'Month6', '8' = 'Month7',
                      '9' = 'Month8', '10' = 'Month9', '11' = 'Month10', '12' = 'Month11', '1' = 'Month12'))
merg_1_even <- merg_1 %>% 
  filter(Wave == 2 | Wave == 4 | Wave == 6) %>% 
  mutate(Month=recode(Month, '6' = 'Month1', '7' = 'Month2', '8' = 'Month3', '9' = 'Month4', '10' = 'Month5', '11' = 'Month6', '12' = 'Month7',
                      '1' = 'Month8', '2' = 'Month9', '3' = 'Month10', '4' = 'Month11', '5' = 'Month12'))

merg_comb <- rbind(merg_1_odd, merg_1_even)

# The Below codes aggregates Class, keyswipes, unique_class, and unique_keyswipe
Class <- merg_comb %>% 
  select(ID, Month, Class) %>% 
  pivot_wider(names_from = Month, values_from = Class, values_fn = sum) %>% 
  rename(Month1C = 'Month1', Month2C = 'Month2', Month3C = 'Month3', Month4C = 'Month4', Month5C = 'Month5', Month6C = 'Month6',
         Month7C = 'Month7', Month8C = 'Month8', Month9C = 'Month9', Month10C = 'Month10', Month11C = 'Month11', Month12C = 'Month12')
  
Keyswipe <- merg_comb %>% 
  select(ID, Month, Keyswipe) %>% 
  pivot_wider(names_from = Month, values_from = Keyswipe, values_fn = sum) %>% 
  rename(Month1K = 'Month1', Month2K = 'Month2', Month3K = 'Month3', Month4K = 'Month4', Month5K = 'Month5', Month6K = 'Month6',
         Month7K = 'Month7', Month8K = 'Month8', Month9K = 'Month9', Month10K = 'Month10', Month11K = 'Month11', Month12K = 'Month12')

Unique_C <- merg_comb %>% 
  select(ID, Month, unique_class) %>% 
  pivot_wider(names_from = Month, values_from = unique_class, values_fn = sum) %>% 
  rename(Month1UC = 'Month1', Month2UC = 'Month2', Month3UC = 'Month3', Month4UC = 'Month4', Month5UC = 'Month5', Month6UC = 'Month6',
         Month7UC = 'Month7', Month8UC = 'Month8', Month9UC = 'Month9', Month10UC = 'Month10', Month11UC = 'Month11', Month12UC = 'Month12')

Unique_K <- merg_comb %>% 
  select(ID, Month, unique_keyswipe) %>% 
  pivot_wider(names_from = Month, values_from = unique_keyswipe, values_fn = sum) %>% 
  rename(Month1UK = 'Month1', Month2UK = 'Month2', Month3UK = 'Month3', Month4UK = 'Month4', Month5UK = 'Month5', Month6UK = 'Month6',
         Month7UK = 'Month7', Month8UK = 'Month8', Month9UK = 'Month9', Month10UK = 'Month10', Month11UK = 'Month11', Month12UK = 'Month12')

# Combine all files into one
Final <- Class %>% 
  left_join(Keyswipe, by = 'ID') %>% 
  left_join(Unique_C, by = 'ID') %>% 
  left_join(Unique_K, by = 'ID')

Final <- Final %>% 
  mutate(Month1U_CK = Month1UC + Month1UK,
         Month2U_CK = Month2UC + Month2UK,
         Month3U_CK = Month3UC + Month3UK,
         Month4U_CK = Month4UC + Month4UK,
         Month5U_CK = Month5UC + Month5UK,
         Month6U_CK = Month6UC + Month6UK,
         Month7U_CK = Month7UC + Month7UK,
         Month8U_CK = Month8UC + Month8UK,
         Month9U_CK = Month9UC + Month9UK,
         Month10U_CK = Month10UC + Month10UK,
         Month11U_CK = Month11UC + Month11UK,
         Month12U_CK = Month12UC + Month12UK)

# Save as csv
write_csv(Final, "Class_Visit_By_Month.csv", na = '-999')
