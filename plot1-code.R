##assignment
#download file
setwd("C:\\Users\\vantr\\OneDrive\\Documents\\R\\tu hoc\\Exploratory Data Analysis")
downloadURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
downloadFile <- "C:\\Users\\vantr\\OneDrive\\Documents\\R\\tu hoc\\Exploratory Data Analysis\\household_power_consumption.zip"
householdFile <- "C:\\Users\\vantr\\OneDrive\\Documents\\R\\tu hoc\\Exploratory Data Analysis\\household_power_consumption.txt"
#check if file exist
if (!file.exists(householdFile)) {
  download.file(downloadURL, downloadFile, method = "curl")
  unzip(downloadFile, overwrite = T, exdir = "./Data")
}
# reading file
hh <- read.table("C:\\Users\\vantr\\OneDrive\\Documents\\R\\tu hoc\\Exploratory Data Analysis\\household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
# converting the Date and Time variables to Date/Time 
hh$Date <- as.Date(hh$Date,"%d/%m/%Y")

# Setting date 1/2/2007 to 2/2/2007
hh <- subset(hh,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

# Removing incomplete observations
hh <- hh[complete.cases(hh),]

# Combining Date and Time column
dateTime <- paste(hh$Date, hh$Time)

# Setting the vector's name
dateTime <- setNames(dateTime, "DateTime")

# Removing Date and Time column
hh <- hh[ ,!(names(hh) %in% c("Date","Time"))]

# Adding dateTime column
hh <- cbind(dateTime, hh)

# Formatting dateTime Column
hh$dateTime <- as.POSIXct(dateTime)

#Plot 1
hist(hh$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

#Save it o PNG file
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()