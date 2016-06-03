# Script written by Kam Dahlquist
# Learning R First Script
# 2016-06-03
# Try some simple arithmetic
3+2
3-2
3*2
3/2
# Store a simple variable, then display it
testVariable <- 3
testVariable
# Use the variable
plot(testVector, testVectorB)testVariable + 2
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
