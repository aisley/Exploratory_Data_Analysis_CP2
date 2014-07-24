# =================================================================================================================================================
# FileName:    Plot6.R
# =================================================================================================================================================
# 
# Change log:
# Created:     July 22, 2014
# Author:      Andy Isley
# Company: 
# 
# =================================================================================================================================================
# Description:
#              6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in
#              Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
#
# =================================================================================================================================================

# =================================================================================================================================================
# REVISION HISTORY
# =================================================================================================================================================
# Date: 
# Issue:       Initial Version
# Solution: 
# 
# =================================================================================================================================================

library(plyr)
library(ggplot2)
source("FileReader.R")


#Get the data into a data frame
dataFile <- paste(getwd(), "data/Source_Classification_Code.rds", sep="/")

if(!file.exists(dataFile)) {
     #download the source data
     DataLoc <- GetSourceFiles()
} else {
     NEI <- LoadSummPM25Data()
     SCC <- LoadClassCodeData()
}


#Get the Data for Baltimore & Los Angeles
BaltimoreLos <- subset(NEI, fips == "24510" | fips == "06037", select = c(SCC, Emissions, year, type, fips))

# identify the sources related to Trucks or Vehicles
# pattern could be in any field for Level.one - Level.Four and EI
pattern1 <- "Vehicle"
pattern2 <- "Truck"
Filter1 <- grepl(pattern1, SCC$EI.Sector, ignore.case=T) |
     grepl(pattern1, SCC$SCC.Level.One, ignore.case=T) |
     grepl(pattern1, SCC$SCC.Level.Two, ignore.case=T) |
     grepl(pattern1, SCC$SCC.Level.Three, ignore.case=T) |
     grepl(pattern1, SCC$SCC.Level.Four, ignore.case=T) | 
     grepl(pattern2, SCC$EI.Sector, ignore.case=T) |
     grepl(pattern2, SCC$SCC.Level.One, ignore.case=T) |
     grepl(pattern2, SCC$SCC.Level.Two, ignore.case=T) |
     grepl(pattern2, SCC$SCC.Level.Three, ignore.case=T) |
     grepl(pattern2, SCC$SCC.Level.Four, ignore.case=T)


# Get the ids based on the grep filter
FilteredSet <- SCC$SCC[Filter1]


#Subset the data for all data based on Filter set and On-Road or Off-Road
NEISubset <- subset(BaltimoreLos, SCC %in% FilteredSet & (type == 'ON-ROAD' | type == 'OFF-ROAD'), select = c(fips, year, Emissions))



groupColumns = c("year", "fips")
dataColumns = c("Emissions")
#Aggregate the data
NEIByYear <- ddply(NEISubset, groupColumns, function(x) colSums(x[dataColumns ]))

Baltimore = subset(NEIByYear, fips == "24510" , select = c(Emissions, year))
LosAngeles = subset(NEIByYear, fips == "06037" , select = c(Emissions, year))

#Plot the data
png("plot6.png")

plot(x=Baltimore$year
     ,y=Baltimore$Emissions
     ,type="l"
     ,col="Blue"
     ,xlab="Year"
     ,ylab="Total Emissions(Tons)"
     ,xaxt = "n"
     ,main = "Total Emissions of PM2.5 per year for Motor Vehicles"
     ,ylim=range(Baltimore$Emissions, LosAngeles$Emissions)
)
lines(LosAngeles$year, LosAngeles$Emissions, type="o", col="Red")
legend("right", col=c("Blue", "Red"), lty=1, legend=c("Baltimore", "Los Angeles"))

axis(1, at = c("1999", "2002", "2005", "2008"), labels = c("1999", "2002", "2005", "2008"))

dev.off()
