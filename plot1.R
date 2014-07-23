# plot1.R
# answer the question: Has the annual total PM2.5 emission across the US decreased over the monitored time?
#
# read relevant data into memory
setwd("C:/LocalData/__SUE/Mounts/64GB_SD_Card/D/_Data_Management_Strategical/Data_Science/_COURSERA_STUFF/Course_4_Exploratory_Data_Analysis/Project_2/")

if (!exists("NEI"))
  NEI <- readRDS("Data/summarySCC_PM25.rds")

# Aggregate pollution data along years
AnnualTotalPollution <- with(NEI,aggregate(NEI$Emissions, by=list(year), sum))
names(AnnualTotalPollution) <- c("Year", "PM2.5 emission (in tons)")

# Create a simple graph in PNG format
png(filename="plots/plot1.png", width=640, height=480,units="px")
  plot(AnnualTotalPollution, type="l", main="PM2.5 Pollution across the United States")
dev.off()
