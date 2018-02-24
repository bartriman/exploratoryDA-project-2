# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, 
# California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

if(!exists("NEI")){
  NEI <- readRDS("./summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./Source_Classification_Code.rds")
}

#Combine two data sets 
if(!exists("NSCC")){
  NSCC <- merge(NEI, SCC, by="SCC")
}

library(ggplot2)
library(scales)

#find all NSCC records with Short.Name (SCC) containing strng "gasoline" or "diesel" regardless case
cMatch  <- grepl("gasoline | diesel", NSCC$Short.Name, ignore.case=TRUE)

# Prepare dataset with gasoline or diesel source emmissions in Baltimore city (fips 24510) and in LA (fips 06037)
cmNS_LAB <- NSCC[cMatch & (NSCC$fips=="24510" | NSCC$fips=="06037"), ]
emTby_LAB <- aggregate(Emissions ~ year + fips, cmNS_LAB, sum)
emTby_LAB$fips[emTby_LAB$fips=="06037"] <- "Los Angeles, CA"
emTby_LAB$fips[emTby_LAB$fips=="24510"] <- "Baltimore, MD"


#Preparing plot

png("plot6.png", width=1040, height=480)
g <- ggplot(emTby_LAB, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  facet_grid(. ~ fips) +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicles from 1999 to 2008 in Baltimore City and LA') +
  scale_y_continuous(labels = comma)
print(g)
dev.off()