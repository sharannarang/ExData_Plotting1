## Load the sqldf package
require(sqldf)

## Read the dataset only for the required dates
power_df <- read.csv2.sql("household_power_consumption.txt", 
                          sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'",
                          na.strings="?")

## Merge Date and Time to create a new datetime object
power_df$datetime <- strptime(paste(power_df$Date,power_df$Time), format="%d/%m/%Y %H:%M:%S")

## Open a PNG graphics device
png("plot4.png")

## Setup the mfrow arguement
par(mfrow=c(2,2))

## Create the first plot
with(power_df, plot(datetime,Global_active_power,type="l", xlab="",ylab="Global Active Power"))

## Second plot
with(power_df, plot(datetime,Voltage,type="l"))

## Third plot
with(power_df, 
{plot(datetime,Sub_metering_1, type="n", ylab="", xlab="")
 lines(datetime, Sub_metering_1)
 lines(datetime, Sub_metering_2, col="red")
 lines(datetime, Sub_metering_3, col="blue")
 title(ylab="Energy sub metering")
 legend("topright", 
        legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
        lty = c(1,1,1), 
        col = c("black","red","blue"),
        bty='n')})

with(power_df, plot(datetime,Global_reactive_power,type="l"))

## Close the device
dev.off()