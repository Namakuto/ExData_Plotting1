
# This script will create a histogram of the variable "Global Active Power" from
# an Excel-converted "household_power_consumption" spreadsheet (saved as .csv). 
# The histogram is then exported as a .png image.


data<-read.csv("household_power_consumption.csv", header=TRUE)

num<-as.numeric(as.character(data$Global_active_power)) # Variable conversions
date<-as.Date(data$Date, format="%d/%m/%Y")

newframe<- data.frame(date,num) # Ensures correct subsetting of data

picknum<-subset(newframe, date=="2007-02-02" | date=="2007-02-01", num)


library(datasets)
png(file="plot1.png", height=480, width=480)
hist(picknum$num, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()
