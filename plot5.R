#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

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

# Prepare dataset with gasoline or diesel source emmissions in Baltimore city (fips 24510) 
cMatchNEISCC <- NSCC[cMatch & NEI$fips==24510, ]
emTby <- aggregate(Emissions ~ year, cMatchNEISCC, sum)

#Preparing plot

png("plot5.png")
g <- ggplot(emTby, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from motor vehicles from 1999 to 2008 in Baltimore City') +
  scale_y_continuous(labels = comma)
print(g)
dev.off()