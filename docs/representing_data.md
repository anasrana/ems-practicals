# (PART\*) Statistical Modelling {-}

# Representing Data in R

In this exercise, we will go through some aspects of Linear Algebra and how we implement them in R. We will also look how to represent data and encode it properly for applications. It will teach you to implement statistical methodologies effectively in R.

After these initial introduction to concepts, we will implement some linear algebraic manipulations. In this section you should check if you can repeat the calculations by hand. You will have the solutions in R and can check if you reach the same solutions calculating by hand.

Some of the ideas will be familiar to you but we will phrase them in the linear algebra context. We will use data built into R or we will generate our own data.

## Representing data as vectors

The first thing we will revisit is vectors. This is quite basic and you have already encountered it so think of this as a refresher. We create a basic vector using `c()` and assign it using `<-` to a variable. Let us create a vector \(x\) going from 1 to 3. We can also use the function `seq()` to create a more elaborate vector. Let us create another vector, \(y\), that is made up of \(x\) and sequence from 10 to 120 in steps of 20. Some functions will also return vectors, a simple example is creating random numbers for instance using `rnorm()`. Let us create another vector, \(z\), which consists of 7 random numbers from \(\operatorname{N}(0,1)\).

*Hint: Use `?seq` (or `?rnorm`) to find more information on a function. Make use of this in everything that follows.*


```{.r .numberLines}
# Create x vector
x <- c(1:3)
print(x)
```

``` bg-info
#> [1] 1 2 3
```

```{.r .numberLines}
# Create y vector
y <- c(x, seq(from = 10, to = 120, by = 20))
print(y)
```

``` bg-info
#> [1]   1   2   3  10  30  50  70  90 110
```

```{.r .numberLines}
# Create z vector
z <- rnorm(7)
print(z)
```

``` bg-info
#> [1]  0.2855566  2.2126968 -0.8523812  0.6212688  0.3990666
#> [6] -1.5078422 -0.8130322
```

When you are trying to implement any vector operations in R you will be using data and for manipulations. It is important that data is made up of numbers and not anything else, otherwise operations will not work. There is one way of checking if what we have created is a vector made up of numbers, we can use the function `class()`. If it only contains numbers you will get a response of `integer`, or `numeric`. We can check what it looks like for the vectors we have created.

*Note: We can nest functions in R, to run them. We make use of that here.*


```{.r .numberLines}
# Check what each of the vectors is made of.
# We nest the print function and class function to create one output.
print(class(x))
```

``` bg-info
#> [1] "integer"
```

```{.r .numberLines}
# We can also introduce a step inbetween
a <- class(y)
print(a)
```

``` bg-info
#> [1] "numeric"
```

```{.r .numberLines}
print(class(z))
```

``` bg-info
#> [1] "numeric"
```

What happens when one of the entries in the vector is a string. We will create a new vector `x1` based on \(x\) and `y2` based on \(y\) to test what happens to the vector.


```{.r .numberLines}
# Create a vector x1
x1 <- c(x, "x")
# Print the class for vector x1
print(class(x1))
```

``` bg-info
#> [1] "character"
```

```{.r .numberLines}
# Create a vector y1
y1 <- c(y, "1")
# Print the class for vector y1
print(class(y1))
```

``` bg-info
#> [1] "character"
```

This is not a vector we can use for manipulations as you will see in the next section.

## Vector operations

### Addition

Next we look at operations we can perform with vectors. There are a few simple ones we will explore and also see what errors we can have. You will also have noticed a few ways that R behaves in unexpected ways, this can be useful and can also cause errors. You need to be aware of them to exploit them or know when something has gone wrong.

The first thing we look at is addition. We can add two vectors together that are of the same length. The first quirk in R is that we can also add vectors together that are multiples of each other. This is important to remember as it doesn't follow the rules we looked at for linear algebra. The simplest such case is when we add a number to a vector. We will look at the error message when the vectors are not of equal length.


```{.r .numberLines}
# Add the same vector to itself
x + x
```

``` bg-info
#> [1] 2 4 6
```

```{.r .numberLines}
# Add a number to the vector
x + 2
```

``` bg-info
#> [1] 3 4 5
```

```{.r .numberLines}
# We can add x + y even though they are not the same length
x + y
```

``` bg-info
#> [1]   2   4   6  11  32  53  71  92 113
```

```{.r .numberLines}
# Check the length of each
length(x)
```

``` bg-info
#> [1] 3
```

```{.r .numberLines}
length(y)
```

``` bg-info
#> [1] 9
```

```{.r .numberLines}
length(x + y)
```

``` bg-info
#> [1] 9
```

```{.r .numberLines}
# We can try to add vectors of different length
x + z
```

```
#> Warning in x + z: longer object length is not a multiple of
#> shorter object length
```

``` bg-info
#> [1] 1.2855566 4.2126968 2.1476188 1.6212688 2.3990666
#> [6] 1.4921578 0.1869678
```

We can add \(x\) and \(y\), only because one is a multiple of the other. The vector \(x\) has length 3 and the vector \(y\) has length 9. The addition is performed without error. You will find that the shorter vector is replicated to perform the addition and the new vector is the same length as the longer. The final part we tried is to add two vectors which are not multiples of each other. You will notice that the code will run and produce a result but you will get a warning message. This is among the reasons you want to be careful with warnings and checking each step of functions and code you write.

### Multiplication

The second important operation is multiplication. We can obviously multiply a vector with a numerical value. We can also multiply two vectors of the same length, and two vectors of different length, where the lengths are multiples of each other. This operation has no equivalent in linear algebra we have studied but it can be useful and can provide a shortcut for many applications. We can of course also multiply the transpose of a vector with a vector of equal length which results in a simple number. For this we use the special product sign `%*%`. Finally we can also check what happens if we multiply a numeric vector with a character vector.


```{.r .numberLines}
# Multiply by scalar
2 * x
```

``` bg-info
#> [1] 2 4 6
```

```{.r .numberLines}
# Multiply two vectors of equal length
x * x
```

``` bg-info
#> [1] 1 4 9
```

```{.r .numberLines}
# Multiply two vectors of unequal length
x * y
```

``` bg-info
#> [1]   1   4   9  10  60 150  70 180 330
```

```{.r .numberLines}
# Vector multiplications
x %*% x
```

``` bg-info
#>      [,1]
#> [1,]   14
```

```{.r .numberLines}
# Multiply character vector with numeric vector
x * x1
```

```
#> Error in x * x1: non-numeric argument to binary operator
```

You get an error message for the final product because one of the vectors is not a numeric vector. There are many other useful commands `sum(x)` will sum the values of a vector. You can also use `max(x)` or `min(x)` to find the maximum and minimal entry of a vector. There are many others we don't have time to go into.

## Representing data as a matrix

An important part of linear algebra is of course also matrices. In R a matrix is simply data arrange in two dimensions as a square or rectangle. Here is an example of a simple matrix:

\[
  A = \begin{bmatrix}
            1 & 3 & 4\\
            5 & 9 & 2
        \end{bmatrix}
\]

In R to create a matrix using the `matrix()` function. We first provide a data vector and then we can specify how many rows and columns the matrix has and in which order the matrix is filled with the data. Either filling rows one at a time or columns at a time.


```{.r .numberLines}
# Create a matrix A using the specified vector
A <-
matrix(
  c(1, 3, 4, 5, 9, 2), # data
  nrow = 2, # 2 rows
  ncol = 3, # 3 columns
  byrow = TRUE # fill by row
)

# Create a matrix B using the specified vector
B <-
matrix(
  c(1, 3, 4, 5, 9, 2), # data
  nrow = 2, # 2 rows
  ncol = 3, # 3 columns
  byrow = FALSE # fill by column
)

# Create a matrix C using the specified vector
C <-
matrix(
  c(1, 3, 4, 5, 9, 2), # data
  nrow = 3, # 2 rows
  ncol = 2, # 3 columns
  byrow = FALSE # fill by column
)

# Create a matrix D using the specified vector
D <-
matrix(
  c(1, 3, 4, 5, 9, 2), # data
  nrow = 6, # 2 rows
  ncol = 2, # 3 columns
  byrow = FALSE # fill by column
)

# print matrix A
print(A)
```

``` bg-info
#>      [,1] [,2] [,3]
#> [1,]    1    3    4
#> [2,]    5    9    2
```

```{.r .numberLines}
# print matrix B
print(B)
```

``` bg-info
#>      [,1] [,2] [,3]
#> [1,]    1    4    9
#> [2,]    3    5    2
```

```{.r .numberLines}
# print matrix C
print(C)
```

``` bg-info
#>      [,1] [,2]
#> [1,]    1    5
#> [2,]    3    9
#> [3,]    4    2
```

```{.r .numberLines}
# print matrix D
print(D)
```

``` bg-info
#>      [,1] [,2]
#> [1,]    1    1
#> [2,]    3    3
#> [3,]    4    4
#> [4,]    5    5
#> [5,]    9    9
#> [6,]    2    2
```

You can see that it is not only important what the data vector looks like but also how we fill the matrix. You can see different options when we created matrices \(A\), \(B\), and \(C\). We can create matrices with different dimensions and fill them up differently. It is important to know which matrix we are trying to create and to ensure we are doing it correctly.

**Always print it (if not too large) to check you have done it correctly.**

The other thing you will have seen when creating \(D\) is that R will reuse your data vector if you put in a matrix where the number of elements are a multiple of the data vector without warning and with warning when it isn't an exact exact multiple.

We use `dim()` to check the dimension of the data. For instance `dim(A) =`  2, 3, and `dim(D) =` 6, 2. The other useful thing is that we can name rows and columns to identify wha the data is that we have created. We can use it in two different ways, using `dimnames()`, and a combination of `colnames()`  and `rownames()`.


```{.r .numberLines}
# use dimnames to create both in one go using a list of vector
dimnames(A)  <- list(
  c("sample1", "sample2"), # rows
  c("patient1", "patient2", "patient3") # columns
)

# print matrix A
print(A)
```

``` bg-info
#>         patient1 patient2 patient3
#> sample1        1        3        4
#> sample2        5        9        2
```

```{.r .numberLines}
# Create column names B
colnames(B) <- c("gene1", "gene2", "gene3")
# print matrix B
print(B)
```

``` bg-info
#>      gene1 gene2 gene3
#> [1,]     1     4     9
#> [2,]     3     5     2
```

```{.r .numberLines}
# create row names C
rownames(C) <- c("hospital1", "hospital2", "hospital3")
# print matrix C
print(C)
```

``` bg-info
#>           [,1] [,2]
#> hospital1    1    5
#> hospital2    3    9
#> hospital3    4    2
```

This can be very useful when working with data. We can also create a matrix based on a data matrix. We will make use of the `iris` data set which is built  into R. This can be useful when the data is not made up of just numerical values and you need to perform linear algebraic manipulations. We can convert a subset of a `data.frame` to matrix using the `as.matrix()` command.


```{.r .numberLines}
# Load iris data
data("iris")

# Look at first 6 rows of the data
head(iris)
```

``` bg-info
#>   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
#> 1          5.1         3.5          1.4         0.2  setosa
#> 2          4.9         3.0          1.4         0.2  setosa
#> 3          4.7         3.2          1.3         0.2  setosa
#> 4          4.6         3.1          1.5         0.2  setosa
#> 5          5.0         3.6          1.4         0.2  setosa
#> 6          5.4         3.9          1.7         0.4  setosa
```

```{.r .numberLines}
# Create a matrix of the first 3 columns and the first 10 rows
iris_matrix <- as.matrix(iris[1:10, 1:3])

print(iris_matrix)
```

``` bg-info
#>    Sepal.Length Sepal.Width Petal.Length
#> 1           5.1         3.5          1.4
#> 2           4.9         3.0          1.4
#> 3           4.7         3.2          1.3
#> 4           4.6         3.1          1.5
#> 5           5.0         3.6          1.4
#> 6           5.4         3.9          1.7
#> 7           4.6         3.4          1.4
#> 8           5.0         3.4          1.5
#> 9           4.4         2.9          1.4
#> 10          4.9         3.1          1.5
```

```{.r .numberLines}
# Create a matrix of the first 10 rows and all columns
iris_full <- as.matrix(iris[1:10, ])

print(iris_full)
```

``` bg-info
#>    Sepal.Length Sepal.Width Petal.Length Petal.Width
#> 1  "5.1"        "3.5"       "1.4"        "0.2"      
#> 2  "4.9"        "3.0"       "1.4"        "0.2"      
#> 3  "4.7"        "3.2"       "1.3"        "0.2"      
#> 4  "4.6"        "3.1"       "1.5"        "0.2"      
#> 5  "5.0"        "3.6"       "1.4"        "0.2"      
#> 6  "5.4"        "3.9"       "1.7"        "0.4"      
#> 7  "4.6"        "3.4"       "1.4"        "0.3"      
#> 8  "5.0"        "3.4"       "1.5"        "0.2"      
#> 9  "4.4"        "2.9"       "1.4"        "0.2"      
#> 10 "4.9"        "3.1"       "1.5"        "0.1"      
#>    Species 
#> 1  "setosa"
#> 2  "setosa"
#> 3  "setosa"
#> 4  "setosa"
#> 5  "setosa"
#> 6  "setosa"
#> 7  "setosa"
#> 8  "setosa"
#> 9  "setosa"
#> 10 "setosa"
```

We can see that if the data we use in the `as.matrix()` command consists of more than numerical values all entries will be converted to characters. This will not allow for matrix manipulations. So you have to be careful when creating such a matrix.

## Matrix operations

Now we can look at matrix operations that will allow us to perform operations. We can create a transpose of a matrix using the `t()` command. All normal arithmetic operations like addition and subs-traction. There are multiple ways we can use to perform multiplications. If we use the simple product `*` operation it multiplies both matrices element by element. We did not cover this in the lectures but it is called a Hadamard product. We can implement the matrix product using `%*%` we can also use this to multiply a vector with a matrix.


```{.r .numberLines}
# Substraction
A - B
```

``` bg-info
#>         patient1 patient2 patient3
#> sample1        0       -1       -5
#> sample2        2        4        0
```

```{.r .numberLines}
# Addition
A + B
```

``` bg-info
#>         patient1 patient2 patient3
#> sample1        2        7       13
#> sample2        8       14        4
```

```{.r .numberLines}
# Adding matrices of different dimensions
A + D
```

```
#> Error in A + D: non-conformable arrays
```

```{.r .numberLines}
# Haddamard product
print(A)
```

``` bg-info
#>         patient1 patient2 patient3
#> sample1        1        3        4
#> sample2        5        9        2
```

```{.r .numberLines}
print(B)
```

``` bg-info
#>      gene1 gene2 gene3
#> [1,]     1     4     9
#> [2,]     3     5     2
```

```{.r .numberLines}
A * B
```

``` bg-info
#>         patient1 patient2 patient3
#> sample1        1       12       36
#> sample2       15       45        4
```

```{.r .numberLines}
# matrix product with equal dimensions
A %*% B
```

```
#> Error in A %*% B: non-conformable arguments
```

```{.r .numberLines}
# matrix product with unequal dimension
print(A)
```

``` bg-info
#>         patient1 patient2 patient3
#> sample1        1        3        4
#> sample2        5        9        2
```

```{.r .numberLines}
print(B)
```

``` bg-info
#>      gene1 gene2 gene3
#> [1,]     1     4     9
#> [2,]     3     5     2
```

```{.r .numberLines}
print(C)
```

``` bg-info
#>           [,1] [,2]
#> hospital1    1    5
#> hospital2    3    9
#> hospital3    4    2
```

```{.r .numberLines}
print(D)
```

``` bg-info
#>      [,1] [,2]
#> [1,]    1    1
#> [2,]    3    3
#> [3,]    4    4
#> [4,]    5    5
#> [5,]    9    9
#> [6,]    2    2
```

```{.r .numberLines}
A %*% C
```

``` bg-info
#>         [,1] [,2]
#> sample1   26   40
#> sample2   40  110
```

```{.r .numberLines}
A %*% B
```

```
#> Error in A %*% B: non-conformable arguments
```

```{.r .numberLines}
C %*% A
```

``` bg-info
#>           patient1 patient2 patient3
#> hospital1       26       48       14
#> hospital2       48       90       30
#> hospital3       14       30       20
```

```{.r .numberLines}
A %*% D
```

```
#> Error in A %*% D: non-conformable arguments
```

```{.r .numberLines}
# product between matrix and vector
length(x)
```

``` bg-info
#> [1] 3
```

```{.r .numberLines}
dim(A)
```

``` bg-info
#> [1] 2 3
```

```{.r .numberLines}
# Using a normal product operation
A * x
```

``` bg-info
#>         patient1 patient2 patient3
#> sample1        1        9        8
#> sample2       10        9        6
```

```{.r .numberLines}
# matrix multiplication with a vector
A %*% x
```

``` bg-info
#>         [,1]
#> sample1   19
#> sample2   29
```

```{.r .numberLines}
x %*% A
```

```
#> Error in x %*% A: non-conformable arguments
```

> Q1: Check the product `A * x`, does it behave as you expect? What about `x * A`?

There are several other operations that can be useful for matrices. We will not be able to go through all of them. Here are a few you should explore:

- `rowSums()`
- `colSums()`
- `rowMeans()`
- `det()`

## Testing application {#rep_data-ex}

We will create a few matrices and vectors here. Then you should implement some arithmetic operations in R. Following that you should try to perform the same calculations by hand to check you have done the operations correctly and can perform them by hand.


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

> Q2: Calculate the following matrices.
>
> - `A1 + A2`
> - `A1 * A2`
> - `A1 - A2`
> - `t(A1)`
> - `t(B2)`


> Q3: Compute the norms of all vectors.

> Q4: Compute the inverse of `A1`, `A2`, and `B3`.
> You don't need to invert the matrices by hand but check they are an inverse.

> Q5: Compute `A1 %*% v1` and `v1 %*% A1`

> Q6: Compute `v2 %*% B2` and `B2 %*% v2`

<button class="button">
 [Solution](#representing_data-sol)
</button>
