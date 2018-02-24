#Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

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

#find all NSCC records with Short.Name (SCC) Coal regardless case
cMatch  <- grepl("coal", NSCC$Short.Name, ignore.case=TRUE)

# Prepare dataset with coal emmissions
cMatchNEISCC <- NSCC[cMatch, ]
emTby <- aggregate(Emissions ~ year, cMatchNEISCC, sum)

#Preparing plot

png("plot4.png")
g <- ggplot(emTby, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression('Total PM'[2.5]*" Emissions")) +
  ggtitle('Total Emissions from coal sources from 1999 to 2008') +
  scale_y_continuous(labels = comma)
print(g)
dev.off()