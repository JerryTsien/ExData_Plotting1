# Use the following command to construct Plot 3:
# > ConstructPlot3()

ConstructPlot3 <- function(from.cache = TRUE) {
  
  library(datasets)
  source("plot1.R")
  ds <- ReadData(from.cache)
  palette <- c("black", "red", "blue")
  
  datetime <- paste(ds$Date, ds$Time)
  ds$Date_time <- strptime(datetime, "%d/%m/%Y %T")
  
  png("plot3.png", width = 480, height = 480, units = "px")
  
  # There are 3 data series in the same graph.
  plot(ds$Date_time, as.numeric(ds$Sub_metering_1), type = "l", col = palette[1],
       xlab = "", ylab = "Energy sub metering")
  lines(ds$Date_time, as.numeric(ds$Sub_metering_2), type = "l", col = palette[2])
  lines(ds$Date_time, as.numeric(ds$Sub_metering_3), type = "l", col = palette[3])
  legend("topright", lty = 1, col = palette, legend = names(ds)[7:9])

  dev.off()
}
