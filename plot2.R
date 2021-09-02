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
###Q2.Have total emissions from PM2.5 decreased in the Baltimore City, 
##Maryland fips == "24510") 
##from 1999 to 2008? Use the base plotting system to make a plot answering this question
###########################################################
BaltimoreEmissiondata <- aggregate(Emissions~year,NEIsub,sum)
BaltimoreEmissiondata
# Plot (png file)
png('plot2.png')
barplot(Emissions~year,BaltimoreEmissiondata,xlab="Years",ylab ="Total Emissions ",col="green",main="Baltimore City Emissions per year") 
dev.off()
###############
#Observation
#Yes.There is an absolute decrease from the year 1999 to the year 2008 in total PM2.5 emissions in Baltimore City.
###################################