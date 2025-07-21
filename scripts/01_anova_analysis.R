library(googlesheets4)
library(xgboost)
library(dplyr)
library(Matrix)


df <- read_sheet("https://docs.google.com/spreadsheets/d/161A2zCCLf_uj_37Yi7sJhryp4VltNft8mWUzeUXX-Xk/edit?usp=sharing")
# Run ANOVA for each target variable
summary(aov(gdp_growth ~ ideology, data = df))
summary(aov(gdp_per_capita ~ ideology, data = df))
summary(aov(life_expectancy ~ ideology, data = df))
summary(aov(military_exp ~ ideology, data = df))
summary(aov(tax_revenue ~ ideology, data = df))
summary(aov(exports ~ ideology, data = df))
summary(aov(imports ~ ideology, data = df))
summary(aov(inflation ~ ideology, data = df))
summary(aov(unemployment ~ ideology, data = df))
summary(aov(fdi ~ ideology, data = df))
# Create a named vector of p-values from your ANOVA results
anova_results <- c(
  gdp_growth = 0.0569,
  gdp_per_capita = 0.00662,
  life_expectancy = 0.0799,
  military_exp = 0.362,
  tax_revenue = 0.0993,
  exports = 0.0109,
  imports = 0.0204,
  inflation = 0.0225,
  unemployment = 0.0932,
  fdi = 0.637
)

# Create a data frame for plotting
anova_df <- data.frame(
  variable = names(anova_results),
  p_value = as.numeric(anova_results),
  significance = cut(anova_results,
                     breaks = c(-Inf, 0.05, 0.1, Inf),
                     labels = c("Significant", "Marginal", "Not Significant"))
)

# Load ggplot2 for plotting
library(ggplot2)

# Plot: Significance of ANOVA by variable
ggplot(anova_df, aes(x = reorder(variable, p_value), y = p_value, fill = significance)) +
  geom_col() +
  geom_hline(yintercept = 0.05, linetype = "dashed", color = "darkgreen") +
  geom_hline(yintercept = 0.1, linetype = "dashed", color = "orange") +
  coord_flip() +
  scale_fill_manual(values = c("Significant" = "#4CAF50", "Marginal" = "#FFC107", "Not Significant" = "#F44336")) +
  labs(
    title = "ANOVA p-values for Ideology's Effect on Variables",
    x = "Target Variable",
    y = "p-value",
    fill = "Significance"
  ) +
  theme_minimal()
