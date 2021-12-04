################################################################################
# R Basics: E2 Student Code Template
# By: [Xavier Haendiges]
# MIS 4580 - Fall 2020
# Copyright 2020 may not be shared or posted without permission. 
################################################################################

#install and load the packages:
install.packages("lubridate")
install.packages("tidyverse")
install.packages("readr")
### ATTENTION ###
## you may need to use the below two lines of codes if you see error messages loading "readr"
### install.packages('Rcpp', dependencies = TRUE)
### install.packages('readr', dependencies = TRUE)
### ATTENTION ###

## Loading Libraries
library(lubridate)
library(readr)
library(tidyverse)
library(dplyr)


#===============================================================================
# Question 1) Working with Numbers: Generate Numbers                                         
#===============================================================================
# Generate this sequence and store it in set1: 2 2 2 -4 -4 -4 6 6 6 -19 -19 -19. 
# You must use rep() 
set1 <- rep(c(2,-4,6,-19), each = 3)

#Generate 10 random integers between 30 and 60 (without replacement) 
set2 <- sample(30:60, 10, replace = FALSE)

#Generate 300 random numbers from a Normal Distribution with mean of 100 and SD of 5   
set3 <- rnorm(300, mean = 100, sd = 5)
hist(set3)
# output and Histogram


#===============================================================================
# Question 2) Working with Characters and Strings                                                
#===============================================================================
examText <- "THIS-IS-EXAM 2-MIS-4580."

# Make original text lower case: and store it in newExamText
newExamText <-  tolower(examText)

# Split newExamText based on "-" and store in examSplit. Hint: use strsplit().
examSplit <- strsplit(newExamText, split = "-")

# Unlist examSplit (hint use unlist()) and store in examSplitText.
examSplitText <- unlist(examSplit)

# Sort examSplitText and store it in examSortText.
examSortText <-  sort(examSplitText)

# Output how many characters examText string has.
nchar(examText)

# Print this: "new text is [content of newExamText]". Hint: use sprintf()
sprintf("new text is [%s]", newExamText)

# Also display: #examSplit & examSortText
examSplit
examSortText

#===============================================================================
# Question 3) Working with Dates                                         
#===============================================================================
# Your code goes here: 
# Part 1)
examTime <- "2021-10-19"

#Using year() Get the years for examTime.
year(examTime)

#Using month() Get the months for examTime. make sure Label is TRUE.
month(examTime, label = TRUE)

# Using wday() get the week days for examTime. make sure Label is TRUE, 
# AND abbr is TRUE.
wday(examTime, label = TRUE, abbr = TRUE)
#______________________________________________________________________________
## Part 2)
#Get the current date and time of your system and save it in t1  
t1 <- now()


#Read this "2020-11-29" convert it to date (hint use as.Date()) and save it in t2
x <- "2020-11-29"
t2 <- as.Date(x)

# check to see if t1 > t2.  
t1 > t2

# Find the difference between the two dates.
as.Date(t1) - t2

#===============================================================================
# Question 4) Working with Dates                                         
#===============================================================================
# Your code goes here:
library("readr")
# Import .csv file: in case using read_csv You need library(readr)
myExamData1 <- read_csv("examData1.csv")

# Part 1)
#factor
genderFactor <- factor(myExamData1$Gender, levels = c("F", "M"))

# summary()
summary(genderFactor)


#table()
table(genderFactor)

#________________________________________________________________________________
#Part 2)
# Your code goes here:

#a) Produce tables based on two categorical variables: ProductGroup by State
examTable1 <- table(myExamData1$ProductGroup, myExamData1$State) 
#------------------------------------------

#b) Produce multidimensional table based on three or more categorical variables: 
#  Gender, Homeowner, State 
examTable2 <- table(myExamData1$Gender, myExamData1$Homeowner, myExamData1$State)

#use of ftable()
ftable(examTable2)
#------------------------------------------

#c) Using prop.table() find proportions based two categorical variables for examTable1.
propExamTable <- prop.table(examTable1)
#Round the content to 2 decimal places.
finalPropTable <- round(propExamTable, 2)

#===============================================================================
# Question 5) Numeric Data Analysis & Data Transformation using dplyr                                    
#===============================================================================
# Import .csv file: in case using read_csv You need library(readr)
myExamData2 <- read_csv("examData2.csv")

## a) fivenum() and Range()
myFive <- fivenum(myExamData2$depth)


myMin <- min(myExamData2$depth)
myMax <- max(myExamData2$depth)

myRange <- myMax - myMin

myFive
myRange
#--------------------------------------------------------------------------------

# b)  Use summarise() to get minimum, median, mean, variance, 
# Standard deviation, maximum, total of the price column. 
# Also find the count of rows. 
# Please make sure to set na.rm=TRUE when needed. 
myExamData2 %>% summarise(minPrice = min(price, na.rm = TRUE),
                          medianPrice = median(price, na.rm = TRUE),
                          meanPrice = mean(price, na.rm = TRUE),
                          varPrice = var(price, na.rm = TRUE),
                          SDPrice = sd(price, na.rm = TRUE),
                          maxPrice = max(price, na.rm = TRUE),
                          sumPrice = sum(price, na.rm = TRUE),
                          countData = n())
#-------------------------------------------------------------------------------

#c) Use the filter() to filter rows that have
#   cut ("Good" or "Ideal") and (color "E" or  "J"). 
#   Then use the arrange() to sort your results based on "price" descending.
myFilterTable <- myExamData2 %>% 
  filter((cut == "Good" | cut == "Ideal") & (color == "E" | color == "J")) %>%
  group_by(color) 
arrange(myFilterTable, desc(price))
#-------------------------------------------------------------------------------

#d) Find mean, maximum, and minimum of price per cut. 
# Sort the results based on mean of price descending. 
# Please make sure to set na.rm=TRUE when needed. (you need to use dplyr package)
examResults <- myExamData2 %>%
  group_by(cut) %>%
  summarise(meanPrice = mean(price, na.rm = TRUE),
            maxPrice = max(price, na.rm = TRUE),
            minPrice = min(price, na.rm = TRUE)) %>%
  arrange(desc(meanPrice))
#-------------------------------------------------------------------------------
# e) Export to CSV
write_csv(examResults, path = "xh918718_E2Results.csv", col_names = TRUE)