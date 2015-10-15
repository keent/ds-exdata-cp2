library(ggplot2)
library(stringr)

# read the data
if (!exists("NEI")) NEI <- readRDS("summarySCC_PM25.rds")
if (!exists("SCC")) SCC <- readRDS("Source_Classification_Code.rds")

# get the motor-related sources for both Baltimore and 
# Los Angeles then summarize

bDataMobile <- str_detect(SCC$EI.Sector, "Mobile")
sccDataMobile <- subset(SCC, bDataMobile)
sccMobile <- as.character(sccDataMobile$SCC)

dataBaltimore <- subset(NEI, fips == "24510")
neiMobileBaltimore <- subset(dataBaltimore, dataBaltimore$SCC %in% sccMobile)
dataLosAngeles <- subset(NEI, fips == "06037")
neiMobileLosAngeles <- subset(dataLosAngeles, dataLosAngeles$SCC %in% sccMobile)

dataBoth <- rbind(dataBaltimore, dataLosAngeles)

# summarize and use more descriptive fips names
dataSum <- ddply(dataBoth, ~year * fips, summarise, 
                 totalEmissions=sum(Emissions))
fips <- as.factor(dataSum$fips)
levels(fips) <- c("Los Angeles", "Baltimore")
dataSum$fips <- fips

# plot
# ANSWER:
# Los Angeles has better changes over time as it improved greatly when seeing
# the linear regression - it decreased its emissions better than Baltimore did, 
# however for its scale it is still has a lot more emissions
# than Baltimore: 25K tons vs < 5K tons of emissions

qplot(year, totalEmissions, data=dataSum, facets = .~fips,
      geom=c("point", "smooth"), method="lm",
      main="Total Mobile related Emissions in LA and Baltimore",
      ylab="Total Emissions in ton")

# save plot as png
ggsave("plot6.png")
