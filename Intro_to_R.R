
# INTRODUCTION TO R

# Let us check some basics

2-5*3^2

(2-5)*3^2

(2-5)*(3^2)

# In R, you can assign values to variables using `<-`, `->`, or `=`.

x <- 3

7 -> some.complicated.name

z = 10

x + some.complicated.name + z

# Note: You cannot use `10 = z` for assignment.

# You can view all defined objects and remove them when needed.


ls()       # View all objects

rm(x)      # Remove a specific variable

rm(list=ls())  # Remove all variables

# Data structures
 
## Vectors

# A vector is a sequence of elements of the same type.

my_vector <- c(8, 2, 4, 6, 2, 1)
my_vector

# Operations with vector

my_vector * 2

# R executes the operation element-wise. 
# This means the computation should involve either two elements of the same length (like a+b) or one vector 
# and a single number (like a\*3). If the lengths of the vectors in your calculation don’t fit, 
# R will recycle the shorter to make it fit the longer of the vectors.

b <- c(1, 1, 1, 1, 1, 1)
my_vector + b

# Let check this one

long <- c(1, 2, 3, 4)
short <- c(1, 2)
long+short

# The shorter vector was repeated, i.e. the calculation was long + c(short, short).

# Every element of a vector can be accessed individually by referencing its position (i.e. its index) in the vector. 
# You can for example retrieve the fourth element of my_vector like this:

my_vector
my_vector[4]

# It is also possible to select more than one element of the vector by using an integer vector of the desired indices (e.g. c(1,4,5) 
# if you want to retrieve the first, fourth and fifth element of a vector) within the square brackets:

my_vector
my_vector[c(1, 4, 5)]

# We call this subsetting your vector. For subsetting vectors we often need longer sequences of integers. 
# To generate a sequence of consecutive integer numbers R has the <start> : <end> operator, which is read as from <start> to <end>:

4:15 #generates sequence from 4 to 15

## Character

# A piece of text is called a string and is written in a pair of double or single quotes.

v2 <- c("male", "female", "female", "male")
v2

f <- c("wrinkled", "round", "wrinkled", "round", "round")
f

Ht <- c("tall", "tall", "short", "short", "short")
Ht

v3 <- c('blue', 'brown', 'yellow')
v3

## Logical
# In the logical vector, the elements of which are the so called booleans TRUE and FALSE, 
# which can be shortened by T and F (cases matter, you have to use upper case letters in both versions.)

c(TRUE, FALSE, TRUE)

c(F, T, T, T)

# Boolean values are the result of logical operations, that is, of statements that can be either true or false:

3 < 4

# The most common logical operators:

# -   AND &
 
# -   OR \|
 
# -   NOT !

# -   greater than \>
 
# -   greater or equal \>=
 
# -   less than \<
 
# -   less or equal \<=
 
# -   equal to == (yes, you need two equal signs)
 
# -   not equal to !=

# Combination of logical operations

((1+2)==(5-2)) & (7<9)

