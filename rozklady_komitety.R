#!/usr/bin/Rscript
# Skrypt wykreślna różnego rodzaju histogramy dla danych z pliku ws2018_komitety_by_komisja_T.csv
#
require (ggplot2)

estimatedMode <- function(x) { d <- density(x, na.rm=T); d$x[which.max(d$y)] }

showVotes <- function(df, x, co, region, N, minN) {
   ## showVotes = wykreśla histogram dla województwa (region)
   kN <- nrow(df)
   sX <- summary(df[[x]], na.rm=TRUE);
   sV <- sd(df[[x]], na.rm=TRUE)
   ## współczynnik skośności Pearsona
   skewness <- 3 * (sX[["Mean"]] - sX[["Median"]])/sV
   Mo <- estimatedMode(df[[x]])
   skewnessMo <- (sX[["Mean"]] - Mo)/sV

   summary_label <- sprintf ("Śr = %.1f\nMe = %.1f\nq1 = %.1f\nq3 = %.1f\nS = %.1f\nW = %.2f", 
     sX[["Mean"]], sX[["Median"]],
     sX[["1st Qu."]], sX[["3rd Qu."]], sV, skewness)
   summary_label_bold <- sprintf ("D = %.2f\nSr - D = %.2f\nWd = %.2f", Mo, sX[["Mean"]] - Mo, skewnessMo)

   if (minN < 1) {
   t <- sprintf("Wybory 2018. Głosy na %s\n%s ogółem %d komisji", co, region, kN ) } 
   else { t <- sprintf("Wybory 2018. Głosy na %s\n%s ogółem %d komisji (N>%d)", co, region, kN, minN ) } 

   h <- hist(df[[x]], breaks=kpN, freq=TRUE, col="orange", main=t, 
     ylab="%", xlab="% poparcia", labels=F, xaxt='n' )
     axis(side=1, at=kpN, cex.axis=2, cex.lab=2)
    ## pozycja tekstu zawierającego statystyki opisowe
   posX <- .50 * max(h$counts)
   posY <- .66 * max(h$counts)
   text(80, posX, summary_label, cex=1.4, adj=c(0,1) )
   text(80, posY, summary_label_bold, cex=1.4, adj=c(0,1), font=4)
}


## Wczytanie danych; obliczenie podst. statystyk:
komisje <- read.csv("wp2019_komisje_wyniki.csv", 
   sep = ';', header=T, na.string="NA");

summary(komisje$PSL); summary(komisje$PiS); summary(komisje$PO);
fivenum(komisje$PSLp); fivenum(komisje$PiSp); fivenum(komisje$POp);

## ## ###
par(ps=6,cex=1,cex.axis=1,cex.lab=1,cex.main=1.2)
kpN <- seq(0, 100, by=2);
kpX <- c(0, 10,20,30,40,50,60,70,80,90, 100);
kN <- nrow(komisje)
region <- "Polska"
minTurnout <- 0

## cała Polska:
showVotes(komisje, "PSLp", "PSL", region, kN, minTurnout);
showVotes(komisje, "PiSp", "PiS", region, kN, minTurnout);
showVotes(komisje, "POp",  "PO",  region, kN, minTurnout);
showVotes(komisje, "SLDp", "SLD", region, kN, minTurnout);

