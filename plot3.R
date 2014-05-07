## Load the sqldf package
require(sqldf)

## Read the dataset only for the required dates
power_df <- read.csv2.sql("household_power_consumption.txt", 
                          sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'",
                          na.strings="?")

## Merge Date and Time to create a new datetime object
power_df$DateTime <- strptime(paste(power_df$Date,power_df$Time), format="%d/%m/%Y %H:%M:%S")

## Open a PNG graphics device
png("plot3.png")

## Create the sub metering plots. 
with(power_df, 
     {plot(DateTime,Sub_metering_1, type="n", ylab="", xlab="")
     lines(DateTime, Sub_metering_1)
     lines(DateTime, Sub_metering_2, col="red")
     lines(DateTime, Sub_metering_3, col="blue")
     title(ylab="Energy sub metering")
     legend("topright", 
            legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
            lty = c(1,1,1), 
            col = c("black","red","blue"))})

## Close the device
dev.off()