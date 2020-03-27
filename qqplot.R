library (ggplot2)
kk <- read.csv("kandydaci_sejm_2019_f4.csv", sep = ';',  header=T, na.string="NA");

ggplot(kk) + geom_qq(aes(sample = glosy))
