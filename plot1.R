#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? (base plotting)


if(!exists("NEI")){
  NEI <- readRDS("./summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("./Source_Classification_Code.rds")
}

NEIpy <- with(NEI, tapply(Emissions, year, FUN=sum))

png('plot1.png')
barplot(NEIpy, yaxt="n", xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' emissions at various years'))
axis(2, axTicks(2), format(axTicks(2), scientific = F))
dev.off()