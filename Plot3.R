
#install.packages("tidyr")
#library(tidyverse)
#install.packages("readr")
#library(readr)
#install.packages("rio")
#library(rio)
#install.packages("sqldf")
#library(sqldf)
#install.packages("lubridate")
#library(lubridate)
#install.packages("ggplot2")
#library(ggplot2)
#install.packages("magrittr")
#library(magrittr)
#install.packages("patchwork")
#library(patchwork)
library(dplyr)
library(lubridate)


df <-data.frame()
df <- read.delim("household_power_consumption.txt", sep = ";") #load file from local drive

df <- within(df, rm(Voltage, Global_intensity))
df<-tibble::as_tibble(df)
df$Date <- lubridate::dmy(df$Date)
df$DT <- lubridate::as_datetime(paste(df$Date, df$Time, sep=" "))

#limit to relevant dates
df_limited <- dplyr::filter(df, Date == "2007-02-01" | Date == "2007-02-02")

df[is.na(df)] <- 0 #replace NAs with 0s
any(is.na(df)) # check for any NAs remaining - should return False

df$Global_active_power<-as.numeric(df$Global_active_power) #"Numeric" #change class of Global_active_power column from character to numeric
df$Global_reactive_power<-as.numeric(df$Global_reactive_power)
df$Sub_metering_1<-as.numeric(df$Sub_metering_1)
df$Sub_metering_2<-as.numeric(df$Sub_metering_2)
df$Sub_metering_3<-as.numeric(df$Sub_metering_3)
print(head(df,10))

#Plot
png("Rplot3.png", width = 480, height = 480, units = "px", pointsize = 12) 

myplot3 <- 
  ggplot(data=df_limited)+
  geom_line(mapping=aes(x=DT, y = Sub_metering_1, color = "black"))+
  geom_line(mapping=aes(x=DT, y = Sub_metering_2, color = "red"))+              
  geom_line(mapping=aes(x=DT, y = Sub_metering_3, color = "blue"))+
  labs(color="")+
  scale_color_manual(values=c("black","blue","red"))
print(myplot3)
dev.off()

