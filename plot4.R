require(dplyr)

data_file <- tempfile()

download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
              destfile = data_file)

data_file <- unzip(zipfile = data_file)

data <- read.table(data_file, header = TRUE, sep = ";", stringsAsFactors = FALSE)

rm(data_file)

data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

data <- filter(data, Date >= "2007-02-01" & Date <= "2007-02-02")

data$Time <- as.POSIXct(strptime(
        paste(data$Date, data$Time),
        format = "%Y-%m-%d %H:%M:%S"))

png("plot4.png", width=480, height=480)

par(mfrow = c(2, 2))

with(data,
     plot(Global_active_power~Time,
          ylab = "Global Active Power",
          xlab = "",
          type = "l"))

with(data,
     plot(Voltage~Time,
          ylab = "Voltage",
          xlab = "datetime",
          type = "l"))

with(data,
     plot(as.numeric(Sub_metering_1)~Time,
          ylab = "Energy sub metering",
          xlab = "",
          type = "l"))

lines(as.numeric(data$Sub_metering_2)~data$Time,
      col = "red")

lines(as.numeric(data$Sub_metering_3)~data$Time,
      col = "blue")

legend("topright",
       lty = 1,
       lwd = 2,
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

with(data,
     plot(Global_reactive_power~Time,
          xlab = "datetime",
          type = "l"))

dev.off()
