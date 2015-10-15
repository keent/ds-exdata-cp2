library(plyr)

# read the data
if (!exists("NEI")) NEI <- readRDS("summarySCC_PM25.rds")
if (!exists("SCC")) SCC <- readRDS("Source_Classification_Code.rds")

# get the total emissions for Baltimore, MD
dataBaltimore <- NEI %>% subset(fips==24510)
dataSum <- ddply(dataBaltimore, ~year, summarise, 
                 totalEmissions=sum(Emissions))
# plot
# ANSWER: YES, there seems to be a SLIGHT downtrend
# emissions decreased over time
plot(dataSum$year, dataSum$totalEmissions, pch=20,
     main="Total Emissions by Year in Baltimore, MD",
     xlab="Year", ylab="Total Emissions in Tons")

# fit a simple linear model
model <- lm(totalEmissions ~ year, dataSum)
abline(model, lwd=2)

# another way to see it:
# plot(dataSum$year, dataSum$totalEmissions, type="l",
#      main="Total Emissions by Year in Baltimore, MD",
#      xlab="Year", ylab="Total Emissions in tons")

# save plot as png
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()