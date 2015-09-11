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

png(file = "Plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

with(plot_data, 
     plot(DateTime, 
          Global_active_power, 
          type = "n",
          main = "",
          xlab = "",
          ylab = "Global Active Power (kilowatts)"))

lines(plot_data$DateTime, plot_data$Global_active_power)


with(plot_data, 
     plot(DateTime, 
          Voltage, 
          type = "n",
          main = "",
          xlab = "datetime",
          ylab = "Voltage"))

lines(plot_data$DateTime, plot_data$Voltage)

with(plot_data, 
     plot(DateTime, 
          Sub_metering_1, 
          type = "n",
          main = "",
          xlab = "",
          ylab = "Energy sub metering"))

lines(plot_data$DateTime, plot_data$Sub_metering_1, col = "black")
lines(plot_data$DateTime, plot_data$Sub_metering_2, col = "red")
lines(plot_data$DateTime, plot_data$Sub_metering_3, col = "blue")
legend(x = "topright",
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1,1),
       col = c("black", "red", "blue"),
       bty = "n")


with(plot_data, 
     plot(DateTime, 
          Global_reactive_power, 
          type = "n",
          main = "",
          xlab = "datetime",
          ylab = "Global_reactive_power"))

lines(plot_data$DateTime, plot_data$Global_reactive_power)

dev.off()
