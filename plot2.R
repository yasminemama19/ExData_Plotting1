file.name <- "household_power_consumption.txt"
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destination <- "Electric power consumption.zip"
download.file(url, destfile = destination, mode = "wb")
unzip(destination)
df <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
df[df == "?"] <- NA
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")
df <- subset(df, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))
df$datetime <- paste(df$Date, df$Time)
df$datetime <- as.POSIXct(df$datetime, format = "%Y-%m-%d %H:%M:%S")
df$Global_active_power <- as.numeric(df$Global_active_power)
png(file = "plot2.png", width = 480, height = 480, units = "px")
plot(df$datetime,df$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="", xaxt="n")
axis(1, at = c(df$datetime[1], df$datetime[1441], df$datetime[2880]), labels = c("Thu", "Fri", "Sat"))
lines(df$datetime,df$Global_active_power, col = "black")
dev.off()
