## Generates a PNG 480x480 line graph of global active power 
## over a 2-day period in Febuary 2007
plot2 <- function(){
  
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
  png(filename = "plot2.png",width = 480, height = 480)
  
  plot(sampledata$Global_active_power,type = "l",xlab = ""
       ,ylab = "Global Active Power (kilowatts)",xaxt="n")
  axis(side=1,at=c(0,nrow(sampledata)/2,nrow(sampledata))
       ,labels = c("Thu","Fri","Sat"))
  
  dev.off()
  dev.set(which=lastuseddevice)

}