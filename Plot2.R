# =================================================================================================================================================
# FileName:    Plot2.R
# =================================================================================================================================================
# 
# Change log:
# Created:     July 19, 2014
# Author:      Andy Isley
# Company: 
# 
# =================================================================================================================================================
# Description:
#              Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
#              Use the base plotting system to make a plot answering this question.
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

#subset the data for Baltimore, Year and Emissions
NEISubset <- subset(NEI, fips == "24510", select = c(year, Emissions))

#Aggregate by Year
NEIByYear <- aggregate(data=NEISubset, Emissions ~ year, FUN=sum)

#Plot the data
png("plot2.png")
plot(x=NEIByYear$year
     ,y=NEIByYear$Emissions
     ,type="l"
     ,col="black"
     ,xlab="Year"
     ,ylab="Total Emissions"
     ,xaxt = "n"
     ,main = "Total Emissions of PM2.5 per year for Baltimore"
)

axis(1, at = c("1999", "2002", "2005", "2008"), labels = c("1999", "2002", "2005", "2008"))

dev.off()
