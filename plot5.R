## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City? 

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

NEI_auto_24510 <- NEI.motor[which(NEI.motor$fips == "24510"), ]

## Build a plot
aggregate_motor_24510 <- with(NEI_auto_24510, aggregate(Emissions, by = list(year), 
    sum))

png(filename='plot5.png')

plot(aggregate_motor_24510, type = "o", ylab = expression("Total Emissions, PM"[2.5]), 
    xlab = "Year", main = "Total Emissions from Motor Vehicle Sources")

dev.off()
