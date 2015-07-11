## Generates a PNG 480x480 histogram of global active power 
## over a 2-day period in Febuary 2007
plot1 <- function(){

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
  png(filename = "plot1.png",width = 480, height = 480)
  
  hist(sampledata$Global_active_power,xlab="Global Active Power (kilowatts)"
       ,main="Global Active Power",col="red")

  dev.off()
  dev.set(which=lastuseddevice)
}