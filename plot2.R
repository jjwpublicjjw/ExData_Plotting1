#----------------------------------------------
# read input data
#
# Note: assumes that input data file is named
# household_power_consumption.txt and resides
# in the current working directory
#----------------------------------------------

#-----
# read and return all data file contents 
#-----
readData <- function(){
  read.table(
    './household_power_consumption.txt',
    header = TRUE, 
    sep = ";",
    na.strings = "?")
}

#-----
# add Date and POSIXlt columns to data by 
# converting existing character data
#  Date column name: 'Date_converted'
#  POSIXlt column name: 'DateTime'
#-----
preprocessData <- function(data){
  characterDates <- as.character(data$Date)
  characterTimes <- as.character(data$Time)
  characterDateTimes <- paste(characterDates, characterTimes)
  
  dateFormat <- '%d/%m/%Y'
  timeFormat <- '%H:%M:%S'
  dateTimeFormat <- paste(dateFormat, timeFormat)
  
  data$Date_converted <- as.Date(characterDates, dateFormat)
  data$DateTime <- strptime(characterDateTimes, dateTimeFormat)
  data
}

#-----
# subset data based on target dates
#-----
subsetData <- function(data){
  firstDate <- as.Date('2007-02-01')
  lastDate <- as.Date('2007-02-02')
  data[(data$Date_converted >= earlyDate & data$Date_converted <= lateDate), ]
}

data <- readData()
data <- preprocessData(data)
data <- subsetData(data)

#----------------------------------------------
# create and save plot
#----------------------------------------------

png(file = 'plot2.png', width = 480, height = 480)

plot(data$DateTime, 
     data$Global_active_power, 
     xlab = '', 
     ylab = 'Global Active Power (kilowatts)', 
     pch = '')

lines(data$DateTime, data$Global_active_power)

dev.off()
