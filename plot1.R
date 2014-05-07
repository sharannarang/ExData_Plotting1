## Load the sqldf package
require(sqldf)

## Read the dataset only for the required dates
power_df <- read.csv2.sql("household_power_consumption.txt", sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'")

## Open a PNG graphics device
png("plot1.png", bg="transparent")

## Plot the histogram with correct labels.
with(power_df, hist(Global_active_power, xlab="Global Active Power (kilowatts)", main="Global Active Power", col="Red", ylim=c(0,1200)))

## Close the PNG device
dev.off()