# =================================================================================================================================================
# FileName:    Plot3.R
# =================================================================================================================================================
# 
# Change log:
# Created:     July 19, 2014
# Author:      Andy Isley
# Company: 
# 
# =================================================================================================================================================
# Description:
#              Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#              which of these four sources have seen decreases in emissions from 1999???2008 for Baltimore City? 
#              Which have seen increases in emissions from 1999???2008? Use the ggplot2 plotting system to make a plot answer this question.
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
#download the source data
DataLoc <- GetSourceFiles()

#Get the data into a data frame
NEI <- LoadSummPM25Data()

#Subset the data for Baltimore for Year, Emissions and Type
NEISubset <- subset(NEI, fips == "24510", select = c(year, Emissions, type))


groupColumns = c("year", "type")
dataColumns = c("Emissions")
#Aggregate the data
NEIByYear <- ddply(NEISubset, groupColumns, function(x) colSums(x[dataColumns ]))

#Plot the data
png("plot3.png")

p <- qplot(year, Emissions, data=NEIByYear, facets= . ~ type)
p + 
     geom_smooth(aes(group=type), method="lm") + 
     labs(title = "Emmissions for Baltimore City, MD") + 
     labs(x = "Year") + 
     labs(y = "Total Emmissions PM2.5")


dev.off()


