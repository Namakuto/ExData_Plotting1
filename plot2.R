
# This script will create a line plot of the variable "Global Active Power" over
# 2 days, from an Excel-converted "household_power_consumption" spreadsheet (saved
# as .csv). The plot is then exported as a .png image.


data<-read.csv("household_power_consumption.csv", header=TRUE)

num<-as.numeric(as.character(data$Global_active_power)) # Variable conversions
date<-as.Date(data$Date, format="%d/%m/%Y")
newtime<-as.POSIXct(paste(date,data$Time), format="%Y-%m-%d %H:%M:%S")

newframe2<-data.frame(newtime,num) # Subset from clean data frame

# Thursday, Friday, Saturday
days<-subset(newtime, newtime>=as.POSIXlt('2007-02-01 00:00:00') & newtime<=as.POSIXlt('2007-02-02 23:59:00'))

picknum2<-subset(newframe2, newtime>=as.POSIXlt('2007-02-01 00:00:00') & newtime<=as.POSIXlt('2007-02-02 23:59:00'), num)


library(datasets)
png(file="plot2.png", height=480, width=480)
plot(picknum2$num~days, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()
