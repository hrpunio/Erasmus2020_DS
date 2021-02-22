library(ggplot2)

komisje <- read.csv("wp2019_komisje_wyniki.csv", sep = ';', 
  colClasses = c( "teryt"="character"),
  header=T, na.string="NA");

##komisje$teryt

komisje$woj <- substr(komisje$teryt, 1,2)

komisje$woj

ggplot(komisje, aes(x=as.factor(woj), y=PiSp, fill=as.factor(woj))) + geom_boxplot() +
  scale_y_continuous(limits=c(0,50)) +
  ggtitle("Support for PiS") +
  guides(fill=guide_legend("")) +
  ylab(label="%") +
  xlab("województwo");
