
# ==========================================================
# S&P WEEKLY MARKET CLASSIFICATION PROJECT
# ==========================================================

# Install packages if required:
# install.packages(c("ISLR", "GGally", "MASS", "class", "ggplot2"))

library(ISLR)
library(GGally)
library(MASS)
library(class)
library(ggplot2)

# ----------------------------------------------------------
# 1. LOAD DATA
# ----------------------------------------------------------

data("Weekly")

str(Weekly)
names(Weekly)
summary(Weekly)
table(Weekly$Direction)


# ----------------------------------------------------------
# 2. EXPLORATORY DATA ANALYSIS
# ----------------------------------------------------------

# Pair plot / correlation visualization
ggpairs(
  Weekly,
  aes(colour = Direction)
)

# Numerical correlation matrix
numeric_data <- Weekly[
  c(
    "Year", "Lag1", "Lag2", "Lag3",
    "Lag4", "Lag5", "Volume", "Today"
  )
]

cor(numeric_data)


# ----------------------------------------------------------
# 3. YEAR VS. TRADING VOLUME
# ----------------------------------------------------------

ggplot(
  Weekly,
  aes(
    x = Year,
    y = Volume,
    color = Direction
  )
) +
  geom_point() +
  geom_smooth(
    method = "loess",
    se = FALSE,
    color = "black",
    linetype = "dashed"
  ) +
  labs(
    title = "Scatter Plot of Year and Volume",
    x = "Year",
    y = "Volume"
  ) +
  theme_minimal()


# ----------------------------------------------------------
# 4. FULL LOGISTIC REGRESSION MODEL
# ----------------------------------------------------------

full_logistic <- glm(
  Direction ~ Lag1 + Lag2 + Lag3 +
    Lag4 + Lag5 + Volume,
  data = Weekly,
  family = binomial
)

summary(full_logistic)


# ----------------------------------------------------------
# 5. FULL-DATA CONFUSION MATRIX
# ----------------------------------------------------------

full_prob <- predict(
  full_logistic,
  type = "response"
)

full_prediction <- ifelse(
  full_prob > 0.5,
  "Up",
  "Down"
)

full_prediction <- factor(
  full_prediction,
  levels = levels(Weekly$Direction)
)

full_confusion <- table(
  Predicted = full_prediction,
  Actual = Weekly$Direction
)

print(full_confusion)

full_accuracy <-
  sum(diag(full_confusion)) /
  sum(full_confusion)

print(full_accuracy)


# ----------------------------------------------------------
# 6. TRAIN / TEST SPLIT
# ----------------------------------------------------------

set.seed(123)

train_index <- sort(
  sample(
    seq_len(nrow(Weekly)),
    size = floor(0.80 * nrow(Weekly))
  )
)

train <- Weekly[train_index, ]
test <- Weekly[-train_index, ]


# ----------------------------------------------------------
# HELPER FUNCTION FOR ACCURACY
# ----------------------------------------------------------

get_accuracy <- function(predicted, actual) {

  predicted <- factor(
    predicted,
    levels = levels(actual)
  )

  cm <- table(
    Predicted = predicted,
    Actual = actual
  )

  print(cm)

  accuracy <-
    sum(diag(cm)) /
    sum(cm)

  return(accuracy)
}


# ==========================================================
# EXPERIMENT 1: LAG2 ONLY
# ==========================================================

# ----------------------------------------------------------
# 7. LOGISTIC REGRESSION
# ----------------------------------------------------------

logistic_lag2 <- glm(
  Direction ~ Lag2,
  data = train,
  family = binomial
)

logistic_prob <- predict(
  logistic_lag2,
  newdata = test,
  type = "response"
)

logistic_pred <- ifelse(
  logistic_prob > 0.5,
  "Up",
  "Down"
)

accuracy_logistic <-
  get_accuracy(
    logistic_pred,
    test$Direction
  )

print(accuracy_logistic)


# ----------------------------------------------------------
# 8. LINEAR DISCRIMINANT ANALYSIS
# ----------------------------------------------------------

lda_lag2 <- lda(
  Direction ~ Lag2,
  data = train
)

lda_pred <- predict(
  lda_lag2,
  newdata = test
)$class

accuracy_lda <-
  get_accuracy(
    lda_pred,
    test$Direction
  )

print(accuracy_lda)


# ----------------------------------------------------------
# 9. QUADRATIC DISCRIMINANT ANALYSIS
# ----------------------------------------------------------

qda_lag2 <- qda(
  Direction ~ Lag2,
  data = train
)

qda_pred <- predict(
  qda_lag2,
  newdata = test
)$class

accuracy_qda <-
  get_accuracy(
    qda_pred,
    test$Direction
  )

print(accuracy_qda)


# ----------------------------------------------------------
# 10. KNN — LAG2
# ----------------------------------------------------------

train_x_lag2 <- as.matrix(
  train[, "Lag2", drop = FALSE]
)

test_x_lag2 <- as.matrix(
  test[, "Lag2", drop = FALSE]
)

train_y <- train$Direction
test_y <- test$Direction

k_values <- c(1, 10, 15)

knn_lag2_results <- data.frame(
  k = integer(),
  Accuracy = numeric()
)

for (k in k_values) {

  knn_pred <- knn(
    train = train_x_lag2,
    test = test_x_lag2,
    cl = train_y,
    k = k
  )

  accuracy <- get_accuracy(
    knn_pred,
    test_y
  )

  knn_lag2_results <- rbind(
    knn_lag2_results,
    data.frame(
      k = k,
      Accuracy = accuracy
    )
  )
}

print(knn_lag2_results)


# ==========================================================
# EXPERIMENT 2:
# LAG1 + LAG2 + LAG1*LAG2
# ==========================================================

# ----------------------------------------------------------
# 11. LOGISTIC REGRESSION
# ----------------------------------------------------------

logistic_interaction <- glm(
  Direction ~ Lag1 * Lag2,
  data = train,
  family = binomial
)

interaction_prob <- predict(
  logistic_interaction,
  newdata = test,
  type = "response"
)

interaction_pred <- ifelse(
  interaction_prob > 0.5,
  "Up",
  "Down"
)

accuracy_logistic_interaction <-
  get_accuracy(
    interaction_pred,
    test$Direction
  )

print(accuracy_logistic_interaction)


# ----------------------------------------------------------
# 12. LDA
# ----------------------------------------------------------

lda_interaction <- lda(
  Direction ~ Lag1 * Lag2,
  data = train
)

lda_interaction_pred <- predict(
  lda_interaction,
  newdata = test
)$class

accuracy_lda_interaction <-
  get_accuracy(
    lda_interaction_pred,
    test$Direction
  )

print(accuracy_lda_interaction)


# ----------------------------------------------------------
# 13. QDA
# ----------------------------------------------------------

qda_interaction <- qda(
  Direction ~ Lag1 * Lag2,
  data = train
)

qda_interaction_pred <- predict(
  qda_interaction,
  newdata = test
)$class

accuracy_qda_interaction <-
  get_accuracy(
    qda_interaction_pred,
    test$Direction
  )

print(accuracy_qda_interaction)


# ----------------------------------------------------------
# 14. CREATE INTERACTION FEATURE FOR KNN
# ----------------------------------------------------------

train$Interaction <-
  train$Lag1 * train$Lag2

test$Interaction <-
  test$Lag1 * test$Lag2

train_x <- as.matrix(
  train[
    c(
      "Lag1",
      "Lag2",
      "Interaction"
    )
  ]
)

test_x <- as.matrix(
  test[
    c(
      "Lag1",
      "Lag2",
      "Interaction"
    )
  ]
)


# ----------------------------------------------------------
# 15. KNN WITH DIFFERENT K VALUES
# ----------------------------------------------------------

knn_interaction_results <- data.frame(
  k = integer(),
  Accuracy = numeric()
)

for (k in k_values) {

  knn_pred_interaction <- knn(
    train = train_x,
    test = test_x,
    cl = train$Direction,
    k = k
  )

  accuracy <- get_accuracy(
    knn_pred_interaction,
    test$Direction
  )

  knn_interaction_results <- rbind(
    knn_interaction_results,
    data.frame(
      k = k,
      Accuracy = accuracy
    )
  )
}

print(knn_interaction_results)


# ----------------------------------------------------------
# 16. FINAL MODEL COMPARISON
# ----------------------------------------------------------

model_results <- data.frame(
  Model = c(
    "Logistic Regression",
    "LDA",
    "QDA"
  ),
  Lag2_Accuracy = c(
    accuracy_logistic,
    accuracy_lda,
    accuracy_qda
  ),
  Interaction_Accuracy = c(
    accuracy_logistic_interaction,
    accuracy_lda_interaction,
    accuracy_qda_interaction
  )
)

print(model_results)

print("KNN — Lag2")
print(knn_lag2_results)

print("KNN — Lag1, Lag2 and Interaction")
print(knn_interaction_results)
