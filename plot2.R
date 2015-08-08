# check packages
is.installed <- function(mypkg) is.element(mypkg, installed.packages()[,1]) 
if (is.installed('data.table') == 'FALSE') {install.packages("data.table")} else{library(data.table)}
if (is.installed('lubridate') == 'FALSE') {install.packages("lubridate")} else{library(lubridate)}

# set working directory
curdir <-setwd("D:/Google Drive/Coursera/Assignment 4.1/ExData_Plotting1")
file.url<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(file.url,destfile=paste(curdir,'/power_consumption.zip',sep=""))
unzip(paste(curdir,'/power_consumption.zip',sep=""),exdir=paste(curdir,sep=""),overwrite=TRUE)

# read the  table and limit in 2 days
variable.class<-c(rep('character',2),rep('numeric',7))
power.consumption<-read.table(paste(curdir,'/household_power_consumption.txt',sep=""),header=TRUE,
                                sep=';',na.strings='?',colClasses=variable.class)
power.consumption<-power.consumption[power.consumption$Date=='1/2/2007' | power.consumption$Date=='2/2/2007',]

# clean up the variable
cols<-c('Date','Time','GlobalActivePower','GlobalReactivePower','Voltage','GlobalIntensity','SubMetering1','SubMetering2','SubMetering3')
colnames(power.consumption)<-cols
power.consumption$DateTime<-dmy(power.consumption$Date)+hms(power.consumption$Time)
power.consumption<-power.consumption[,c(10,3:9)]
  
# write  data set to the directory
write.table(power.consumption,file=paste(curdir,'/power_consumption.txt',sep=""),sep='|',row.names=FALSE)
png(filename=paste(curdir,'/plot2.png',sep=""),width=480,height=480,units='px')
plot(power.consumption$DateTime,power.consumption$GlobalActivePower,ylab='Global Active Power (kilowatts)', xlab='', type='l')

graphics.off() 