# =================================================================================================================================================
# FileName:    Plot1.R
# =================================================================================================================================================
# 
# Change log:
# Created:     July 19, 2014
# Author:      Andy Isley
# Company: 
# 
# =================================================================================================================================================
# Description:
#              Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, 
#              make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
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
library("plyr")
source("FileReader.R")
#download the source data
DataLoc <- GetSourceFiles()

#Get the data into a data frame
NEI <- LoadSummPM25Data()

#Sum the data by Year
NEIByYear <- aggregate(data=NEI, Emissions ~ year, FUN=sum)

#Plot the data
png("plot1.png")
plot(x=NEIByYear$year
     ,y=NEIByYear$Emissions/1000000
     ,type="l"
     ,col="black"
     ,xlab="Year"
     ,ylab="Total Emissions (tons)"
     ,xaxt = "n"
     ,main = "Total emissions of PM 2.5 per year"
)
# Add the yeas to the axis
axis(1, at = c("1999", "2002", "2005", "2008"), labels = c("1999", "2002", "2005", "2008"))

dev.off()
#Close the Plot and save the image