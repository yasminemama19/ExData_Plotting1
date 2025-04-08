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
png(file = "plot3.png", width = 480, height = 480, units = "px")
# Si t est un data frame, par exemple df, remplace 't' par le bon nom de ton data frame
plot(df$Sub_metering_1 ~ df$datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="", xaxt="n")
lines(df$Sub_metering_2 ~ df$datetime, col='Red')
lines(df$Sub_metering_3 ~ df$datetime, col='Blue')
axis(1, at = c(df$datetime[1], df$datetime[1441], df$datetime[2880]), labels = c("Thu", "Fri", "Sat"))

# Ajouter la légende
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
