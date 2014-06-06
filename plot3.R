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

Sys.setlocale("LC_TIME", "English United States")

days<-seq(from=as.Date(data$Date[1],"%d/%m/%Y"), length.out=3, by="1 day")
dayNames<-weekdays(days,T)

x<-1:nrow(data)
y1<-data$Sub_metering_1
y2<-data$Sub_metering_2
y3<-data$Sub_metering_3

png("plot3.png",width=480,height=480)
plot(x,y1,type="l",xaxt='n',ylab="Energy sub metering",xlab="",col="black")
lines(x,y2,col="red")
lines(x,y3,col="blue")
axis(1,at=c(1,nrow(data) %/% 2,nrow(data)),labels=dayNames)
legend(x="topright" ,c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=c(1,1,1), col=c("black","red","blue")) 
dev.off()