# Load required libraries
library(tidyverse)
library(readxl)
kaloli <- read_excel("kaloli.xlsx")
View(kaloli)

# Calculate frequency of responses for each variable

No_visits <- table(kaloli$freq_health_centre_visit)
freq_satisfaction <- table(kaloli$health_centre_satisf)
freq_clarity <- table(kaloli$understanding_healthinfo)
freq_access <- table(kaloli$understand_writteninfo)
freq_language <- table(kaloli$language_barrier)

# Print the frequencies
print(No_visits)
print(freq_satisfaction)
print(freq_clarity)
print(freq_access)
print(freq_language)

# Create a data frame for the satisfaction variable
satisfaction_data <- kaloli %>%
  count(health_centre_satisf) %>%
  mutate(percentage = n / sum(n) * 100)

# Create a pie chart
ggplot(satisfaction_data, aes(x = "", y = percentage, fill = health_centre_satisf)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +  # Optional for pie chart
  labs(
    title = "Satisfaction Levels",
    x = NULL,
    y = "Percentage",
    fill = "Satisfaction"
  ) +
  theme_minimal()


# Create a data frame for clarity of explanations
clarity_data <- kaloli %>%
  count(understanding_healthinfo) %>%
  mutate(percentage = n / sum(n) * 100)

# Create a pie chart
ggplot(clarity_data, aes(x = "", y = percentage, fill = understanding_healthinfo)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +  # Optional for pie chart
  labs(
    title = "Clarity of Explanations",
    x = NULL,
    y = "Percentage",
    fill = "Clarity"
  ) +
  theme_minimal()


# Frequency tables for all variables
freq_tables <- lapply(kaloli, table)

# Print frequencies
for (var in names(freq_tables)) {
  cat("\nFrequency for", var, ":\n")
  print(freq_tables[[var]])
}


# Frequency of visits pie chart
freq_visits <- kaloli %>%
  count(freq_health_centre_visit) %>%
  mutate(percentage = n / sum(n) * 100)

ggplot(freq_visits, aes(x = "", y = percentage, fill = freq_health_centre_visit)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +  # Optional: remove this for a standard bar chart
  labs(
    title = "Frequency of Visits",
    x = NULL,
    y = "Percentage",
    fill = "Visits"
  ) +
  theme_minimal()


# Satisfaction pie chart
freq_satisfaction <- kaloli %>%
  count(health_centre_satisf) %>%
  mutate(percentage = n / sum(n) * 100)

ggplot(freq_satisfaction, aes(x = "", y = percentage, fill = health_centre_satisf)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  labs(
    title = "Satisfaction with Time Spent",
    x = NULL,
    y = "Percentage",
    fill = "Satisfaction"
  ) +
  theme_minimal()


# Clarity pie chart
freq_clarity <- kaloli %>%
  count(understanding_healthinfo) %>%
  mutate(percentage = n / sum(n) * 100)

ggplot(freq_clarity, aes(x = "", y = percentage, fill = understanding_healthinfo)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  labs(
    title = "Clarity of Explanations",
    x = NULL,
    y = "Percentage",
    fill = "Clarity"
  ) +
  theme_minimal()


# Access to educational materials pie chart
freq_access <- kaloli %>%
  count(understand_writteninfo) %>%
  mutate(percentage = n / sum(n) * 100)

ggplot(freq_access, aes(x = "", y = percentage, fill = understand_writteninfo)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  labs(
    title = "Access to Educational Materials",
    x = NULL,
    y = "Percentage",
    fill = "Access"
  ) +
  theme_minimal()


# Language barriers pie chart
freq_language <- kaloli %>%
  count(language_barrier) %>%
  mutate(percentage = n / sum(n) * 100)

ggplot(freq_language, aes(x = "", y = percentage, fill = language_barrier)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar(theta = "y") +
  labs(
    title = "Language Barriers",
    x = NULL,
    y = "Percentage",
    fill = "Language Barriers"
  ) +
  theme_minimal()


summary_table <- kaloli %>%
  summarise(
    freq_health_centre_visit = list(table(freq_health_centre_visit)),
    health_centre_satisf = list(table(health_centre_satisf)),
    understanding_healthinfo = list(table(understanding_healthinfo)),
    understand_writteninfo = list(table(understand_writteninfo)),
    language_barrier = list(table(language_barrier))
  )

# Print summary
print(summary_table)


# Frequency and percentage for confidence in understanding HIV
freq_confidence_HIV <- kaloli %>%
  count(understand_your_condition) %>%
  mutate(percentage = n / sum(n) * 100)

# Print the results
cat("\nConfidence in Understanding HIV:\n")
print(freq_confidence_HIV)


# Frequency and percentage for ability to manage treatment
freq_management_treatment <- kaloli %>%
  count(rate_how_manage_your_condition) %>%
  mutate(percentage = n / sum(n) * 100)

# Print the results
cat("\nAbility to Manage Treatment:\n")
print(freq_management_treatment)


# Frequency and percentage for adherence to ART medication
freq_adherence_ART <- kaloli %>%
  count(remember_take_ART) %>%
  mutate(percentage = n / sum(n) * 100)

# Print the results
cat("\nAdherence to ART Medication:\n")
print(freq_adherence_ART)

# Frequency and percentage for emotional/psychological barriers
freq_emotional_barriers <- kaloli %>%
  count(emotions) %>%
  mutate(percentage = n / sum(n) * 100)

# Print the results
cat("\nEmotional/Psychological Barriers:\n")
print(freq_emotional_barriers)


# Plot a bar chart for confidence in understanding HIV
ggplot(freq_confidence_HIV, aes(x = understand_your_condition, y = percentage, fill = understand_your_condition)) +
  geom_bar(stat = "identity") +
  labs(
    title = "Confidence in Understanding HIV",
    x = "Confidence Level",
    y = "Percentage",
    fill = "Confidence"
  ) +
  theme_minimal()


# Plot a bar chart for ability to manage treatment
ggplot(freq_management_treatment, aes(x = rate_how_manage_your_condition, y = percentage, fill = rate_how_manage_your_condition)) +
  geom_bar(stat = "identity") +
  labs(
    title = "Ability to Manage Treatment",
    x = "Management Level",
    y = "Percentage",
    fill = "Management Ability"
  ) +
  theme_minimal()


# Plot a bar chart for adherence to ART medication
ggplot(freq_adherence_ART, aes(x = remember_take_ART, y = percentage, fill = remember_take_ART)) +
  geom_bar(stat = "identity") +
  labs(
    title = "Adherence to ART Medication",
    x = "Adherence Frequency",
    y = "Percentage",
    fill = "Adherence"
  ) +
  theme_minimal()


# Plot a bar chart for emotional/psychological barriers
ggplot(freq_emotional_barriers, aes(x = emotions, y = percentage, fill = emotions)) +
  geom_bar(stat = "identity") +
  labs(
    title = "Emotional/Psychological Barriers",
    x = "Barriers",
    y = "Percentage",
    fill = "Emotional Barrier"
  ) +
  theme_minimal()



