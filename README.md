# S&P Stock Market Classification Analysis

## Comparative Performance of Classification Methods

### Project Overview

This project compares four classification methods for predicting the
weekly direction of the S&P stock market: 

- Logistic Regression
- Linear Discriminant Analysis (LDA)
- Quadratic Discriminant Analysis (QDA)
- K-Nearest Neighbors (KNN).


## Objective

The objective was to determine which classification method provided
the highest prediction accuracy for classifying weekly market
direction as **Up** or **Down**


## Data Source

The analysis uses the **Weekly** stock-market dataset containing weekly
percentage returns for the S&P 500 from **1990 through 2010**.

The dataset contains **1,089 weekly observations** and is distributed with
the `ISLR`/`ISLR2` materials associated with *An Introduction to Statistical
Learning*.

Dataset documentation:

[Weekly Stock Market Data – ISLR Documentation](https://rdrr.io/cran/ISLR/man/Weekly.html)

## Dataset Description

The variables include:

- **Year:** Year of observation
- **Lag1:** Percentage return from the previous week
- **Lag2:** Percentage return two weeks previously
- **Lag3:** Percentage return three weeks previously
- **Lag4:** Percentage return four weeks previously
- **Lag5:** Percentage return five weeks previously
- **Volume:** Average number of shares traded
- **Today:** Percentage return for the current week
- **Direction:** Market direction (`Up` or `Down`)

The target variable for classification is **Direction**.

## Exploratory Data Analysis

Exploratory analysis included:

- Summary statistics
- Correlation analysis
- Pairwise visualization
- Analysis of trading volume over time
- Examination of lagged weekly returns

A strong relationship between **Year** and **Volume** was observed, reflecting
the substantial increase in trading volume over the period.

The lagged returns generally showed relatively weak pairwise correlations.

## Classification Models

Four classification techniques were evaluated:

1. **Logistic Regression**
2. **Linear Discriminant Analysis (LDA)**
3. **Quadratic Discriminant Analysis (QDA)**
4. **K-Nearest Neighbors (KNN)**

For the initial logistic regression using all lag variables and Volume,
**Lag2** was the predictor showing statistically significant evidence at
the 5% level (p ≈ 0.030).

## Train/Test Evaluation

The data were split into approximately:

- **80% training data**
- **20% testing data**

Models were evaluated using out-of-sample classification accuracy and
confusion matrices.

Two predictor specifications were investigated:

### Experiment 1 — Lag2 Only

| Model | Test Accuracy |
|---|---:|
| Logistic Regression | 54.59% |
| LDA | 54.59% |
| QDA | 55.04% |
| KNN (k = 1) | 53.67% |
| KNN (k = 10) | 55.96% |
| **KNN (k = 15)** | **56.68%** |

With Lag2 as the predictor, **KNN with k = 15** achieved the highest
reported test accuracy at **56.68%**.

### Experiment 2 — Lag1, Lag2 and Their Interaction

| Model | Test Accuracy |
|---|---:|
| Logistic Regression | 55.04% |
| LDA | 54.59% |
| QDA | 53.67% |
| KNN (k = 1) | 55.50% |
| **KNN (k = 10)** | **56.88%** |
| KNN (k = 15) | 51.83% |

Under this specification, **KNN with k = 10** produced the highest reported
test accuracy at **56.88%**.

## Key Findings

- KNN produced the highest reported test accuracy in both experiments.
- The best reported accuracy was **56.88%**, obtained using KNN with
  `k = 10` in the second experiment.
- Logistic Regression and LDA produced similar classification performance.
- Lag2 showed the strongest statistical evidence among the predictors in
  the full logistic regression.
- Prediction accuracy remained modest across all models, illustrating the
  difficulty of predicting short-term stock-market direction from lagged
  returns alone.

## Conclusion

Among the models evaluated, KNN achieved the highest reported holdout
accuracy.

The results also demonstrate that selecting the number of neighbors and
the predictor set can meaningfully affect KNN performance. However, the
relatively modest accuracy suggests substantial uncertainty remains in
predicting weekly market direction from these predictors.

This project demonstrates the application and comparison of multiple
classification techniques rather than establishing a trading strategy.

## Skills Demonstrated

- R
- Logistic Regression
- Linear Discriminant Analysis
- Quadratic Discriminant Analysis
- K-Nearest Neighbors
- Train/Test Splitting
- Confusion Matrices
- Model Comparison
- Exploratory Data Analysis


## Source Code
The complete R analysis is available here:
https://github.com/Therancearizi/sp500-classification-analysis/blob/main/Rcodes

## Full Report

[[View the complete project report]([report/SP500_Classification_Report.pdf](https://github.com/Therancearizi/sp500-classification-analysis/blob/main/Project%20Report.pdf))](https://github.com/Therancearizi/sp500-classification-analysis/blob/main/Project%20Report.pdf)
