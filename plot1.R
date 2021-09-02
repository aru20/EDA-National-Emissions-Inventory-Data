library(dplyr)
library(ggplot2)
##############################################################################
# STEP1 - Geting the data
##############################################################################
# download zip file containing data if it hasn't already been downloaded
##path = getwd()
##path
##url1= "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
##download.file(url=url1,destfile = paste(path,"datafiles.zip",sep = "/"))
##unzip("datafiles.zip")
## This first line will likely take a few seconds. Be patient!
##########################################################
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#str(NEI)
#str(SCC)
##########################################################
#Q1.Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
#Using the base plotting system, make a plot showing the total PM2.5 emission from all 
#sources for each of the years 1999, 2002, 2005, and 2008.
###########################################################
aggregatedTotalByYear <- aggregate(Emissions ~ year, NEI, sum)
#Plotting the graph
png('plot1.png')
barplot(height=aggregatedTotalByYear$Emissions, names.arg=aggregatedTotalByYear$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' emissions at various years'),col="green")
dev.off()
###############
#Observation
#Yes, total emissions from PM2.5 decreased in the United States from 1999 to 2008
###################################