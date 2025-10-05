# Solution: Computational Testing

## Solution: Exercise 1 {#ht-sol-ex1}

The data is:


```{.r .numberLines}
x <- c(263.9, 266.2, 266.3, 266.8, 265.0)
```

Now construct some summary statistics and define some given parameters:


```{.r .numberLines}
x_bar <- mean(x) # compute sample mean
sigma <- 1.65 # population standard deviation is given
mu <- 260 # population mean to be tested against
n <- length(x) # number of samples
```
Construct the z-statistic:


```{.r .numberLines}
z <- (x_bar - mu) / (sigma / sqrt(n))
print(z)
```

``` bg-info
#> [1] 7.643287
```

Check if the z-statistic is in the critical range. First, work out what the z-value at the edge of the critical region is:


```{.r .numberLines}
z_threshold <- qnorm(1 - 0.01, mean = 0, sd = 1)
print(z_threshold)
```

``` bg-info
#> [1] 2.326348
```

Thus, the z-statistic is much greater than the threshold and there is evidence to suggest the cartons are overfilled.

<button class="button">
  [Back to exercise](#ht-ex1)
</button>

## Solution: Exercise 2 {#ht-sol-ex2}

Parameters given by the problem:


```{.r .numberLines}
x_bar <- 103.11
s <- 53.5
mu <- 100
n <- 45
```
Compute the z-statistic assuming large sample assumptions apply:


```{.r .numberLines}
z <- ( x_bar - mu )/(s/sqrt(n))
print(z)
```

``` bg-info
#> [1] 0.3899535
```

Now, work out the thresholds of the critical regions:


```{.r .numberLines}
z_upper <- qnorm(1 - 0.025, mean = 0, sd = 1)
print(z_upper)
```

``` bg-info
#> [1] 1.959964
```

```{.r .numberLines}
z_lower <- qnorm(0.025, mean = 0, sd = 1)
print(z_lower)
```

``` bg-info
#> [1] -1.959964
```

The z-statistic is outside the critical regions and therefore we do not reject the null hypothesis.

<button class="button">
  [Back to exercise](#ht-ex2)
</button>

## Solution: Exercise 3 {#ht-sol-ex3}


```{.r .numberLines}
z_test <- function(x, mu, popvar){

  one_tail_p <- NULL

  z_score <- round((mean(x) - mu) / (popvar / sqrt(length(x))), 3)

  one_tail_p <- round(pnorm(abs(z_score),lower.tail = FALSE), 3)

  cat(" z =", z_score, "\n",
    "one-tailed probability =", one_tail_p, "\n",
    "two-tailed probability =", 2 * one_tail_p)

  return(list(z = z_score, one_p = one_tail_p, two_p = 2 * one_tail_p))
}

x <- rnorm(10, mean = 0, sd = 1) # generate some artificial data from a N(0, 1)
out <- z_test(x, 0, 1) # null should not be rejected!
```

``` bg-info
#>  z = -0.038 
#>  one-tailed probability = 0.485 
#>  two-tailed probability = 0.97
```

```{.r .numberLines}
print(out)
```

``` bg-info
#> $z
#> [1] -0.038
#> 
#> $one_p
#> [1] 0.485
#> 
#> $two_p
#> [1] 0.97
```

```{.r .numberLines}
x <- rnorm(10, mean = 1, sd = 1) # generate some artificial data from a N(1, 1)
out <- z_test(x, 0, 1) # null should be rejected!
```

``` bg-info
#>  z = 1.741 
#>  one-tailed probability = 0.041 
#>  two-tailed probability = 0.082
```

```{.r .numberLines}
print(out)
```

``` bg-info
#> $z
#> [1] 1.741
#> 
#> $one_p
#> [1] 0.041
#> 
#> $two_p
#> [1] 0.082
```

<button class="button">
  [Back to exercise](#ht-ex3)
</button>

## Solution: Exercise 4 {#ht-sol-ex4}

Define some parameters


```{.r .numberLines}
mu <- 5.4
n <- 5
x_bar <- 5.64
s2 <- 0.05
```
Compute the t-statistic:


```{.r .numberLines}
t <- (x_bar - mu) / sqrt(s2 / n)
print(t)
```

``` bg-info
#> [1] 2.4
```

Work out the thresholds of the critical regions:



```{.r .numberLines}
t_upper <- qt(1 - 0.025, df = n - 1)
print(t_upper)
```

``` bg-info
#> [1] 2.776445
```

```{.r .numberLines}
t_lower <- qt(0.025, df = n - 1)
print(t_lower)
```

``` bg-info
#> [1] -2.776445
```

The t-statistic is outside of the critical regions so we do not reject the null hypothesis.

<button class="button">
  [Back to exercise](#ht-ex4)
</button>

## Solution: Exercise 5 {#ht-sol-ex5}

Define the parameters:


```{.r .numberLines}
x_bar_a <- 88
s2_a <- 4.5
n_a <- 72
x_bar_b <- 79
s2_b <- 4.2
n_b <- 48
mu_a <- 0
mu_b <- 0
```

Compute the z-statistic:


```{.r .numberLines}
z <- ((x_bar_a - x_bar_b) - (mu_a - mu_b)) / sqrt(s2_a / n_a + s2_b / n_b)
print(z)
```

``` bg-info
#> [1] 23.2379
```

Work out for the 5% significance level, the critical values:


```{.r .numberLines}
z_upper <- qnorm(1 - 0.05, mean = 0, sd = 1)
print(z_upper)
```

``` bg-info
#> [1] 1.644854
```
There is evidence to support the claim that process \(A\) yields higher pressurisation.

<button class="button">
  [Back to exercise](#ht-ex5)
</button>

## Solution: Exercise 6 {#ht-sol-ex6}


```{.r .numberLines}
# Data vectors
x_A <- c(91.50, 94.18, 92.18, 95.39, 91.79, 89.07, 94.72, 89.21)
x_B <- c(89.19, 90.95, 90.46, 93.21, 97.19, 97.04, 91.07, 92.75)

# parameters based on data
x_bar_A <- mean(x_A)
s2_A <- var(x_A)
n_A <- length(x_A)
x_bar_B <- mean(x_B)
s2_B <- var(x_B)
n_B <- length(x_B)
```
Compute the pooled variance estimator:


```{.r .numberLines}
s2_p <- ((n_A - 1) * s2_A + (n_B - 1) * s2_B) / (n_A + n_B - 2)
print(s2_p)
```

``` bg-info
#> [1] 7.294654
```

Compute the t-statistic:


```{.r .numberLines}
t = ( x_bar_A - x_bar_B ) / sqrt( s2_p*(1/n_A + 1/n_B) )
print(t)
```

``` bg-info
#> [1] -0.3535909
```

Work out the critical values:


```{.r .numberLines}
t_upper <- qt(1 - 0.025, df = n_A + n_B - 2)
print(t_upper)
```

``` bg-info
#> [1] 2.144787
```

```{.r .numberLines}
t_lower <- qt(0.025, df = n_A + n_B - 2)
print(t_lower)
```

``` bg-info
#> [1] -2.144787
```


Since \(|t|<2.14\) we have no evidence to reject the null hypothesis that the mean yields are equal.

Now, let us use the built-in `t.test` command:


```{.r .numberLines}
  out <- t.test(x = x_A, y = x_B, paired = FALSE, var.equal = TRUE,
    conf.level = 0.95, mu = 0, alternative = "two.sided")
  print(out)
```

``` bg-info
#> 
#> 	Two Sample t-test
#> 
#> data:  x_A and x_B
#> t = -0.35359, df = 14, p-value = 0.7289
#> alternative hypothesis: true difference in means is not equal to 0
#> 95 percent confidence interval:
#>  -3.373886  2.418886
#> sample estimates:
#> mean of x mean of y 
#>   92.2550   92.7325
```

The options `paired=FALSE` means this is an unpaired t-test, `var.equal=TRUE` forces the estimated variances to be the same (i.e. we are using a pooled variance estimator) and we are testing at 95% confidence level with an alternative hypothesis that the true difference in means is non-zero.

The p-value for the t-test is between 0 and 1. In this case, the value is around 0.72 which means the hypothesis should not be reject.

<button class="button">
  [Back to exercise](#ht-ex6)
</button>

## Solution: Exercise 7 {#ht-sol-ex7}

Define parameters:


```{.r .numberLines}
x <- c(23, 36, 31)
p <- c(1 / 3, 1 / 3, 1 / 3)
n <- sum(x)
K <- length(x)
```

Compute the expected counts:


```{.r .numberLines}
Ex = p*n
```

Compute the chi-squared statistic:


```{.r .numberLines}
chi2 <- sum((x - Ex)^2 / Ex)
print(chi2)
```

``` bg-info
#> [1] 2.866667
```

Compute the critical value form the chi-squared distribution:


```{.r .numberLines}
chi_upper <- qchisq(1 - 0.05, df = K-1)
print(chi_upper)
```

``` bg-info
#> [1] 5.991465
```

Thus there is no evidence to reject the null hypothesis. The data provides no reason to suggest a preference for a particular door.

Now, we could have done this in `R`:


```{.r .numberLines}
out <- chisq.test(x, p = c(1 / 3, 1 / 3, 1 / 3))
print(out)
```

``` bg-info
#> 
#> 	Chi-squared test for given probabilities
#> 
#> data:  x
#> X-squared = 2.8667, df = 2, p-value = 0.2385
```

<button class="button">
  [Back to exercise](#ht-ex7)
</button>

## Solution: Exercise 8 {#ht-sol-ex8}


```{.r .numberLines}
y <- c( 0, 1, 2 )
x <- c( 32, 12, 6 )
```

You will need the `vcdExtra` package to use the `expand.dft` command. If you are using BearPortal you don't need to install it, but if you are running the practical on your own computer you will need to install the package `install.packages("vcdExtra")`.

Now before we can use the `expand.dft()` function we need to load the package containing this function. The `expand.dft` command allows one to convert the frequency table into a vector of samples:


```{.r .numberLines}
library(vcdExtra)
```

```
#> Loading required package: vcd
```

```
#> Loading required package: grid
```

```
#> Loading required package: gnm
```

```{.r .numberLines}
samples <- expand.dft(data.frame(y,Frequency = x), freq = "Frequency")
```

Now we can use the `fitdistr` function in the `MASS` package to estimate the MLE of the Poisson distribution


```{.r .numberLines}
# loading the MASS package
library(MASS)

# fitting a Poisson distribution using maximum-likelihood
lambda_hat <- fitdistr(samples$y, densfun = 'Poisson')
```
Let just solve this directly using R built in function. First compute the expected probabilities under the Poisson distribution using `dpois` to compute the Poisson pdf:


```{.r .numberLines}
pr <- c(0, 0, 0)
pr[1] <- dpois(0, lambda = lambda_hat$estimate)
pr[2] <- dpois(1, lambda = lambda_hat$estimate)
pr[3] <- 1 - sum(pr[1:2])
```

Then apply `chisq.test`:


```{.r .numberLines}
out <- chisq.test(x, p = pr)
```

```
#> Warning in chisq.test(x, p = pr): Chi-squared approximation
#> may be incorrect
```

```{.r .numberLines}
print(out)
```

``` bg-info
#> 
#> 	Chi-squared test for given probabilities
#> 
#> data:  x
#> X-squared = 1.3447, df = 2, p-value = 0.5105
```

Actually, in this case the answer is wrong(!), we need to apply an additional loss of degree of freedom to account for the use of the MLE. However, we can re-use values already computed by `chisq.test`:


```{.r .numberLines}
chi2 <- out$statistic
print(chi2)
```

``` bg-info
#> X-squared 
#>   1.34466
```

```{.r .numberLines}
chi2_lower <- qchisq(1 - 0.01, df = 1)
print(chi2_lower)
```

``` bg-info
#> [1] 6.634897
```

Hence, there is no evidence to reject the null hypothesis. There is no reason to suppose that the Poisson distribution is not a plausible model for the number of accidents per week at this junction.

<button class="button">
  [Back to exercise](#ht-ex8)
</button>

## Universal Hypothesis Testing Function {#ht-sol-universal}

Here's a comprehensive function that can handle multiple types of hypothesis tests. This is a basic implementation and can be extended further based on specific requirements. There are many edge cases and additional features that could be added, but this should serve as a solid starting point. This is not the only way to implement such a function, but it covers the main types of tests:


```{.r .numberLines}
# Universal hypothesis testing function
hypothesis_test <- function(test_type, data = NULL, ..., alpha = 0.05) {

  # Initialize result list
  result <- list()

  if (test_type == "z_test") {
    # Z-test (one-sample or two-sample)
    args <- list(...)

    if (length(args$mu0) > 0 && length(args$sigma) > 0) {
      # One-sample z-test
      x <- data
      mu0 <- args$mu0
      sigma <- args$sigma
      alternative <- ifelse(is.null(args$alternative), "two.sided", args$alternative)

      n <- length(x)
      xbar <- mean(x)
      z_stat <- (xbar - mu0) / (sigma / sqrt(n))

      # Calculate p-value based on alternative hypothesis
      if (alternative == "two.sided") {
        p_value <- 2 * (1 - pnorm(abs(z_stat)))
        h0 <- paste("H0: μ =", mu0)
        h1 <- paste("H1: μ ≠", mu0)
      } else if (alternative == "greater") {
        p_value <- 1 - pnorm(z_stat)
        h0 <- paste("H0: μ ≤", mu0)
        h1 <- paste("H1: μ >", mu0)
      } else if (alternative == "less") {
        p_value <- pnorm(z_stat)
        h0 <- paste("H0: μ ≥", mu0)
        h1 <- paste("H1: μ <", mu0)
      }

      result <- list(
        test_name = "One-sample Z-test",
        null_hypothesis = h0,
        alternative_hypothesis = h1,
        test_statistic = z_stat,
        p_value = p_value,
        alpha = alpha,
        conclusion = ifelse(p_value < alpha, "Reject H0", "Fail to reject H0"),
        sample_mean = xbar,
        sample_size = n
      )
    }

  } else if (test_type == "t_test") {
    # T-test (one-sample, two-sample, or paired)
    args <- list(...)

    if (!is.null(args$y)) {
      # Two-sample t-test
      x <- data
      y <- args$y
      alternative <- ifelse(is.null(args$alternative), "two.sided", args$alternative)
      paired <- ifelse(is.null(args$paired), FALSE, args$paired)

      if (paired) {
        # Paired t-test
        diff <- x - y
        n <- length(diff)
        mean_diff <- mean(diff)
        sd_diff <- sd(diff)
        t_stat <- mean_diff / (sd_diff / sqrt(n))
        df <- n - 1

        if (alternative == "two.sided") {
          p_value <- 2 * (1 - pt(abs(t_stat), df))
          h0 <- "H0: μd = 0"
          h1 <- "H1: μd ≠ 0"
        } else if (alternative == "greater") {
          p_value <- 1 - pt(t_stat, df)
          h0 <- "H0: μd ≤ 0"
          h1 <- "H1: μd > 0"
        } else if (alternative == "less") {
          p_value <- pt(t_stat, df)
          h0 <- "H0: μd ≥ 0"
          h1 <- "H1: μd < 0"
        }

        result <- list(
          test_name = "Paired t-test",
          null_hypothesis = h0,
          alternative_hypothesis = h1,
          test_statistic = t_stat,
          degrees_of_freedom = df,
          p_value = p_value,
          alpha = alpha,
          conclusion = ifelse(p_value < alpha, "Reject H0", "Fail to reject H0"),
          mean_difference = mean_diff
        )

      } else {
        # Two-sample t-test (assuming equal variances)
        n1 <- length(x)
        n2 <- length(y)
        mean1 <- mean(x)
        mean2 <- mean(y)
        var1 <- var(x)
        var2 <- var(y)

        # Pooled variance
        pooled_var <- ((n1 - 1) * var1 + (n2 - 1) * var2) / (n1 + n2 - 2)
        se <- sqrt(pooled_var * (1/n1 + 1/n2))
        t_stat <- (mean1 - mean2) / se
        df <- n1 + n2 - 2

        if (alternative == "two.sided") {
          p_value <- 2 * (1 - pt(abs(t_stat), df))
          h0 <- "H0: μ1 = μ2"
          h1 <- "H1: μ1 ≠ μ2"
        } else if (alternative == "greater") {
          p_value <- 1 - pt(t_stat, df)
          h0 <- "H0: μ1 ≤ μ2"
          h1 <- "H1: μ1 > μ2"
        } else if (alternative == "less") {
          p_value <- pt(t_stat, df)
          h0 <- "H0: μ1 ≥ μ2"
          h1 <- "H1: μ1 < μ2"
        }

        result <- list(
          test_name = "Two-sample t-test",
          null_hypothesis = h0,
          alternative_hypothesis = h1,
          test_statistic = t_stat,
          degrees_of_freedom = df,
          p_value = p_value,
          alpha = alpha,
          conclusion = ifelse(p_value < alpha, "Reject H0", "Fail to reject H0"),
          sample1_mean = mean1,
          sample2_mean = mean2
        )
      }

    } else {
      # One-sample t-test
      x <- data
      mu0 <- ifelse(is.null(args$mu0), 0, args$mu0)
      alternative <- ifelse(is.null(args$alternative), "two.sided", args$alternative)

      n <- length(x)
      xbar <- mean(x)
      s <- sd(x)
      t_stat <- (xbar - mu0) / (s / sqrt(n))
      df <- n - 1

      if (alternative == "two.sided") {
        p_value <- 2 * (1 - pt(abs(t_stat), df))
        h0 <- paste("H0: μ =", mu0)
        h1 <- paste("H1: μ ≠", mu0)
      } else if (alternative == "greater") {
        p_value <- 1 - pt(t_stat, df)
        h0 <- paste("H0: μ ≤", mu0)
        h1 <- paste("H1: μ >", mu0)
      } else if (alternative == "less") {
        p_value <- pt(t_stat, df)
        h0 <- paste("H0: μ ≥", mu0)
        h1 <- paste("H1: μ <", mu0)
      }

      result <- list(
        test_name = "One-sample t-test",
        null_hypothesis = h0,
        alternative_hypothesis = h1,
        test_statistic = t_stat,
        degrees_of_freedom = df,
        p_value = p_value,
        alpha = alpha,
        conclusion = ifelse(p_value < alpha, "Reject H0", "Fail to reject H0"),
        sample_mean = xbar,
        sample_size = n
      )
    }

  } else if (test_type == "chi_squared_test") {
    # Chi-squared test (goodness of fit or independence)
    args <- list(...)

    if (!is.null(args$expected)) {
      # Goodness of fit test
      observed <- data
      expected <- args$expected

      chi_stat <- sum((observed - expected)^2 / expected)
      df <- length(observed) - 1
      p_value <- 1 - pchisq(chi_stat, df)

      result <- list(
        test_name = "Chi-squared goodness of fit test",
        null_hypothesis = "H0: Data follows the specified distribution",
        alternative_hypothesis = "H1: Data does not follow the specified distribution",
        test_statistic = chi_stat,
        degrees_of_freedom = df,
        p_value = p_value,
        alpha = alpha,
        conclusion = ifelse(p_value < alpha, "Reject H0", "Fail to reject H0"),
        observed = observed,
        expected = expected
      )

    } else {
      # Test of independence (contingency table)
      contingency_table <- data

      # Calculate expected frequencies
      row_totals <- rowSums(contingency_table)
      col_totals <- colSums(contingency_table)
      total <- sum(contingency_table)

      expected <- outer(row_totals, col_totals) / total

      chi_stat <- sum((contingency_table - expected)^2 / expected)
      df <- (nrow(contingency_table) - 1) * (ncol(contingency_table) - 1)
      p_value <- 1 - pchisq(chi_stat, df)

      result <- list(
        test_name = "Chi-squared test of independence",
        null_hypothesis = "H0: Variables are independent",
        alternative_hypothesis = "H1: Variables are not independent",
        test_statistic = chi_stat,
        degrees_of_freedom = df,
        p_value = p_value,
        alpha = alpha,
        conclusion = ifelse(p_value < alpha, "Reject H0", "Fail to reject H0"),
        observed = contingency_table,
        expected = expected
      )
    }
  }

  class(result) <- "hypothesis_test"
  return(result)
}

# Print method for hypothesis_test objects
print.hypothesis_test <- function(x) {
  cat("\n", x$test_name, "\n")
  cat(rep("=", nchar(x$test_name) + 2), "\n\n", sep = "")

  cat("Hypotheses:\n")
  cat("  ", x$null_hypothesis, "\n")
  cat("  ", x$alternative_hypothesis, "\n\n")

  cat("Test Statistics:\n")
  cat("  Test statistic:", round(x$test_statistic, 4), "\n")
  if (!is.null(x$degrees_of_freedom)) {
    cat("  Degrees of freedom:", x$degrees_of_freedom, "\n")
  }
  cat("  P-value:", round(x$p_value, 6), "\n")
  cat("  Significance level (α):", x$alpha, "\n\n")

  cat("Conclusion:\n")
  cat("  ", x$conclusion, "\n")
  if (x$p_value < x$alpha) {
    cat("  There is sufficient evidence to reject the null hypothesis.\n")
  } else {
    cat("  There is insufficient evidence to reject the null hypothesis.\n")
  }
}
```

## Example Usage

Here are examples of how to use the universal hypothesis testing function:


```{.r .numberLines}
# Example 1: One-sample z-test (Exercise 1 data)
milk_data <- c(263.9, 266.2, 266.3, 266.8, 265.0)
z_result <- hypothesis_test("z_test", data = milk_data, mu0 = 260, sigma = 1.65,
                           alternative = "greater", alpha = 0.01)
print(z_result)
```

``` bg-info
#> 
#>  One-sample Z-test 
#> ===================
#> 
#> Hypotheses:
#>    H0: μ ≤ 260 
#>    H1: μ > 260 
#> 
#> Test Statistics:
#>   Test statistic: 7.6433 
#>   P-value: 0 
#>   Significance level (α): 0.01 
#> 
#> Conclusion:
#>    Reject H0 
#>   There is sufficient evidence to reject the null hypothesis.
```

```{.r .numberLines}
# Example 2: One-sample t-test (Exercise 4 data)
# Simulating data with mean 5.64 and variance 0.05
set.seed(123)
process_data <- rnorm(5, mean = 5.64, sd = sqrt(0.05))
t_result <- hypothesis_test("t_test", data = process_data, mu0 = 5.4,
                           alternative = "two.sided", alpha = 0.05)
print(t_result)
```

``` bg-info
#> 
#>  One-sample t-test 
#> ===================
#> 
#> Hypotheses:
#>    H0: μ = 5.4 
#>    H1: μ ≠ 5.4 
#> 
#> Test Statistics:
#>   Test statistic: 3.4929 
#>   Degrees of freedom: 4 
#>   P-value: 0.025056 
#>   Significance level (α): 0.05 
#> 
#> Conclusion:
#>    Reject H0 
#>   There is sufficient evidence to reject the null hypothesis.
```

```{.r .numberLines}
# Example 3: Chi-squared goodness of fit test (Exercise 7 data)
door_counts <- c(23, 36, 31)
expected_counts <- rep(30, 3)  # Equal preference expected
chi_result <- hypothesis_test("chi_squared_test", data = door_counts,
                             expected = expected_counts, alpha = 0.05)
print(chi_result)
```

``` bg-info
#> 
#>  Chi-squared goodness of fit test 
#> ==================================
#> 
#> Hypotheses:
#>    H0: Data follows the specified distribution 
#>    H1: Data does not follow the specified distribution 
#> 
#> Test Statistics:
#>   Test statistic: 2.8667 
#>   Degrees of freedom: 2 
#>   P-value: 0.238513 
#>   Significance level (α): 0.05 
#> 
#> Conclusion:
#>    Fail to reject H0 
#>   There is insufficient evidence to reject the null hypothesis.
```

<button class="button">
  [Back to exercise](#ht-universal)
</button>
