# Load necessary libraries

library(dplyr)      # For data manipulation
library(ggplot2)    # For data visualization
library(tidyr)      # For data tidying
library(readr)      # For reading data
library(car)         # For regression diagnostics
library(stargazer)   # For regression tables

# Load the dataset (assuming it's in a CSV file)

data <- read.csv("Anemia.csv")

# View the first few rows of the dataset

head(data)
summary(data)

# Data Cleaning and Preparation

# Let us Check for missing values in key variables

colSums(is.na(data))

# Descriptive Statistics
# Let us get a Summary of key variables

summary(data[, c("Haemoglobin", "Age", "WealthScore", "CleanWater", "Pregnant", "Rural")])

# Let us Handle Invalid Data

# We shall identify rows with invalid Haemoglobin values

invalid_haemoglobin <- data %>% filter(Haemoglobin == -1.00)
n_invalid <- nrow(invalid_haemoglobin)
cat("Number of invalid Haemoglobin values (-1.00):", n_invalid, "\n")

# We shall remove rows with invalid Haemoglobin values

data_cleaned <- data %>% filter(Haemoglobin != -1.00)

# Now let us verify the cleaning process

summary(data_cleaned$Haemoglobin)
cat("Number of rows after cleaning:", nrow(data_cleaned), "\n")

# Step 4: Save the cleaned dataset (optional)

write.csv(data_cleaned, "cleaned_dataset.csv", row.names = FALSE)

# Let us view the cleaned dataset

library(readr)
cleaned_dataset <- read_csv("cleaned_dataset.csv")
View(cleaned_dataset)

# Now, let us try the Summary of key variables again

summary(data_cleaned[, c("Haemoglobin", "Age", "WealthScore", "CleanWater", "Pregnant", "Rural")])

# We shall now define anemia threshold (WHO guidelines: <12 g/dL for non-pregnant women, <11 g/dL for pregnant women)

data_cleaned <- data_cleaned %>%
  mutate(Anemic = ifelse(Pregnant == 1 & Haemoglobin < 11, 1,
                         ifelse(Pregnant == 0 & Haemoglobin < 12, 1, 0)))

# Now, we shall compare Haemoglobin Levels by Subgroups

# Rural vs. Urban

haemoglobin_rural_urban <- data_cleaned %>%
  group_by(Rural) %>%
  summarise(Mean_Haemoglobin = mean(Haemoglobin, na.rm = TRUE),
            Median_Haemoglobin = median(Haemoglobin, na.rm = TRUE),
            SD_Haemoglobin = sd(Haemoglobin, na.rm = TRUE))

print(haemoglobin_rural_urban)

# Pregnant vs. Non-Pregnant

haemoglobin_pregnant <- data_cleaned %>%
  group_by(Pregnant) %>%
  summarise(Mean_Haemoglobin = mean(Haemoglobin, na.rm = TRUE),
            Median_Haemoglobin = median(Haemoglobin, na.rm = TRUE),
            SD_Haemoglobin = sd(Haemoglobin, na.rm = TRUE))

print(haemoglobin_pregnant)

# We shall now compare Anemia Prevalence by Subgroups

# Rural vs. Urban

anemia_rural_urban <- data_cleaned %>%
  group_by(Rural) %>%
  summarise(Anemia_Prevalence = mean(Anemic, na.rm = TRUE) * 100)

print(anemia_rural_urban)

# Pregnant vs. Non-Pregnant

anemia_pregnant <- data_cleaned %>%
  group_by(Pregnant) %>%
  summarise(Anemia_Prevalence = mean(Anemic, na.rm = TRUE) * 100)

print(anemia_pregnant)

# We shall create the bar plot; Anemia Prevalence by Rural/Urban Residence

data_cleaned %>%
  group_by(Rural) %>%
  summarise(Anemia_Prevalence = mean(Anemic, na.rm = TRUE) * 100) %>%
  ggplot(aes(x = factor(Rural), y = Anemia_Prevalence, fill = factor(Rural))) +
  geom_bar(stat = "identity", color = "black", alpha = 0.7) +  # Add fill and border colors
  scale_fill_manual(values = c("0" = "lightblue", "1" = "lightcoral"),  # Custom fill colors
                    labels = c("Urban", "Rural")) +  # Add meaningful labels for the legend
  labs(title = "Anemia Prevalence by Rural/Urban Residence",
       subtitle = "Comparison between Urban and Rural Women",
       x = "Residence (0 = Urban, 1 = Rural)", 
       y = "Anemia Prevalence (%)",
       fill = "Residence") +  # Add a subtitle and improve axis/legend labels
  theme_minimal() +  # Use a clean theme
  theme(
    plot.title = element_text(size = 16, face = "bold", hjust = 0.5),  # Customize title
    plot.subtitle = element_text(size = 12, hjust = 0.5),  # Customize subtitle
    axis.title.x = element_text(size = 12, face = "bold"),  # Customize x-axis label
    axis.title.y = element_text(size = 12, face = "bold"),  # Customize y-axis label
    legend.position = "top",  # Move legend to the top
    legend.title = element_text(face = "bold")  # Bold legend title
  ) +
  scale_x_discrete(labels = c("Urban", "Rural")) +  # Replace 0 and 1 with meaningful labels
  geom_text(aes(label = paste0(round(Anemia_Prevalence, 1), "%")),  # Add percentage labels on bars
            vjust = -0.5, size = 4, color = "black")  # Adjust label position and appearance


# We shall also create the bar plot; Anemia prevalence by Pregnant/Non-Pregnant

data_cleaned %>%
  group_by(Pregnant) %>%
  summarise(Anemia_Prevalence = mean(Anemic, na.rm = TRUE) * 100) %>%
  ggplot(aes(x = factor(Pregnant), y = Anemia_Prevalence, fill = factor(Pregnant))) +
  geom_bar(stat = "identity", color = "black", alpha = 0.7) +  # Add fill and border colors
  scale_fill_manual(values = c("0" = "lightblue", "1" = "lightcoral"),  # Custom fill colors
                    labels = c("Non-Pregnant", "Pregnant")) +  # Add meaningful labels for the legend
  labs(title = "Anemia Prevalence by Pregnancy Status",
       subtitle = "Comparison between Non-Pregnant and Pregnant Women",
       x = "Pregnancy Status (0 = Non-Pregnant, 1 = Pregnant)", 
       y = "Anemia Prevalence (%)",
       fill = "Pregnancy Status") +  # Add a subtitle and improve axis/legend labels
  theme_minimal() +  # Use a clean theme
  theme(
    plot.title = element_text(size = 16, face = "bold", hjust = 0.5),  # Customize title
    plot.subtitle = element_text(size = 12, hjust = 0.5),  # Customize subtitle
    axis.title.x = element_text(size = 12, face = "bold"),  # Customize x-axis label
    axis.title.y = element_text(size = 12, face = "bold"),  # Customize y-axis label
    legend.position = "top",  # Move legend to the top
    legend.title = element_text(face = "bold")  # Bold legend title
  ) +
  scale_x_discrete(labels = c("Non-Pregnant", "Pregnant")) +  # Replace 0 and 1 with meaningful labels
  geom_text(aes(label = paste0(round(Anemia_Prevalence, 1), "%")),  # Add percentage labels on bars
            vjust = -0.5, size = 4, color = "black")  # Adjust label position and appearance

# Let us create a barplot: Anemia prevalence by region

data_cleaned %>%
  group_by(Region) %>%
  summarise(Anemia_Prevalence = mean(Anemic, na.rm = TRUE) * 100) %>%
  ggplot(aes(x = factor(Region), y = Anemia_Prevalence)) +
  geom_bar(stat = "identity", col = "blue") +
  labs(title = "Anemia Prevalence by Region",
       x = "Region", y = "Anemia Prevalence (%)")

# Statistical Tests

# Let us perform T-test for Haemoglobin levels (Rural vs. Urban)

t_test_rural_urban <- t.test(Haemoglobin ~ Rural, data = data_cleaned)
print(t_test_rural_urban)

# Visualization for the t-test

ggplot(data_cleaned, aes(x = factor(Rural), y = Haemoglobin)) +
  geom_boxplot() +
  labs(title = "Haemoglobin Levels by Rural/Urban Residence",
       x = "Residence (0 = Urban, 1 = Rural)", y = "Haemoglobin (g/dL)")

# Let us create the boxplot with colors

ggplot(data_cleaned, aes(x = factor(Rural), y = Haemoglobin, fill = factor(Rural))) +
  geom_boxplot(alpha = 0.7, color = "black", outlier.color = "red", outlier.shape = 16) +  # Add fill, border, and outlier customization
  scale_fill_manual(values = c("0" = "lightgreen", "1" = "lightblue"),  # Custom fill colors for urban and rural groups
                    labels = c("Urban", "Rural")) +  # Add meaningful labels for the legend
  labs(title = "Haemoglobin Levels by Rural/Urban Residence",
       subtitle = "Comparison between Urban and Rural Women",
       x = "Residence (0 = Urban, 1 = Rural)", 
       y = "Haemoglobin (g/dL)",
       fill = "Residence") +  # Add a subtitle and improve axis/legend labels
  theme_minimal() +  # Use a clean theme
  theme(
    plot.title = element_text(size = 16, face = "bold", hjust = 0.5),  # Customize title
    plot.subtitle = element_text(size = 12, hjust = 0.5),  # Customize subtitle
    axis.title.x = element_text(size = 12, face = "bold"),  # Customize x-axis label
    axis.title.y = element_text(size = 12, face = "bold"),  # Customize y-axis label
    legend.position = "top",  # Move legend to the top
    legend.title = element_text(face = "bold")  # Bold legend title
  ) +
  scale_x_discrete(labels = c("Urban", "Rural"))  # Replace 0 and 1 with meaningful labels

# We shall also perform the T-test for Haemoglobin levels (Pregnant vs. Non-Pregnant)

t_test_pregnant <- t.test(Haemoglobin ~ Pregnant, data = data_cleaned)
print(t_test_pregnant)

# Visualization for t-test, by pregnancy status

ggplot(data_cleaned, aes(x = factor(Pregnant), y = Haemoglobin)) +
  geom_boxplot() +
  labs(title = "Haemoglobin Levels by Pregnancy Status",
       x = "Pregnancy Status (0 = Non-Pregnant, 1 = Pregnant)", y = "Haemoglobin (g/dL)")

# Let us create the boxplot with colors, for the t-test by pregnancy status

ggplot(data_cleaned, aes(x = factor(Pregnant), y = Haemoglobin, fill = factor(Pregnant))) +
  geom_boxplot(alpha = 0.7, color = "black", outlier.color = "red", outlier.shape = 16) +  # Add fill, border, and outlier customization
  scale_fill_manual(values = c("0" = "lightblue", "1" = "lightcoral"),  # Custom fill colors for non-pregnant and pregnant groups
                    labels = c("Non-Pregnant", "Pregnant")) +  # Add meaningful labels for the legend
  labs(title = "Haemoglobin Levels by Pregnancy Status",
       subtitle = "Comparison between Non-Pregnant and Pregnant Women",
       x = "Pregnancy Status (0 = Non-Pregnant, 1 = Pregnant)", 
       y = "Haemoglobin (g/dL)",
       fill = "Pregnancy Status") +  # Add a subtitle and improve axis/legend labels
  theme_minimal() +  # Use a clean theme
  theme(
    plot.title = element_text(size = 16, face = "bold", hjust = 0.5),  # Customize title
    plot.subtitle = element_text(size = 12, hjust = 0.5),  # Customize subtitle
    axis.title.x = element_text(size = 12, face = "bold"),  # Customize x-axis label
    axis.title.y = element_text(size = 12, face = "bold"),  # Customize y-axis label
    legend.position = "top",  # Move legend to the top
    legend.title = element_text(face = "bold")  # Bold legend title
  ) +
  scale_x_discrete(labels = c("Non-Pregnant", "Pregnant"))  # Replace 0 and 1 with meaningful labels

# We shall now perform the Chi-square test for Anemia prevalence (Rural vs. Urban)

chisq_test_rural_urban <- chisq.test(table(data_cleaned$Rural, data_cleaned$Anemic))
print(chisq_test_rural_urban)

# Chi-square test for Anemia prevalence (Pregnant vs. Non-Pregnant)

chisq_test_pregnant <- chisq.test(table(data_cleaned$Pregnant, data_cleaned$Anemic))
print(chisq_test_pregnant)

# Subgroup Analysis:
# Let us explore whether the disparity in anemia prevalence persists after controlling for other factors 
# (e.g., wealth, education, access to clean water) using logistic regression.

logistic_model <- glm(Anemic ~ Rural + WealthScore + CleanWater + Pregnant + Education + Ethnicity + Region, 
                      family = binomial, data = data_cleaned)
summary(logistic_model)

# Let us exponentiate the coefficients to interpret them as odds ratios.

exp(coef(logistic_model))

# Visualization of the logistic regression

ggplot(data_cleaned, aes(x = WealthScore, y = Anemic)) +
  geom_smooth(method = "glm", method.args = list(family = "binomial")) +
  labs(title = "Probability of Anemia by Wealth Score",
       x = "Wealth Score", y = "Probability of Anemia")

# Let us create a table for this logistic regression
# We shall load necessary libraries

library(knitr)
library(kableExtra)
library(openxlsx)

# Let us create a data frame for the odds ratios

odds_ratios <- exp(coef(logistic_model))
odds_table <- data.frame(
  Variable = names(odds_ratios),
  Odds_Ratio = round(odds_ratios, 4)  # Round to 4 decimal places
)

# Next, we are going to print the table using kable for a clean and professional look (Print the table in the console for reference)

kable(odds_table, caption = "Odds Ratios from Logistic Regression Model", align = "l") %>%
  kable_styling(bootstrap_options = c("striped", "hover", "condensed"), full_width = FALSE)

# Save the table to an Excel file

write.xlsx(odds_table, file = "Odds_Ratios_Table.xlsx", rowNames = FALSE)

