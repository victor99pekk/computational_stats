
#1c)
simulation <- function(n){
  return(sample(1:4, size=n, prob = c(0.3, 0.5, 0.15, 0.05), replace=TRUE))
}
# print("1c)")
# print(simulation())
#1d)
estimate_mean <- function(n) {
  return(mean((simulation(n))))
}
# print("1d)")
# print(estimate_mean())
#1e)
estimate_prob <- function(n, p){
  array <- simulation(n)
  filtered <- array[array <= p]
  return(length(filtered) / n)
}
# print("1e)")
# print(estimate_prob(1000, 2))
#----------------------------

#2a)
plot_binom <- function(n, p, file_name){
  array <- rbinom(1000, n, p)
  pdf(file_name)
  hist(array, freq = FALSE, main = "binomial sampling",
       plot = TRUE, border = "black")
  dev.off()
}

#----------------------------

#3a)
hypothesis_test <- function(){
  n <- 100      # Sample size
  mu <- 1       # Mean
  sigma2 <- 1   # Variance
  alpha <- 0.05 # Significance level
  sim_count <- 1000 # Number of simulations
  coverage_count <- 0
  for (i in 1:sim_count){
    #sampling <- rnorm(n, mu, sigma2) #q3a,b,c)
    sampling <- rexp(n, 1)
    s2 <- var(sampling)
    #Chi-squared critical values
    lower_bound <- (n - 1) * s2 / qchisq(1 - alpha / 2, df = n - 1)
    upper_bound <- (n - 1) * s2 / qchisq(alpha / 2, df = n - 1)

    if (sigma2 >= lower_bound && sigma2 <= upper_bound) {
      coverage_count <- coverage_count + 1
    }
  }
  result <- (coverage_count / sim_count)
  print("3c) rexp(100, 1, 1)")
  print(result)
  return(result)
}
#hypothesis_test()

perform_nulltest <- function(sample){
  n <- length(sample)
  s2 <- var(sample)  # Sample variance
  sigma2_0 <- 1
  alpha <- 0.05
  test_result <- (n - 1) * s2 / sigma2_0
  lower <- qchisq(alpha / 2, df = n - 1)
  upper <- qchisq(1 - (alpha / 2), df = n - 1)
  return(lower > test_result || test_result > upper)
}

null_test <- function() {
  num_simulations <- 1000
  type1_error_count <- 0
  sigma2 <- 1
  mu <- 1
  n <- 10
  mean <- 1
  for (i in 1:num_simulations) {
    #sample <- rnorm(n, mean = mu, sd = sqrt(sigma2))
    sample <- rexp(n, 1)
    mean <- mean + var(sample)
    #print(paste("sd: ", sd(sample)))
    if (perform_nulltest(sample)) {
      type1_error_count <- type1_error_count + 1
    }
  }
  print(type1_error_count / num_simulations)
}
#3b, N(1,1) -> 0.946
#3b n=100 rexp(100,1) -> 0.681
#3b n=10 rexp(10,1) -> 0.758
# Parameters
#hypothesis_test()
print("3d) rexp(10,1)")
null_test()

#print(plot_binom(100, 0.015, "binomial_2b.pdf"))