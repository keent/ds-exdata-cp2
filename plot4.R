library(ggplot2)
library(stringr)

# read the data
if (!exists("NEI")) NEI <- readRDS("summarySCC_PM25.rds")
if (!exists("SCC")) SCC <- readRDS("Source_Classification_Code.rds")

# get the coal-combustion-related sources and summarize
bDataCoal <- str_detect(SCC$EI.Sector, "Coal")
sccDataCoal <- subset(SCC, bDataCoal)
sccCoal <- as.character(sccDataCoal$SCC)

neiCoal <- subset(NEI, NEI$SCC %in% sccCoal)
dataSum <- ddply(neiCoal, ~year, summarise, 
                 totalEmissions=sum(Emissions))

# plot
# ANSWER:
# Coal combusion related emissions DECREASED over time in all states of USA
qplot(year, totalEmissions, data=dataSum, 
      geom=c("point", "smooth"), method="lm",
      main="Total Coal-Combustion related Emissions in USA",
      ylab="Total Emissions in Tons")

# save plot as png
ggsave("plot4.png")
