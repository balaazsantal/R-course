
# creating deck of cards --------------------------------------------------

df <- data.frame(szam = c())



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

##

faces = rep(c('asz','tiz','kilenc','nyolc','het','kiraly','felso','also'),4)
values = rep(c(11,10,9,8,7,4,3,2),4)
suits = rep(c('piros','tok','zold','makk'),each=8)        
deck <- data.frame(
  face=faces,
  suit = suits,
  value=values
)         
         
df <- expand.grid(face=c('asz','tiz','kilenc','nyolc','het','kiraly','felso','also'),suit=c('piros','tok','zold','makk'))
valueMap <- c(asz=11,tiz=10,kilenc=9,nyolc=8,het=7, kiraly=4, felso=3, also=2)
typeof(valueMap)
attributes(valueMap)


df <- transform(df,values=valueMap[face])


# saving and load data ----------------------------------------------------

write.csv(deck,file= "deck.csv",row.names = FALSE)


# deal cards --------------------------------------------------------------

deal <- function(cards){
  cards[1,]
}

deal(deck)

shuffle <- function(cards){
  cards[sample(dim(deck)[1]),]
}

set.seed(7)
deck
shuffle(deck)
deck['face']
deck[['face']]
deck$face

typeof(deck)
attributes(deck)

# misc --------------------------------------------------------------------


1 %in% 1:10
1 %in% 2:10
1:4 %in% 1:10
all(1:4 %in% 3:10)

### missing value
NA+1
NA==1
NA==NA

is.na(NA)

mean(c(NA,1:32))
mean(c(NA,1:32),na.rm = T)

vec <- c(NA,1:32)
vec[is.na(vec)] <- 0
mean()