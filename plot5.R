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
##Q5.How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?
###########################################################
# Pattern match mobile vehicles in SCC description
scc.vehicles <- SCC[grep("Mobile.*Vehicles", SCC$EI.Sector),  ] 
# Create motor vehicle lookup list by SCC
scc.vehicles.list <- unique(scc.vehicles$SCC) 
# Filter for motor vehicle sources
nei.vehicles <- subset(NEI, SCC %in% scc.vehicles.list) 
# Filter for Baltimore
nei.vehicles <- subset(nei.vehicles, fips == "24510") 
Emissiondata.Baltimore <- aggregate(Emissions~year,nei.vehicles,sum)
 png('plot5.png')

ggplot(Emissiondata.Baltimore,aes(factor(year),Emissions)) +
  geom_bar(stat="identity", fill ="#FF9999" ,width=0.75) +
  labs(x="Year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))
dev.off()
###############
#Observation
#Emissions from motor vehicle sources have declined from 1999-2008 in Baltimore City.
###################################