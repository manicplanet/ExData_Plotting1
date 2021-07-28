file <- read.delim("household_power_consumption.txt", sep = ";") #load file from local drive
df <- subset(file[file$Date >= "02/01/2007" & file$Date <= "02/02/2007"]) 
head(df)
df[is.na(df)] <- 0 #replace NAs with 0s
any(is.na(df)) # check for any NAs remaining - should return False
class(df$Global_active_power) = "Numeric" #change class of Global_active_power column from character to numeric
df$Time <- strptime(df$Time, format = "%H:%M:%S") #change formatting of Time column from character to DateTime and specify format


