# Szymon Kozlowski
# 8/1/2022

# Import Readr Library
# Reader quickly loads the csv dataset
library(readr)

# Gets the working directory, helpful when working with files
getwd()

# Command makes sure that the file exists
file.exists("Stem_TDR_VWC_gal.csv")

# Sent the data from the CSV file for shrubs in a specific region into a variable
data2 <- read_csv("Stem_TDR_VWC_gal.csv")

# Played around with the data

# Initially, the plot for the whole CSV was messy, and took a long time to load
plot(data2$Timestamp,data2$VWC)

# In order to make the data more readable, I trimmed it to a specific date range

# Loaded the dates I wanted data for into variables for ease of access
DATE1 <- as.Date("2017-05-01")
DATE2 <- as.Date("2017-09-01")
newData <- data2[data2$Timestamp > DATE1 & data2$Timestamp < DATE2,]
plot(newData$Timestamp,newData$VWC)

# However, this data was still barely readable, although a trend started to form

# In order to make the data more readable, I decided to only look at the data from one shrub
newData1 <- newData[newData$Stem == 1,]
plot(newData1$Timestamp,newData1$VWC)

# While this improved the readability, it still wasn't great

# To improve the graph, I averaged all of the data from individual days into one point

# This finally made the graph decent 
newData3 <- aggregate(VWC ~ Timestamp, newData1, mean)
plot(newData3$Timestamp,newData3$VWC)

# However, that graph now lacked data, as it only included one shrub

# I took took the data from one of the initial graphs, and trimmed it similarly to the previous one, except I included all of the shrubs
newData4 <- aggregate(VWC ~ Timestamp, newData, mean)
plot(newData4$Timestamp,newData4$VWC)

# Added some labels to the graph
plot(newData4$Timestamp,newData4$VWC,
     pch = 19,
     main = "Water Moisture Content of Shrubs at Galbraith Lake, Alaska",
     ylab = "Stem Moisture (%WMC)",
     xlab = "Dates",
     )

# Turned it into a line graph, in order to emulate the graph in the study article
plot(newData4$Timestamp,newData4$VWC, 
     type = "l",
     main = "Water Moisture Content of Shrubs at Galbraith Lake, Alaska",
     ylab = "Stem Moisture (%WMC)",
     xlab = "Dates",)

# Clear packages
detach("package:datasets", unload = TRUE)

# Clear plots
dev.off()



