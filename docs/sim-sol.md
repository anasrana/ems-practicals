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
#>  [1]  1  4  4  2  1 10  5  3  6  1
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
#>  [1]  9  3  8  2  7 10  3  4  1  5  9  1  4  9 10  7  8 10
#> [19]  5  1
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
#> 858 862 800 840 811 829
```


```{.r .numberLines}
table(rolls_from_sample.int)
```

``` bg-info
#> rolls_from_sample.int
#>   1   2   3   4   5   6 
#> 805 858 882 823 839 793
```

Both gives a uniform distribution over the numbers 1-6. The function `sample.int` is a specialised version of sample for sampling integers. Many `R` libraries have specialised versions of more general functions to do specific tasks under certain conditions.

<button class="button">
  [Back to exercise](#sim-ex2)
</button>
