# Script written by Kam Dahlquist
# 2016-06-07
# From http://petersonbiology.com/math230Notes/ Chapter 2
# Electronic lab notebook found at: http://www.openwetware.org/wiki/Dahlquist:GCAT-SEEK_Workshop_2016

# Manually set working directory
# Made sure that this is set for my computer, not the tutorial
setwd("~/Travel-Conferences/GCAT-SEEK_2016/scripts")

# Read in the data directly
hotdogs <- read.csv("../data/hotdogs.csv")

# Look at the hotdogs data
head(hotdogs)

# Check all of the entries
hotdogs$Type

# Check just the levels directly
levels(hotdogs$Type)

# Make a table of hotdog types
table(hotdogs$Type)

# Make a table of hotdog types, this time assigning it to a variable
typeCounts <- table(hotdogs$Type)

# See how many total hotdogs are in the data
sum(typeCounts)

# Calculate proportions for each type of hotdog
typeCounts / sum( typeCounts )

# Use prop.table to directly compute proportions of each type in a table
prop.table(typeCounts)

# Make a pie chart of count data stored in typeCounts variable
pie(typeCounts)

# Make a barchart of count data stored in typeCounts variable
barplot(typeCounts)

# Beautify the plot by adding title and axis labels
barplot( typeCounts,
         main = "Distribution of Hotdog Types",
         xlab = "Hotdog Type",
         ylab = "Count")

# Load Titanic data by reading it into a variable called titanicData
titanicData <- read.csv("../data/titanicData.csv")

# Check the data
head(titanicData)

# Save and display the counts of living and dead in a variable called titanicSurvival
titanicSurvival <- table(titanicData$survival)
titanicSurvival

# How many people were on the Titanic?
sum(titanicSurvival)

# What proportion lived and died?
prop.table(titanicSurvival)

# Make a plot of survival
barplot(titanicSurvival,
        main = "Titanic Survival",
        xlab = "Status",
        ylab = "Number of people")

# Save and display the counts of people in different classes in a variable called titanicClass
titanicClass <- table(titanicData$class)
titanicClass

# How many people were on the Titanic?
sum(titanicClass)

# What proportion were in each class?
prop.table(titanicClass)

# Make a plot of peole in each class
barplot(titanicClass,
        main = "Where were people on the Titanic?",
        xlab = "Class",
        ylab = "Number of people")

# Don't forget to make the notebook