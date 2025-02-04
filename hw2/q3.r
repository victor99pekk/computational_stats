
set.seed(123)

perm_test <- function(x, y, b) {
  correlation <- cor(x, y)
  permuted_corrs <- numeric(b)
  
  for (i in 1:b) {
    y_perm <- sample(y)
    permuted_corrs[i] <- cor(x, y_perm)
  }
  
  p_value <- mean(abs(permuted_corrs) >= abs(correlation))
  return(p_value)
}

estimate_type1_error <- function(sims, alpha) {
  type1_errors <- replicate(sims, {
    x <- rnorm(100)
    y <- rnorm(100)
    p_val <- perm_test(x, y, b = 1000)
    return(p_val < alpha)
  })
  
  return(mean(type1_errors))
}

estimate_power <- function(sims, alpha, a_values) {
  power_estimates <- sapply(a_values, function(a) {
    rejections <- replicate(sims, {
      x <- runif(100, 0, 1)
      epsilon <- rnorm(100)
      y <- a * x + epsilon
      p_val <- perm_test(x, y, b = 1000)
      return(p_val < alpha)
    })
    
    return(mean(rejections))
  })
  
  return(setNames(power_estimates, a_values))
}

# Run simulations
type_I_error <- estimate_type1_error(1000, 0.10)
a_values <- c(0.8, 1.0, 1.2)
power_results <- estimate_power(1000, 0.10, a_values)

cat(sprintf("Estimated Type I Error: %.3f\n", type_I_error))
for (a in names(power_results)) {
  cat(sprintf("Estimated Power for a=%s: %.3f\n", a, power_results[[a]]))
}
