# Basics  of R


# Variables ---------------------------------------------------------------

a <- 4
a +5

a <- a +5

die <- 1:6
die[1]
die2 <- die[3:6]



seq(1,6,1) # params : from , to , by
seq_len(6)
seq_along(die)



#  operations with sequences ----------------------------------------------

c(die,die2) # combine two seqs

die + die 
die - die 

#add single num to seq
die + a

#add shorter seq to longer seq
die3 <- die[1:2]
die + die3

die + die2 # error

die^3

#inner product
die %*% die
crossprod(die,die)
sum(die*die)


#outer prod
die %o% die
outer(die,die)


# help --------------------------------------------------------------------

help(sum)
help(help)

?sum #simple help
??sum #search for help


mean(die)
var(die)
sd(die)
sqrt(var(die))

round(sd(die),3)


rep(die,3) #die seq 3 times
rep(die, each=3) 

sample(die) #reshuffling
sample(die,1) #single sample
sample(x=die,size=1)
sample(x=die, replace = T, size = 2)


out <- sample(die,2,T)
out

hello <- function(){print("hello world") }
hello()

#roll the dice
roll <- function(n){
  print(sample(die,n,T))
}

roll(2)
prob <- c(0,1/6,1/6,1/6,1/6,1/3)
sample(die,6,prob = prob,replace = T)


# if, for, while ----------------------------------------------------------

a==8
a==9

if(a>5){
  print(a)
  a <- a-1
}


#for loop - we know the number of repetitions

for (i in die) {
 print(die[i])
}

replicate(3,roll(2))

# while loop - condition on rerun
a <- 9
while(a>5){
  print(a)
  a <- a-1
}
print("done")

ls() #list defined variables
rm("a") #remove variables

die
