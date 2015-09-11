library(data.table)
library(dplyr)
library(lubridate)
library(datasets)


## get test data
test_file <- "data/household_power_consumption.txt"
test_data <- read.table(test_file, header = TRUE, sep = ";", stringsAsFactors = FALSE)

test_data <- mutate(test_data, DateTime = dmy(Date) + hms(Time))
plot_data <- filter(test_data, DateTime >= "2007-02-01" & DateTime < "2007-02-03")
plot_data[,3:9] <- apply(plot_data[,3:9], 2, function(x) as.numeric(x))

png(file = "Plot2.png", width = 480, height = 480)

with(plot_data, 
     plot(DateTime, 
          Global_active_power, 
          type = "n",
          main = "",
          xlab = "",
          ylab = "Global Active Power (kilowatts)"))

lines(plot_data$DateTime, plot_data$Global_active_power)

dev.off()
