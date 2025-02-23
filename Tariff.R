library(dplyr)
library(ggplot2) 
doge = read.csv("doge.csv")  
xrp = read.csv("xrp.csv")    
eth = read.csv("eth.csv")    
doge$snapped_at <- as.Date(doge$snapped_at)
xrp$snapped_at <- as.Date(xrp$snapped_at)
eth$snapped_at <- as.Date(eth$snapped_at)
tariff_date <- as.Date("2025-01-31")
doge_post_tariff <- doge %>%
  filter(snapped_at > tariff_date)
xrp_post_tariff <- xrp %>%
  filter(snapped_at > tariff_date)
eth_post_tariff <- eth %>%
  filter(snapped_at > tariff_date)
doge_post_tariff$Cryptocurrency <- "DOGE"
xrp_post_tariff$Cryptocurrency <- "XRP"
eth_post_tariff$Cryptocurrency <- "ETH"
combined_data_tariff <- bind_rows(doge_post_tariff, xrp_post_tariff, eth_post_tariff)

price_changes <- combined_data_tariff %>%
  group_by(Cryptocurrency) %>%
  summarise(Price_Change = (last(price) - first(price)) / first(price) * 100)

ggplot(price_changes, aes(x = Cryptocurrency, y = Price_Change, fill = Cryptocurrency)) +
  geom_bar(stat = "identity", show.legend = FALSE) +  # Use geom_bar() for bar graph
  labs(title = "Price Change of DOGE, XRP, and ETH After Tariff Imposition (Jan 1, 2025)",
       x = "Cryptocurrency",
       y = "Price Change (%)") +
  theme_minimal() +
  scale_fill_manual(values = c("DOGE" = "gold", "XRP" = "green", "ETH" = "blue"))
