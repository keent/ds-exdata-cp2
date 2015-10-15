library(ggplot2)
library(stringr)

# read the data
if (!exists("NEI")) NEI <- readRDS("summarySCC_PM25.rds")
if (!exists("SCC")) SCC <- readRDS("Source_Classification_Code.rds")

# get the mobile-related sources and summarize
bDataMobile <- str_detect(SCC$EI.Sector, "Mobile")
sccDataMobile <- subset(SCC, bDataMobile)
sccMobile <- as.character(sccDataMobile$SCC)

dataBaltimore <- subset(NEI, fips == "24510")
neiMobileBaltimore <- subset(dataBaltimore, dataBaltimore$SCC %in% sccMobile)
dataSum <- ddply(neiMobileBaltimore, ~year, summarise, 
                 totalEmissions=sum(Emissions))

# plot
# ANSWER:
# Coal combusion related emissions INCREASED over time
qplot(year, totalEmissions, data=dataSum, 
      geom=c("point", "smooth"), method="lm",
      main="Total Motor related Emissions in Baltimore",
      ylab="Total Emissions in Tons")

# save plot as png
ggsave("plot5.png")
