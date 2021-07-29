"""Our overall goal here is simply to examine how household energy usage varies over a 2-day period in February, 2007. Your task is to reconstruct the following plots below, all of which were constructed using the base plotting system.

First you will need to fork and clone the following GitHub repository: https://github.com/rdpeng/ExData_Plotting1

For each plot you should

  Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.

  Name each of the plot files as plot1.png, plot2.png, etc.

  Create a separate R code file (plot1.R, plot2.R, etc.) that constructs the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot. Your code file should include code for reading the data so that the plot can be fully reproduced. You should also include the code that creates the PNG file.

  Add the PNG file and R code file to your git repository

When you are finished with the assignment, push your git repository to GitHub so that the GitHub version of your repository is up to date. There should be four PNG files and four R code files."""

df <- read.delim("household_power_consumption.txt", sep = ";") #load file from local drive

#convert .txt to .csv
install.packages("rio")
library("rio")

export(df, "household_power_consumption.csv")

#write.csv(iris, "iris.csv", quote = FALSE, row.names = FALSE)
df <- read.csv.sql("household_power_consumption.csv", 
                      sql = "select * from file where Date = '02/01/2007' OR Date = '02/02/2007") #conditiona clause NOT limiting rows loaded
summary(df)

head(df)

""" Produces? :

Date     Time Global_active_power Global_reactive_power Voltage Global_intensity Sub_metering_1 Sub_metering_2
1 16/12/2006 17:24:00               4.216                 0.418 234.840           18.400          0.000          1.000
2 16/12/2006 17:25:00               5.360                 0.436 233.630           23.000          0.000          1.000
3 16/12/2006 17:26:00               5.374                 0.498 233.290           23.000          0.000          2.000
4 16/12/2006 17:27:00               5.388                 0.502 233.740           23.000          0.000          1.000
5 16/12/2006 17:28:00               3.666                 0.528 235.680           15.800          0.000          1.000
6 16/12/2006 17:29:00               3.520                 0.522 235.020           15.000          0.000          2.000
  Sub_metering_3
1             17
2             16
3             17
4             17
5             17
6             17"""

######################################################################################################################################

df[is.na(df)] <- 0 #replace NAs with 0s
any(is.na(df)) # check for any NAs remaining - should return False
class(df$Global_active_power) = "Numeric" #change class of Global_active_power column from character to numeric
df$Time <- strptime(df$Time, format = "%H:%M:%S") #change formatting of Time column from character to DateTime and specify format
df$datetime <- df$Date + df$Time



df$Global_active_power <- rnorm(2075259) #fake data to test plotting


png(filename = "Rplot1.png",
    width = 480, height = 480, units = "px", pointsize = 12) #open png graphics device
hist(df$Global_active_power, col="dark orange", main="Global Active Power", ylab="Frequency", xlab="Global Active Power (kilowatts)")
dev.off() #close png graphics device

#Plot number 2

png(filename = "Rplot2.png",
    width = 480, height = 480, units = "px", pointsize = 12) 
df$Global_active_power <-rnorm(2075259)
plot(df$Global_active_power, df$Time, ylab="Global Active Power (kilowatts")

#Plot number 3 - submetering

df$Sub_metering_1 <-rnorm(2075259)
df$Sub_metering_2 <-rnorm(2075259)
df$Sub_metering_3 <-rnorm(2075259)

png(filename = "Rplot3.png",
    width = 480, height = 480, units = "px", pointsize = 12) 
plot(df$Sub_metering_1, col = "black")
plot(df$Sub_metering_2, col = "red")
plot(df$Sub_metering_3, col = "blue", ylab = "Energy sub metering")

#Plot number 4
png(filename = "Rplot4.png",
    width = 480, height = 480, units = "px", pointsize = 12) 
par(mfrow=c(2,2))
