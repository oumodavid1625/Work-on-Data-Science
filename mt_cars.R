# --------------------------------------------
# R Script: Data Science on mtcars Dataset
# --------------------------------------------

# 1. Load and inspect the dataset
data(mtcars)
head(mtcars)          # View the first few rows
str(mtcars)           # Structure of the dataset
summary(mtcars)       # Summary statistics

# 2. Data Wrangling
mtcars$cyl <- as.factor(mtcars$cyl)   # Convert cylinders to a factor (categorical)
mtcars$am <- factor(mtcars$am, labels = c("Automatic", "Manual"))  # Label transmission

# 3. Data Visualization (requires ggplot2)
library(ggplot2)

# Histogram of Miles Per Gallon (mpg)
ggplot(mtcars, aes(x = mpg)) +
  geom_histogram(binwidth = 2, fill = "skyblue", color = "black") +
  theme_minimal() +
  labs(title = "Distribution of MPG", x = "Miles per Gallon", y = "Count")

# Boxplot: MPG by number of cylinders
ggplot(mtcars, aes(x = cyl, y = mpg, fill = cyl)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = "MPG by Cylinder Count", x = "Cylinders", y = "Miles per Gallon")

# 4. Correlation Analysis
cor_matrix <- cor(mtcars[, sapply(mtcars, is.numeric)])
print(cor_matrix)

# Visualize correlation with corrplot
install.packages("corrplot")  # Run once
library(corrplot)
corrplot(cor_matrix, method = "color", addCoef.col = "black", tl.cex = 0.8)

# 5. Linear Regression: Predict MPG
model <- lm(mpg ~ wt + hp + cyl, data = mtcars)
summary(model)

# Plot regression diagnostics
par(mfrow = c(2, 2))  # 2x2 plot layout
plot(model)

# 6. Model Prediction
new_data <- data.frame(wt = c(3.0, 2.5), hp = c(110, 150), cyl = factor(c(6, 4)))
predicted_mpg <- predict(model, newdata = new_data)
print(predicted_mpg)

# 7. Save results
write.csv(mtcars, file = "mtcars_cleaned.csv")

# --------------------------------------------
# End of Script
# --------------------------------------------
