#set.seed(123)  # Ensure reproducibility

# Function to perform permutation test
perm_test <- function(x, y, b = 1000) {
  t_obs <- mean(x) - mean(y)  # observed test statistic
  combined <- c(x, y)
  n <- length(x)

  # b - permutations
  t_perm <- replicate(b, {
    perm <- sample(combined)  # Shuffle the combined data
    mean(perm[1:n]) - mean(perm[(n + 1):length(combined)])
  })

  p_value <- (sum(t_perm >= t_obs) + 1) / (b + 1)
  return(p_value)
}

# Function to estimate Type I error
estimate_type1_error <- function(n = 10, m = 10,
                                 b = 1000, alpha = 0.05, sims = 1000) {
  type1_errors <- replicate(sims, {
    x <- rnorm(n)
    y <- rnorm(m)
    p_val <- perm_test(x, y, b)
    return(p_val < alpha)
  })
  return(mean(type1_errors))  # Proportion of false rejections
}

# Function to estimate power
estimate_power <- function(n = 10, m = 10,
                           b = 1000, alpha = 0.05, sims = 1000) {
  power <- replicate(sims, {
    x <- rnorm(n, mean = 0.5, sd = 1)  # Shifted mean for X
    y <- rnorm(m, mean = 0, sd = 1)    # Y remains standard normal
    p_val <- perm_test(x, y, b)
    return(p_val < alpha)
  })
  return(mean(power))  # Proportion of true rejections
}

# Part (a): Type I error estimation for n = m = 10
type1_error_10 <- estimate_type1_error(n = 10, m = 10, b = 1000, sims = 10000)
cat("Estimated Type I error (n = m = 10):", type1_error_10, "\n")

# Part (b): Type I error estimation for n = m = 50
type1_error_50 <- estimate_type1_error(n = 50, m = 50, b = 1000, sims = 10000)
cat("Estimated Type I error (n = m = 50):", type1_error_50, "\n")

# Part (c): Power estimation for n = m = 10
power_10 <- estimate_power(n = 10, m = 10, b = 1000, sims = 1000)
cat("Estimated Power (n = m = 10):", power_10, "\n")

# Part (d): Power estimation for n = m = 50
power_50 <- estimate_power(n = 50, m = 50, b = 1000, sims = 1000)
cat("Estimated Power (n = m = 50):", power_50, "\n")
