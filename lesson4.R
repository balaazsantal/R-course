
# environments ------------------------------------------------------------



# import deck.csv

deck <- read.csv("C:/Users/Antal Balázs/R-course/deck.csv")

install.packages('pryr')
library(pryr)

pryr::parenvs(all=T)


globalenv()
baseenv()
emptyenv()


parent.env(globalenv())
parent.env(emptyenv())

#active environment
environment()

ls(environment())
ls(baseenv())

sum <- function(x,y) x-y 
sum(5,6)
sum <- baseenv()$sum

assign('a',5, envir=globalenv())
## check if it's available in the global after 
roll <- function() {
  dice <- sample(die, size = 2, replace = TRUE)
  dice
}
die <- 7:10
roll()
rm('die')

roll2 <- function() {
  die <- 1:6
  assign('dice',sample(die, size = 2, replace = TRUE), envir = globalenv())
  # dice <<- sample(die, size = 2, replace = TRUE)
  dice
}

roll2()

show_env <- function(){
  a <- 10
  list(ran.in = environment(), 
       parent = parent.env(environment()), 
       objects = ls.str(environment()))
}
show_env()

DECK <- deck
identical(DECK, deck)
deal2()

setup_cards <- function(deck){

  DECK <- deck
  DEAL <- function() {
    card <- deck[1, ]
    assign("deck", deck[-1, ], envir = globalenv())
    card
  }
  
  
  SHUFFLE <- function(){
    random <- sample(seq_len(dim(DECK)[1]), size = 32)
    assign("deck", DECK[random, ], envir = globalenv())
  }
  
  list(deal = DEAL,shuffle = SHUFFLE)
}

cards <- setup_cards(read.csv("C:/Users/Antal Balázs/R-course/deck.csv"))
deal <- cards$deal



# DATA VISUALIZATION ------------------------------------------------------


install.packages('tidyverse')
library(tidyverse)
pack <- installed.packages()

?ggplot2
View(mpg)
?mpg

?qplot
#qplot
qplot(x= mpg$displ, y= mpg$hwy)
qplot(mpg$displ,mpg$hwy)
qplot(data = mpg, x=displ, y = hwy)

# ggplot 
# 
# ggplot(data = <DATA>) + 
#   <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy))

#not useful
ggplot(data = mpg) +
  geom_point(mapping = aes(x=class, y = drv))

#color
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy, color = class))

#shape
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy, shape = class))

# alpha
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy, alpha = cty))

#size
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy, size = cty))

?geom_point

# setting properties not aes
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy), color = 'blue',shape= 9,alpha = 0.7)


#modified var in plotting
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, colour = displ < 5))



#  Facets -----------------------------------------------------------------
#
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy, size = cty))+
  facet_wrap(~class, nrow = 2, scales = 'free')


?facet_wrap



ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy, shape = drv, color = cyl))+
  facet_grid(drv ~ cyl,  scales = 'free' )


# color palette
# http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/figure/unnamed-chunk-14-1.png
# https://www.datanovia.com/en/blog/top-r-color-palettes-to-know-for-great-data-visualization/



ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y = hwy))+
  geom_smooth(mapping = aes(x=displ, y = hwy),method = 'lm', se = F)

?mpg
diamonds <- "diamond"

?ggplot2::diamonds
m
ggplot(data=ggplot2::diamonds)+
  geom_line(mapping = aes(x=x,y=y))
