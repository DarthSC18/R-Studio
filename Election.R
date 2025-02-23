library(dplyr)
library(ggplot2)
doge = read.csv("doge.csv") 
xrp = read.csv("xrp.csv")   
eth = read.csv("eth.csv")  
doge$snapped_at <- as.Date(doge$snapped_at)
xrp$snapped_at <- as.Date(xrp$snapped_at)
eth$snapped_at <- as.Date(eth$snapped_at)
election_date <- as.Date("2024-11-05")
doge_post_election <- doge %>%
  filter(snapped_at >= election_date & snapped_at <= (election_date + 30))
xrp_post_election <- xrp %>%
  filter(snapped_at >= election_date & snapped_at <= (election_date + 30))
eth_post_election <- eth %>%
  filter(snapped_at >= election_date & snapped_at <= (election_date + 30))
doge_change <- (tail(doge_post_election$price, 1) - doge_post_election$price[1]) / doge_post_election$price[1] * 100
xrp_change <- (tail(xrp_post_election$price, 1) - xrp_post_election$price[1]) / xrp_post_election$price[1] * 100
eth_change <- (tail(eth_post_election$price, 1) - eth_post_election$price[1]) / eth_post_election$price[1] * 100
price_changes <- data.frame(
  Crypto = c("DOGE", "XRP", "ETH"),
  Price_Change = c(doge_change, xrp_change, eth_change) )

ggplot(price_changes, aes(x = Crypto, y = Price_Change, fill = Crypto)) +
  geom_bar(stat = "identity", show.legend = FALSE) +
  labs(title = "Price Change in DOGE, XRP, and ETH 30 Days After 2024 Election",
       x = "Cryptocurrency",
       y = "Price Change (%)") +
  theme_minimal() +
  scale_fill_manual(values = c("DOGE" = "blue", "XRP" = "green", "ETH" = "orange")) +
  theme(axis.text.x = element_text(angle = 0, hjust = 0.5))  
