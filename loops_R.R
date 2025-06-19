
# INTRODUCTION TO R

## Loops

# The final structure is the loop: 
# A loop allows you to assign repetitive tasks to our computer instead of doing them yourself. 
# The first kind of loop we’ll learn about is the for loop. 
# In this loop we specify the number of repetitions for a task explicitly. 
# The following loop prints the numbers from 1 to 5:

for (i in 1:5) {
  
  print(i)
  
}

# In the () part we define the counting variable, which is often called i (but can have any other name too) 
# and we define the values this counting variable should take (the values 1 to 5 in our case). 
# In the {} part we then define the task for every iteration. print(i) simply tells R to print the value of i into the console. 
# So the above loop has 5 iterations in each of which the current value of i is printed to the console.

# Of course we can also have proper computations. For example we can add up all the numbers from 1 to 1000 with this code:

result <- 0

for(count in 1:1000){
  
  result <- result + count
  
}

result

# Sometimes a repetitive task has to be done until a certain condition is met, 
# but we cannot tell beforehand how many iterations it is going to take. In these cases, we can use the while loop. 
# For example we can count how often we have to add 0.6 until we get to a number that is greater than 1000:

x <- 0 
counter <- 0 
while(x <= 1000){ 
  x <- x + 0.6 
  counter <- counter + 1 
} 
counter

# Before the loop starts, both x and counter have the value 0. Then in every iteration, x grows by 0.6 
# and counter by 1 to count the number of iterations. As soon as the condition in () is not met anylonger 
# (i.e. when x is greater than 1000), the loop stops. As you can see, it takes 1667 iterations to make x greater than 1000.

## Exercise 2

# Write a function is_prime(n) that takes an integer n as input and returns TRUE if n is a prime number, and FALSE otherwise. 
# Use this function to print all prime numbers between 1 and 50.

# Function to check if a number is prime 
is_prime <- function(n) {
  ############ YOUR CODE STARTS HERE ###############
  
  ########### YOUR CODE ENDS HERE ################
}

# Loop to print prime numbers between 1 and 50
for (num in 1:50) { 
  if (is_prime(num)) { 
    cat(num, "is a prime number.\n") 
  } 
}


# Hints:
 
# 1.  a %% b is the modulus operator. 
# It calculates the remainder when the number on the left-hand side (a) is divided by the number on the right-hand side (b).

## Data manipulation

# Previously, we conducted some basic exploratory analysis on our data, but it was limited. 
# To further analyze our data, we need more advanced tools for data manipulation.

# The tidyverse (Wickham et al. 2019) is an R package that contains a lot of useful functions to deal with these problems, 
# so we’ll start by installing and loading this package:

install.packages("tidyverse") #only do this once

library(tidyverse)

# Here we will use our test.csv data. Please make sure to use read_csv() and not read.csv(). 
# While both are used to read csv-files into R, 
# the former is a special tidyverse function that gives your data.frame a couple of nice extra features.

# load data 
example_csv = read_csv("example.csv") 
example_csv

# If we look at the type of example_csv using class(), we can see that it is more than just a data.frame, 
# it is for example also a tbl which is short for tibble.

class(example_csv)

## Select, Filter, Apply

# The first two functions for data manipulation are select(), which allows you to keep only certain variables (i.e. columns) 
# and filter(), which allows you to keep only certain rows.

# As its first argument, select() takes a data.frame or tibble and as its second argument the names of the variables you want to keep. 
# Although it is technically not needed, we recommend bundling together the variable names in a vector:

select(example_csv, c(Category, Sales))

# It is also possible to specify the variables you want to throw out instead, by putting a - before their names:

select(example_csv, -c(Category, Sales))

# When you use filter() to chose only certain rows, we’ll mostly have some kind of rule which cases to keep. 
# These rules are expressed as logical statements. filter() takes a tibble as its first and a logical expression as its second argument:

filter(example_csv,(Category == "Electronics") & (Type == "High-End") & Profit > 2600 )

# It is also possible to select parts of your tibble by simply listing the indices of the rows and columns want want to keep. 
# This works similarly to subsetting a vector by using [<rows to keep> , <columns to keep>]:

example_csv[c(1:3), c(1,3)] #keep rows 1 to 3 and columns 1 and 3

# If we want to keep all columns or all rows, we leave the corresponding element in the [,] empty. 
# We nevertheless have to keep the comma!
 
example_csv[1,] #only keep first row

example_csv[,2] #only keep second column

# Apply functions are a family of functions in base R that allow you to repetitively perform an action on multiple chunks of data. 
# An apply function is essentially a loop but runs faster than loops and often requires less code.

# There are many different apply functions because they are meant to operate on different types of data 
# (e.g., apply, lapply, sapply, vapply, tapply, and mapply). Here, we will only discuss apply for simplicity.

# the apply function looks like this: apply(X, MARGIN, FUN).

# -   X is an array or matrix (this is the data that you will be performing the function on)

# -   Margin specifies whether you want to apply the function across rows (1) or columns (2)

# -   FUN is the function you want to use
 
# my.matrx is a matrix with 1-10 in column 1, 11-20 in column 2, and 21-30 in column 3. 
# my.matrx will be used to show some of the basic uses for the apply function.
 
my.matrx <- matrix(c(1:10, 11:20, 21:30), nrow = 10, ncol = 3) 
my.matrx

# What if we wanted to summarize the data in matrix m by finding the sum of each row

apply(my.matrx, 1, sum)


# What if I wanted to be able to find how many datapoints (n) are in each column of m?

apply(my.matrx, 2, length)

# What if instead, I wanted to find n-1 for each column? 
# There isn’t a function in R to do this automatically, so I can create my own function. 
# If the function is simple, you can create it right inside the arguments for apply. 
# In the arguments I created a function that returns length - 1.

apply(my.matrx, 2, function (x) length(x)-1)

# If we don’t want to write a function inside of the arguments, we can define the function outside of apply, 
# and then use that function in apply later. This may be useful if you want to have the function available to use later. 
# In this example, a function to find standard error was created, then passed into an apply function.

st.err <- function(x){ 
  sd(x)/sqrt(length(x)) 
} 
apply(my.matrx,2, st.err)

## Computing summaries by group

# One thing we’ll want to do quite often in statistics is to compute a certain statistic not for our whole sample 
# but individually for certain subgroups. The steps needed for this are the following:
 
# 1.  group your data in subsets according to some factor, e.g., Type
 
# 2.  apply the statistic to each subset
 
# 3.  combine the results in a suitable way
 
# R has a huge number of solutions for this. Some of the most handy ones are part of the dplyr package, 
# which we’ve already loaded as part of the tidyverse. Among others, 
# this package introduces the so-called pipe operator %\>% which is used to chain together multiple operations on the same data set.
 
# The following code takes our data example_csv and computes the the mean Profit and the median Expenses for each Type. 
# Here’s a breakdown of each line:
 
# -   example_csv %\>%: Here the pipe operator (%\>%) is used to pass the data frame example_csv into the subsequent operations.
 
# -   group_by(Type): Groups the data by the levels of the Type variable, 
#     indicating that subsequent summary statistics will be calculated for each unique Type group.
 
# -   summarise(meanProfit=mean(Profit, na.rm=T), medianExpenses=median(Expenses, na.rm=T)): 
#     This line creates summary statistics for each Type group. It calculates the mean of the Profit variable, 
#     assigning the result to a new variable called meanProfit. 
#     Similarly, it calculates the median of the Expenses variable and assigns the result to a new variable called medianExpenses. 
#     The na.rm = T argument is used to exclude any missing values from the calculations.

example_csv

example_csv %>% 
  group_by(Type) %>% 
  summarise(meanProfit=mean(Profit, na.rm=T), medianExpenses=median(Expenses, na.rm=T))

# Instead of generating a separate table for the summaries, 
# an alternative approach is to integrate the computed values directly into the input data by substituting summarise() with mutate():

example_csv %>% 
  group_by(Type) %>% 
  mutate(meanProfit=mean(Profit, na.rm=T), medianExpenses=median(Expenses, na.rm=T))


example_csv %>% 
  group_by(Type) %>% 
  mutate(meanProfit=mean(Profit, na.rm=T), medianExpenses=median(Expenses, na.rm=T)) %>%  filter(Type == "High-End")

## Exercise 3

# Calculate the difference between sales and expenses (net revenue). 
# Then, filter out the cases where the net revenue is below the average net revenue for each category. 
# Replace the `"..."` with your code.

########## YOUR CODE STARTS HERE ##########

# Step 1: Calculate the difference between sales and expenses (net revenue) for each row 
# and save the result in a new column called Net_Revenue. 
example_csv_with_net_revenue <- example_csv %>% ...

# Step 2: Filter out the cases where the net revenue is below the average net revenue for each category.
filtered_data <- example_csv_with_net_revenue %>% ...

########## YOUR CODE ENDS HERE ########## 

## Solutions

## Solution to exercise 1


# Function to compute the Euclidean distance between two vectors
computeEucDistance <- function(vect1, vect2) {
  # Calculate the squared differences between corresponding elements
  squared_differences <- (vect1 - vect2)^2
  
  # Sum the squared differences
  sum_squared_differences <- sum(squared_differences)
  
  # Take the square root of the sum to get the Euclidean distance
  distance <- sqrt(sum_squared_differences)
  
  # Return the computed distance
  return(distance)
}

vector_1 <- c(1, 1)
vector_2 <- c(2, 2)

# Compute and print the Euclidean distance between the two vectors
distance <- computeEucDistance(vector_1, vector_2)
cat("The Euclidean distance between the vectors is:", distance, "\n")

## Solution to exercise 2
 
# Function to check if a number is prime
is_prime <- function(n) {
  # Check if n is less than or equal to 1
  if (n <= 1) {
    return(FALSE)
  }
  
  # Check for factors from 2 to sqrt(n)
  for (i in 2:sqrt(n)) {
    if (n %% i == 0) {
      return(FALSE)
    }
  }
  
  return(TRUE)
}

# Loop to print prime numbers between 1 and 50
for (num in 1:50) {
  if (is_prime(num)) {
    cat(num, "is a prime number.\n")
  }
}


## Solution to exercise 3

# Step 1: Calculate the difference between sales and expenses (net revenue) for each row 
# and save the result in a new column called Net_Revenue.
example_csv_with_net_revenue <- example_csv %>%
  mutate(Net_Revenue = Sales - Expenses)

# Step 2: Filter out the cases where the net revenue is below the average net revenue for each category.
filtered_data <- example_csv_with_net_revenue %>%
  group_by(Category) %>%
  mutate(Avg_Net_Revenue = mean(Net_Revenue)) %>%
  filter(Avg_Net_Revenue >= Net_Revenue) 

## Session information

sessionInfo()
