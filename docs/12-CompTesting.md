# Computational Testing Techniques

In this practical we will look at various hypothesis testing techniques in `R`. The main focus will be to implement what we learned in the lectures. Please make an attempt before looking at the models answers. The solutions are quite straightforward to implement in `R` and should not take too long to complete.

## Exercise 1 {#ht-ex1}

A process for filling milk cartons is claimed to fill each carton with an average of 260g.

The population fill weight is known to be normal, with a standard deviation of 1.65g.

A random sample of five cartons was collected, and the content weighed, yielding the following (in g.)

```
263.9, 266.2, 266.3, 266.8, 265.0
```

Construct a suitable hypothesis test, at the 1% significance level, to determine whether cartons are being over-filled.

<button class="button">
 [Solution](#ht-sol-ex1)
</button>

## Exercise 2 {#ht-ex2}

The mean length of a certain type of component is assumed to be 100mm. Concerns are raised that the mean length is not 100mm.

A random sample of size 45 was obtained, yielding \(\bar{x}=103.11\) and \(s=53.5\).

Perform a hypothesis test, at the 5% level, to determine whether these concerns are justified.

<button class="button">
 [Solution](#ht-sol-ex2)
</button>

## Exercise 3 {#ht-ex3}

Can you write your own `z_test` function to perform one-sided or two-sided location (z) tests?

<button class="button">
 [Solution](#ht-sol-ex3)
</button>

## Exercise 4 {#ht-ex4}

A manufacturing process yields a product that has a quality control specification of \(\mu_0=5.4\).

A random sample of size \(n=5\) had a sample mean of \(5.64\) and sample variance of \(0.05\).

Conduct a hypothesis test, at the \(5%\) significance level, to assess whether the process is meeting specification.
<button class="button">
 [Solution](#ht-sol-ex4)
</button>

## Exercise 5 {#ht-ex5}

Two methods of filling standard gas cylinders are claimed to be different.

In particular, process \(A\) is claimed to yield a higher pressure that process \(B\).

1. A random sample of 72 cylinders were filled using process $A$, yielding $\bar{x}_A = 88$ and $s_A^2 = 4.5$.
2. A random sample of 48 cylinders were filled with process $B$, yielding $\bar{x}_B = 79$ and $s_B^2 = 4.2$.

Conduct a hypothesis test, at the 5% significance level, to investigate this claim.

<button class="button">
 [Solution](#ht-sol-ex5)
</button>

## Exercise 6 {#ht-ex6}

Two catalysts are available for a chemical process. Catalyst B is cheaper than catalyst A.

Provided catalyst B produces the same mean yields, it should be preferred.

To compare methods an experiment was conducted yielding the following data:

| \(A\) | 91.50 | 94.18 | 92.18 | 95.39 | 91.79 | 89.07 | 94.72 | 89.21 |
|-------|-------|-------|-------|-------|-------|-------|-------|-------|
| \(B\) | 89.19 | 90.95 | 90.46 | 93.21 | 97.19 | 97.04 | 91.07 | 92.75 |

Is there evidence to say the two catalysts produce different mean yields? Test at the 5% significance level

<button class="button">
 [Solution](#ht-sol-ex6)
</button>


## Exercise 7 {#ht-ex7}

In an animal behaviour experiment a group of 90 rats proceed down a ramp to one of three doors.

The observed counts for each door were:

| Door | 1 | 2 | 3 |
|------|---|---|---|
| Count| 23| 36| 31|

Is there evidence to suggest a preference for a specific door? Test at the 5% significance level.

<button class="button">
 [Solution](#ht-sol-ex7)
</button>

## Exercise 8 {#ht-ex8}

The number of accidents at a junction per week, \(Y\), was observed over a 50 week period, yielding:

| $y$ | 0 | 1 | 2 | $\geq 3$ |
|-----|---|---|---|----------|
| $O$ | 32| 12| 6 | 0        |

Test the hypothesis, at the 1% level, that \(Y \sim \operatorname{Poisson} (\lambda)\)

<button class="button">
 [Solution](#ht-sol-ex8)
</button>


# Model Answers: Computational Testing {-}

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

```{.bg-info}
#> [1] 7.643287
```

Check if the z-statistic is in the critical range. First, work out what the z-value at the edge of the critical region is:


```{.r .numberLines}
z_threshold <- qnorm(1 - 0.01, mean = 0, sd = 1)
print(z_threshold)
```

```{.bg-info}
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

```{.bg-info}
#> [1] 0.3899535
```

Now, work out the thresholds of the critical regions:


```{.r .numberLines}
z_upper <- qnorm(1 - 0.025, mean = 0, sd = 1)
print(z_upper)
```

```{.bg-info}
#> [1] 1.959964
```

```{.r .numberLines}
z_lower <- qnorm(0.025, mean = 0, sd = 1)
print(z_lower)
```

```{.bg-info}
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

```{.bg-info}
#>  z = -0.816 
#>  one-tailed probability = 0.207 
#>  two-tailed probability = 0.414
```

```{.r .numberLines}
print(out)
```

```{.bg-info}
#> $z
#> [1] -0.816
#> 
#> $one_p
#> [1] 0.207
#> 
#> $two_p
#> [1] 0.414
```

```{.r .numberLines}
x <- rnorm(10, mean = 1, sd = 1) # generate some artificial data from a N(1, 1)
out <- z_test(x, 0, 1) # null should be rejected!
```

```{.bg-info}
#>  z = 1.839 
#>  one-tailed probability = 0.033 
#>  two-tailed probability = 0.066
```

```{.r .numberLines}
print(out)
```

```{.bg-info}
#> $z
#> [1] 1.839
#> 
#> $one_p
#> [1] 0.033
#> 
#> $two_p
#> [1] 0.066
```

<button class="button">
  [Back to exercise](#ht-ex3)
</button>

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

```{.bg-info}
#> [1] 2.4
```

Work out the thresholds of the critical regions:



```{.r .numberLines}
t_upper <- qt(1 - 0.025, df = n - 1)
print(t_upper)
```

```{.bg-info}
#> [1] 2.776445
```

```{.r .numberLines}
t_lower <- qt(0.025, df = n - 1)
print(t_lower)
```

```{.bg-info}
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

```{.bg-info}
#> [1] 23.2379
```

Work out for the 5% significance level, the critical values:


```{.r .numberLines}
z_upper <- qnorm(1 - 0.05, mean = 0, sd = 1)
print(z_upper)
```

```{.bg-info}
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

```{.bg-info}
#> [1] 7.294654
```

Compute the t-statistic:


```{.r .numberLines}
t = ( x_bar_A - x_bar_B ) / sqrt( s2_p*(1/n_A + 1/n_B) )
print(t)
```

```{.bg-info}
#> [1] -0.3535909
```

Work out the critical values:


```{.r .numberLines}
t_upper <- qt(1 - 0.025, df = n_A + n_B - 2)
print(t_upper)
```

```{.bg-info}
#> [1] 2.144787
```

```{.r .numberLines}
t_lower <- qt(0.025, df = n_A + n_B - 2)
print(t_lower)
```

```{.bg-info}
#> [1] -2.144787
```


Since \(|t|<2.14\) we have no evidence to reject the null hypothesis that the mean yields are equal.

Now, let us use the built-in `t.test` command:


```{.r .numberLines}
  out <- t.test(x = x_A, y = x_B, paired = FALSE, var.equal = TRUE,
    conf.level = 0.95, mu = 0, alternative = "two.sided")
  print(out)
```

```{.bg-info}
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

```{.bg-info}
#> [1] 2.866667
```

Compute the critical value form the chi-squared distribution:


```{.r .numberLines}
chi_upper <- qchisq(1 - 0.05, df = K-1)
print(chi_upper)
```

```{.bg-info}
#> [1] 5.991465
```

Thus there is no evidence to reject the null hypothesis. The data provides no reason to suggest a preference for a particular door.

Now, we could have done this in `R`:


```{.r .numberLines}
out <- chisq.test(x, p = c(1 / 3, 1 / 3, 1 / 3))
print(out)
```

```{.bg-info}
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

```{.bg-info}
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

```{.bg-info}
#> X-squared 
#>   1.34466
```

```{.r .numberLines}
chi2_lower <- qchisq(1 - 0.01, df = 1)
print(chi2_lower)
```

```{.bg-info}
#> [1] 6.634897
```

Hence, there is no evidence to reject the null hypothesis. There is no reason to suppose that the Poisson distribution is not a plausible model for the number of accidents per week at this junction.

<button class="button">
  [Back to exercise](#ht-ex8)
</button>
