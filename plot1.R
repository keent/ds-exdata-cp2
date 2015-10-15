library(plyr)

# read the data
if (!exists("NEI")) NEI <- readRDS("summarySCC_PM25.rds")
if (!exists("SCC")) SCC <- readRDS("Source_Classification_Code.rds")

# let's summarize it fist by getting the total
# the data is too large
totalByYear <- ddply(NEI, ~year, summarise, 
                     totalEmissions=sum(Emissions))

# plot emissions by year and use a simple linear model
# ANSWER: YES, there seems to be a DOWNTREND
# emissions decreased over time
with(totalByYear, plot(year, totalEmissions, pch=20,
                       main="Total Emissions per Year",
                       ylab="Total Emissions in Tons"))
model <- lm(totalEmissions ~ year, totalByYear)
abline(model, lwd=2)

# here's another kind of plot,
# same but uses lines:
# plot(totalByYear, type="l", main="Total Emissions per Year",
#      ylab="Total Emissions in Ton")

# save plot as png
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()