library(ggplot2)

d <- read.csv("WP2019_KO.csv", sep = ';',  header=T, na.string="NA");
d$pgnw <- d$lgnw / (d$lgnw + d$lgw ) * 100

pdf(file="komisje-frekwencja2019.pdf", onefile = TRUE);

ggplot(d, aes(x=freq)) +
    ggtitle("Wybory Parlamentarne 2015: komisje wg frekwencji", subtitle="(N = 27859 stations)") +
    xlab(label="") + ylab(label="N") +
    scale_x_continuous(limits = c(0, 100)) +
    geom_histogram(binwidth=1, fill="steelblue", alpha=.5)

ggplot(d, aes(x=pgnw)) +
    ggtitle("Wybory Parlamentarne 2015: komisje wg % głosów nieważnych", subtitle="(N = 27859 stations)") +
    xlab(label="") + ylab(label="N") +
    scale_x_continuous(limits = c(0, 100)) +
    geom_histogram(binwidth=1, fill="steelblue", alpha=.5)

ggplot(d, aes(x=lgw)) +
    ggtitle("Wybory Parlamentarne 2015: komisje wg liczby głosów ważnych", subtitle="komisji (N = 27859)") +
    xlab(label="") + ylab(label="N") +
    ##scale_x_continuous(limits = c(0, 100)) +
    geom_histogram(binwidth=10, fill="steelblue", alpha=.5)

ggplot(d, aes(x=lgw)) +
    ggtitle("Elections 2019: number of valid votes", subtitle="(N = 27859 stations)") +
    xlab(label="") + ylab(label="N") +
    ##scale_x_continuous(limits = c(0, 100)) +
    geom_freqpoly(binwidth=10, size=.5, position="identity")
##    geom_histogram(binwidth=50, fill="steelblue", alpha=.5)

fivenum(d$lgw)
mean(d$lgw, na.rm=TRUE)

d <- subset (d, ( lgw < 25 ));

nrow(d)
