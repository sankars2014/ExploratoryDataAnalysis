## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission from 
## all sources for each of the years 1999, 2002, 2005, and 2008.

##Load the required libraries
library(plyr)
library(ggplot2)

## Read the data sets
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## collapse data using BY variables
aggregate.data <- with(NEI, aggregate(Emissions, by = list(year), sum))

## Plot showing the total PM2.5 emission from 
## all sources for each of the years 1999, 2002, 2005, and 2008.

png(filename='plot1.png')

plot(aggregate.data, type = "o", ylab = expression("Total Emissions, PM"[2.5]), 
    xlab = "Year", main = "Total Emissions in the United States")
polygon(aggregate.data, col = "green", border = "blue")

dev.off()