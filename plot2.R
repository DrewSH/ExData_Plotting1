##Creating Project Folder
dir.create("./Coursera/ExData_Plotting1", showWarnings = FALSE)

## Retrieving Data 
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./Coursera/ExData_Plotting1/data.zip",mode="wb")
unzip("./Coursera/ExData_Plotting1/data.zip",exdir="./Coursera/ExData_Plotting1")

hpc <- read.table("./Coursera/ExData_Plotting1/household_power_consumption.txt",colClasses = "character",header= TRUE, sep=";")

##creating date/time for specific plots
DT<-paste(hpc$Date,hpc$Time)
DT2<-strptime(DT,"%d/%m/%Y %H:%M:%S")
hpc$DT<-DT2
##Changing Date to be an R Date, so the data.frame can be subsetted
hpc$Date <- as.Date(as.character(hpc$Date), "%d/%m/%Y")
##Only be using data from the dates 2007-02-01 and 2007-02-02.
hpc2<-subset(hpc,Date >= "2007-02-01" & Date <= "2007-02-02")

##Output PNG
png(file="./Coursera/ExData_Plotting1/plot2.png")
plot(hpc2$DT,hpc2$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
dev.off()