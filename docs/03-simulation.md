# Simulating random numbers {#simulating-random-numbers}

There are a number of functions in `R` that you can use to simulate random numbers according to different probability distributions.

The function `sample` allows you to take a sample of the specified size from the elements of a vector `x`using sampling with or without replacement. You can use `?sample` to read the documentation describing the command.

In the following, we will use the `sample` function to make 10,000 draws from the set of numbers `1`, `2`, `3` and `4` and display the distribution of the sampled values using a histogram.

First, we define a vector called `x` which contains the numbers `1`, `2`, `3`, and `4`. The function `c` allows us to combine these four numbers together into one vector:


```r
x <- c(1, 2, 3, 4)
```


We now use the function `sample` to pick from those four numbers in `x` 10,000 times. The result, the 10,000 numbers chosen, is store in `out`:


```r
out <- sample(x, 10000, replace=TRUE)
```

Lets plot a histogram of the values picked:


```r
hist_out <- hist(out, main = '', xlab = 'Values', ylab = 'Frequency')
```

<img src="03-simulation_files/figure-html/unnamed-chunk-3-1.png" width="80%" style="display: block; margin: auto;" />

We picked each number with equal probability so the histogram shows each number is equally likely to have been chosen.

**Problem**

::: {.rmdnote}
> What is the difference in the output `out1` and `out2` in the following piece of code?


```r
x <- c( 1, 2, 2, 3, 4, 1, 6, 7, 8, 10, 5, 5, 1, 4, 9 )
out1 <- sample(x, 10, replace=FALSE)
out2 <- sample(x, 10, replace=TRUE)
```

The option `replace=TRUE` activates sampling with replacement (i.e. the numbers that are picked are put back and can be picked again).

The option `replace=FALSE` activates sampling without replacement (i.e. the numbers that are picked are not put back and cannot be picked again).
:::
**Problem**

> Use the `sample` or `sample.int` function to simulate values from rolls of an unbiased six-sided die. Show that the distribution of values you obtain is consistent with an unbiased die.

*Hint 1*: Type `?sample.int` in the console to get help on this function.

*Hint 2*: You may find it useful to use the function `table`. Type `?table` in the console to get help on this function.


```r
rolls_from_sample = sample(c(1:6), size=5000, replace=TRUE)
rolls_from_sample.int = sample(6, size=5000, replace=TRUE)

table(rolls_from_sample)
#> rolls_from_sample
#>   1   2   3   4   5   6 
#> 832 821 794 873 849 831
```


```r
table(rolls_from_sample.int)
#> rolls_from_sample.int
#>   1   2   3   4   5   6 
#> 816 853 842 876 811 802
```

Both gives a uniform distribution over the numbers 1-6. The function `sample.int` is a specialised version of sample for sampling integers. Many `R` libraries have specialised versions of more general functions to do specific tasks under certain conditions.
