# Script written by Kam Dahlquist
# Learning R First Script
# 2016-06-03

# Manually set working directory
# Made sure that this is set for my computer, not the tutorial
setwd("~/Travel-Conferences/GCAT-SEEK_2016/scripts")

# Try some simple arithmetic
3+2
3-2
3*2
3/2

# Store a simple variable, then display it
testVariable <- 3
testVariable

# Use the variable
testVariable + 2
testVariable * 2

# Change test variable
testVariable <- 4
testVariable

# Make a test vector, then display it
testVector <- c(1,3,4,6,8,10,15)
testVector

# See how vectors respond to arithmetic
testVector + 3
testVector * 2
testVector + testVector

# Create a second vector
testVectorB <- testVector + 3
testVectorB

# Display only the 3rd element of a vector
testVectorB[3]

# Display only elements greater than 8
testVectorB[testVectorB > 8]

# Show how it is done:
testVectorB > 8

# Display the value of testVectorB when testVector equals 3
# Note that two '=' are used for logical tests
testVectorB[testVector == 3]

# Make a plot of two vectors
plot(testVector, testVectorB)

# Practice making a data frame
testDataFrame <- data.frame(testVector,testVectorB)
testDataFrame

# What RStudio added to my Console after using menu to read csv data file
hotdogs <- read.csv("~/Travel-Conferences/GCAT-SEEK_2016/data/hotdogs.csv")
View(hotdogs)

# Read hotdogs.csv data file directly instead of from menu
read.csv("../data/hotdogs.csv")

# previous data was read in, but not saved, so we are going to assign it to the variable hotdogs
hotdogs <- read.csv("../data/hotdogs.csv")

# Look at the top of the hotdogs data
head(hotdogs)

# Look at the data a little more completely
summary(hotdogs)

# Install knitr
# commented out line after running it so that it doesn't run again each time I run this script
# install.packages('knitr')
