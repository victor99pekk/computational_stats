library(boot)
setwd("/Users/victorpekkari/Desktop/comp_stats/hw2")

csv_data <- read.csv("lightbulb.csv")
brand_a <- csv_data$times[data$brand == "A"]
brand_b <- csv_data$times[data$brand == "B"]


theta_hat <- median(brand_a) - median(brand_b)
cat("Question 1a)   Estimated θ̂:", theta_hat, "\n") # question 1a)


# Number of bootstrap samples
b_bias <- 200
b_var <- 200
b_ci <- 1000

bootstrapped_median <- function(data_a, data_b, iterations) {

  b <- iterations
  median_diff <- numeric(b)

  for (i in 1:b) {
    resample_a <- sample(data_a, replace = TRUE)
    resample_b <- sample(data_b, replace = TRUE)
    median_diff[i] <- median(resample_a) - median(resample_b)
  }
  return(median_diff)
}

bias <- mean(bootstrapped_median(brand_a, brand_b, b_bias)) - theta_hat

cat("question 1b)   Estimated bias of the estimator: ", bias, "\n")


bootstrapped_variance <- function(data_a, data_b) {

  b <- b_var
  median_diff <- numeric(b)

  for (i in 1:b) {
    resample_a <- sample(data_a, replace = TRUE)
    resample_b <- sample(data_b, replace = TRUE)
    median_diff[i] <- median(resample_a) - median(resample_b)
  }
  return(var(median_diff))
}

cat("question 1c)   Estimated bias of the estimator: ",
    bootstrapped_variance(brand_a, brand_b), "\n")


median_array <- bootstrapped_median(brand_a, brand_b, b_ci)
quantiles <- quantile(median_array, probs = c(0.025, 0.975))
cat("question 1d)   lower quantile: ", quantiles[1], ", upper quantile: "
    , quantiles[2], "\n")


bootstrappped_diffs <- bootstrapped_median(brand_a, brand_b, b_ci)
#bias_Hall <- theta_hat_star - theta_hat  # Bias

ci_hall <- 2 * theta_hat - quantile(bootstrappped_diffs, probs = c(0.975, 0.025))
cat("question 1e)   95% Hall’s Percentile Bootstrap CI:", ci_hall[1], "to", ci_hall[2], "\n")