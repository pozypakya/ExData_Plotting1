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
# open device
png(filename=paste(curdir,'/plot3.png',sep=""),width=480,height=480,units='px')

# plot data
legend_color<-c('black','red','blue')
legend_txt<-c('Sub_metering_1','Sub_metering_2','Sub_metering_3')
plot(power.consumption$DateTime,power.consumption$SubMetering1,type='l',col=legend_color[1],xlab='',ylab='Energy sub metering')
lines(power.consumption$DateTime,power.consumption$SubMetering2,col=legend_color[2])
lines(power.consumption$DateTime,power.consumption$SubMetering3,col=legend_color[3])

# add legend
legend('topright',legend=legend_txt,col=legend_color,lty='solid')

graphics.off() 

legend_color<-c('black','red','blue')
legend_txt<-c('Sub_metering_1','Sub_metering_2','Sub_metering_3')
plot(power.consumption$DateTime,power.consumption$SubMetering1,type='l',col=legend_color[1],xlab='',ylab='Energy sub metering')
lines(power.consumption$DateTime,power.consumption$SubMetering2,col=legend_color[2])
lines(power.consumption$DateTime,power.consumption$SubMetering3,col=legend_color[3])

# add legend
legend('topright',legend=legend_txt,col=legend_color,lty='solid')
