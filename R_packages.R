
# INTRODUCTION TO R

## Packages

# A basic set of functions are already included in basic R. 
# But since there is a huge community worldwide constantly developing new functions and features for R 
# and since the entirety of all R functions there are is way to big to install at once, 
# most of the functions are bundeled into so called packages. 
# A package is a bundle of functions you can download and 
# install from the Comprehensive R Archive Network (CRAN) (<https://cran.r-project.org/>). 
# If you visit the site, you can also get an overview over all available packages. 
# You can install a package by using the function install.packages() 
# which takes the package name as a string (i.e.in quotes) as its argument:

install.packages("lubridate")

# Once we have installed the package, its functions are downloaded to our computer but are not accessible yet, 
# because the package has to be activated first.

# To activate the package, you use the function library(). 
# This function activates the package for your current R session, 
# so you have to do this once per session (a session starts when you open R/Rstudio and ends when you close the window).

library(lubridate) 
today()

## Read data

# *working directory*

# The working directory is the folder on the computer where R looks for files to import and where R will create files if we save something. 
# To find out what the current working directory is, use:

getwd()

# To change the working directory, use the function setwd() and put the correct path in it.

setwd(getwd()) # setwd("<Path to the chosen directory>")

# The comma-separated values (.csv) format is probably the format most widely used in the open-source community. 
# Csv-files can be read into R using the read.csv() function, which expects a csv-file using , as a separator and . as a decimal point. 
# If you happen to have a German file that uses ; and , instead, you have to use read.csv2().

# Here's a sample dataset in CSV format. The dataset contains the following columns:

# -   Year: Represents years from 2000 to 2100.
 
# -   Category: Represents different product categories (Electronics and Clothing).
 
# -   Type: Represents different product types (High-End, Standard, Mid-Range).
 
# -   Sales, Profit, Expenses: Numerical variables
 
example_csv = read.csv("example.csv", header = TRUE, sep = ",") 
example_csv

# If you have another kind of file, just google read R and you file type and you will most likely find an R package for just that.

## Data visualization

# The plot() function is a built-in tool used to draw points (markers) in diagrams. While there are other built-in functions like lines(), points(), pie(), and barplot() for plotting, we will focus solely on the plot() function here. Later, we'll explore more advanced tools for visualization. Here's a quick way to visualize data.
 
# The function takes parameters for specifying points in the diagram.
 
# Parameter 1 specifies points on the x-axis.
 
# Parameter 2 specifies points on the y-axis.
 
plot(example_csv$Profit, example_csv$Sales)

## Save data

# Sometimes we have worked on some data and want to be able to use your R objects in a later session. 
# In this case, we can save the workspace (the objects listed under Environment) 
# using save() or save.image(). save() takes the names ob the objects you want to save 
# and a name for the file they are saved in. save.image() just saves all of the R objects in the workspace, 
# so you just have to provide the file name:

save(example_csv, file="example.RData") # saves only example_csv 
save.image(file="my_workspace.RData") # saves entire workspace

# When we now open a new R session and want to pick up where we left, we can load the data with load():

load("example.RData") 
load("my_workspace.RData")

# If we want to save a data.frame in some non-R format, almost every read function has a corresponding write function. 
# The most versatile is write.table() which will write a text-file based format, like a tabular separated file or a csv, 
# depending on what you supply in the sep argument.

write.table(example_csv, "my_example.csv", sep = ",", row.names = FALSE, col.names = TRUE, quote = FALSE) 

# or write.csv(example_csv, "my_example.csv", row.names = FALSE, quote = FALSE)

## Defining a function

# Apart from using already existing functions in R, 
# we can write you own function if you don’t find one that is doing exactly what you need. 
# For demonstration purposes, let’s define a function mySum() that takes two single numbers firstNumber 
# and secondNumber as input and computes the sum of these numbers:

mySum <- function(firstNumber, secondNumber){ 
  result <- firstNumber + secondNumber 
  return(result) # or just result
}


# After defining the function we can use it:

mySum(3,4)

# It is also possible to assign default values to some of the arguments. 
# The following function has a default of 10 for secondNumber:

mySum2 <- function(firstNumber, secondNumber=10){ 
  result <- firstNumber + secondNumber 
  result 
}

# This means if we omit secondNumber in the function call, it is assumed to be 10:

mySum2(5)

# But we can overwrite the default:

mySum2(5, 2)

## Exercise 1

# Make a function called computeEucDistance that takes two vectors (assumed to have numerical values) as input 
# and computes the Euclidean distance between them. Use this function to compute the distance between the points (1, 1) and (2, 2). 
# The Euclidean distance between two vectors $v$ and $w$ is calculated as $((v_1 - w_1)^2 + \dots + (v_n - w_n)^2)^{1/2}$.

vector_1 <- c(1, 1)
vector_2 <- c(2, 2)

# Compute and print the Euclidean distance between the two vectors
distance <- computeEucDistance(vector_1, vector_2)
cat("The Euclidean distance between the vectors is:", distance, "\n")

# Hints:
 
# 1.  Recall the element-wise operation of vectors.
 
# 2.  Functions like sum() and sqrt() may be useful. If we are not sure about what those functions do, use ?<a function> to find out.


## Conditional execution and loops
 
## Conditional execution

# Sometimes we want our code to do one thing in one case and another thing in the other case. 
# For example we could write some code that tests the body temperature.

tempChecker <- function(bodytemp){
  
  if(bodytemp<36){
    
    return("too cold")
    
  }else if(bodytemp>=38){
    
    return("too hot")
    
  }else{
    
    return("normal")
  }
  
}

tempChecker(35) 
tempChecker(39) 
tempChecker(37)

