# Use the following command to construct Plot 4:
# > ConstructPlot4()

ConstructPlot4 <- function(from.cache = TRUE) {
  
  library(datasets)
  source("plot1.R")
  ds <- ReadData(from.cache)
  palette <- c("black", "red", "blue")
  
  datetime <- paste(ds$Date, ds$Time)
  ds$Date_time <- strptime(datetime, "%d/%m/%Y %T")
  
  png("plot4.png", width = 480, height = 480, units = "px")
  
  par(mfrow = c(2, 2))
  
  # Top-left: Only differs from Plot 2 in Y label.
  plot(ds$Date_time, as.numeric(ds$Global_active_power), type = "l",
       xlab = "", ylab = "Global Active Power")
  
  # Top-right
  plot(ds$Date_time, as.numeric(ds$Voltage), type = "l",
       xlab = "datetime", ylab = "Voltage")
  
  # Bottom-left: Only differs from Plot 3 in legend box style.
  plot(ds$Date_time, as.numeric(ds$Sub_metering_1), type = "l", col = palette[1],
       xlab = "", ylab = "Energy sub metering")
  lines(ds$Date_time, as.numeric(ds$Sub_metering_2), type = "l", col = palette[2])
  lines(ds$Date_time, as.numeric(ds$Sub_metering_3), type = "l", col = palette[3])
  legend("topright", lty = 1, col = palette, legend = names(ds)[7:9], bty = "n")
  
  # Bottom-right
  plot(ds$Date_time, as.numeric(ds$Global_reactive_power), type = "l",
       xlab = "datetime", ylab = "Global_reactive_power")
  
  dev.off()
}
