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

png("plot1.png", width=480, height=480)

with(data, 
     hist(as.numeric(Global_active_power),
          col = "red",
          main = "Global Active Power",
          xlab = "Global Active Power (kilowatts)"))

dev.off()
