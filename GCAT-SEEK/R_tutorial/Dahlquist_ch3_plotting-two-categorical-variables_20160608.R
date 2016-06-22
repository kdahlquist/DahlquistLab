# Script written by Kam Dahlquist
# 2016-06-08
# From http://petersonbiology.com/math230Notes/ Chapter 3
# Electronic lab notebook found at: http://www.openwetware.org/wiki/Dahlquist:GCAT-SEEK_Workshop_2016

# Manually set working directory
# Made sure that this is set for my computer, not the tutorial
setwd("~/Travel-Conferences/GCAT-SEEK_2016/scripts")

# Load data into variables by reading from csv files
titanic <- read.csv("../data/titanicData.csv")
popularKids <- read.csv("../data/popularKids.csv")

# Make table of Gender
table(popularKids$Gender)

# Make barplot of Gender
barplot( table(popularKids$Gender),
         main = "Proportion of Boys and Girls in Sample",
         xlab = "Gender",
         ylab = "Count")

# Make table of Goals
table(popularKids$Goals)

# Make barplot of Gender
barplot( table(popularKids$Goals),
         main = "Students choice in personal goals",
         xlab = "Goals",
         ylab = "Count")

# Save a table of the two-way interaction between gender and goals
genderGoals <- table(popularKids$Gender, popularKids$Goals)

# Enter the variable name to display it
genderGoals

# Make a simple (default) barplot
barplot(genderGoals,
        main = "Goals divided by gender",
        xlab = "Goals",
        ylab = "Count")

# Make a barplot with a legend, with bars side-by-side
barplot(genderGoals,
        main = "Goals divided by gender",
        xlab = "Goals",
        ylab = "Count",
        legend.text = TRUE,
        beside = TRUE)

# Save a table of location and goals
locGoals <- table(popularKids$Urban.Rural,
                  popularKids$Goals)
# View the table
locGoals

# Plot the result of location vs. goals
barplot(locGoals,
        legend.text = TRUE,
        beside = TRUE,
        main = "Does location matter?",
        xlab = "Personal goal",
        ylab = "Number of students")

# Save a second table of location and goals so data is transposed
locGoalsB <- table(popularKids$Goals,
                   popularKids$Urban.Rural)

# Plot the result of transposed location vs. goals
barplot(locGoalsB,
        legend.text = TRUE,
        beside = TRUE,
        main = "Does location matter?",
        xlab = "Location",
        ylab = "Number of students")

# Display the original table transposed
t(locGoals)

# Plot the original table transposed
barplot(t(locGoals),
        legend.text = TRUE,
        beside = TRUE,
        main = "Does location matter?",
        xlab = "Location",
        ylab = "Number of students")

# Make a plot of the difference in goals by gender with the bars reversed from before. 
barplot(t(genderGoals),
        main = "Goals divided by gender",
        xlab = "Goals",
        ylab = "Count",
        legend.text = TRUE,
        beside = TRUE)
# boys and girls are similar with respect to desire for good grades, but girls rate being popular higher than sports and boys rank them about equal.

# Save a two-way table of survival for the Titanic data
survivalClass <-  table(titanic$survival,titanic$class)

# Make a plot of survival for each class of passenger
barplot(survivalClass,
        main = "Survival by Class",
        xlab = "Class",
        ylab = "Number of People",
        legend.text = TRUE,
        beside = TRUE)

# Look at the margins, i.e., the sum of each class
addmargins(survivalClass)

# Simple example of the conditional distribution of survival
prop.table(survivalClass)

# compute the conditional distribution by column, which is class
prop.table(survivalClass,
           margin = 2)

# check answer to see if columns sum to 1 as we would expect
addmargins(prop.table(survivalClass,
                      margin = 2))

# Plot the conditional distribution of survival by class, embedding computation in plot call
barplot( prop.table(survivalClass,
                    margin = 2),
         main = "Survival by Class",
         legend.text = TRUE,
         ylab = "Proportion surviving",
         xlab = "Class")

# Make a table of gender by survival
survivalGender <- table(titanic$survival,titanic$gender)

# Plot the conditional distributions of gender by survival
barplot( prop.table(survivalGender, 2),
         main = "Survival by Gender",
         legend.text = TRUE,
         ylab = "Proportion surviving",
         xlab = "Gender")

# Look at the raw counts of survival by gender
survivalGender

# Save a two-way table of gender by class for Titanic data
genderClass <-  table(titanic$gender,titanic$class)
genderClass

# Plot the conditional distributions of gender by class
barplot( prop.table(genderClass, 2),
         main = "Where were the Women?",
         legend.text = TRUE,
         ylab = "Proportion within class",
         xlab = "Class")

# define a new variable which is the transpose of gender by class and display
genderClass2 <- t(genderClass)
genderClass2

# Plot the conditional distributions of class by gender
barplot( prop.table(genderClass2, 2),
         main = "Difference in class by gender",
         legend.text = TRUE,
         ylab = "Proportion within gender",
         xlab = "gender")