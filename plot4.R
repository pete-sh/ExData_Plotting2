# plot4.R
# answer the question:
#   Across the United States, how has the Carbon related combustion changed over the monitored period of time?
#   have increased/decreased over the monitored time?
#   -> Baltimore City, Maryland has "fips == 24510"
#
# Use the ggplot2 system to visualize the data
library(ggplot2)

setwd("C:/LocalData/__SUE/Mounts/64GB_SD_Card/D/_Data_Management_Strategical/Data_Science/_COURSERA_STUFF/Course_4_Exploratory_Data_Analysis/Project_2/")

# Read the rds data for PM2.5 Emissions Data
if (!exists("NEI"))
  NEI <- readRDS("Data/summarySCC_PM25.rds")

# Read the rds data for Source Classification Code Table
if (!exists("SCC"))
  SCC <- readRDS("Data/Source_Classification_Code.rds")

# Apply correct filter to data - assuming EI.Sector as the field containing the relevant information
#  - selecting from field EI.Sector
#    - looking for anything to do with coal
#    - looking for anything to do with comb (for combustion)
# coal5 <- grep("comb", grep("coal", SCC$EI.Sector, ignore.case=T, value=T), ignore.case=T, value=T)
CoalComb <- SCC[grep("comb", grep("coal", SCC$EI.Sector, ignore.case=T, value=T), ignore.case=T), "SCC"]

# create relevant subset of the NEI data
NEICoalBased <- subset(NEI, SCC %in% CoalComb, select = c("year", "Emissions"))

# Aggregate the data - summarize by year
Result <- with(NEICoalBased,aggregate(NEICoalBased$Emissions, by=list(year), sum))

#Change column names for this aggregated data to something meaningful
names(Result) <- c("Year", "Emission")

#Open graphics device
png(filename="plots/plot4.png", width=640, height=480)

#Plot final data
qplot(Year, Emission, data = Result) + geom_line() + ggtitle("Annual Pollution by Coal Combustion across the United States") + xlab("Year") + ylab("Coal combustion (in tons)")

#shutdown device
dev.off()
