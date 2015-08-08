temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"))
unlink(temp)
tail(data,5)


data = read.csv("c://household_power_consumption.txt",header = TRUE, sep = ";") 
tail(data,5)



create table house_hold ( `Date` STRING , `Time` STRING , Global_active_power STRING , Global_reactive_power STRING , Voltage STRING , Global_intensity STRING , Sub_metering_1 STRING , Sub_metering_2 STRING , Sub_metering_3 STRING ) row format delimited  fields terminated by ';' lines terminated by '\n';

install.packages("RImpala")
library(RImpala)
rimpala.init(libs="c:\\impala")
rimpala.connect(IP="10.54.1.151",principal="noSasl")
data1 <- rimpala.query("select * from coursera.house_hold limit 10")

create function IF NOT EXISTS evaluate(STRING, STRING, INT) returns STRING location '/lib/ipv6RangeCheck.jar' symbol='sp.split';
select a.global_active_power as frequency , count(*) as active_global from 
( select case 
 WHEN ( cast(global_active_power as double) >= 0 and cast(global_active_power as double) < 1 ) then 1
 WHEN ( cast(global_active_power as double) >= 1 and cast(global_active_power as double) < 2 ) then 2
 WHEN ( cast(global_active_power as double) >= 2 and cast(global_active_power as double) < 3 ) then 3
 WHEN ( cast(global_active_power as double) >= 3 and cast(global_active_power as double) < 4 ) then 4
 WHEN ( cast(global_active_power as double) >= 4 and cast(global_active_power as double) < 5 ) then 5
 WHEN ( cast(global_active_power as double) >= 5 and cast(global_active_power as double) < 6 ) then 6
 WHEN ( cast(global_active_power as double) >= 6 and cast(global_active_power as double) < 7 ) then 7
 WHEN ( cast(global_active_power as double) >= 7 and cast(global_active_power as double) < 8 ) then 8
 WHEN ( cast(global_active_power as double) >= 8 and cast(global_active_power as double) < 9 ) then 9
 WHEN ( cast(global_active_power as double) >= 9 and cast(global_active_power as double) < 10 ) then 10
 WHEN ( cast(global_active_power as double) >= 10 and cast(global_active_power as double) < 11 ) then 11
 WHEN ( cast(global_active_power as double) >= 11 and cast(global_active_power as double) < 12 ) then 12
 END as global_active_power from house_hold where global_active_power <> '?'  
 and cast(evaluate(`date`,'\\/',2)as int) = 2007 and cast(evaluate(`date`,'\\/',1)as int) = 2 
 and cast(evaluate(`date`,'\\/',0)as int) in (1,3,5,7,9,11,13,15,17,19,21,23,25,27,29)
 ) a where a.global_active_power <=12 
group by a.global_active_power 
order by frequency