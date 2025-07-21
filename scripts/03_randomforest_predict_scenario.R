# Load required libraries
library(randomForest)
library(dplyr)
library(caret)
library(googlesheets4)

# Read your dataset
data <- read_sheet("https://docs.google.com/spreadsheets/d/161A2zCCLf_uj_37Yi7sJhryp4VltNft8mWUzeUXX-Xk/edit?usp=sharing")

# Convert necessary columns
data$ideology <- as.numeric(as.character(data$ideology))
data$year <- as.numeric(as.character(data$year))
data$country <- as.numeric(as.character(data$country))

# Define features
features <- data %>% select(ideology, year, country)

# Function to train, evaluate, and predict for a given target
run_model <- function(target_column, new_input) {
  target <- data[[target_column]]
  
  set.seed(42)
  train_index <- createDataPartition(target, p = 0.8, list = FALSE)
  
  train_features <- features[train_index, ]
  train_target <- target[train_index]
  
  test_features <- features[-train_index, ]
  test_target <- target[-train_index]
  
  # Train Random Forest Model
  rf_model <- randomForest(
    x = train_features,
    y = train_target,
    ntree = 100,  # Number of trees in the forest
    #tuneLength = 10, #Removed this as it is for trainControl and is used for repeated cross validation, which we do not do.
    importance = TRUE
  )
  
  # Predict
  preds <- predict(rf_model, newdata = test_features)
  rmse <- sqrt(mean((preds - test_target)^2))
  r2 <- 1 - sum((preds - test_target)^2) / sum((test_target - mean(test_target))^2)
  
  cat("\n---", toupper(target_column), "---\n")
  cat("RMSE:", rmse, "\n")
  cat("R²:", r2, "\n")
  
  # Predict for custom scenario
  prediction <- predict(rf_model, newdata = new_input)
  
  cat("Predicted", target_column, "for ideology =", new_input$ideology,
      ", year =", new_input$year,
      ", country =", new_input$country, "is:", prediction, "\n")
}

# Custom scenario to predict
new_input <- data.frame(
  ideology = 4,
  year = 2024,
  country = 1038
)

# Run models for inflation, imports, and exports
run_model("gdp_growth", new_input)
run_model("gdp_per_capita", new_input)
run_model("imports", new_input)
run_model("exports", new_input)
run_model("fdi", new_input)
run_model("life_expectancy", new_input)
run_model("tax_revenue", new_input)
run_model("military_exp", new_input)
