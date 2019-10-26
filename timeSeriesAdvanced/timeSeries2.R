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
  "PATH TO timesSeries1_R.csv",
  header=FALSE,
  colClasses=c(NA, "NULL", "NULL", "NULL", "NULL")
)
#Capital (capital stock) in Billion US Dollar
capital <- read.csv(
  "PATH TO timesSeries1_R.csv",
  header=FALSE,
  colClasses=c("NULL", NA, "NULL", "NULL", "NULL")
)
#Profit in Billion US Dollar
profit <- read.csv(
  "PATH TO timeSeries1_R.csv",
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

#SIMPLE REGRESSION MODELL
#Simple regression modell for rate_ts
rate_ts_t <- 1:length(rate_ts)
rate_ts_linear <-lm(rate_ts ~ rate_ts_t)
summary((rate_ts_linear))
rate_ts_P <- predict(rate_ts_linear, int="c", level = 0.95)

#Simple regression modell for dgdp_ts
dgdp_ts_t <- 1:length(dgdp_ts)
dgdp_ts_linear <-lm(dgdp_ts ~ dgdp_ts_t)
summary((dgdp_ts_linear))
dgdp_ts_P <- predict(dgdp_ts_linear, int="c", level = 0.95)

#PLOTS
#Rate of profit with simple linear regression modell and regression line
par(mar=c(4, 4, 4, 4), family="serif", ps=12)
plot(
  rate_ts, type="l", col="black", lwd=c(1.5),
  ylim=c(6,16), xlim=c(1948, 2014), 
  main="Rate of profit in the USA 1948-2014",
  ylab="", xlab=""
)
lines(ts(rate_ts_P[,1], freq = 1, start = 1948), col = "blue")
mtext("Rate of profit in percentage", side=2, line=2.5)
mtext("Year", side=1, line=2.5)

#DGDP with simple linear regression modell and regression line
par(mar=c(4, 4, 4, 4), family="serif", ps=12)
plot(
  dgdp_ts, type="l", col="black", lwd=c(1.5),
  ylim=c(-3,9), xlim=c(1948, 2014), 
  main="Real growth rate of GDP of the USA 1948-2014",
  ylab="", xlab=""
)
lines(ts(dgdp_ts_P[,1], freq = 1, start = 1948), col = "blue")
mtext("Real growth rate of GDP in percentage", side=2, line=2.5)
mtext("Year", side=1, line=2.5)

#END
