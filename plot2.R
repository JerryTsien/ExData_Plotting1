# Use the following command to construct Plot 2:
# > ConstructPlot2()
# Or use this command if you are very patient :-)
# > ConstructPlot2(FALSE)

ConstructPlot2 <- function(from.cache = TRUE) {
  
  library(datasets)
  # Re-use the ReadData function in plot1.R
  source("plot1.R")
  ds <- ReadData(from.cache)

  # Add a column in POSIXlt format and use it as the X axis in the graph.
  datetime <- paste(ds$Date, ds$Time)
  ds$Date_time <- strptime(datetime, "%d/%m/%Y %T")  # %T = %H:%M:%S
  
  png("plot2.png", width = 480, height = 480, units = "px")
  with(ds, plot(Date_time, as.numeric(Global_active_power),
                type = "l",
                xlab = "",
                ylab = "Global Active Power (kilowatts)"))
  dev.off()
}
