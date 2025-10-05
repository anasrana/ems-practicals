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

## Solution - Data Processing Function {#rep_data-func-sol}

Here's a function that extracts a matrix and vector from a data.frame and performs matrix multiplication. Note, this is a more advanced function that includes error handling and checks to ensure the matrix multiplication is valid.Also, this is a implementation and there are several ways to do this:


```{.r .numberLines}
# Function to extract matrix and vector from data.frame
#   and perform matrix multiplication
# Note: For matrix multiplication A %*% v, the vector length must equal
#   the number of columns in A
# Here we will make use of the function `stop()` to handle errors.
#   this will ensure you know where the error is coming from
matrix_vector_multiply <- function(data, columns, vector, n_rows) {

  # Input validation
  if (!is.data.frame(data)) {
    stop("Error: 'data' must be a data.frame")
  }

  if (!is.numeric(columns) || any(columns < 1) ||
      any(columns > ncol(data))) {
    stop("Error: 'columns' must be valid column indices within the data.frame")
  }

  if (!is.numeric(vector) || length(vector) != 1 || vector < 1 ||
      vector > ncol(data)) {
    stop("Error: 'vector' must be a single valid column index")
  }

  if (!is.numeric(n_rows) || length(n_rows) != 1 || n_rows < 1 ||
      n_rows > nrow(data)) {
    stop("Error: 'n_rows' must be a single positive integer not exceeding ",
         "the number of rows in data")
  }

  # Check if selected columns are numeric
  if (!all(sapply(data[columns], is.numeric))) {
    stop("Error: All selected columns must be numeric")
  }

  if (!is.numeric(data[[vector]])) {
    stop("Error: The vector column must be numeric")
  }

  # Extract the matrix (first n_rows of specified columns)
  matrix_data <- as.matrix(data[1:n_rows, columns])

  # Extract the vector (first ncol(matrix) rows of specified column)
  # For matrix multiplication A %*% v, length(v) must equal ncol(A)
  vector_length_needed <- ncol(matrix_data)

  if (vector_length_needed > nrow(data)) {
    stop("Error: Not enough rows in data to create vector of required ",
         "length (", vector_length_needed, ")")
  }

  vector_data <- as.vector(data[1:vector_length_needed, vector])

  # Print dimensions before multiplication
  cat("Matrix dimensions:", dim(matrix_data), "\n")
  cat("Vector length:", length(vector_data), "\n")

  # Check if matrix multiplication is possible (should always be true now)
  if (ncol(matrix_data) != length(vector_data)) {
    stop("Error: Matrix multiplication not possible - number of columns ",
         "in matrix (", ncol(matrix_data), ") must equal length of vector (",
         length(vector_data), ")")
  }

  # Perform matrix multiplication
  result <- matrix_data %*% vector_data

  # Return the result
  return(result)
}
```

## Example Usage with Iris Dataset

Let's demonstrate the function using the iris dataset:


```{.r .numberLines}
# Load the iris dataset
data(iris)

# Display the structure of iris dataset
str(iris)
```

``` bg-info
#> 'data.frame':	150 obs. of  5 variables:
#>  $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
#>  $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
#>  $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
#>  $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
#>  $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...
```

```{.r .numberLines}
# Example 1: Extract first 3 columns as matrix, 4th column as vector,
#   using 5 rows
# Note: Vector will have length 3 (matching matrix columns) for valid
#   multiplication
cat("Example 1: Using columns 1-3 as matrix (5 rows), column 4 as vector",
    "(3 elements)\n")
```

``` bg-info
#> Example 1: Using columns 1-3 as matrix (5 rows), column 4 as vector (3 elements)
```

```{.r .numberLines}
result1 <- matrix_vector_multiply(
  data = iris,
  columns = 1:3,
  vector = 4,
  n_rows = 5
)
```

``` bg-info
#> Matrix dimensions: 5 3 
#> Vector length: 3
```

```{.r .numberLines}
print(result1)
```

``` bg-info
#>   [,1]
#> 1 2.00
#> 2 1.86
#> 3 1.84
#> 4 1.84
#> 5 2.00
```

```{.r .numberLines}
# Example 2: Extract columns 1 and 3 as matrix, column 2 as vector,
#   using 10 rows
# Note: Vector will have length 2 (matching matrix columns) for valid
#   multiplication
cat("Example 2: Using columns 1,3 as matrix (10 rows), column 2 as vector",
    "(2 elements)\n")
```

``` bg-info
#> Example 2: Using columns 1,3 as matrix (10 rows), column 2 as vector (2 elements)
```

```{.r .numberLines}
result2 <- matrix_vector_multiply(
  data = iris,
  columns = c(1, 3),
  vector = 2,
  n_rows = 10
)
```

``` bg-info
#> Matrix dimensions: 10 2 
#> Vector length: 2
```

```{.r .numberLines}
print(result2)
```

``` bg-info
#>     [,1]
#> 1  22.05
#> 2  21.35
#> 3  20.35
#> 4  20.60
#> 5  21.70
#> 6  24.00
#> 7  20.30
#> 8  22.00
#> 9  19.60
#> 10 21.65
```

```{.r .numberLines}
# Example 3: Create a square matrix for demonstration
cat("Example 3: Using columns 1-3 as matrix (3 rows), column 1 as vector",
    "(3 elements)\n")
```

``` bg-info
#> Example 3: Using columns 1-3 as matrix (3 rows), column 1 as vector (3 elements)
```

```{.r .numberLines}
result3 <- matrix_vector_multiply(
  data = iris,
  columns = 1:3,
  vector = 1,
  n_rows = 3
)
```

``` bg-info
#> Matrix dimensions: 3 3 
#> Vector length: 3
```

```{.r .numberLines}
print(result3)
```

``` bg-info
#>    [,1]
#> 1 49.74
#> 2 46.27
#> 3 45.76
```

### Error Handling Examples

Let's test the error handling capabilities:


```{.r .numberLines}
# Test error cases (these will produce errors as expected)

# Error: Invalid column indices
try({
  matrix_vector_multiply(iris, columns = c(1, 10), vector = 2,
                         n_rows = 5)
})
```

``` bg-info
#> Error in matrix_vector_multiply(iris, columns = c(1, 10), vector = 2,  : 
#>   Error: 'columns' must be valid column indices within the data.frame
```

```{.r .numberLines}
# Error: Non-numeric vector column (species column)
try({
  matrix_vector_multiply(iris, columns = 1:2, vector = 5,
                         n_rows = 5)
})
```

``` bg-info
#> Error in matrix_vector_multiply(iris, columns = 1:2, vector = 5, n_rows = 5) : 
#>   Error: The vector column must be numeric
```

```{.r .numberLines}
# Error: Too many rows requested
try({
  matrix_vector_multiply(iris, columns = 1:2, vector = 3,
                         n_rows = 200)
})
```

``` bg-info
#> Error in matrix_vector_multiply(iris, columns = 1:2, vector = 3, n_rows = 200) : 
#>   Error: 'n_rows' must be a single positive integer not exceeding the number of rows in data
```

```{.r .numberLines}
# Error: Non-data.frame input
try({
  matrix_vector_multiply(c(1, 2, 3), columns = 1, vector = 1,
                         n_rows = 1)
})
```

``` bg-info
#> Error in matrix_vector_multiply(c(1, 2, 3), columns = 1, vector = 1, n_rows = 1) : 
#>   Error: 'data' must be a data.frame
```

## Function Features Summary

The `matrix_vector_multiply` function includes:

1. **Input Validation**:
   - Checks if `data` is a data.frame
   - Validates column indices are within bounds
   - Ensures vector column index is valid
   - Confirms n_rows is appropriate
   - Verifies all selected columns are numeric

2. **Smart Dimension Handling**:
   - Extracts matrix using first `n_rows` of specified columns
   - Extracts vector with length equal to number of matrix columns
     (ensuring valid multiplication)
   - Prints matrix and vector dimensions before multiplication
   - Ensures matrix multiplication is mathematically possible

3. **Matrix Multiplication Logic**:
   - For `A %*% v`, ensures `length(v) == ncol(A)`
   - Vector is extracted from the first `ncol(matrix)` rows of the
     specified column
   - This guarantees valid matrix-vector multiplication

4. **Error Handling**:
   - Provides clear error messages for invalid inputs
   - Uses `stop()` for immediate termination with informative messages
   - Checks if enough data rows exist for required vector length

5. **Flexibility**:
   - Allows selection of any numeric columns for the matrix
   - Can extract any number of rows for the matrix (up to dataset size)
   - Works with any data.frame containing numeric columns
   - Automatically adjusts vector length to match matrix dimensions

<button class="button">
  [Back to exercise](#rep_data-ex)
</button>
