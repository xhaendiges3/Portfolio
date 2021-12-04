################################################################################
# EXAM 3 Code Template  
# By: [Xavier Haendiges]
# MIS 4580
# Copyright 2020 Dr. Anahita Sanandaji.
# This may not be shared or posted without permission. 
################################################################################

#install and load the packages:
install.packages("ggplot2")
install.packages("gridExtra")
install.packages("readr")
install.packages("tidyverse")
library(ggplot2)
library(gridExtra)
library(readr)
library(dplyr)
# Please set your working directory now: you can also go to session -> Set working directory or use setwd("..")

#===============================================================================
# Question 1) Bar Plot                                
#===============================================================================
# USE: Animals.csv
# Your code goes here:
myData <- read_csv("Animals.csv")

# a) Basic Bar plot
myBar <- table(myData$eating_type)

barplot(myBar, main = "Xavier Haendiges's q1-a) Bar Plot",
        xlab = "Eating Type", ylab = "Count",
        col = "blue")

# b) Quick bar Plot
qplot(data = myData, eating_type, geom = "bar", main = "Xavier Haendiges's q1-b) Bar plot",
      xlab = "Eating Type", ylab = "Count",
      fill = eating_type)

# c) Use of dplyr
myTable <- myData %>% 
  group_by(eating_type) %>%
  summarise(meanBody = mean(bodywt))

barplot(myTable$meanBody, names.arg = myTable$eating_type,
        main = "Xavier Haendiges's q1-c) Bar chart Average Price per Cut",
        xlab = "Eating Type", ylab = "Mean of Body Weight",
        col = "orange")

#===============================================================================
# Question 2) Box plot                              
#===============================================================================
# CONTINUE WITH myData
# a) Basic Box plot
boxplot(data = myData, bodywt ~ eating_type,
        main = "Xavier Haendiges's q2-a) Box Plot",
        xlab = "Eating Type", ylab = "Body Weight",
        col = "yellow")

# b) Quick Box plot
qplot(data = myData, x = eating_type, y = bodywt,
      geom = "boxplot",
      main = "Xavier Haendiges's q2-b) Box Plot",
      xlab = "Eating Type", ylab = "Body Weight",
      fill = eating_type)

#===============================================================================
# Question 3) Scatter plot with ggplot()                                  
#===============================================================================
# USE: Twitter.csv
# Your code goes here:
Twitter <- read_csv("Twitter.csv")

p1 <- ggplot(Twitter, aes(x = date_time, y= number_of_likes)) +
  geom_point() +
  ggtitle("a): Xavier Haendiges's Basic Scatter")

p2 <- ggplot(Twitter, aes(x = date_time, y= number_of_likes)) +
  geom_point(color = "blue") +
  ggtitle("b): Xavier Haendiges's Basic Scatter")

p3 <- ggplot(Twitter, aes(x = date_time, y= number_of_likes, color = factor(author))) +
  geom_point() +
  ggtitle("c): Xavier Haendiges's Basic Scatter")

grid.arrange(p1, p2, p3, ncol = 3)

#===============================================================================
# Question 4) Bar plot: Use of coord_flip() & reorder()                                   
#===============================================================================
# use diamonds
# dplyr
myDiamonds <- diamonds %>% 
  group_by(cut) %>%
  summarise(meanPrice = mean(price))

#plot
ggplot(myDiamonds, aes(x = reorder(cut, meanPrice), y = meanPrice)) +
  geom_bar(stat = "identity", fill = "orange", color = "black", alpha = 0.3) +
  coord_flip() +
  scale_y_continuous(labels = scales::dollar) +
  labs(title = "Average Price by Cut", 
       subtitle = "By Xavier Haendiges",
       x = "Average Price",
       y = "Cut")

#===============================================================================
# Question 5) Advanced Bar Plot                                    
#===============================================================================
# use diamonds
diamonds
head(diamonds)
# a) Simple Bar Plot
ggplot(diamonds, aes(x = cut)) +
  geom_bar(fill = "red", color = "grey40", alpha = 0.5, width = 0.9) +
  labs(title = "Diamond Cuts", 
       subtitle = "By Xavier Haendiges",
       x = "Cuts", 
       y = "Number of Diamonds")

#-----------------------------------------------------------------------------
# b) Side by side Bar Plot
# dplyr

avg_price <- diamonds %>%
  group_by(cut, color) %>%
  summarise(meanLike = mean(price, na.rm = TRUE))

ggplot(avg_price, aes(factor(cut), meanLike, fill = color)) +
  geom_bar(stat = "identity", position = "dodge", color = "grey40") +
  scale_fill_brewer(palette = "Accent") +
  scale_y_continuous(labels = scales::dollar) +
  labs(title = "Side-by-side Bar Plot", 
       subtitle = "By Xavier Haendiges",
       fill = "Color",
       x = "Cut",
       y = "Average Price")

-----------------------------------------------------------------------------
  # c) Stacked Plot
  
  ggplot(avg_price, aes(factor(cut), meanLike, fill = color)) +
  geom_bar(stat = "identity", color = "grey40") +
  scale_fill_brewer(palette = "Pastel2") +
  scale_y_continuous(labels = scales::dollar) +
  labs(title = "Stack Plot", 
       subtitle = "By Xavier Haendiges",
       fill = "Color", 
       x = "Cut",
       y = "Average Price")