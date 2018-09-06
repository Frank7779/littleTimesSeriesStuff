#START
#CLEAR
rm(list=ls())
cat("\014")

#IMPORT
dgdp <- read.csv(
  "PATH TO FILE R.csv",
  header=FALSE,
  colClasses=c(NA, "NULL", "NULL", "NULL", "NULL")
)

capital <- read.csv(
  "PATH TO FILE R.csv",
  header=FALSE,
  colClasses=c("NULL", NA, "NULL", "NULL", "NULL")
)

profit <- read.csv(
  "PATH TO FILE R.csv",
  header=FALSE,
  colClasses=c("NULL", "NULL", "NULL", "NULL", NA)
)

#Calculation
rate <- (profit/capital*100)

#Time series
dgdp_ts <- ts(dgdp, freq=1, start=1948)
capital_ts <- ts(capital, freq=1, start=1948)
profit_ts <- ts(profit, freq=1, start=1948)
rate_ts <- ts(rate, freq=1, start=1948)

#PLOTS
#Profit
par(mar=c(4, 4, 4, 4), family="serif", ps=12)
plot(
  profit_ts, type="l", col="black", lwd=c(1.5),
  ylim=c(0,1500), xlim=c(1948, 2014), 
  main="Profit 1948-2014",
  ylab="", xlab=""
)
mtext("Profit in Billion Dollar", side=2, line=2.5)
mtext("Year", side=1, line=2.5)

#Capital
par(mar=c(4, 4, 4, 4), family="serif", ps=12)
plot(
  capital_ts, type="l", col="black", lwd=c(1.5),
  ylim=c(0,15000), xlim=c(1948, 2014), 
  main="Capital 1948-2014",
  ylab="", xlab=""
)
mtext("Capital in Billion Dollar", side=2, line=2.5)
mtext("Year", side=1, line=2.5)

#Rate of profit
par(mar=c(4, 4, 4, 4), family="serif", ps=12)
plot(
  rate_ts, type="l", col="black", lwd=c(1.5),
  ylim=c(6,16), xlim=c(1948, 2014), 
  main="Rate of profit 1948-2014",
  ylab="", xlab=""
)
mtext("Rate of profit in percentage", side=2, line=2.5)
mtext("Year", side=1, line=2.5)

#DGDP
par(mar=c(4, 4, 4, 4), family="serif", ps=12)
plot(
  dgdp_ts, type="l", col="black", lwd=c(1.5),
  ylim=c(-3,9), xlim=c(1948, 2014), 
  main="Real growth rate of GDP 1948-2014",
  ylab="", xlab=""
)
mtext("Real growth rate of GDP in percentage", side=2, line=2.5)
mtext("Year", side=1, line=2.5)

#Comparison of DGDP and rate of profit
par(mar=c(4, 4, 4, 4), family="serif", ps=12)
plot(
  rate_ts, type="l", col="black", axes=F, lwd=c(1.5),
  ylim=c(6,16),
  main="Comparion of rate of profit and real growth rate of GDP 1948-2014",
  ylab="", xlab=""
)
axis(2, ylim=c(4,15), las=0)
mtext("Rate of profit in percentage", side=2, line=2.5)
par(new=T)
plot(
  dgdp_ts, type="l", col="red", axes=F, lwd=c(1.5),
  ylim=c(-3,9),
  ylab="", xlab=""
)
axis(1)
axis(4, ylim=c(-3,9), las=0)
mtext("Real growth rate of GDP in percentage", side=4, line=2.5)
mtext("Year", side=1, line=2.5)
box()

#END