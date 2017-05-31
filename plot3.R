# This script will create a multi-lined plot of "Sub_metering" variables over
# 2 days, from an Excel-converted "household_power_consumption" spreadsheet (saved
# as .csv). The plot is exported as a .png image.


data<-read.csv("household_power_consumption.csv", header=TRUE)

sm1<-as.numeric(as.character(data$Sub_metering_1))
sm2<-as.numeric(as.character(data$Sub_metering_2))
sm3<-as.numeric(as.character(data$Sub_metering_3))
date<-as.Date(data$Date, format="%d/%m/%Y")
newtime<-as.POSIXct(paste(date,data$Time), format="%Y-%m-%d %H:%M:%S")

newframe3<-data.frame(newtime,sm1,sm2,sm3)

days<-subset(newtime, newtime>=as.POSIXlt('2007-02-01 00:00:00') & newtime<=as.POSIXlt('2007-02-02 23:59:00'))

picksm1<-subset(newframe3, newtime>=as.POSIXlt('2007-02-01 00:00:00') & newtime<=as.POSIXlt('2007-02-02 23:59:00'), sm1)
picksm2<-subset(newframe3, newtime>=as.POSIXlt('2007-02-01 00:00:00') & newtime<=as.POSIXlt('2007-02-02 23:59:00'), sm2)
picksm3<-subset(newframe3, newtime>=as.POSIXlt('2007-02-01 00:00:00') & newtime<=as.POSIXlt('2007-02-02 23:59:00'), sm3)


library(datasets)
png(file="plot3.png", height=480, width=480)

plot(picksm1$sm1~days, lwd=1, type="l", xlab="", ylab="Energy sub metering")
points(days, picksm2$sm2, pch=1, lwd=1, col="red", type="l")
points(days, picksm3$sm3, pch=1, lwd=1, col="blue", type="l")
legend("topright", lty = c(1,1,1), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"))
dev.off()