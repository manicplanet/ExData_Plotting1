install.packages("tidyr")
library(tidyverse)
install.packages("readr")
library(readr)
install.packages("rio")
library(rio)
install.packages("sqldf")
library(sqldf)
install.packages("lubridate")
library(lubridate)
install.packages("ggplot2")
library(ggplot2)
install.packages("magrittr")
library(magrittr)
install.packages("patchwork")
library(patchwork)
install.packages("dplyr")
library(dplyr)

df <-data.frame()
df <- read.delim("household_power_consumption.txt", sep = ";") #load file from local drive

df <- within(df, rm(Voltage, Global_intensity))
df<-tibble::as_tibble(df)
print(head(df,10))

df$Date <- lubridate::dmy(df$Date)
head(df)

df$DT <- lubridate::as_datetime(paste(df$Date, df$Time, sep=" "))
head(df)

#limit to relevant dates
print("number of rows of df:")
print(nrow(df))
df_limited <- dplyr::filter(df, Date == "2007-02-01" | Date == "2007-02-02")
print("number of rows of df_limited:")

print(nrow(df_limited))
print(head(df_limited))

df[is.na(df)] <- 0 #replace NAs with 0s
any(is.na(df)) # check for any NAs remaining - should return False

df$Global_active_power<-as.numeric(df$Global_active_power) #"Numeric" #change class of Global_active_power column from character to numeric
df$Global_reactive_power<-as.numeric(df$Global_reactive_power)
df$Sub_metering_1<-as.numeric(df$Sub_metering_1)
df$Sub_metering_2<-as.numeric(df$Sub_metering_2)
df$Sub_metering_3<-as.numeric(df$Sub_metering_3)
print(head(df,10))

#convert .txt to .csv

write.csv(df,"household_power_consumption.csv", row.names = TRUE)

png(filename = "Rplot5.png", width = 480, height = 480, units = "px", pointsize = 12) 

myplot5<-
myplot + myplot2 + myplot3 + myplot4

#myplot5

print(myplot5)
dev.off()
