library(dplyr)
library(ggplot2)

eth = read.csv("eth.csv")
btc = read.csv("btc.csv")

eth$snapped_at <- as.Date(eth$snapped_at)
btc$snapped_at <- as.Date(btc$snapped_at)

eth_recent <- eth %>% arrange(desc(snapped_at)) %>% slice_head(n = 15)
btc_recent <- btc %>% arrange(desc(snapped_at)) %>% slice_head(n = 15)

merged_data <- merge(eth_recent, btc_recent, by = "snapped_at", suffixes = c("_ETH", "_BTC"))

eth_prices <- merged_data$price_ETH
btc_prices <- merged_data$price_BTC

n <- length(eth_prices)

sum_eth <- sum(eth_prices)
sum_btc <- sum(btc_prices)
sum_product <- sum(eth_prices * btc_prices)
sum_eth_squared <- sum(eth_prices^2)
sum_btc_squared <- sum(btc_prices^2)

num <- n * sum_product - (sum_eth * sum_btc)
s <- (n * sum_eth_squared - sum_eth^2) * (n * sum_btc_squared - sum_btc^2)
den <- sqrt(s)

r <- num / den
r
#ans:[1] 0.8875342
sig=sigma
sig_eth <- sd(eth_prices)
sig_btc <- sd(btc_prices)

#ETH on BTC
beta1eb <- r * (sigma_eth / sigma_btc)
beta1eb #slope for eth on btc
#ans:[1] 0.08700453
beta0eb<- mean(eth_prices) - beta1eb * mean(btc_prices)
beta0eb#intercept for eth on btc
#ans:[1] -5737.47
#BTC on ETH 
beta1be<- r * (sigma_btc / sigma_eth)
beta1be #slope for btc on eht
#ans:[1] 9.053746
beta0be <- mean(btc_prices) - beta1be * mean(eth_prices)
beta0be #intercept for btc on eth
#ans:[1] 72722.74
cat("Regression Equation for ETH(x) on BTC(y): x = ", round(beta0eb, 2), " + ", round(beta1eb, 2), " * y\n")
cat("Regression Equation for BTC(y) on ETH(x): y = ", round(beta0be, 2), " + ", round(beta1be, 2), " * x\n")

