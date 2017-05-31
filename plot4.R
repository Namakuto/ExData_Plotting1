# This script will create a .png of 4 plots, plotting various Excel-converted 
# "household_power_consumption" variables (saved as a .csv). The plot is then 
# exported in the aforementioned image format.


#data<-read.csv("household_power_consumption.csv", header=TRUE)

num<-as.numeric(as.character(data$Global_active_power)) # Variable conversions
sm1<-as.numeric(as.character(data$Sub_metering_1))
sm2<-as.numeric(as.character(data$Sub_metering_2))
sm3<-as.numeric(as.character(data$Sub_metering_3))
volt<-as.numeric(as.character(data$Voltage))
grp<-as.numeric(as.character(data$Global_reactive_power))
date<-as.Date(data$Date, format="%d/%m/%Y")
newtime<-as.POSIXct(paste(date,time), format="%Y-%m-%d %H:%M:%S")

newframe4<-data.frame(newtime,num,sm1,sm2,sm3,volt,grp) # Quite a bit of waiting

picknum2<-subset(newframe4, newtime>=as.POSIXlt('2007-02-01 00:00:00') & newtime<=as.POSIXlt('2007-02-02 23:59:00'), num)
picksm1<-subset(newframe4, newtime>=as.POSIXlt('2007-02-01 00:00:00') & newtime<=as.POSIXlt('2007-02-02 23:59:00'), sm1)
picksm2<-subset(newframe4, newtime>=as.POSIXlt('2007-02-01 00:00:00') & newtime<=as.POSIXlt('2007-02-02 23:59:00'), sm2)
picksm3<-subset(newframe4, newtime>=as.POSIXlt('2007-02-01 00:00:00') & newtime<=as.POSIXlt('2007-02-02 23:59:00'), sm3)
voltsub<-subset(newframe4, newtime>=as.POSIXlt('2007-02-01 00:00:00') & newtime<=as.POSIXlt('2007-02-02 23:59:00'), volt)
grpsub<-subset(newframe4, newtime>=as.POSIXlt('2007-02-01 00:00:00') & newtime<=as.POSIXlt('2007-02-02 23:59:00'), grp)
days<-subset(newtime, newtime>=as.POSIXlt('2007-02-01 00:00:00') & newtime<=as.POSIXlt('2007-02-02 23:59:00'))

library(datasets) # ----------------------------- Graphical processing and export
png(file="plot4.png", height=480, width=480)
par(mfcol=c(2,2))

plot(picknum2$num~days, type="l", ylab="Global Active Power (kilowatts)", xlab="")

plot(picksm1$sm1~days, lwd=1, type="l", xlab="", ylab="Energy sub metering")
points(days, picksm2$sm2, pch=1, lwd=1, col="red", type="l")
points(days, picksm3$sm3, pch=1, lwd=1, col="blue", type="l")
legend("topright", lty = c(1,1,1), bty="n", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"))

plot(voltsub$volt~days, type="l", ylab="Voltage", xlab="datetime")
plot(grpsub$grp~days, type="l", ylab="Global_reactive_power", xlab="datetime")
dev.off()
