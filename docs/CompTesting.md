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
