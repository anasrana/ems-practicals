# Markov Chains

<!-- In this practical you will learn a number of techniques in R that you will use to simulate simplified games of Monopoly (<https://en.wikipedia.org/wiki/Monopoly_(game)>). In addition, there are also many tutorials and guides on the Web describing how to produce computer simulations for Monopoly. You are welcome to read and use these examples to inspire your work. -->

We will now look at a **Markov Chain**. We have not covered it during lectures but based on the basic principles we have covered we will be able to use it for simulations.

Any random process is known to have the *Markov property* (a Markov process) if the probability of going to the next state depends only on the current state and not on the past states. A Markov process is **memoryless property** in that it does not store any property or memory of its past states.

If a Markov process operates within a specific (finite) set of states, it is called a ***Markov Chain***.

A Markov Chain is defined by three properties:

1.  A state space: a set of values or states in which a process could exist

2.  A transition matrix: defines the probability of moving from one state to another state

3.  A current state probability distribution: defines the probability of being in any one of the states at the start of the process

Consider the following example where we have two states describing the weather on any particular day: (i) Sunny and (ii) Rainy. Each arrow denotes the probability of going from one state to itself or another over the course of a day. For example, if it is currently sunny, the probability of it raining the next day is 0.6. Conversely, if it is raining, the probability that it will become sunny the next day is 0.7 and 0.3 that it will continue raining.

<img src="04-markov-chains_files/figure-html/unnamed-chunk-1-1.png" width="90%" />

The transition matrix can be written as the following in R:


```r
transitionMatrix = matrix(c(0.4, 0.6, 0.7, 0.3), nrow=2, ncol=2, byrow=TRUE)
print(transitionMatrix)
#>      [,1] [,2]
#> [1,]  0.4  0.6
#> [2,]  0.7  0.3
```

which creates a 2 x 2 matrix consisting of the transition probabilities shown in the diagram.

Suppose I want to simulate a sequence of 30 days and the weather patterns over those days. Assuming that on day 0 it is currently sunny, I can do the following:


```r
# initial state - it is [1] sunny or [2] rainy
state <- 1
weather_sequence <- rep(0, 30) # vector to store simulated values
for (day in 1:30) { # simulate for 30 days
  pr <- transitionMatrix[state, ] # select the row of transition probabilities

  # sample [1] or [2] based on the probs pr
  state = sample(c(1, 2), size = 1, prob = pr)
  weather_sequence[day] <- state # store the sampled state
}

# print the simulated weather sequence
print(weather_sequence)
#>  [1] 1 2 1 1 1 2 1 1 2 1 2 2 2 1 2 1 2 1 1 2 2 1 2 1 1 2 1 2
#> [29] 2 1
```


**Problem**

> Can you extend this example to a three-state model?

<img src="04-markov-chains_files/figure-html/unnamed-chunk-4-1.png" width="90%" />

Note, the diagram (intentionally) misses out the self-transitions. You should be able to infer this because the probabilities given would otherwise not add up to one!

## Model answers 3 state Markov Chain{-}

Set up a 3x3 transition matrix:


```r
transitionMatrix = matrix(c(0.7, 0.2, 0.1,
                            0.3, 0.3, 0.4,
                            0.6, 0.2, 0.2), nrow=3, ncol=3, byrow=TRUE)

# Check matrix set-up correctly
print(transitionMatrix)
#>      [,1] [,2] [,3]
#> [1,]  0.7  0.2  0.1
#> [2,]  0.3  0.3  0.4
#> [3,]  0.6  0.2  0.2
```

Note the ordering of the states is arbitrary but here we have used the convention that State 1 is Sunny, State 2 is Rainy and State 3 is Cloudy which means the probabilities are completed in that order in the transition matrix. We just need to be consistent.


```r
state <- 1 # initial state - it is [1] sunny, [2] rainy and [3] cloudy
weather_sequence <- rep(0, 30) # vector to store simulated values

# simulate for 30 days
for (day in 1:30) {
  pr <- transitionMatrix[state, ] # select the row of transition probabilities

  # sample [1-3] based on the probs pr
  state <- sample(c(1, 2, 3), size = 1, prob = pr)
  weather_sequence[day] <- state # store the sampled state
}
print(weather_sequence)
#>  [1] 1 1 1 1 2 1 1 1 2 3 1 1 3 1 1 1 2 2 3 1 1 2 1 1 2 3 3 1
#> [29] 1 1
```

## A Monopoly simulation

Now you will use to simulate simplified games of Monopoly (https://en.wikipedia.org/wiki/Monopoly_(game)). In addition, there are also many tutorials and guides on the Web describing how to produce computer simulations for Monopoly. You are welcome to read and use these examples to inspire your work.

## Moving around the board

A Monopoly board has 40 spaces. Players take it in turns to roll two dice and traverse around the board according to the sum of the dice values.

Use the following code example to simulate turns of a single player:


```r
num_turns <- 100000 # number of turns to take

current_board_position <- 0 # start on the GO space

move_size <- rep(0, num_turns)
positions_visited <- rep(0, num_turns)

# use a for loop to simulate a number of turns
for (turn in 1:num_turns) {

  # roll two dice
  die_values <- sample(c(1:6), 2, replace = TRUE)

  # move player position

  # number of positions to move
  plus_move <- sum(die_values)

  # compute new board position
  new_board_position <- current_board_position + plus_move

  # update board position (this corrects for the fact the board is circular)
  current_board_position <- (new_board_position %% 40)

  # store position visited
  positions_visited[turn] <- current_board_position

}
```


By increasing the number of turns taken, what distribution does the set of simulated board positions converge towards? Show this graphically using the histogram function.


```r
hist(positions_visited, breaks = seq(0, 40, len = 41), right = FALSE)
```

<img src="04-markov-chains_files/figure-html/unnamed-chunk-8-1.png" width="672" />

## Going to Jail

If a player lands on to Go To Jail space they must move immediately to the Jail space. Extend your code to include the possibility of going to jail. Here, assume that once in jail, the player continues as normal on the next turn.


```r
 num_turns <- 100000 # number of turns to take

current_board_position <- 0 # start on the GO space
go_to_jail_position <- 30 # the go to jail space
jail_position <- 10 # jail space

move_size <- rep(0, num_turns)
positions_visited <- rep(0, num_turns)

# use a for loop to simulate a number of turns
for (turn in 1:num_turns) {

  # roll two dice
  die_values <- sample(c(1:6), 2, replace = TRUE)

  # move player position

  # number of positions to move
  plus_move <- sum(die_values)

  # compute new board position
  new_board_position <- current_board_position + plus_move

  # if land on GO TO JAIL square, then go backwards to the JAIL square
  if (new_board_position == go_to_jail_position) {
    new_board_position <- jail_position
  }

  # update board position (this corrects for the fact the board is circular)
  current_board_position <- (new_board_position %% 40)

  # store position visited
  positions_visited[turn] <- current_board_position

}
```

> What is the distribution of board positions during a long game?


```r
hist(positions_visited, breaks = seq(0, 40, len = 41), right = FALSE)
```

<img src="04-markov-chains_files/figure-html/unnamed-chunk-10-1.png" width="672" />




> Can you explain this result qualitatively?

You can also go to jail, if you roll three doubles (both dice having the same value) in a row. Update your code to allow for the possibility of going to Jail with three doubles. How does the distribution of board positions change?


```r
num_turns <- 100000 # number of turns to take

current_board_position <- 0 # start on the GO space
go_to_jail_position  <- 30 # the go to jail space
jail_position <- 10 # jail space

move_size <- rep(0, num_turns)
positions_visited <- rep(0, num_turns)

# use a for loop to simulate a number of turns
for (turn in 1:num_turns) {

  # set double counter to zero
  double_counter <- 0

  # roll (max) three times
  for (j in 1:3){

    # roll two dice
    die_values <- sample(c(1:6), 2, replace = TRUE)

    # if we have rolled a double for the third time, we proceed straight to jail
    if ((die_values[1] == die_values[2]) & (double_counter == 2 )) {
      current_board_position <- jail_position
      break
    }

    # otherwise

    # move player position

    # number of positions to move
    plus_move <- sum(die_values)

    # compute new board position
    new_board_position <- current_board_position + plus_move

    # if land on GO TO JAIL square, then go backwards to the JAIL square
    if (new_board_position == go_to_jail_position) {
      new_board_position <- jail_position
    }

    # update board position (this corrects for the fact the board is circular)
    current_board_position <- (new_board_position %% 40)

    # break out of loop if we roll a non-double
    if (die_values[1] != die_values[2]) {
      break
    } else { # increment double counter
      double_counter <- double_counter + 1
    }

  }

  # store final position visited
  positions_visited[turn] <- current_board_position


}


hist(positions_visited, breaks = seq(0, 40, len = 41), right = FALSE)
```

<img src="04-markov-chains_files/figure-html/unnamed-chunk-11-1.png" width="672" />

Adding the rolling doubles feature doesn't seem to change much. We might expect this since rolling three doubles is a very unlikely event!

## Further Exercises

Now consider building a more complex Monopoly simulation by incorporating more complex aspects of the game such as:

-   the purchase of properties
-   a ledger for each player
-   chance and community cards

You will need to think carefully about the simplifying assumptions you will make to make the task achievable. Do not be over-ambitious. For example, you might initially assume that players will not build houses/hotels on properties.

Here are some questions to answer with your simulations:

1.  How many turns does it take before all properties are purchased?
2.  What are the best properties to buy?
3.  How long does it take for a winner to be determined?

For example, the following simple extension of the previous example adds some features to record properties being purchased. This simulation is constructed based on the assumption that a players always buys any free property that land on.


```r
num_games <- 1000 # number of games to play
num_turns <- 1000 # number of turns to take

current_board_position <- 0 # start on the GO space
go_to_jail_position <- 30 # the go to jail space
jail_position <- 10 # jail space
# vector of squares containing properties
properties_that_can_be_bought <- c(1, 3, 5, 6, 8, 9, 11, 12, 13, 14, 15, 16,
   18, 19, 21, 23, 24, 25, 26, 27, 28, 29, 31, 32, 34, 35, 37, 39)


# vector to store number of turns to buy all properties
time_to_buy_all_properties <- rep(0, num_games)

# simulate multiple games
for (game in 1:num_games) {

  positions_visited <- rep(0, num_turns)
  positions_purchased <- rep(0, 40)
  properties_bought <- rep(0, num_turns)

  # use a for loop to simulate a number of turns
  for (turn in 1:num_turns) {

    # roll two dice
    die_values <- sample(c(1:6), 2, replace = TRUE)

    # move player position

    # number of positions to move
    plus_move <- sum(die_values)

    # compute new board position
    new_board_position <- current_board_position + plus_move

    # if land on GO TO JAIL square, then go backwards to the JAIL square
    if (new_board_position == go_to_jail_position) {
      new_board_position <- jail_position
    }

    # update board position (this corrects for the fact the board is circular)
    current_board_position <- (new_board_position %% 40)

    # if we can on a square that can be purchased and which has not been
    # purchased (note R uses 1-indexing for arrays)
    if (positions_purchased[current_board_position+1] == 0) {
      if (current_board_position %in% properties_that_can_be_bought) {
        positions_purchased[current_board_position + 1] <- 1
      }
    }

    # store position visited
    positions_visited[turn] <- current_board_position

    # store number of properties bought
    properties_bought[turn] <- sum(positions_purchased)

    # check if all properties are gone
    if (properties_bought[turn] == length(properties_that_can_be_bought)) {
      time_to_buy_all_properties[game] <- turn
      break
    }


  }

}

hist(time_to_buy_all_properties, breaks = 20)
```

<img src="04-markov-chains_files/figure-html/unnamed-chunk-12-1.png" width="672" />