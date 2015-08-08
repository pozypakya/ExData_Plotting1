temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"))
unlink(temp)
tail(data,5)


data = read.csv("c://household_power_consumption.txt",header = TRUE, sep = ";") 
tail(data,5)