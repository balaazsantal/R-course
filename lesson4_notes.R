
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
  # dice <<- sample(die, size = 2, replace = TRUE)
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
show_env()

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

cards <- setup_cards(deck)

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


# Data visualization ------------------------------------------------------
# https://www.rstudio.com/resources/cheatsheets/

library(tidyverse)
install.packages("tidyverse")
pack <- installed.packages()

mpg
ggplot2::mpg
?mpg


?qplot
#qplot for the easiest plots
qplot(data = mpg, x=displ,y=hwy)
qplot(data=mpg,x=hwy, geom = "histogram", fill = drv)

#   BE CAREFUL ABOUT THE PLACE OF + SIGN
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

# 
# ggplot(data = <DATA>) + 
#   <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))


# Make a scatterplot of hwy vs cyl


# what's this?
ggplot(data = mpg)


# why's this not useful?
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = class, y = drv))

  
#Explain aesthetics
#example for color
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = cyl))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = factor(cyl)))

#example for size
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class))

# alpha
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))


### MAX OF SIX SHAPES
# shape -What happened to the SUVs????????
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))

#### non aesthetic setting 

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")



# EXERCISES ---------------------------------------------------------------



# what's wrong with this code???
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))

# What happens if you map the same variable to multiple aesthetics?

# What does the stroke aesthetic do? What shapes does it work with? (Hint: use ?geom_point
#Use the stroke aesthetic to modify the width of the border

#mapping to modified variable
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, colour = displ < 5))



# FACETS ------------------------------------------------------------------

#?facet_wrap
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_wrap(~ class, nrow = 2)

#?facet_grid
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(drv ~ cyl)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(. ~ cyl)

#Faceting on continuous

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy)) + 
  facet_grid(. ~ hwy)

#check description of facet_grid
# change scales, other properties


# Geometric objects -------------------------------------------------------

# point
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

# smooth
ggplot(data = mpg) + 
  geom_smooth(mapping = aes(x = displ, y = hwy))

# different aes work with different geoms


# add multiple geoms

#common aes
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth()


#different aes
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = drv)) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

#se property
ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + 
  geom_smooth(se = FALSE)

# line chart

# geom_histogram

# geom_boxplot

#area chart


# Statistical transformations ---------------------------------------------

?ggplot2::diamonds

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut))

# looks better, does the same
ggplot(data = diamonds) + 
  stat_count(mapping = aes(x = cut))

# three reasons you might need to use a stat explicitly
## draw greater attention to the statistical transformation in your code
## override the default stat (identity)
## override the default mapping from transformed variables to aesthetics
#why do we need group=1??
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = stat(prop), group = 1))


# Examples

?stat_summary #what's the default geom
?stat_smooth # same as geom_smooth, but this way geom can be changed

# how's geom_col different from geom_bar



# positional adjustments --------------------------------------------------


#you probably don't want this
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut))

#but this
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))

ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 1/5)
ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
  geom_bar(fill = NA)

## what if the aes is mapped to something else

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))


# positions can be identity, dodge, or fill

#fill
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "fill")

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity), position = "dodge")


## adjustment useful for geom_point --- jitter
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy),)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), position = "jitter")

ggplot(data = mpg) + 
  geom_count(mapping = aes(x = displ, y = hwy))

?geom_jitter




# coordinate systems ------------------------------------------------------


# coord_flip
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot()

ggplot(data = mpg, mapping = aes(x = class, y = hwy)) + 
  geom_boxplot() +
  coord_flip()

# 
# ggplot(data = <DATA>) + 
#   <GEOM_FUNCTION>(
#     mapping = aes(<MAPPINGS>),
#     stat = <STAT>, 
#     position = <POSITION>
#   ) +
#   <COORDINATE_FUNCTION> +
#   <FACET_FUNCTION>



#color palettes
# http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/figure/unnamed-chunk-14-1.png
# https://www.datanovia.com/en/blog/top-r-color-palettes-to-know-for-great-data-visualization/



?economics
