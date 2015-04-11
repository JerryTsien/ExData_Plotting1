# Use the following command to construct Plot 1:
# > ConstructPlot1()

ReadData <- function(from.cache) {
  # This function returns the dataset needed to make the plots
  # and also caches the data in csv format for faster future retrieval.
  # Returns:
  #   A date frame containing only the required subset of the raw data.
  
  # The minimum required memory is about 2,075,259 * 9 * 10 = 180 MB,
  # if the entire raw data is loaded into memory.
  # However, a better alternative is to read only the potion that's needed.
  
  datasource <- "household_power_consumption.txt"
  datacache <- "household_power_consumption_cache.csv"
  
  # Use the cache if it's there and you want to use it.
  if(from.cache && file.exists(datacache)) {
    result <- read.csv(datacache, header = TRUE)
    return(result)
  }
  
  con <- file(datasource, open = "r")
  single.line <- readLines(con, n = 1, warn = FALSE)
  name.list <- unlist(strsplit(single.line, ";"))
  
  # Get every column in string format, in order to ensure portability
  result <- data.frame(matrix(ncol = 9, nrow = 0), stringsAsFactors = FALSE)
  # Keep the original column names
  names(result) <- name.list
  
  i <- 1
  while (length(single.line <- readLines(con, n = 1, warn = FALSE)) > 0) {
    data.list <- unlist(strsplit(single.line, ";"))
    if (data.list[1] == "1/2/2007" | data.list[1] == "2/2/2007") {
      # Here is the best place to detect and correct missing values, coded as "?".
      # However, missing values are actually missing in the final dataset.
      result[i, ] <- data.list
      i <- i + 1
    }
  }
  close(con)
  
  # Save the cache for future re-use.
  if(file.exists(datacache)) {
    unlink(datacache, force = TRUE)
  }
  write.csv(result, file = datacache, row.names = FALSE)
  
  result
}

ConstructPlot1 <- function(from.cache = FALSE) {
  
  library(datasets)
  ds <- ReadData(from.cache)
  
  png("plot1.png", width = 480, height = 480, units = "px")
  hist(as.numeric(ds$Global_active_power),
       xlab = "Global Active Power (kilowatts)",
       col = "red",
       main = "Global Active Power")
  
  # The following code will also work:
  # dev.copy(png, file = "plot1.png")
  # The default size of the image is just 480 x 480 pixels
  
  dev.off()
}
