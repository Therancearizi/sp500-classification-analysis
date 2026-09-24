# S&P Stock Market Classification Analysis

## Comparative Performance of Classification Methods

### Project Overview

This project compares four classification methods for predicting the
weekly direction of the S&P stock market: 

- Logistic Regression
- Linear Discriminant Analysis (LDA)
- Quadratic Discriminant Analysis (QDA)
- K-Nearest Neighbors (KNN)

The analysis was conducted in **R** using 1,089 weekly observations
covering the period from 1990 to 2010.

The objective was to determine which classification method provided
the highest prediction accuracy for classifying weekly market
direction as **Up** or **Down**.

---

## Technologies Used

- R
- ggplot2
- GGally
- ISLR
- MASS
- class
- Logistic Regression
- LDA
- QDA
- KNN

---

## Dataset

The Weekly dataset contains:

- `Year` — Year of observation
- `Lag1`–`Lag5` — Percentage returns from the previous five weeks
- `Volume` — Trading volume
- `Today` — Current week's percentage return
- `Direction` — Market direction (Up or Down)

The dataset contains **1,089 observations** from 1990–2010.

---

## Exploratory Data Analysis

### Correlation and Pairwise Analysis

The lagged returns displayed generally weak correlations with one
another. One of the strongest relationships in the dataset was
between `Year` and `Volume`, with a correlation of approximately
**0.842**.

### Trading Volume Over Time



Trading volume increased substantially over the period covered by
the dataset. The LOESS trend highlights the nonlinear growth in
trading activity, particularly during the later years.

---

## Logistic Regression

An initial logistic regression model used:

`Lag1 + Lag2 + Lag3 + Lag4 + Lag5 + Volume`

Among the lag predictors, **Lag2** was statistically significant at
the 5% level:

- Coefficient: **0.05844**
- p-value: **0.0296**

This motivated further investigation of Lag2 in the classification
models.

---

## Model Comparison

### Lag2 as Predictor

| Model | Test Accuracy |
|---|---:|
| Logistic Regression | 54.59% |
| LDA | 54.59% |
| QDA | 55.04% |
| KNN (k = 1) | 53.67% |
| KNN (k = 10) | 55.96% |
| KNN (k = 15) | **56.68%** |

### Lag1, Lag2 and Interaction

| Model | Test Accuracy |
|---|---:|
| Logistic Regression | 55.04% |
| LDA | 54.59% |
| QDA | 53.67% |
| KNN (k = 1) | 55.50% |
| KNN (k = 10) | **56.88%** |
| KNN (k = 15) | 51.83% |

---

## Key Findings

K-Nearest Neighbors achieved the highest reported prediction
accuracy among the classification methods investigated.

The highest reported accuracy was approximately **56.9%**, obtained
using KNN.

Although KNN performed best among the models tested, the relatively
modest accuracy illustrates the difficulty of predicting short-term
stock-market direction using historical lagged returns alone.

---

## Skills Demonstrated

- Exploratory Data Analysis
- Data Visualization
- Statistical Modeling
- Machine Learning
- Binary Classification
- Feature Engineering
- Logistic Regression
- Linear Discriminant Analysis
- Quadratic Discriminant Analysis
- K-Nearest Neighbors
- Confusion Matrix Analysis
- Model Evaluation
- R Programming

---
## Source Code
The complete R analysis is available here:
https://github.com/Therancearizi/sp500-classification-analysis/blob/main/Rcodes

## Full Report

[[View the complete project report]([report/SP500_Classification_Report.pdf](https://github.com/Therancearizi/sp500-classification-analysis/blob/main/Project%20Report.pdf))](https://github.com/Therancearizi/sp500-classification-analysis/blob/main/Project%20Report.pdf)
