###### Basics of R

# Creating variables ------------------------------------------------------


die <- 1:6

# alternative ways to create sequences
die <- seq(1,6,1) #from, to, by
die <- seq_len(6) # from 1 to 6
seq_along(die) # from 1 to length(die)



# Operations with sequences -----------------------------------------------

c(die,die)

die + die

die - die

die * die
die^2

die %*% die
crossprod(die,die)

die %o% die
outer(die,die)

# Basic functions ---------------------------------------------------------

## Help
help(help)
help(sample)
?sample
??sample
help("??")


# Summary on sequences

sum(die)
mean(die)
round(mean(die))

var(die)
sd(die)
sqrt(var(die))

## rep


## ?sample




# Writing functions -------------------------------------------------------

# hello world

# arguments

# roll
?replicate


# if, for, while ----------------------------------------------------------


# Exercises ---------------------------------------------------------------

# tic-tac-toe 

tictactoe <- function(){
  board <- matrix("",3,3)
  i <- 0  # number of filled cells
  gameover <- F
  while (i<9 & !gameover){
    if(i%%2){marker <- "o"}else{marker <- "x"}
    if(i==8){board[which(board== "")] <- marker}else board[sample(which(board== ""),1)] <- marker
    gameover <-( any(rowSums(board==marker)==3)) | (any( colSums(board==marker)==3)) | (sum(diag(board==marker))==3) |( all((board==marker)[c(3,5,7)]))
    if(!gameover)i=i+1
  }
  if(i<9 ){print(paste(marker,"won in", i+1))}else{print("Tie")}
  print(board)
  
}

tictactoe()

# first n Fibonacci nums

# Pascal's triangle

# a game until someone rolls the same num on both dice

# Hornik: https://statmath.wu.ac.at/~hornik/Comp/comp_exercises.pdf
# 1, 6,7, 8, 9, 12, 13, 14, 15, 16, 20, 21

