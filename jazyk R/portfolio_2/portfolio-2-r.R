# Vizualizace právních norem pediátrů v Královohradeckém kraji dle právní formy / Visualization of the legal norms of pediatricians in the Kralovehradec Region by legal form
# Zdroj: ÚZIS/Otevřená data

library(ggplot2)

data <- read.csv("data.csv")

# Vizualizace dat pro jednotlivé typy zřízení pediatrů v Kralovehradeckém kraji
ggplot(
  data,
  aes(x = factor(Právní.forma), fill = factor(Právní.forma))
) +
  geom_bar() +
  scale_x_discrete(expand = c(0.2, 0.2)) +
  labs(
    x = "Typ právní formy",
    y = "Počet subjektů",
    title = "Rozdělení dětských lékařů v Kralovehradeckém kraji dle právní formy",
  )+
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
    axis.title.x = element_text(size = 12),
    legend.position = "none"
  )
