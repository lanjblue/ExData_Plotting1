
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

# Read in data and only subset for only for only two days 2007-02-01 and 2007-02-02
dt <- fread(file.path(path, "household_power_consumption.txt"),sep=";",na.strings="?",header=TRUE,
            stringsAsFactors=FALSE)
dt <- filter(dt,Date %in% c("1/2/2007","2/2/2007"))
dt$DateTime <- paste(dt$Date, dt$Time)
dt$DateTime <- as.POSIXlt(dt$DateTime,format="%d/%m/%Y %H:%M:%S")

# Plot 2 - 
png("plot2.png",width=480,height=480)
plot(dt$DateTime, dt$Global_active_power, type="l", xlab=NA, ylab="Global Active Power (kilowatts)")
dev.off()
