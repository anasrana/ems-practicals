# (APPENDIX) Solutions {-}

# Solution: Simulations {#simSol}

## Solution Simulation - replacement {#sim-sol-ex1}

The option `replace=TRUE` activates sampling with replacement (i.e. the numbers that are picked are put back and can be picked again).

The option `replace=FALSE` activates sampling without replacement (i.e. the numbers that are picked are not put back and cannot be picked again).

Let's try this out:


```{.r .numberLines}
x <- c( 1, 2, 2, 3, 4, 1, 6, 7, 8, 10, 5, 5, 1, 4, 9 )

# Working example
sample(x, 10, replace = FALSE)
```

``` bg-info
#>  [1]  4  1  2  3  5  6  2  8  9 10
```

```{.r .numberLines}
# This will cause an error
sample(x, 20, replace = FALSE)
```

```
#> Error in sample.int(length(x), size, replace, prob): cannot take a sample larger than the population when 'replace = FALSE'
```

```{.r .numberLines}
# Fix it
sample(x, 20, replace = TRUE)
```

``` bg-info
#>  [1]  6  1  1 10  2  1 10  5  1  4  6  5  1  4  2  5  3  2
#> [19]  1  2
```

<button class="button">
  [Back to exercise](#sim-ex1)
</button>

## Solution Simulation - using sample {#sim-sol-ex2}



```{.r .numberLines}
rolls_from_sample = sample(c(1:6), size=5000, replace=TRUE)
rolls_from_sample.int = sample(6, size=5000, replace=TRUE)

table(rolls_from_sample)
```

``` bg-info
#> rolls_from_sample
#>   1   2   3   4   5   6 
#> 784 845 827 850 820 874
```


```{.r .numberLines}
table(rolls_from_sample.int)
```

``` bg-info
#> rolls_from_sample.int
#>   1   2   3   4   5   6 
#> 828 824 795 860 858 835
```

Both gives a uniform distribution over the numbers 1-6. The function `sample.int` is a specialised version of sample for sampling integers. Many `R` libraries have specialised versions of more general functions to do specific tasks under certain conditions.

<button class="button">
  [Back to exercise](#sim-ex2)
</button>
