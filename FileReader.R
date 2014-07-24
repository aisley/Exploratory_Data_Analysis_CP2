# =================================================================================================================================================
# FileName:    FileReader.R
# =================================================================================================================================================
# 
# Change log:
# Created:     July 19, 2014
# Author:      Andy Isley
# Company: 
# 
# =================================================================================================================================================
# Description:
#              Download and read National Emission Inventory dataset files
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

# =================================================================================================================================================
# FUNCTION LISTING
# =================================================================================================================================================
# Function:    GetSourceFiles
# Created:     July 19, 2014
# Author:      Andy Isley
# Arguments:   None
# Usage:       path <- GetSourceFiles()
#
# Returns:     Path of the downloaded files
#              Returns "ERR" if download failed
# =================================================================================================================================================
# Purpose:
#              Downloads and extracts the source files for the 2nd class project
#
# =================================================================================================================================================

# =================================================================================================================================================
# FUNCTION LISTING
# =================================================================================================================================================
# Function:    LoadSummPM25Data
# Created:     July 19, 2014
# Author:      Andy Isley
# Arguments:   None
# Usage:       path <- LoadSummPM25Data()
#
# Returns:     data frame of the EPA NEI data
# =================================================================================================================================================
# Purpose:
#              Read directory "Data" for the EPA NEI(National Emissions Inventory) Data set
#              PM2.5 Emissions Data  summarySCC_PM25.rds
#
# =================================================================================================================================================


# =================================================================================================================================================
# FUNCTION LISTING
# =================================================================================================================================================
# Function:    LoadClassCodeData
# Created:     July 19, 2014
# Author:      Andy Isley
# Arguments:   None
# Usage:       path <- LoadClassCodeData()
#
# Returns:     data frame of the Class Code data
# =================================================================================================================================================
# Purpose:
#              Read directory "Data" for the Class Code Data set
#              Source Classification Code Table (Source_Classification_Code.rds)
#
# =================================================================================================================================================


GetSourceFiles <- function() {

     #Get the zip file
     fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
     
     SourceFile <- "exdata-data-NEI_data.zip"
     
     fileDir <- "Data"
     #Check if Data Dir exists adn create if not
     if(!file.exists(fileDir)) {
          dir.create(fileDir)
     }
     
     #Get the Data dir to place the files
     DataFileDir <- paste(getwd(), fileDir, sep="/")
     #setwd(workingDir)
     
     zipFile <- paste(getwd(), SourceFile, sep="/")
     download.file(fileURL, destfile=SourceFile)
     
     #Check to see if file was downloaded
     if(!file.exists(zipFile)) {
          DataFileDir <- "ERR"
     } else {
          unzip(zipFile,  exdir = DataFileDir)
     }
     
     return(DataFileDir)
}



# =================================================================================================================================================
# Function:    LoadLoadSummPM25Data  -  Emissions Data
# =================================================================================================================================================
LoadSummPM25Data <- function() {
     
     dataFile <- paste(getwd(), "data/summarySCC_PM25.rds", sep="/")

     if(!file.exists(dataFile)) {
          DataFileDir <- "ERR"
     } else {
          summarySCC_PM25 <- readRDS(dataFile)
     }
     
     return(summarySCC_PM25)
}


# =================================================================================================================================================
# Function:    LoadClassCodeData  -  Emissions Data
# =================================================================================================================================================

LoadClassCodeData  <- function() {
     
     dataFile <- paste(getwd(), "data/Source_Classification_Code.rds", sep="/")
     
     if(!file.exists(dataFile)) {
          DataFileDir <- "ERR"
     } else {
          ClassCodes <- readRDS(dataFile)
     }
     
     return(ClassCodes)
}