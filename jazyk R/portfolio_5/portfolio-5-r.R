# Analýza incidence a prevalence nádorových onemocnění v České republice / Analysis of Cancer Incidence and Prevalence in the Czech Republic
# Zdroj dat: ÚZIS/Otevřená data

# Odstranění jiných proměnných z případného minulého užití programu
rm(list = ls())

# Instalace případných chybějích knihoven pro jazyk R / možnost použít vektor pro zkrácení na jeden řádek :-)
install.packages("ggplot2")
install.packages("dplyr")
install.packages("survival")


# Načítání potřebných knihoven / možnost využít vektor pro zkrácení na jeden řádek
library(ggplot2)
library(dplyr)
library(survival)

# Definuji konstanty pro analýzu
KRAJ_USTECKY <- "CZ042"
KRAJ_PRAHA <- "CZ010"

# Načítám data ze zdrojového CSV souboru
data <- read.csv("onkologie-incidence-a-prevalence.csv")

# Funkce pro určení kategorií jednotlivých novotvarů
create_diagnosis_category <- function(data) {
    data$diagnosis_category <- ifelse(
        data$diagnoza_kod >= "C00" & data$diagnoza_kod <= "C97",
        "Zhoubný nádor",
        ifelse(
            data$diagnoza_kod %in% c("D10", "D11", "D12", "D13", "D14", "D15", "D18", "D20", "D21", "D22", "D23", "D24", "D25", "D29", "D30", "D31", "D32", "D33", "D34", "D35", "D36"),
            "Nezhoubný nádor",
            ifelse(
                data$diagnoza_kod %in% c("D00", "D01", "D02", "D03", "D04", "D05", "D06", "D07", "D08", "D09", "D37", "D38", "D39", "D40", "D41", "D42", "D43", "D44", "D45", "D46", "D47", "D48"),
                "Nejednoznačný nádor",
                NA
            )
        )
    )
    return(data)
}

# Funkce, která počítá jednotlivé počty případů pro různé druhy novotvarů u pacientů
calculate_diagnosis_counts <- function(data) {
    data %>%
        group_by(diagnosis_category) %>%
        summarise(count = n())
}

# Filtrace relevantních dat výše pro Ústecký kraj
ustek_data <- data %>%
    filter(kraj_kod == KRAJ_USTECKY) %>%
    create_diagnosis_category()

# Filtrace relevantních dat výše pro hlavní město Prahu
praha_data <- data %>%
    filter(kraj_kod == KRAJ_PRAHA) %>%
    create_diagnosis_category()

# Zkombinování dat pro Ústecký kraj a Prahu
combined_data <- rbind(
    ustek_data %>% mutate(kraj = "Ústecký kraj"),
    praha_data %>% mutate(kraj = "Praha")
)

# Kalkulace spojených dat pro oba regiony
diagnosis_counts <- combined_data %>%
    group_by(kraj, diagnosis_category) %>%
    summarise(count = n())

# Vytvoření bar chart
ggplot(diagnosis_counts, aes(x = diagnosis_category, y = count, fill = kraj)) +
    geom_col(position = position_dodge()) +
    scale_fill_manual(values = c("darkblue", "red")) +
    labs(x = "Kategorie diagnózy", y = "Počet případů") +
    theme_classic() +
    scale_y_continuous(trans = "log", labels = function(x) format(x, scientific = FALSE))

##############
# Zvolil jsem z sloupce C22 (ten zahrnuje různé druhy karcinomu jater) ze sloupce s názvem diagnoza_kod, poté zjistil u záznamů s C22 obsah roku úmrtí v dalším sloucpi a následně jsem zjišťoval pomocí sloupce umrti_rok smrtnost na tento druh rakoviny (ve sloupci je rok umrtí = to jsem musel zakodovat a následně tam není nic = takže jsem do prázdných buněk musel vepsat hodnotu, abych věděl, že jsou živí)
# Jako vizualizaci smrtnosti jsem zvolil piechart

# Filtrace dat pro karcinom jater (C22)
jaterni_karcinom_data <- data %>%
    filter(diagnoza_kod == "C22")

# Kalkulace smrtnosti
smrtnost_pocet <- jaterni_karcinom_data %>%
    group_by(smrtnost = ifelse(umrti == 1, "Mrtvý", "Živý")) %>%
    summarise(count = n())

# Vytvoření pie chartu
ggplot(smrtnost_pocet, aes(x = "", y = count, fill = smrtnost)) +
    geom_col() +
    coord_polar(theta = "y") +
    labs(x = "", y = "", title = "Smrtnost u karcinomu jater") +
    scale_fill_manual(values = c("red", "green")) +
    theme_void() +
    geom_text(aes(label = paste0(round(count / sum(count) * 100), "%")), position = position_stack(vjust = 0.5))

########################
