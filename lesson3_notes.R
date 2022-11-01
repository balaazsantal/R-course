##discuss tictactoe and questions
## closure

# Creating deck of cards --------------------------------------------------
#https://upload.wikimedia.org/wikipedia/commons/e/e1/Piatnik_%C3%A1szok.jpg

df <- data.frame(face = c("also", "felso", "kiraly"),  
                 suit = c("piros", "piros", "piros"),
                 value = c(1, 2, 3))

typeof(df)
class(df)
str(df)


#stringsAsFactors = 


deck <- data.frame(
  face = c('asz','tiz','kilenc','nyolc','het','kiraly','felso','also',
           'asz','tiz','kilenc','nyolc','het','kiraly','felso','also',
           'asz','tiz','kilenc','nyolc','het','kiraly','felso','also',
           'asz','tiz','kilenc','nyolc','het','kiraly','felso','also'),
  suit = c('piros','piros','piros','piros','piros','piros','piros','piros',
           'tok','tok','tok','tok','tok','tok','tok','tok',
           'zold','zold','zold','zold','zold','zold','zold','zold',
           'makk','makk','makk','makk','makk','makk','makk','makk'),
  value = c(11,10,9,8,7,4,3,2,
            11,10,9,8,7,4,3,2,
            11,10,9,8,7,4,3,2,
            11,10,9,8,7,4,3,2)
)


##build up deck with rep


##expand grid
faces= c('asz','tiz','kilenc','nyolc','het','kiraly','felso','also')
suits = c('piros','tok','zold','makk')
df <- expand.grid(faces=faces,suits=suits)
valueMap=c(asz=11, tiz=10, kilenc=9, nyolc=8, het=7, kiraly=4, felso=3, also=2)

transform(df,values=valueMap[faces])
df$values=unname(valueMap[df$faces])


# Saving and loading data -------------------------------------------------

write.csv(deck, file = "cards.csv", row.names = FALSE)

#check optional arguments

#import data with wizard

# will get back to specifics later
?write.csv



# Function to deal cards --------------------------------------------------


deal <- function(cards) {
  
  cards[1, ]
}

deal(deck)



# Shuffling the deck ------------------------------------------------------

deck[1:2,]
deck[c(2,1),]
sample(1:32)

deck[sample(1:32),]

shuffle <- function(cards) { 
  cards[sample(1:32),]
}


deal(shuffle(deck))




# Indexing ---------------------------------------------------------------

##indexing with square brackets
##possible values 
# 
# Positive integers
# Negative integers
# Zero
# Blank spaces
# Logical values
# Names


head(deck)

deck[1, c(1, 2, 3)]
deck[1:5, c(1, 2, 3)]

#duplication
deck[c(1, 1), c(1, 2, 3)]

#single col selection and drop=F

deck[1:3, 1]
deck[1:3, 1, drop = FALSE]


## indexing with negative integers

deck[-(2:32), 1:3]

#mixing does not work
deck[c(-1, 1), 1]

#blank spaces

deck[,]


# logical values
#example with rep, and condition


#names
deck[ , "value"]
deck$value


# Changing values ---------------------------------------------------------

vec <- c(0, 0, 0, 0, 0, 0)

vec[1] <- 1000
vec[c(1, 3, 5)] <- c(1, 1, 1)
vec[4:6] <- vec[4:6] + 1


deck2$index <- 1:32

vec[c(FALSE, FALSE, FALSE, FALSE, TRUE, FALSE, FALSE)]


## in
1 %in% c(3, 4, 5)
c(1, 2, 3, 4) %in% c(3, 4, 5)


## with logical indexing 
sum(deck2$face == "asz")


deck3$value[deck3$face == "asz"]


# changing asz value to 1
deck3$value[deck3$face == "ace"] <- 1



# missing values ----------------------------------------------------------

NA+1

NA==1

NA==NA

is.na(NA)

mean(c(NA, 1:50))
mean(c(NA, 1:50), na.rm = TRUE)



# Environments ------------------------------------------------------------

install.packages('pryr')
library(pryr)
parenvs(all = TRUE)

globalenv()
baseenv()
emptyenv()


parent.env(globalenv())
parent.env(emptyenv())

ls(emptyenv())
ls(globalenv())


head(globalenv()$deck, 3)
assign("new", "Hello Global", envir = globalenv())

## active environment
environment()


## scoping rules
# 
# R looks for objects in the current active environment.
# When you work at the command line, the active environment is the global environment.
# Hence, R looks up objects that you call at the command line in the global environment.
# Here is a third rule that explains how R finds objects that are not in the active environment
# 
# When R does not find an object in an environment, R looks in the environment’s parent environment,
# then the parent of the parent, and so on, until R finds the object or reaches the empty environment.


## check if it's available in the global after 
roll <- function() {
  die <- 1:6
  dice <- sample(die, size = 2, replace = TRUE)
  sum(dice)
}

roll2()

roll2 <- function() {
  die <- 1:6
  assign("dice",sample(die, size = 2, replace = TRUE) , envir = globalenv())
  sum(dice)
}

dice

### check environments
show_env <- function(){
  list(ran.in = environment(), 
       parent = parent.env(environment()), 
       objects = ls.str(environment()))
}

# R will connect a function’s runtime environment to the environment that the function was first created in
environment(parenvs)
environment(show_env)


### Deal cards with environment considerations

## deal from global environment
deal <- function() {
  deck[1, ]
}

###save a master copy that we do not change
DECK <- deck

deck <- deck[-1, ]

head(deck, 3)


deal2 <- function() {
  card <- deck[1, ]
  assign("deck", deck[-1, ], envir = globalenv())
  card
}

shuffle2 <- function(){
  random <- sample(1:32, size = 32)
  assign("deck", DECK[random, ], envir = globalenv())
}

#### Setting up environment
setup_cards <- function(deck) {
  DECK <- deck
  
  DEAL <- function() {
    card <- deck[1, ]
    assign("deck", deck[-1, ], envir = globalenv())
    card
  }
  
  SHUFFLE <- function(){
    random <- sample(1:52, size = 52)
    assign("deck", DECK[random, ], envir = globalenv())
  }
  
  list(deal = DEAL, shuffle = SHUFFLE)
}

cards <- setup(deck)

deal <- cards$deal
shuffle <- cards$shuffle

deal 
shuffle

environment(deal)
environment(shuffle)


### change setup to change variables in parent instead of global

setup <- function(deck) {
  DECK <- deck
  
  DEAL <- function() {
    card <- deck[1, ]
    assign("deck", deck[-1, ], envir = parent.env(environment()))
    card
  }
  
  SHUFFLE <- function(){
    random <- sample(1:52, size = 52)
    assign("deck", DECK[random, ], envir = parent.env(environment()))
  }
  
  list(deal = DEAL, shuffle = SHUFFLE)
}

cards <- setup(deck)
deal <- cards$deal
shuffle <- cards$shuffle
# Homeworks ---------------------------------------------------------------


# Practice with tests - Exercise 7.3 (Practice with Tests) 

typeof()
