library(ggplot2)

# read the data
if (!exists("NEI")) NEI <- readRDS("summarySCC_PM25.rds")
if (!exists("SCC")) SCC <- readRDS("Source_Classification_Code.rds")

# get the total emissions for Baltimore, MD
# and summarize by year and type
dataBaltimore <- NEI %>% subset(fips==24510)
dataSum <- ddply(dataBaltimore, ~year * type, summarise, 
                 totalEmissions=sum(Emissions))
# plot
# ANSWER:
# performing a simple linear regression it seems 
# these types descreases over time: NON-ROAD, NONPOINT, ON-ROAD (which is good)
# while POINT type slightly increases over time
qplot(year, totalEmissions, data=dataSum, facets=.~type,
      geom=c("point", "smooth"), method="lm",
      main="Total Emissions in Baltimore by Emission Type",
      ylab="Total Emissions in Tons")

# save plot as png
ggsave("plot3.png")
