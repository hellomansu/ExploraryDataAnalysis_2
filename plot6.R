#Activity:
# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County,
# California (fips == 06037). Which city has seen greater changes over time in motor vehicle emissions?

if(!exists("NEI")) {
  NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
}

if (!exists("SCC")) {
  SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
}

library(dplyr)
library(knitr)
library(ggplot2)


#Fetch motor vehicle sources [ON-ROAD] related matches for Baltimore,MD and LA, CA from the NEI
motorvehsources.LABAL <- filter( NEI, (fips == "24510" | fips == "06037") & type == "ON-ROAD")

#Aggregate by year .
NEI.OnRoad.BaltimoreLosAngeles <- motorvehsources.LABAL  %>% group_by(year, fips) %>% summarise(sum(Emissions))
colnames(NEI.OnRoad.BaltimoreLosAngeles) <- c("Year", "Fips", "Emissions")
NEI.OnRoad.BaltimoreLosAngeles$Fips <- as.factor(NEI.OnRoad.BaltimoreLosAngeles$Fips)
levels(NEI.OnRoad.BaltimoreLosAngeles$Fips) <- c("Los Angeles, CA", "Baltimore, MD")
kable(NEI.OnRoad.BaltimoreLosAngeles)

#Plot
png('plot6.png')

g <- ggplot(data = NEI.OnRoad.BaltimoreLosAngeles, aes(x = factor(Year), y = Emissions) )
g <- g + facet_grid(. ~ Fips)
g <- g + geom_bar(stat="Identity", width = 0.5, fill = "wheat", color="darkgreen") + xlab("year") + ylab(expression('Total PM'[2.5]*' Emissions')) 
g <- g + ggtitle('Total Emissions of ON-ROAD - LA Vs Baltimore - 1999 to 2008') + theme_bw()

print(g)
dev.off()