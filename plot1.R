file.name <- "household_power_consumption.txt"
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destination <- "Electric power consumption.zip"
download.file(url, destfile = destination, mode = "wb")
unzip(destination)
df <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")
df <- subset(df, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
df$Global_reactive_power <- as.numeric(df$Global_reactive_power)
png(file = "plot1.png", width = 480, height = 480, units = "px")
hist(df$Global_reactive_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()