install.packages('tidyverse')
library(tidyverse)


?mpg


qplot(data=mpg,x=displ,y=hwy)
qplot(data=mpg, x=trans)
qplot(data=mpg, x=hwy, geom = "freqpoly")


ggplot(data = mpg)+
  layer(geom = 'point',stat = 'identity',position = 'identity', mapping = aes(x=displ,y=hwy))

ggplot(data = mpg)+
  layer(geom = 'point',stat = 'identity',position = 'jitter', mapping = aes(x=class,y=drv))

ggplot(data=mpg)+
  geom_point(mapping = aes(x=class, y=drv),stat = 'sum')

ggplot(data=mpg)+
  geom_count(mapping = aes(x=class, y=drv))

ggplot(data=mpg)+
  geom_jitter(mapping = aes(x=class, y=drv), width = 0.2, height = 0.2)



ggplot(data=mpg)+
  geom_jitter(mapping = aes(x=class, y=drv),alpha=0.2, width = 0.1, height = 0.1)


ggplot(data=mpg,mapping = aes(displ,hwy,color=drv))+
  geom_point()+
  geom_smooth(method = 'lm',se=F)+
  facet_grid(drv~class)

?diamonds
ggplot(data=diamonds,aes(x=cut))+
  geom_bar()

ggplot()
ggplot(diamonds,aes(x=cut))+
  stat_count()


?geom_jitter


?economics

tail(economics)

yrng <- range(economics$unemploy)
ggplot(economics)+
  geom_line(aes(date,unemploy),linetype='solid')+
  geom_vline(aes(xintercept=start),data=presidential)+
  geom_text(aes(x=start,y=yrng[1],label=name),data=presidential,hjust=0,vjust=0)+
  geom_rect(aes(NULL,NULL,xmin=start, xmax=end,
                ymin=yrng[1],ymax=yrng[2],fill=party),data=presidential)+
  scale_fill_manual(values = alpha(c('blue','red'),0.3))

?geom_rect

last_plot()


?geom_line

?presidential
