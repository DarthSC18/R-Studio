library(dplyr)
library(ggplot2)
xrp = read.csv("xrp.csv")
btc <- read.csv("btc.csv")
xrp$snapped_at <- as.Date(xrp$snapped_at)
btc$snapped_at <- as.Date(btc$snapped_at)
xrp_recent <- xrp%>% arrange(desc(snapped_at)) %>% slice_head(n = 15)
btc_recent <- btc %>% arrange(desc(snapped_at)) %>% slice_head(n = 15)
merged_data <- merge(xrp_recent, btc_recent, by = "snapped_at", suffixes = c("_XRP", "_BTC"))
correlation <- cor(merged_data$price_XRP, merged_data$price_BTC, use = "complete.obs")
correlation
[1] 0.8654773
scatter_plot <- ggplot(merged_data, aes(x = price_XRP, y = price_BTC))+
       geom_point(color = "blue")+
       geom_smooth(method = "lm", color = "red")+
       labs(title = "Scatter Plot of XRP vs BTC Prices",
                       x = "XRP Closing Price",
                       y = "BTC Closing Price")
scatter_plot
