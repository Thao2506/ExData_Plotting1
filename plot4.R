
data <- read.table("household_power_consumption.txt", 
                   header=TRUE, sep=";", na.strings="?", 
                   stringsAsFactors=FALSE)

data$Date <- as.Date(data$Date, format="%d/%m/%Y")

subset_data <- subset(data, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

datetime <- strptime(paste(subset_data$Date, subset_data$Time), 
                     format="%Y-%m-%d %H:%M:%S")

png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))

# Top-left
plot(datetime, subset_data$Global_active_power, type="l", 
     xlab="", ylab="Global Active Power")

# Top-right
plot(datetime, subset_data$Voltage, type="l", 
     xlab="datetime", ylab="Voltage")

# Bottom-left
plot(datetime, subset_data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(datetime, subset_data$Sub_metering_2, col="red")
lines(datetime, subset_data$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1, bty="n")

# Bottom-right
plot(datetime, subset_data$Global_reactive_power, type="l", 
     xlab="datetime", ylab="Global_reactive_power")

dev.off()
