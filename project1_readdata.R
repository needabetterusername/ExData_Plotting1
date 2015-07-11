#read data
rawdata <- read.csv2("household_power_consumption.txt",skip = startRow, nrows=2*24*60, header=FALSE, na.strings = "?",stringsAsFactors = FALSE)
colnames(rawdata)<-scan("household_power_consumption.txt",what="a",sep = ";",nlines = 1)

#convert
for(i in 3:9){
  rawdata[i]<-as.vector(sapply(rawdata[i],as.numeric))
}
