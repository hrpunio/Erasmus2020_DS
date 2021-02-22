library(ggplot2)

d <- read.csv("komisje-frekwencja2015.csv", sep = ';',  header=T, na.string="NA");

pdf(file="komisje-frekwencja2015.pdf", onefile = TRUE);

ggplot(d, aes(x=freq)) +
    ggtitle("Wybory Parlamentarne 2015: komisje wg frekwencji", subtitle="komisji (N = 27859)") +
    xlab(label="") + ylab(label="N") +
    scale_x_continuous(limits = c(0, 100)) +
    geom_histogram(binwidth=1, fill="steelblue", alpha=.5)

ggplot(d, aes(x=pgnw)) +
    ggtitle("Wybory Parlamentarne 2015: komisje wg % głosów nieważnych", subtitle="komisji (N = 27859)") +
    xlab(label="") + ylab(label="N") +
    scale_x_continuous(limits = c(0, 100)) +
    geom_histogram(binwidth=1, fill="steelblue", alpha=.5)

ggplot(d, aes(x=lgw)) +
    ggtitle("Wybory Parlamentarne 2015: komisje wg liczby głosów ważnych", subtitle="komisji (N = 27859)") +
    xlab(label="") + ylab(label="N") +
    ##scale_x_continuous(limits = c(0, 100)) +
    geom_histogram(binwidth=5, fill="steelblue", alpha=.5)

fivenum(d$lgw)
mean(d$lgw, na.rm=TRUE)

d <- subset (d, ( lgw < 25 ));


nrow(d)
