# plot2.R
# answer the question: Has the annual PL2.5 emission for Baltimore City/Maryland decreased over the monitored time?
#   -> Baltimore City, Maryland has "fips == 24510"

# read data into memory
setwd("C:/LocalData/__SUE/Mounts/64GB_SD_Card/D/_Data_Management_Strategical/Data_Science/_COURSERA_STUFF/Course_4_Exploratory_Data_Analysis/Project_2/")
if (!exists("NEI"))
  NEI <- readRDS("Data/summarySCC_PM25.rds")

# filter contents for Baltimore (fips = 24510) and relevant columns
Baltimore <- subset(NEI, fips == "24510", select = c("year", "Emissions"))
  
# Aggregate pollution data along years
AnnualTotalPollution <- with(Baltimore,aggregate(Baltimore$Emissions, by=list(year), sum))
names(AnnualTotalPollution) <- c("Year", "PM2.5 emission (in tons)")

# Create a simple graph in PNG format
png(filename="plots/plot2.png", width=640, height=480,units="px")
  plot(AnnualTotalPollution, type="l", main="PM2.5 Pollution for Baltimore City / Maryland")
dev.off()
