# Srovnání počtu preventivních vyšetření pomocí barchart
# Zdroj: MZČR/Otevřená data

# Smazání případných jiných uložených proměnných při posledním otevření programu
rm(list = ls())

#Instalace připadně chybějících knihoven pro jazyk R
install.packages("tidyverse")

#Instalace potřebných balíčků
install.packages("ggplot2")

#Načtení potřebných balíčků do scriptu
library(ggplot2)

#Načtení dat do proměnné ze souboru csv
data <- read.csv("data-vysetreni.csv")

#Ošetření chybějících hodnot ve sloupcích vek, pocet_vysetreni a kraj_nazev
data <- na.omit(data[, c("vek", "pocet_vysetreni", "kraj_nazev")])

#Vytvoření barchart Rozdělení počtu preventivních vyšetření podle věku žen + formátování (vypnutá vědwcká notace na ose y)
ggplot(data, aes(x = vek, y = pocet_vysetreni)) + 
  geom_bar(stat = "identity") + 
  labs(title = "Rozdělení počtu preventivních vyšetření podle věku",
       x = "Věk", y = "Počet vyšetření") +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE))

#Vytvoření barchart Počet preventivních vyšetření podle krajů + úprava celkového formátování grafu včetně editace os a formátování popisků os
ggplot(data, aes(x = kraj_nazev, y = pocet_vysetreni)) + 
  geom_bar(stat = "identity") + 
  labs(title = "Počet preventivních vyšetření podle krajů",
       x = "Kraj", y = "Počet vyšetření") +
  scale_x_discrete(expand = c(0.2, 0.2)) +
  scale_y_continuous(labels = function(x) format(x, scientific = FALSE)) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, size = 10),
    axis.title.x = element_text(size = 12),
    legend.position = "none"
  )
