
# INTRODUCTION TO R

## Data frames

# If you want to do statistics, the most likely format your data will come in is some kind of table. In R, the basic form of a table is called a data.frame and looks like this:
 
# | Name      | Height | Gender | Age |
# |-----------|--------|--------|-----|
# | Rooney    | 186.4  | male   | 25  |
# | Mike      | 174.7  | male   | 32  |
# | Shanice   | 153.1  | female | 27  |
# | Antonella | 162.9  | female | 24  |
 
# Every row is an observation (e.g. individual or a measurement point) 
# Each column is a variable on which the observation is measured (e.g. age, gender etc.).

# Create vectors for each column 
Name <- c("Rooney", "Mike", "Shanice", "Antonella") 
Height <- c(184.4, 174.7, 153.1, 162.9) 
Gender <- c("male", "male", "female", "female") 
Age <- c(25, 32, 27, 24)

# Combine the vectors into a dataframe

df <- data.frame(Name, Height, Gender, Age) 
df

# We can extract each of the columns with a \$ :

df$Name


# It is also possible to select parts of your data.frame by simply listing the indices of the rows and columns we want to keep. 
# This works similarly to subsetting a vector by using [<rows to keep> , <columns to keep>]:

df[c(1:3), c(1,3)] # keep rows 1 to 3 and columns 1 and 3

# If we want to keep all columns or all rows, leave the corresponding element in the [,] empty. keep the comma!

df[1,] # only keep first row

df[,2] # only keep second column

# A data.frame in R is a number of vectors of the same length that have been stuck together column-wise to build a table. 
# Each column must have a unique format but different formats can be assigned to different columns.

## Lists

# While data.frames are useful to bundle together vectors of the same length, lists are used to combine more heterogeneous data. 
# The following block of code creates a list:

# create list 
my.list <- list(my_vector, df, 1, "a string") 
print(my.list)

# A list is a collection of R objects that are called the elements of the list. 
# Lists are similar to data.frames, but while data.frames can only have vectors of the same length as their elements (i.e. variables), 
# lists can have all kinds of data types as elements. An element of a list can be a vector of arbitrary length, a data.frame, 
# another list or even a function. You can access a single list element by referencing its position in the list 
# using double square brackets [[]]:

my.list[[1]]

my.list[[2]]

# If we want to subset the list (i.e. keep only certain parts), use single square brackets []:

print(my.list[2:4])

# Note that if you use single square brackets [], the result will always be a list, 
# whereas using double square brackets [[]] will return whatever type the object is that you are referencing with [[]].

# my.list is an unnamed list, but it is also possible to create a named list:

#create list 
my.named.list <- list(a=my_vector, b=df, c=1, d="a string") 
print(my.named.list )

# The advantage of a named list is that you can extract the list elements by their names, 
# similar to extracting variables from a data.frame:

my.named.list$a

# The square brackets [] and [[]] do however also work on named lists.
# Because lists can bundle a lot of heterogeneous data in one R object, 
# they are quite often used to give results of functions for statistical analyses as you will see later on.

## Type of data structure

# We can find out what type of data structure an object is with the class() function:

class(my.list)

class(df)

class(c(TRUE,FALSE, FALSE))

# When we get more complex objects, it can sometimes be useful to get an overview over their structure with str():

str(my.list)

## Functions

### Function

# A function can be thought of as a small machine that takes some input (usually some kind of data), 
# processes that input in a certain way, and gives back the result as output.

# R has some built-in functions.

# mwan

mean(c(2, 4, 6))

# The information that goes into the function is called an argument, the output is called the result. 
# A function can have an arbitrary number of arguments, which are named to tell them apart. 
# The function log() for example takes two arguments: a numeric vector x with numbers we want to take the logarithm of 
# and a single integer base with respect to which the logarithm should be taken:

log(x = c(10, 20, 30), base = 10)

# To find out how a function is used (i.e. what arguments it takes and what kind of result it returns) we can use R’s help. 
# Just put ? in front of the function name (without brackets after the function name). 
# If we run this code, the help page appears in the lower right window in R Studio.

?log

