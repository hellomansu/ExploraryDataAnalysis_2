#Activity:
# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

if(!exists("NEI")) {
  NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
}

if (!exists("SCC")) {
  SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
}

library(dplyr)
library(knitr)
library(ggplot2)


#Fetch motor vehicle sources [ON-ROAD] related matches for Baltimore,MD from the SCC
motorvehsources <- filter(NEI, fips == "24510" & type == "ON-ROAD")

#Aggregate by year .
NEI.OnRoad.Baltimore <- motorvehsources  %>% group_by(year) %>% summarise(sum(Emissions))
colnames(NEI.OnRoad.Baltimore) <- c("Year",  "Emissions")
kable(NEI.OnRoad.Baltimore)

#Plot
png('plot5.png')

g <- ggplot(data = NEI.OnRoad.Baltimore, aes(x = factor(Year), y = Emissions) )
g <- g + geom_bar(stat="Identity", width = 0.5, fill = "wheat", color="darkgreen") + xlab("year") + ylab(expression('Total PM'[2.5]*' Emissions')) 
g <- g + ggtitle('Total Emissions of ON-ROAD in Baltimore City  - 1999 to 2008') + theme_bw()

print(g)
dev.off()