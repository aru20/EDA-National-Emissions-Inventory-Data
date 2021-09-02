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
##Q6 Compare emissions from motor vehicle sources in Baltimore City with
#emissions from motor vehicle sources in Los Angeles County, California
#fips == "06037". Which city has seen greater changes over time in motor vehicle emissions?
# Gather the subset of the NEI data which corresponds to vehicles

###########################################################
# Gather the subset of the NEI data which corresponds to vehicles

aggregatedTotalByYearAndFips <- aggregate(Emissions ~ year + fips, subsetNEI, sum)
aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="24510"] <- "Baltimore, MD"
aggregatedTotalByYearAndFips$fips[aggregatedTotalByYearAndFips$fips=="06037"] <- "Los Angeles, CA"

png("plot6.png")
 ggplot(aggregatedTotalByYearAndFips, aes(factor(year), Emissions)) +
 facet_grid(. ~ fips)+
 geom_bar(aes(fill=year),stat="identity")  +
 xlab("Year") +
 ylab(expression('Total PM'[2.5]*" Emissions")) +
 ggtitle('Total Emissions from motor vehicle in Baltimore City vs Los Angeles, 1999-2008')
dev.off()
###############
#Motor vehicle emissions have declined in Baltimore City and increased in Los Angeles.
###################################