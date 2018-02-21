#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
#Which have seen increases in emissions from 1999–2008?

library(ggplot2)

if(!exists("NEI")){
  NEI <- readRDS("./summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./Source_Classification_Code.rds")
}

NEIpy <- with(NEI, tapply(Emissions, year, FUN=sum))


emBal <- subset(NEI, NEI$fips=="24510")
emBalpy <- with(emBal, tapply(Emissions, year, FUN=sum))
emBalpyt <- aggregate(Emissions ~ year + type, emBal, sum)

png('plot3.png')
poi <- ggplot(emBalpyt, aes(year, Emissions))
print(poi + geom_line() + facet_wrap(~type, nrow = 2, ncol=2)+ xlab("year") + ylab(expression('Total PM'[2.5]*" Emissions")) +
        ggtitle('Total Emissions in Baltimore, Maryland from 1999 to 2008'))
dev.off()
