plot1 <- function(file){
	#Load required libraries
	library(sqldf)
	library(datasets)
	
	#Read data with date range 1/2/2007 to 2/2/2007
	df <- read.csv.sql(file, sql="select * from file where Date in ('1/2/2007', '2/2/2007')",
		sep=";")
	
	#Create png file and plot
	png(file="plot1.png")
	hist(df$Global_active_power, main="Global Active Power", xlab="Global Active Power(kilowatts)",
		col="red")
	dev.off()
} 