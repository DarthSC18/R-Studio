
library(dplyr)
library(ggplot2)
eth = read.csv("eth.csv")
btc <- read.csv("btc.csv")
eth$snapped_at <- as.Date(eth$snapped_at)
btc$snapped_at <- as.Date(btc$snapped_at)
eth_recent <- eth%>% arrange(desc(snapped_at)) %>% slice_head(n = 15)
btc_recent <- btc %>% arrange(desc(snapped_at)) %>% slice_head(n = 15)

merged_data <- merge(eth_recent, btc_recent, by = "snapped_at", suffixes = c("_ETH", "_BTC"))
correlation <- cor(merged_data$price_ETH, merged_data$price_BTC, use = "complete.obs")
correlation
[1] 0.8875342
scatter_plot <- ggplot(merged_data, aes(x = price_ETH, y = price_BTC))+
      geom_point(color = "blue")+
       geom_smooth(method = "lm", color = "red")+
      labs(title = "Scatter Plot of ETH vs BTC Prices",
                       x = "ETH Closing Price",
                       y = "BTC Closing Price")
scatter_plot
