file.name <- "household_power_consumption.txt"
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destination <- "Electric power consumption.zip"
download.file(url, destfile = destination, mode = "wb")
unzip(destination)
df <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")
df <- subset(df, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
df$Global_reactive_power <- as.numeric(df$Global_reactive_power)
df$datetime <- paste(df$Date, df$Time)
df$datetime <- as.POSIXct(df$datetime, format = "%Y-%m-%d %H:%M:%S")
df$Global_reactive_power <- as.numeric(df$Global_reactive_power)
df$day_of_week <- format(df$datetime, "%a")
png(file = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(df, {
  plot(Global_active_power~datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="", xaxt="n")
  plot(Voltage~datetime, type="l", 
       ylab="Voltage (volt)", xlab="", xaxt="n")
  plot(Sub_metering_1~datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="", xaxt="n")
  lines(Sub_metering_2~datetime,col='Red')
  lines(Sub_metering_3~datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~datetime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="", xaxt="n")
  axis(1, at = df$datetime, labels = df$day_of_week)
})
dev.off()