## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
## from 1999 to 2008? Use the base plotting system to make a plot answering this question.

##Load the required libraries
library(plyr)
library(ggplot2)

## Read the data sets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## subset
NEI24510 <- NEI[which(NEI$fips == "24510"), ]

## collapse data using BY variables
aggregate24510 <- with(NEI.24510, aggregate(Emissions, by = list(year), sum))
colnames(aggregate24510) <- c("year", "Emissions")

## Plot the graph
png(filename='plot2.png')

plot(aggregate24510, type = "o", ylab = expression("Total Emissions, PM"[2.5]), 
    xlab = "Year", main = "Total Emissions for Baltimore County", xlim = c(1999, 
        2008))

dev.off()