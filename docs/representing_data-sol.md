# Solution: Representing Data {#representing_data-sol}
## Creating vectors and matrices


```{.r .numberLines}
# Creating matrices
A1 <- matrix(
  c(1:9),
  nrow = 3
)

A2 <- matrix(
  c(1, 3, 4, 6, 9, 2, 1, 0, 3),
  nrow = 3
)

# Creating vectors
v1 <- c(0, 1, 1)
v2 <- c(2, 1, 0)
v3 <- c(3, 1, 1)
x1 <- c(1, 2, 0, 1)
x2 <- c(2, 3, 1, 1)
x3 <- c(4, 1, 2, 0)

# Another way to create matrices
B1 <- cbind(v1, v3, v2)
B2 <- rbind(v1, v2, v3)
```

<button class="button">
  [Back to exercise](#rep_data-ex)
</button>


## Solution Q2

> Q2: Calculate the following matrices.

- `A1 + A2`
- `A1 * A2`
- `A1 - A2`
- transpose of `A1`
- transpose of `B2`


```{.r .numberLines}
A1 + A2
```

``` bg-info
#>      [,1] [,2] [,3]
#> [1,]    2   10    8
#> [2,]    5   14    8
#> [3,]    7    8   12
```

```{.r .numberLines}
A1 * A2
```

``` bg-info
#>      [,1] [,2] [,3]
#> [1,]    1   24    7
#> [2,]    6   45    0
#> [3,]   12   12   27
```

```{.r .numberLines}
A1 - A2
```

``` bg-info
#>      [,1] [,2] [,3]
#> [1,]    0   -2    6
#> [2,]   -1   -4    8
#> [3,]   -1    4    6
```

```{.r .numberLines}
t(A1)
```

``` bg-info
#>      [,1] [,2] [,3]
#> [1,]    1    2    3
#> [2,]    4    5    6
#> [3,]    7    8    9
```

```{.r .numberLines}
t(B2)
```

``` bg-info
#>      v1 v2 v3
#> [1,]  0  2  3
#> [2,]  1  1  1
#> [3,]  1  0  1
```

<button class="button">
  [Back to exercise](#rep_data-ex)
</button>

## Solution Q3

> Q3: Compute the norms of all vectors.


```{.r .numberLines}
sum(v1^2)
```

``` bg-info
#> [1] 2
```

```{.r .numberLines}
sum(v2^2)
```

``` bg-info
#> [1] 5
```

```{.r .numberLines}
sum(v3^2)
```

``` bg-info
#> [1] 11
```

```{.r .numberLines}
sum(x1^2)
```

``` bg-info
#> [1] 6
```

```{.r .numberLines}
sum(x2^2)
```

``` bg-info
#> [1] 15
```

```{.r .numberLines}
sum(x3^2)
```

``` bg-info
#> [1] 21
```

<button class="button">
  [Back to exercise](#rep_data-ex)
</button>

## Solution Q4

> Q4: Compute the inverse of `A1`, `A2`, and `B3`.
> You don't need to invert the matrices by hand but check they are an inverse.


```{.r .numberLines}
# Inverse doesn't exist as it is a singular matrix
solve(A1)
```

```
#> Error in solve.default(A1): Lapack routine dgesv: system is exactly singular: U[3,3] = 0
```

```{.r .numberLines}
solve(A2)
```

``` bg-info
#>            [,1]        [,2]        [,3]
#> [1,] -0.4736842  0.28070175  0.15789474
#> [2,]  0.1578947  0.01754386 -0.05263158
#> [3,]  0.5263158 -0.38596491  0.15789474
```

```{.r .numberLines}
solve(A2) %*% A2
```

``` bg-info
#>               [,1]          [,2]          [,3]
#> [1,]  1.000000e+00 -5.551115e-17  2.775558e-17
#> [2,] -2.775558e-17  1.000000e+00 -4.163336e-17
#> [3,] -1.110223e-16  1.665335e-16  1.000000e+00
```

```{.r .numberLines}
solve(B2)
```

``` bg-info
#>              v1 v2         v3
#> [1,] -0.3333333  0  0.3333333
#> [2,]  0.6666667  1 -0.6666667
#> [3,]  0.3333333 -1  0.6666667
```

```{.r .numberLines}
solve(B2) %*% B2
```

``` bg-info
#>               [,1] [,2] [,3]
#> [1,]  1.000000e+00    0    0
#> [2,]  1.110223e-16    1    0
#> [3,] -1.110223e-16    0    1
```

<button class="button">
  [Back to exercise](#rep_data-ex)
</button>

## Solution Q5 and Q6

> Q5: Compute `A1 %*% v1` and `v1 %*% A1`


```{.r .numberLines}
A1 %*% v1
```

``` bg-info
#>      [,1]
#> [1,]   11
#> [2,]   13
#> [3,]   15
```

```{.r .numberLines}
v1 %*% A1
```

``` bg-info
#>      [,1] [,2] [,3]
#> [1,]    5   11   17
```

> Q6: Compute `v2 %*% B2` and `B2 %*% v2`


```{.r .numberLines}
v2 %*% B2
```

``` bg-info
#>      [,1] [,2] [,3]
#> [1,]    2    3    2
```

```{.r .numberLines}
B2 %*% v2
```

``` bg-info
#>    [,1]
#> v1    1
#> v2    5
#> v3    7
```

<button class="button">
  [Back to exercise](#rep_data-ex)
</button>
