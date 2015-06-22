getwd()

#Activity:
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

if(!exists("NEI")) {
  NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
}

if (!exists("SCC")) {
  SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
}


library(dplyr)
library(knitr)

#Aggregate by year.
NEI.annual.emission.summary <- NEI %>% group_by(year) %>% summarise(sum(Emissions))
colnames(NEI.annual.emission.summary) <- c("Year", "Emissions")
kable(NEI.annual.emission.summary)

#Plot
png('plot1.png')
barplot(height = NEI.annual.emission.summary$Emissions, 
         names.arg=NEI.annual.emission.summary$Year, 
         col = "wheat", 
         xlab = "years",
         ylab = expression('total PM'[2.5]*' emission'),
         main = expression('Total PM'[2.5]*' emissions for years 1999,2002,2005 and 2008'))
dev.off()
