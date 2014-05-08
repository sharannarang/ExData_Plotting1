## Load the sqldf package
require(sqldf)

## Read the dataset only for the required dates
power_df <- read.csv2.sql("household_power_consumption.txt", 
                          sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'",
                          na.strings="?")

## Merge Date and Time to create a new datetime object
power_df$datetime <- strptime(paste(power_df$Date,power_df$Time), format="%d/%m/%Y %H:%M:%S")

## Open a PNG graphics device
png("plot2.png")

## Create plot with lines
with(power_df, plot(datetime,Global_active_power,type="l", xlab="",ylab="Global Active Power (kilowatts)"))

## Close the device
dev.off()