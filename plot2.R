#Activity:
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == 24510) from 1999 to 2008? 
#Use the base plotting system to make a plot answering this question.
#Upload a PNG file containing your plot addressing this question.

setwd("C:\\Users\\Suman\\Dropbox\\Coursera\\Data Science\\EDA\\Data")

if(!exists("NEI")) {
  NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
}

if (!exists("SCC")) {
  SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
}


library(dplyr)
library(knitr)

#Filter for Baltimore, Maryland.
filter.baltimore <- NEI %>% filter(fips == "24510")

#Aggregate by year.
NEI.annual.emission.summary <- filter.baltimore %>% group_by(year) %>% summarise(sum(Emissions))
colnames(NEI.annual.emission.summary) <- c("Year", "Emissions")
kable(NEI.annual.emission.summary)

#Plot
png('plot2.png')
barplot(height = NEI.annual.emission.summary$Emissions, 
        names.arg=NEI.annual.emission.summary$Year, 
        col = "wheat", 
        xlab = "years",
        ylab = expression('total PM'[2.5]*' emission'),
        main = expression('Total PM'[2.5]*' in Baltimore, MD for years 1999,2002,2005 and 2008'))
dev.off()

