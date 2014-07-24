# =================================================================================================================================================
# FileName:    Plot4.R
# =================================================================================================================================================
# 
# Change log:
# Created:     July 22, 2014
# Author:      Andy Isley
# Company: 
# 
# =================================================================================================================================================
# Description:
#              Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
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

# identify the sources related to coal combustion
# Coal could be in any field for Level.one - Level.Four and EI
pattern <- "[C|c]oal"
coal <- grepl(pattern, SCC$EI.Sector) |
     grepl(pattern, SCC$SCC.Level.One) |
     grepl(pattern, SCC$SCC.Level.Two) |
     grepl(pattern, SCC$SCC.Level.Three) |
     grepl(pattern, SCC$SCC.Level.Four)


# Get the ids based on the grep filter
coal <- SCC$SCC[coal]


#Subset the data for all data based on Coal Emissions for Year
NEISubset <- subset(NEI, SCC %in% coal, select = c(year, Emissions))


groupColumns = c("year")
dataColumns = c("Emissions")
#Aggregate the data
NEIByYear <- ddply(NEISubset, groupColumns, function(x) colSums(x[dataColumns ]))

#Plot the data
png("plot4.png")

plot(x=NEIByYear$year
     ,y=NEIByYear$Emissions
     ,type="l"
     ,col="black"
     ,xlab="Year"
     ,ylab="Total Emissions(Tons)"
     ,xaxt = "n"
     ,main = "Total Emissions of PM2.5 per year for Coal"
)

axis(1, at = c("1999", "2002", "2005", "2008"), labels = c("1999", "2002", "2005", "2008"))

dev.off()

