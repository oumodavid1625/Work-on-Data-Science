# --------------------------------------------
# R Script: Data Science on iris Dataset
# --------------------------------------------

# 1. Load and inspect the dataset
data(iris)
head(iris)            # View the first few rows
str(iris)             # Structure of the dataset
summary(iris)         # Summary statistics

# 2. Data Visualization (requires ggplot2)
library(ggplot2)

# Scatter plot: Sepal.Length vs Sepal.Width colored by Species
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point(size = 3) +
  theme_minimal() +
  labs(title = "Sepal Dimensions by Species")

# Boxplot: Petal.Length by Species
ggplot(iris, aes(x = Species, y = Petal.Length, fill = Species)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = "Petal Length by Species")

# 3. Correlation Matrix
cor_matrix <- cor(iris[, 1:4])
print(cor_matrix)

# Visualize correlation with corrplot
library(corrplot)
corrplot(cor_matrix, method = "circle")

# 4. Classification using Decision Tree
install.packages("rpart")  # Run once
library(rpart)
model_dt <- rpart(Species ~ ., data = iris, method = "class")
print(model_dt)

# Plot the decision tree
install.packages("rpart.plot")  # Run once
library(rpart.plot)
rpart.plot(model_dt, main = "Decision Tree for Iris Classification")

# 5. Clustering (k-means)
set.seed(123)
kmeans_result <- kmeans(iris[, 1:4], centers = 3)
table(kmeans_result$cluster, iris$Species)

# Add cluster result to data for plotting
iris$Cluster <- as.factor(kmeans_result$cluster)

# Visualize Clusters
ggplot(iris, aes(x = Petal.Length, y = Petal.Width, color = Cluster)) +
  geom_point(size = 3) +
  theme_minimal() +
  labs(title = "K-Means Clustering of Iris Data")

# 6. Save processed data
write.csv(iris, file = "iris_with_clusters.csv")

# --------------------------------------------
# End of Script
# --------------------------------------------
