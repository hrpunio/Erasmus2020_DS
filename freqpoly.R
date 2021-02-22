library(ggplot2)

komisje <- read.csv("wp2019_komisje_wyniki.csv", sep = ';', 
  colClasses = c( "teryt"="character"),
  header=T, na.string="NA");

##komisje$teryt

komisje$woj <- substr(komisje$teryt, 1,2)
bw <- 2

komisje$woj

ggplot() +
  geom_freqpoly(data = komisje, mapping = aes(x = PiSp, y = ..count.., color = "PiS"), size = 1, binwidth=bw)  +
  geom_freqpoly(data = komisje, mapping = aes(x = POp, y = ..count.., color = "PO"), size = 1, binwidth=bw)  +
  geom_freqpoly(data = komisje, mapping = aes(x = SLDp, y = ..count.., color = "SLD"), size = 1, binwidth=bw)  +
  geom_freqpoly(data = komisje, mapping = aes(x = PSLp, y = ..count.., color = "PSL"), size = 1, binwidth=bw) 

## https://stats.stackexchange.com/questions/280589/how-to-effectively-visualize-multiple-frequency-polygons-in-ggplot2
ggplot() +
  geom_freqpoly(data = komisje, mapping = aes(x = PiSp, y = ..count../sum(..count..)*100, color = "PiS"), size = 1, binwidth=bw)  +
  geom_freqpoly(data = komisje, mapping = aes(x = POp, y = ..count../sum(..count..)*100,  color = "PO"), size = 1)  +
  geom_freqpoly(data = komisje, mapping = aes(x = SLDp, y = ..count../sum(..count..)*100, color = "SLD"), size = 1)  +
  geom_freqpoly(data = komisje, mapping = aes(x = PSLp, y = ..count../sum(..count..)*100, color = "PSL"), size = 1) 
