install.packages(c(
  "colorBlindness", "directlabels", "dplyr", "ggforce", "gghighlight", 
  "ggnewscale", "ggplot2", "ggraph", "ggrepel", "ggtext", "ggthemes", 
  "hexbin", "Hmisc", "mapproj", "maps", "munsell", "ozmaps", 
  "paletteer", "patchwork", "rmapshaper", "scico", "seriation", "sf", 
  "stars", "tidygraph", "tidyr", "wesanderson" 
))


library(tidyverse)

unemp <- qplot(date, unemploy, data=economics, geom="line",xlab = "", ylab = "No. unemployed (1000s)")

presidential <- presidential[-(1:3), ]

yrng <- range(economics$unemploy)
xrng <- range(economics$date)
unemp + geom_vline(aes(xintercept = start), data = presidential)

unemp + geom_rect(aes(NULL, NULL, xmin = start, xmax = end,
                  fill = party), ymin = yrng[1], ymax = yrng[2],
                  data = presidential) + 
  scale_fill_manual(values = alpha(c("blue", "red"), 0.2))

last_plot() + 
  geom_text(aes(x = start, y = yrng[1], label = name), data = presidential, size = 3, hjust = 0, vjust = 0)

highest <- subset(economics, unemploy == max(unemploy))
 unemp + geom_point(data = highest, size = 3, colour = alpha("red", 0.5))

 RColorBrewer::display.brewer.all()
?RColorBrewer 

 ggplot(huron, aes(year)) +
   geom_line(aes(y = level + 5, colour = "above")) +
   geom_line(aes(y = level - 5, colour = "below")) +
   scale_colour_manual("Direction",
                       values = c("above" = "red", "below" = "blue")
   )
 
 #discrete
 
 df <- data.frame(x = c("a", "b", "c", "d"), y = c(3, 4, 1, 2))
 bars <- ggplot(df, aes(x, y, fill = x)) + 
   geom_bar(stat = "identity") + 
   labs(x = NULL, y = NULL) +
   theme(legend.position = "none")
 
 bars + scale_fill_brewer(palette = "Set1")
 bars + scale_fill_brewer(palette = "Set2")
 bars + scale_fill_brewer(palette = "Accent")
 
 
 bars + scale_fill_grey()
 bars + scale_fill_grey(start = 0.5, end = 1)
 bars + scale_fill_grey(start = 0, end = 0.5)
 
 bars + paletteer::scale_fill_paletteer_d("rtist::vangogh")
 bars + paletteer::scale_fill_paletteer_d("colorBlindness::paletteMartin")
 bars + paletteer::scale_fill_paletteer_d("wesanderson::FantasticFox1")
 
 
 bars + 
   scale_fill_manual(
     values = c("sienna1", "sienna4", "hotpink1", "hotpink4")
   )
 
 bars + 
   scale_fill_manual(
     values = c("tomato1", "tomato2", "tomato3", "tomato4")
   )
 
 bars + 
   scale_fill_manual(
     values = c("grey", "black", "grey", "grey")
   )
 
 
 erupt <- ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
   geom_raster() +
   scale_x_continuous(NULL, expand = c(0, 0)) + 
   scale_y_continuous(NULL, expand = c(0, 0)) + 
   theme(legend.position = "none")
 
#continuous

 erupt
 erupt + scale_fill_viridis_c()
 erupt + scale_fill_viridis_c(option = "magma")
 
# colorbrewer cont alternatives
 
 erupt + scale_fill_distiller()
 erupt + scale_fill_distiller(palette = "RdPu")
 erupt + scale_fill_distiller(palette = "YlOrBr")
 
 # paletteer for uniform function calls
 
 erupt + paletteer::scale_fill_paletteer_c("viridis::plasma")
 erupt + paletteer::scale_fill_paletteer_c("scico::tokyo")
 
 
#custom palettes
 
 erupt + scale_fill_gradient(low = "grey", high = "brown")
 erupt + 
   scale_fill_gradient2(
     low = "grey", 
     mid = "white", 
     high = "brown", 
     midpoint = .02
   )
 erupt + scale_fill_gradientn(colours = terrain.colors(7)) 
 
 
#Annotation
 p <- ggplot(mpg, aes(displ, hwy)) +
   geom_point(
     data = filter(mpg, manufacturer == "subaru"), 
     colour = "orange",
     size = 3
   ) +
   geom_point()  
 
 p + 
   annotate(geom = "point", x = 5.5, y = 40, colour = "orange", size = 3) + 
   annotate(geom = "point", x = 5.5, y = 40) + 
   annotate(geom = "text", x = 5.6, y = 40, label = "subaru", hjust = "left")
 p + 
   annotate(
     geom = "curve", x = 4, y = 35, xend = 2.65, yend = 27, 
     curvature = .3, arrow = arrow(length = unit(2, "mm"))
   ) +
   annotate(geom = "text", x = 4.1, y = 35, label = "subaru", hjust = "left")
 
 # highlight
 install.packages("gghighlight")
 
 library(gghighlight)
 set.seed(2)
 d <- purrr::map_dfr(
   letters,
   ~ data.frame(
     idx = 1:400,
     value = cumsum(runif(400, -1, 1)),
     type = .,
     flag = sample(c(TRUE, FALSE), size = 400, replace = TRUE),
     stringsAsFactors = FALSE
   )
 )
 ggplot(d) +
   geom_line(aes(idx, value, colour = type)) +
   gghighlight(max(value) > 20)
 
 ggplot(d, aes(idx, value, colour = type)) +
   geom_line() +
   gghighlight(max(value), max_highlight = 5L)
 
 ggplot(d, aes(idx, value, colour = type)) +
   geom_line() +
   gghighlight(max(value), max_highlight = 5L)
 
 
 data(Oxboys, package = "nlme")
 ggplot(Oxboys, aes(age, height, group = Subject)) + 
   geom_line() + 
   geom_point() + 
   gghighlight::gghighlight(Subject %in% 1:3)
 
 ggplot(mpg, aes(displ, hwy, colour = factor(cyl))) +
   geom_point() + 
   gghighlight::gghighlight() + 
   facet_wrap(vars(cyl))