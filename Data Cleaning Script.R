#School Levy Analysis 
#Based on Kotchen-Powers
#AEDE 2021 - Nick Messenger
install.packages("tidyverse", "lubridate")
library(tidyverse)
library(lubridate)

#Data Frame
levy <- as.data.frame(read.csv("SchoolLevyRaw.csv"))
levy <- levy %>%
  mutate(turnout = For + Against) 

#Extract the year of the levy from the election date.
levy <- levy %>%
  mutate(Year = format(as.Date(Date, format="%d/%m/%Y"),"%Y")) 
levy$Year <- as.character(levy$Year)
levy$Year[levy$Year== "0014"] <- "2014"
levy$Year[levy$Year== "0015"] <- "2015"
levy$Year[levy$Year== "0016"] <- "2016"
levy$Year[levy$Year== "0017"] <- "2017"
levy$Year[levy$Year== "0018"] <- "2018"
levy$Year <- as.factor(levy$Year)

#Create Year Dummy Variables (2014, 2015, 2016, 2017 to avoid multicollinearity)
levy$Y14 <- ifelse(levy$Year == '2014', 1, 0)
levy$Y15 <- ifelse(levy$Year == '2015', 1, 0)
levy$Y16 <- ifelse(levy$Year == '2016', 1, 0)
levy$Y17 <- ifelse(levy$Year == '2017', 1, 0)

#Extract the month of the levy from the election date & create a dummy variable
#if the election occurred in November (General Election)
levy <- levy %>%
  mutate(Month = format(as.Date(Date, format="%m/%d/%Y"),"%m")) 
levy$gen_elec <- ifelse(levy$Month == '11', 1,0)
