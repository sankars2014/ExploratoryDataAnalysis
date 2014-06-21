## Compare emissions from motor vehicle sources in Baltimore City with emissions 
## from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?

##Load the required libraries
library(plyr)
library(ggplot2)

## Read the data sets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## subset
SCC.motor <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
SCC.motor <- SCC[SCC.motor, ]
SCC.identifiers <- as.character(SCC.motor$SCC)

## subsetting
NEI$SCC <- as.character(NEI$SCC)
NEI.motor <- NEI[NEI$SCC %in% SCC.identifiers, ]
NEI.motor.24510 <- NEI.motor[which(NEI.motor$fips == "24510"), ]

## Build a plot
aggregate.motor.24510 <- with(NEI.motor.24510, aggregate(Emissions, by = list(year),sum))

SCC.motor <- grep("motor", SCC$Short.Name, ignore.case = TRUE)
SCC.motor <- SCC[SCC.motor, ]
SCC.identifiers <- as.character(SCC.motor$SCC)


NEI$SCC <- as.character(NEI$SCC)
NEI.motor <- NEI[NEI$SCC %in% SCC.identifiers, ]

## Baltimore
NEI_motor_24510 <- NEI.motor[which(NEI.motor$fips == "24510"), ]

## Los Angeles 
NEI_motor_06037 <- NEI.motor[which(NEI.motor$fips == "06037"), ]

aggregate_motor_24510 <- with(NEI_motor_24510, aggregate(Emissions, by = list(year),  sum))
aggregate_motor_24510$group <- rep("Baltimore County", length(aggregate_motor_24510[, 1]))
aggregate_motor_06037 <- with(NEI_motor_06037, aggregate(Emissions, by = list(year), sum))
aggregate_motor_06037$group <- rep("Los Angeles County", length(aggregate_motor_06037[, 1]))

## Aggregate the data
aggregated_motor_zips <- rbind(aggregate_motor_06037, aggregate_motor_24510)
aggregated_motor_zips$group <- as.factor(aggregated_motor_zips$group)
colnames(aggregated_motor_zips) <- c("Year", "Emissions", "Group")


## Plot the graph
png(filename='plot6.png')

qplot(Year, Emissions, data = aggregated_motor_zips, group = Group, color = Group, 
    geom = c("point", "line"), ylab = expression("Total Emissions, PM"[2.5]), 
    xlab = "Year", main = "Comparison of Total Emissions by County")
dev.off()