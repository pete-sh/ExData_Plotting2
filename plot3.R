# plot3.R
# answer the question:
#   For Baltimore City/Maryland, which of the four possible sources (point, nonpoint, onroad, nonroad) 
#   have increased/decreased over the monitored time?
#   -> Baltimore City, Maryland has "fips == 24510"
#
# Use the ggplot2 system to visualize the data
library(ggplot2)

# read data into memory
setwd("C:/LocalData/__SUE/Mounts/64GB_SD_Card/D/_Data_Management_Strategical/Data_Science/_COURSERA_STUFF/Course_4_Exploratory_Data_Analysis/Project_2/")
if (!exists("NEI"))
  NEI <- readRDS("Data/summarySCC_PM25.rds")

# reduce contents to Baltimore (fips = 24510)
Baltimore <- subset(NEI, fips == "24510", select = c("year", "type", "Emissions"))
  
# Aggregate pollution data along year
Result <- with(Baltimore,aggregate(Baltimore$Emissions, by=list(year, type), sum))
names(Result) <- c("Year", "Type", "Emission")

# Create a ggplot of the data frame in PNG format
png(filename="plots/plot3.png", width=640, height=480,units="px")
  qplot(Year, Emission, data = Result, color=Type) + geom_line() + ggtitle("Baltimore City - Annual Pollution by Source")
dev.off()
