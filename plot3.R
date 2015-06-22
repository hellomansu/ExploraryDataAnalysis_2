#Activity:
#  Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen 
#decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008? Use the ggplot2 
#plotting system to make a plot answer this question.

if(!exists("NEI")) {
  NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
}

if (!exists("SCC")) {
  SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
}


library(dplyr)
library(knitr)
library(ggplot2)

#Filter for Baltimore, Maryland.
filter.baltimore <- NEI %>% filter(fips == "24510")

#Aggregate by year and type.
NEI.annual.type.emission.summary <- filter.baltimore %>% group_by(year, type) %>% summarise(sum(Emissions))
colnames(NEI.annual.type.emission.summary) <- c("Year", "Type", "Emissions")
kable(NEI.annual.type.emission.summary)

#Plot
png('plot3.png')

g <- ggplot(data = NEI.annual.type.emission.summary, aes(x = Year, y = Emissions, color = Type) )
g <- g + geom_line(lwd = 1) + xlab("year") + ylab(expression('Total PM'[2.5]*' Emissions')) 
g <- g + ggtitle('Total Emissions in Baltimore City, MD - 1999 to 2008') + theme_bw()

print(g)
dev.off()
