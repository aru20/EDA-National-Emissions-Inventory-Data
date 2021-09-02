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
##Q4.Across the United States, how have emissions from coal combustion-related 
###sources changed from 1999-2008?
###########################################################
#unique(SCC$EI.Sector) 
###sub setting SCC data to only coal combustion-related source classification codes

SCC.coal <- SCC[grep("Fuel Comb.*Coal", SCC$EI.Sector),]
head(SCC.coal)
SCC.coallist <- unique(SCC.coal$SCC)
##SCC.coallist
NEI.coal <- subset(NEI, SCC %in% SCC.coallist)
#head(NEI.coal)
Emissiondata <- aggregate(Emissions~year,NEI.coal,sum)
png("plot4.png")
ggplot(Emissiondata,aes(x = factor(year),y = Emissions/10^5)) +
  geom_bar(stat="identity") +
  xlab("Year") +
  ylab(expression("Total PM"[2.5]*" Emission (10^5 Tons)") )+ 
  ggtitle(expression(atop("Total Tons of PM"[2.5]*" Emissions in the United States", paste("from Coal Combustion-Related Sources"))))
  dev.off()

###############
#Observation
#emissions from coal combustion-relates sources have decreased from 1999-2008.
###################################