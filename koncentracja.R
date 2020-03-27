##
require (ggplot2)
library(dplyr)

barColor <- "#8a0303"
##################################################################
xxx.limits <- c(0, 20)
xxx.breaks <- seq(0, 30, by = 2)
dft.limits <- c(0, 250)
dft.breaks <- seq(0, 250, by = 10)
##################################################################

kandydaci <- read.csv("kandydaci_sejm_2019_f4.csv", sep = ';',  header=T, na.string="NA");

kk <- kandydaci
nrow(kandydaci)

tit <- "2019 elections: PiS/PO/PSL/SLD"
ggplot(kk, aes(x=as.factor(nrk), y=glosy, fill=as.factor(nrk))) + 
  geom_boxplot() + 
  ggtitle(tit, subtitle="PO/PiS/SLD/PSL/") +
  ylab("votes") +
  ## https://stackoverflow.com/questions/11724311/how-to-add-a-ggplot2-subtitle-with-different-size-and-colour
  theme(plot.subtitle=element_text(size=8)) +
  xlab("list number");

kk <- filter (kandydaci, glosy < 125000)
nrow(kk)

tit <- "2019 elections"
ggplot(kk, aes(x=as.factor(nrk), y=glosy, fill=as.factor(nrk))) + 
  geom_boxplot() + 
  ggtitle(tit, subtitle="PO/PiS/SLD/PSL/ votes < 125000") +
  ylab("votes") +
  ## https://stackoverflow.com/questions/11724311/how-to-add-a-ggplot2-subtitle-with-different-size-and-colour
  theme(plot.subtitle=element_text(size=8)) +
  xlab("list number");

kk <- filter(kandydaci, ((komitet=="PO" | komitet=="PiS") & glosy < 125000))

tit <- "2019 elections"
ggplot(kk, aes(x=as.factor(nrk), y=glosy, fill=as.factor(nrk))) + 
  geom_boxplot() + 
  ggtitle(tit, subtitle="PO/PiS votes < 125000") +
  ylab("votes") +
  ## https://stackoverflow.com/questions/11724311/how-to-add-a-ggplot2-subtitle-with-different-size-and-colour
  theme(plot.subtitle=element_text(size=8)) +
  xlab("list number");

kk <- filter (kandydaci, okr == 25 | okr == 26)

tit <- "2019 elections"
ggplot(kk, aes(x=as.factor(nrk), y=glosy, fill=as.factor(nrk))) + 
  geom_boxplot() + 
  ggtitle(tit, subtitle="PO/PiS/SLD/PSL/ okr 26/25 (Pomorskie) votes < 125000") +
  ylab("votes") +
  ## https://stackoverflow.com/questions/11724311/how-to-add-a-ggplot2-subtitle-with-different-size-and-colour
  theme(plot.subtitle=element_text(size=8)) +
  xlab("list number");

