
library(data.table,dplyr)
# Download and unzip dataset

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(url, dest=temp, mode="wb") 
if (!file.exists("household_power_consumption.txt")){
  unzip (temp, exdir = "./")
}
unlink(temp)

path <- getwd()

# Read in data and subset only for two days 2007-02-01 and 2007-02-02
dt <- fread(file.path(path, "household_power_consumption.txt"),sep=";",na.strings="?",header=TRUE,
            stringsAsFactors=FALSE)
dt <- filter(dt,Date %in% c("1/2/2007","2/2/2007"))
dt$DateTime <- paste(dt$Date, dt$Time)
dt$DateTime <- as.POSIXlt(dt$DateTime,format="%d/%m/%Y %H:%M:%S")

# Plot 4
png("plot4.png",width=480,height=480)
par(mfrow=c(2,2))
plot(dt$DateTime, dt$Global_active_power, xlab=NA, ylab="Global Active Power", type="l")

plot(dt$DateTime, dt$Voltage, xlab="datetime", ylab="Voltage", type="l")

plot(dt$DateTime, dt$Sub_metering_1, type="l", xlab=NA, ylab="Energy sub metering")
lines(dt$DateTime, dt$Sub_metering_2, col="red")
lines(dt$DateTime, dt$Sub_metering_3, col="blue")
legend("topright",lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

plot(dt$DateTime, dt$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="l")

dev.off()
