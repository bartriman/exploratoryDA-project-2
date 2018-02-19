# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? (base plotting)

emBal <- subset(NEI, NEI$fips=="24510")
emBalpy <- with(emBal, tapply(Emissions, year, FUN=sum))

png('plot2.png')
barplot(emBalpy, 
        yaxt="n", 
        xlab="years", 
        ylab=expression('total PM'[2.5]*' emission'),
        main=expression('Total PM'[2.5]*' emissions in Baltimore, Maryland 1999-2008'))
axis(2, axTicks(2), format(axTicks(2), scientific = F))
dev.off()