library(boot)

# Load data
setwd("/Users/victorpekkari/Desktop/comp_stats/hw2")
data <- read.csv("lightbulb.csv")

# Extract burnout times
brand_a <- data$times[data$brand == "A"]
brand_b <- data$times[data$brand == "B"]

# Compute the estimate θ̂
theta_hat <- median(brand_a) - median(brand_b)
cat("Question 1a)   Estimated θ̂:", theta_hat, "\n")

# Number of bootstrap samples
b_bias <- 200
b_var <- 200
b_ci <- 1000

# Bootstrap function to compute median differences
bootstrapped_median <- function(data_a, data_b, iterations) {
  median_diff <- numeric(iterations)
  for (i in 1:iterations) {
    resample_a <- sample(data_a, replace = TRUE)
    resample_b <- sample(data_b, replace = TRUE)
    median_diff[i] <- median(resample_a) - median(resample_b)
  }
  return(median_diff)
}

# Bootstrap Bias Estimation
bootstrap_diffs_bias <- bootstrapped_median(brand_a, brand_b, b_bias)
bias <- mean(bootstrap_diffs_bias) - theta_hat
cat("Question 1b)   Estimated bias of the estimator:", bias, "\n")

# Bootstrap Variance Estimation
bootstrap_diffs_var <- bootstrapped_median(brand_a, brand_b, b_var)
variance <- var(bootstrap_diffs_var)
cat("Question 1c)   Estimated variance of the estimator:", variance, "\n")

# Percentile Bootstrap Confidence Interval
bootstrap_diffs_ci <- bootstrapped_median(brand_a, brand_b, b_ci)
quantiles <- quantile(bootstrap_diffs_ci, probs = c(0.025, 0.975))
cat("Question 1d)   95% Percentile Bootstrap CI: [", quantiles[1], ",", quantiles[2], "]\n")

# Hall’s Percentile Bootstrap CI
ci_hall <- 2 * theta_hat - quantile(bootstrap_diffs_ci, probs = c(0.975, 0.025))
cat("Question 1e)   95% Hall’s Percentile Bootstrap CI: [", ci_hall[1], ",", ci_hall[2], "]\n")
