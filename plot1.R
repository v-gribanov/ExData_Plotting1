#set connection to data file
con <- file("household_power_consumption.txt", 'r')
#read first line with column names
namesLine=readLines(con, n=1)

linesToSkip=1
#read data file line by line 
# till meeting line with date 2007-02-01.
#and go out loop
# line number with date 2007-02-01 is saved in `linesToSkip` 
while (1 > 0){
  ln=readLines(con, n=1)
  date=strsplit(ln,";")[[1]][1]
  if(as.Date(date,"%d/%m/%Y")==as.Date("2007-02-01")){
    break;
  }
  linesToSkip=linesToSkip+1
} 
close(con)
# read 2880 lines (data for 2 days) from data file 
# starting with line `linesToSkip`+1
data<-read.csv("household_power_consumption.txt",sep=";",dec=".",
               header=F,skip=linesToSkip,nrows=2880)
#set column names for data frame
colnames(data)<-strsplit(namesLine,";")[[1]]

#plot
png("plot1.png",width=480,height=480)
 hist(data$Global_active_power,xlab="Global Active Power (kilowatts)",
      main="Global Active Power",col="red")
dev.off()