## Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

##Load the required libraries
library(plyr)
library(ggplot2)

## Read the data sets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## subset
SCC.coal <- grep("coal", SCC$Short.Name, ignore.case = TRUE)
SCC.coal <- SCC[SCC.coal, ]
SCC.identifiers <- as.character(SCC.coal$SCC)

## subsetting
NEI$SCC <- as.character(NEI$SCC)
NEI.coal <- NEI[NEI$SCC %in% SCC.identifiers, ]

## collapse data using BY variables
aggregate.coal <- with(NEI.coal, aggregate(Emissions, by = list(year), sum))
colnames(aggregate.coal) <- c("year", "Emissions")


## Build a plot

png(filename='plot4.png')

plot(aggregate.coal, type = "o", ylab = expression("Total Emissions, PM"[2.5]), 
    xlab = "Year", main = "Emissions and Total Coal Combustion for the United States", 
    xlim = c(1999, 2008))
polygon(aggregate.coal, col = "red", border = "red")

dev.off()
