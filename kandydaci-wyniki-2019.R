library(ggplot2)
library(dplyr)
library(stringr)
library(data.table)
options(dplyr.print_max = 1e9)

kk <- read.csv("kandydaci_wyniki_2015_2019.csv", sep = ';',  header=T, na.string="NA");
kk <- kk %>% filter(komitet=="PiS" | komitet=="PO" | komitet=="SLD" | komitet=="PSL" 
  | komitet == "PETRU" | komitet == "KUKIZ" | komitet == "KONF" | komitet == "KO")  %>% as.data.frame
##kk <- mutate (partia = recode(partia, "" = 3, "neutral" = 2))
kk <- kk %>% mutate(partia=str_replace(partia, "Polska Razem Zjednoczona Prawica", "PJGowina")) %>% as.data.frame()
kk <- kk %>% mutate(komitet=str_replace(komitet, "KO", "PO")) %>% as.data.frame()

kk <- kk %>% filter(partia=="PiS" | partia=="PO" | partia=="SLD" | partia=="PSL" 
  | partia=="PJGowina" | partia=="SolidarnaPolska" | partia=="Wiosna" | partia == "Twój Ruch"
  | partia=="PJGowina" | partia=="ZIELONI" | partia == "Zieloni"
  | partia=="Nowoczesna" | partia=="LewicaRazem" 
  | partia == "BEZPARTYJNY")  %>% as.data.frame
group_by (kk, rok, komitet, partia) %>% summarise( n = n()) %>% as.data.frame 

## tylko wybrani z 4 partii
kk <- kk %>% filter((partia=="PiS" | partia=="PO" | partia=="SLD" | partia=="PSL") & (mandat=="t")) %>% as.data.frame

kk.pp.2019 <- group_by (kk, rok, komitet, partia) %>% summarise( n = n()) %>% filter (rok==2019) %>% as.data.frame 
kk.pp.2015 <- group_by (kk, rok, komitet, partia) %>% summarise( n = n()) %>% filter (rok==2015) %>% as.data.frame 

newRow2015.sld <- data.frame(rok=2015, komitet='SLD', partia='SLD', n=0) 
kk.pp.2015 <- rbind(kk.pp.2015, newRow2015.sld)
str(kk.pp.2019)

ggplot(data=kk.pp.2019, aes(x=as.factor(partia), y=n, fill=partia )) +
  geom_bar(stat="identity", position=position_dodge(width=.4), width=.8,  alpha=.5) +
  geom_text(data=kk.pp.2019, aes(label=sprintf("%s", n), y= n), vjust=-1.25, size=3 ) +
  theme(legend.position="top") +
  ylab(label="seats") +
  xlab(label="") +
  labs(caption = "Source: https://github.com/hrpunio/Data/tree/master/sejm2019") +
  ggtitle("Seats 2019")

kk.pp.2019$n2015 <- kk.pp.2015$n
kk.pp.2019$diff <- kk.pp.2019$n - kk.pp.2019$n2015

ggplot(data=kk.pp.2019, aes(x=as.factor(partia), y=diff, fill=partia )) +
  geom_bar(stat="identity", position=position_dodge(width=.4), width=.8,  alpha=.5) +
  geom_text(data=kk.pp.2019, aes(label=sprintf("%s", diff), y= diff), vjust=-1.25, size=3 ) +
  theme(legend.position="top") +
  ylab(label="seats") +
  xlab(label="") +
  labs(caption = "Source: https://github.com/hrpunio/Data/tree/master/sejm2019") +
  ggtitle("Seats difference (2019 - 2015)")




