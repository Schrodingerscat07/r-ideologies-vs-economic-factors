# Ideologies vs Economic Indicators

This project explores how different political ideologies correlate with key economic indicators using statistical and machine learning models. It is part of the MTT (Machine Thinking Toolkit) initiative to understand patterns in political-economic behavior.

## 📊 Project Overview

We use data from a shared Google Sheet that includes:

- **Country/Region**
- **Political Ideology**
- **GDP, Inflation, Unemployment**
- **Other relevant economic indicators**

Machine learning models help us determine if and how political ideologies statistically relate to economic outcomes.

## 📁 Repository Structure

- `data/`: Directory for local datasets or output files.
- `scripts/`: R scripts for running statistical and ML models.
  - `01_anova_analysis.R`: ANOVA tests for economic indicators.
  - `02_xgboost_predict_scenario.R`: XGBoost predictive modeling.
  - `03_randomforest_predict_scenario.R`: Random Forest predictive modeling.
  - `04_svr_predict_scenario.R`: Support Vector Regression models.

## 🧮 Models Used

- **ANOVA (Analysis of Variance)**: To test if ideology categories show significantly different economic values.
- **Random Forest & XGBoost**: To classify or regress ideology from economic indicators.
- **Support Vector Regression (SVR)**: To predict economic outcomes based on ideology.

## 🔗 Dataset

We use a Google Sheet as the live data source:
[📎 View Google Sheet Data]("https://docs.google.com/spreadsheets/d/161A2zCCLf_uj_37Yi7sJhryp4VltNft8mWUzeUXX-Xk/edit?usp=sharing")


## 🚀 Getting Started

1. Clone this repo:
   ```bash
   git clone https://github.com/Schrodingerscat07/r-ideologies-vs-economic-factors.git
   cd r-ideologies-vs-economic-factors/scripts
   ```
   
2. Install required R packages in your R console:
   ```R
   install.packages(c("googlesheets4", "tidyverse", "randomForest", "xgboost", "e1071", "car"))
   ```
