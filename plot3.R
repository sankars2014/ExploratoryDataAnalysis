## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
## variable, which of these four sources have seen decreases in emissions from 1999–2008 
## for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 
## plotting system to make a plot answer this question.

##Load the required libraries
library(plyr)
library(ggplot2)

## Read the data sets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## subset
NEI_subset_24510 <- NEI[which(NEI$fips == "24510"), ]

## collapse data using BY variables
aggregate24510 <- with(NEI_subset_24510, aggregate(Emissions, by = list(year), sum))
colnames(aggregate24510) <- c("year", "Emissions")


NEI_subset_24510.type <- ddply(NEI_subset_24510, .(type, year), summarize, Emissions = sum(Emissions))
NEI_subset_24510.type$Pollutant_Type <- NEI_subset_24510.type$type

## Plot the graph

png(filename='plot3.png')

qplot(year, Emissions, data = NEI_subset_24510.type, group = Pollutant_Type, color = Pollutant_Type, 
    geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
    xlab = "Year", main = "Total Emissions in U.S. by Type of Pollutant")

dev.off()
