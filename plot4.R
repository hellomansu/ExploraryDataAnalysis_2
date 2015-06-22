#Activity:
# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

if(!exists("NEI")) {
  NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
}

if (!exists("SCC")) {
  SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
}

library(dplyr)
library(knitr)
library(ggplot2)

#Filter for 'coal' types from SCC
filter.coal.types <- SCC %>% filter(grepl("coal", Short.Name, ignore.case = TRUE))

#join with NEI
NEISCC <- inner_join(NEI, filter.coal.types, by = "SCC")

#Aggregate by year.
NEI.annual.coal.emission.summary <- NEISCC %>% group_by(year) %>% summarise(sum(Emissions))
colnames(NEI.annual.coal.emission.summary) <- c("Year", "Emissions")
kable(NEI.annual.coal.emission.summary)

#Plot
png('plot4.png')

g <- ggplot(data = NEI.annual.coal.emission.summary, aes( factor(Year), Emissions ))
# When the data contains y values in a column, use stat="identity", refer to http://docs.ggplot2.org/0.9.3.1/geom_bar.html
g <- g + geom_bar(stat="identity", width = 0.5, fill = "wheat", color="darkgreen")  + xlab("year") + ylab(expression('Total PM'[2.5]*' Emissions')) 
g <- g + ggtitle('Total Emissions for coal categories - 1999 to 2008') + theme_bw()

print(g)
dev.off()