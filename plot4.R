## Generates a PNG 480x480 line graph of energy sub
## metering over a 2-day period in Febuary 2007
plot4 <- function(){
  
  #denote position of data of interest in time-ordered series
  startRow <- 66637L
  
  #read data
  sampledata <- read.csv2("household_power_consumption.txt",skip = startRow
                          , nrows=2*24*60, header=FALSE, na.strings = "?"
                          ,stringsAsFactors = FALSE)
  colnames(sampledata)<-scan("household_power_consumption.txt",what="a"
                             ,sep = ";",nlines = 1, quiet = TRUE)
  
  ##data has been verified to be complete.
  
  #convert types
  for(i in 3:9){
    sampledata[i]<-as.vector(sapply(sampledata[i],as.numeric))
  }
  
  #generate PNG plot
  midpoint <- nrow(sampledata)/2
  endpoint <- nrow(sampledata)
  
  lastuseddevice <- dev.cur()
  png(filename = "plot4.png",width = 480, height = 480)
  
  par(mfrow=c(2,2))
  with(sampledata,{
    plot(Global_active_power,type = "l",xlab = "",ylab = "Global Active Power",xaxt="n")
      axis(side=1,at=c(0,midpoint,endpoint),labels = c("Thu","Fri","Sat"))
    
    plot(Voltage,type = "l",xlab = "datetime",ylab = "Voltage",xaxt="n")
      axis(side=1,at=c(0,midpoint,endpoint),labels = c("Thu","Fri","Sat"))
    
    plot(Sub_metering_1,type = "l",ylab="Energy sub metering",xlab = "", xaxt="n")
      lines(Sub_metering_2,col="red")
      lines(Sub_metering_3,col="blue")
      axis(side=1,at=c(0,midpoint,endpoint),labels = c("Thu","Fri","Sat"))
      legend("topright", bty="n", legend = colnames(sampledata)[7:9]
             , lty=1,col=c("black","red","blue"))
    
    plot(Global_reactive_power,type = "l",xlab = "datetime",xaxt="n")
     axis(side=1,at=c(0,midpoint,endpoint),labels = c("Thu","Fri","Sat"))
  })
  
  dev.off()
  dev.set(which=lastuseddevice)
  
}