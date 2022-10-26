#Qs - loading data, source(), save workspace
# text var said closure
source('roll.R')

a <- 5
die <- 1:6

# atomic vectors ----------------------------------------------------------


#atomic vector

is.vector(a)
is.vector(die)
typeof(a)

length(a)
length(die)

text <- c('apple','orange')
is.vector(text)

typeof(text)

sum(die)
sum(text)


## double

typeof(a)

# integer

a <- 5L
typeof(a)

# floating point error
sqrt(2)^2-2==0 # should be true but false

#character

text

#logical 

l1 <- 5>2
l2 <- 'apple'=='orange'
typeof(l1)

l1 & l2
l1 | l2
!l1

die>3
sum(die>3)
mean(die>3)

(die>3)+1


# attributes --------------------------------------------------------------

attributes(die)

na <- c('a','b','c')
vec <- 1:3
names(vec) <- na
names(vec)

attributes(vec)
is.matrix(vec)

vec[1]

#dim
dim(die) <- c(2,3)
die
is.matrix(die)
is.vector(die)


?matrix

mat[1,3]
mat[5]
mat
mat <- matrix(1:12, 3, byrow = T)
matrix(1:12,ncol= 3)

dim(mat)
attributes(mat)


# array

ar <- array(1:12, dim = c(2,3,2))

## class

class(mat)
class(ar)

class(text)
class(vec)

##dates

today <- Sys.Date()

unclass(today)

typeof(today)
attributes(today)
class(today)

date0 <- 0
class(date0) <- 'Date'
date0


now <-  Sys.time()
typeof(now)
attributes(now)
unclass(now)
time0 <- 0
class(time0) <- class(now)
time0

## Factor

gender <- factor(c('male','female','female','male'))
typeof(gender)
attributes(gender)
unclass(gender)

class(as.character(gender))

gender <- as.character(gender)



### Coercion

mixed <- c(1, '10')
typeof(mixed)
typeof(mixed[1])

c(TRUE, 14)



# Lists, data frames ------------------------------------------------------


### List

list(1,'apple',die)
li <- list(1,'apple',list(die,a))
typeof(li[[3]])

names(li)
li[[3]][[1]][1,2]

li2 <- list(1:6,7:12,13:18)
names(li2) <- c('low','mid','high')
## data frame

df <- data.frame(li2)
View(df)
typeof(df)
attributes(df)

colnames(df)
colnames(df) <- c('l','m','h')

tictactoe <- function(){
  board <- matrix("",3,3)
  i <- 0 #number of filled cells
  while (i<9) {
    if(i%%2){marker <- "o"}else{marker <- "x"}
    if(i<8){board[sample(which(board == ""),1)] <- marker}else{board[which(board == "")] <- marker}
    i <- i+1
  }
  board
}

tictactoe()




## hints for hw: rowSums, colSums, 
