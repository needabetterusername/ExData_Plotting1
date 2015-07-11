## Generates a PNG 480x480 line graph of energy sub
## metering over a 2-day period in Febuary 2007
plot3 <- function(){
  
  #denote position of data of interest in time-ordered series
  startRow <- 66637L
  
  #read data
  sampledata <- read.csv2("household_power_consumption.txt",skip = startRow
                          , nrows=2*24*60, header=FALSE, na.strings = "?"
                          ,stringsAsFactors = FALSE)
  colnames(sampledata)<-scan("household_power_consumption.txt",what="a"
                             ,sep = ";",nlines = 1,quiet = TRUE)
  
  ##data has been verified to be complete.
  
  #convert types
  for(i in 3:9){
    sampledata[i]<-as.vector(sapply(sampledata[i],as.numeric))
  }
  
  #generate PNG plot
  lastuseddevice <- dev.cur()
  png(filename = "plot3.png",width = 480, height = 480)
  
  with(sampledata,{
    plot(Sub_metering_1,type = "l",ylab="Energy sub metering",xlab = "", xaxt="n")
    lines(Sub_metering_2,col="red")
    lines(Sub_metering_3,col="blue")
    axis(side=1,at=c(0,nrow(sampledata)/2,nrow(sampledata))
         ,labels = c("Thu","Fri","Sat"))
    legend("topright",legend = colnames(sampledata)[7:9]
           ,lty=1 ,col=c("black","red","blue"))
  })
  
  dev.off()
  dev.set(which=lastuseddevice)
  
}