plot3 <- function(file){
	#Prepare by loading required libraries	
	library(sqldf)
	library(datasets)
	library(reshape)
	
	#Read data where date range is 1/2/2007 to 2/2/2007
	df <- read.csv.sql(file, sql="select * from file where Date in ('1/2/2007', '2/2/2007')",
		sep=";")

	#Create datetime column as date and time are captured in different columns
	#convert to date class
	df$DateTime <- paste(df$Date,df$Time)
	df$DateTime <- strptime(df$DateTime, format("%d/%m/%Y %H:%M:%S"))

	#Creating a subset containing just DateTime and Submeter readings	
	meterdata <- df[,c(7:10)]
	
	#Cleaning data to create Sub meter readings to variable value pairs
	mdata <- melt(meterdata, id=c("DateTime"))
	
	#Prepare plot
	png(file="plot3.png")
	with(mdata,plot(DateTime,value,type="l",xlab="", ylab="Energy sub metering"))
	with(subset(mdata, variable=="Sub_metering_1"), points(DateTime, value, type="l", col="black"))
	with(subset(mdata, variable=="Sub_metering_2"), points(DateTime, value, type="l", col="red"))
	with(subset(mdata, variable=="Sub_metering_3"), points(DateTime, value, type="l", col="blue"))
	legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
	dev.off()
} 