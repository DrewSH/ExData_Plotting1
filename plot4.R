##Creating Project Folder
dir.create("./Coursera/EDA_Project1", showWarnings = FALSE)

## Retrieving Data 
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./Coursera/EDA_Project1/data.zip",mode="wb")
unzip("./Coursera/EDA_Project1/data.zip",exdir="./Coursera/EDA_Project1")

hpc <- read.table("./Coursera/EDA_Project1/household_power_consumption.txt",colClasses = "character",header= TRUE, sep=";")

##creating date/time for specific plots
DT<-paste(hpc$Date,hpc$Time)
DT2<-strptime(DT,"%d/%m/%Y %H:%M:%S")
hpc$DT<-DT2
##Changing Date to be an R Date, so the data.frame can be subsetted
hpc$Date <- as.Date(as.character(hpc$Date), "%d/%m/%Y")
##Only be using data from the dates 2007-02-01 and 2007-02-02.
hpc2<-subset(hpc,Date >= "2007-02-01" & Date <= "2007-02-02")

##Output PNG
png(file="./Coursera/EDA_Project1/plot4.png")

##4 plots, plot2.R, plot3.R, as well as two new ones
par(mfrow= c(2,2), mar = c(4,4,2,1),oma=c(0,0,2,0))
with(hpc2, {
  ##plot2.R
  plot(hpc2$DT,hpc2$Global_active_power,type="l",xlab="",ylab="Global Active Power")
  ##first new one
  plot(hpc2$DT,hpc2$Voltage,type="l",xlab="datetime",ylab="Voltage")
  ##plot3.R
  with(hpc2, plot(hpc2$DT,hpc2$Sub_metering_1,xlab="",ylab="Energy sub metering",type="n"))
  with(hpc2, lines(hpc2$DT,hpc2$Sub_metering_1))
  with(hpc2, lines(hpc2$DT,hpc2$Sub_metering_2, col="red"))
  with(hpc2, lines(hpc2$DT,hpc2$Sub_metering_3, col="blue"))
  legend("topright",lty=1,bty="n",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  ##second new one
  plot(hpc2$DT,hpc2$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")
})
dev.off()