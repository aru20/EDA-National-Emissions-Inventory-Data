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
##Q3.Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
##which of these four sources have seen decreases in emissions from 1999-2008
##for Baltimore City? Which have seen increases in emissions from 1999-2008? 
##Use the ggplot2 plotting system to make a plot answer this question.
###########################################################
NEI$year <- factor(NEI$year)
NEI$type <- factor(NEI$type)
NEI <- transform(NEI,logEmissions = log10(Emissions))
NEI.sub <- subset(NEI, fips == "24510")
##Plotting the graph
png("plot3.png")
 ggplot(NEI.sub,aes(year,Emissions,fill=type))+
 geom_bar(stat="identity",position="dodge")+
 facet_grid(.~type) + 
 xlab("Year") + 
 ylab(expression("Total Tons of PM"[2.5]*" Emissions")) + 
 ggtitle(expression("Total Tons of PM"[2.5]*" Emissions in Baltimore by Source Type"))+
 theme(axis.text.x=element_text(angle = 90, vjust = 0.5, hjust = 1)) 
dev.off()

###############
#Observation
#on-road, non-road, and non-point sources have all seen decreases in PM2.5 emissions from 1999-2008
#whereas point sources have seen an increase over the same time period.
###################################