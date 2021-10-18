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

library(lubridate)

df$Date <- lubridate::dmy(df$Date)
head(df)

df$DT <- lubridate::as_datetime(paste(df$Date, df$Time, sep=" "))
head(df)


#limit to relevant dates

df_limited <- dplyr::filter(df, Date == "2007-02-01" | Date == "2007-02-02")


print(nrow(df_limited))
print(head(df_limited))

df[is.na(df)] <- 0 #replace NAs with 0s
any(is.na(df)) # check for any NAs remaining - should return False

df$Global_active_power<-as.numeric(df$Global_active_power) #"Numeric" #change class of Global_active_power column from character to numeric
df$Global_reactive_power<-as.numeric(df$Global_reactive_power)
df$Sub_metering_1<-as.numeric(df$Sub_metering_1)
df$Sub_metering_2<-as.numeric(df$Sub_metering_2)
df$Sub_metering_3<-as.numeric(df$Sub_metering_3)

write.csv(df,"household_power_consumption.csv", row.names = TRUE)
print(summary(df))

#create plot
png("Rplot1.png",width = 480, height = 480, units = "px", pointsize = 12)

myplot<-
  ggplot(data=df, mapping=aes(x=Global_active_power ))+
geom_histogram(color="orange", fill="dark orange")+
  ylab("Frequency")+
  xlab("Global active power (kilowatts)")

#save as .png 480 x 480

print(myplot)
dev.off()
