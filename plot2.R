plot2 <- function(file){
	#Load libraries required for plotting	
	library(sqldf)
	library(datasets)

	#Read a subset of data where date range is 1/2/2007 to 2/2/2007
	df <- read.csv.sql(file, sql="select * from file where Date in ('1/2/2007', '2/2/2007')",
		sep=";")
	
	#As date and time are in different columms, create a new column which merges Date and Time
	df$DateTime <- paste(df$Date,df$Time)

	#Converting DateTime data to Date class
	df$DateTime <- strptime(df$DateTime, format("%d/%m/%Y %H:%M:%S"))

	#Create a png file on which plotting will be done
	png(file="plot2.png")
	with(df,plot(DateTime,Global_active_power,type="l", xlab="", ylab="Global Active Power(kilowatts)"))
	
	#Have to turn off device once the plotting is done
	dev.off()

} 