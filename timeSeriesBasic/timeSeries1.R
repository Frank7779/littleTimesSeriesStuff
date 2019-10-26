#!/usr/bin/Rscript

#START
#CLEAR
rm(list=ls())
cat("\014")

#IMPORT
#The timeSeries1_R.csv (which is uploaded in this repository too) contains the needed data.
#No all columns are needed, so the "NA" indicates which colum was actually imported.
#Real growth rates of the US GDP in percentage
dgdp <- read.csv(
  "PATH TO timesSeries_R.csv",
  header=FALSE,
  colClasses=c(NA, "NULL", "NULL", "NULL", "NULL")
)
#Capital (capital stock) in Billion US Dollar
capital <- read.csv(
  "PATH TO timesSeries_R.csv",
  header=FALSE,
  colClasses=c("NULL", NA, "NULL", "NULL", "NULL")
)
#Profit in Billion US Dollar
profit <- read.csv(
  "PATH TO timeSeries_R.csv",
  header=FALSE,
  colClasses=c("NULL", "NULL", "NULL", "NULL", NA)
)

#CALCULATION
#Rate of profit euqals profit divided by capital
rate <- (profit/capital*100)

#TIME SERIES
#This creates a time series which starts back in 1948 and ends 2014 (so 67 values for each time series)
dgdp_ts <- ts(dgdp, freq=1, start=1948)
capital_ts <- ts(capital, freq=1, start=1948)
profit_ts <- ts(profit, freq=1, start=1948)
rate_ts <- ts(rate, freq=1, start=1948)

#PLOTS
#These following plots are not the basic ones which R can produce.
#I edited the font (so it goes along with the paper I used them in), colours as well as style of both axes.
#Profit
png("PATH TO profit.png", width = 700, height = 432)
par(mar=c(4, 4, 4, 4), family="serif", ps=12)
plot(
  profit_ts, type="l", col="black", lwd=c(1.5),
  ylim=c(0,1500), xlim=c(1948, 2014), 
  main="Profit in the USA 1948-2014",
  ylab="", xlab=""
)
mtext("Profit in Billion US Dollar", side=2, line=2.5)
mtext("Year", side=1, line=2.5)
dev.off()

#Capital
png("PATH TO capital.png", width = 700, height = 432)
par(mar=c(4, 4, 4, 4), family="serif", ps=12)
plot(
  capital_ts, type="l", col="black", lwd=c(1.5),
  ylim=c(0,15000), xlim=c(1948, 2014), 
  main="Capital in the USA 1948-2014",
  ylab="", xlab=""
)
mtext("Capital in Billion US Dollar", side=2, line=2.5)
mtext("Year", side=1, line=2.5)
dev.off()

#Rate of profit
png("PATH TO profit_rate.png", width = 700, height = 432)
par(mar=c(4, 4, 4, 4), family="serif", ps=12)
plot(
  rate_ts, type="l", col="black", lwd=c(1.5),
  ylim=c(6,16), xlim=c(1948, 2014), 
  main="Rate of profit in the USA 1948-2014",
  ylab="", xlab=""
)
mtext("Rate of profit in percentage", side=2, line=2.5)
mtext("Year", side=1, line=2.5)
dev.off()

#DGDP
png("PATH TO DGDP.png", width = 700, height = 432)
par(mar=c(4, 4, 4, 4), family="serif", ps=12)
plot(
  dgdp_ts, type="l", col="black", lwd=c(1.5),
  ylim=c(-3,9), xlim=c(1948, 2014), 
  main="Real growth rate of GDP of the USA 1948-2014",
  ylab="", xlab=""
)
mtext("Real growth rate of GDP in percentage", side=2, line=2.5)
mtext("Year", side=1, line=2.5)
dev.off()

#Comparison of DGDP and rate of profit
#This plot is slightly different than the previous ones, because it shows to different time series in one plot, so I had to edit three axis instead of just two as usual.
png("PATH TO DGDB_profit_rate.png", width = 700, height = 432)
par(mar=c(4, 4, 4, 4), family="serif", ps=12)
plot(
  rate_ts, type="l", col="black", axes=F, lwd=c(1.5),
  ylim=c(6,16),
  main="Comparion of rate of profit and real growth rate of GDP (both of USA) 1948-2014",
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
dev.off()

#END
