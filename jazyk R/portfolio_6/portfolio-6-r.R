#Zdroj dat: Otevřená data/ÚZIS

# Vymazání proměnných z případných minulých sessions
rm(list = ls())

# Načtení potřebných knihoven v jazyce R
library(dplyr)
library(readr)
library(ggplot2)
library(car)

# Načtení datasetu do proměnné data
data <- read.csv("alzheimer-data.csv")

# Popisná analýzy datasetu
summary(data)

# Vizualizace vztahu třech proměnných
ggplot(data, aes(x = vekova_kategorie, y = pocet_pacientu)) +
    geom_point() +
    facet_wrap(~alzheimerova_nemoc)

# Tvorba prvního modelu lineární regresní analýzy + jeho zobrazení v konzoli
model_1 <- lm(pocet_pacientu ~ vekova_kategorie * pohlavi * alzheimerova_nemoc, data = data)
summary(model_1)

# Tvorba druhého modelu lineární regresní analýzy + jeho zobrazení v konzoli
model_2 <- lm(pocet_pacientu ~ vekova_kategorie + pohlavi + alzheimerova_nemoc, data = data)
summary(model_2)

# Tvorba třetího modelu lineární rgresní analýzy + jeho zobrzaení v konzoli
model_3 <- lm(pocet_pacientu ~ vekova_kategorie + pohlavi + alzheimerova_nemoc + vekova_kategorie:pohlavi + vekova_kategorie:alzheimerova_nemoc, data = data)
summary(model_3)

# Extrakce R-squared hodnot
r_squared_1 <- summary(model_1)$r.squared
r_squared_2 <- summary(model_2)$r.squared
r_squared_3 <- summary(model_3)$r.squared


# Extrakce AIC hodnot
AIC_1 <- AIC(model_1)
AIC_2 <- AIC(model_2)
AIC_3 <- AIC(model_3)


# Extrakce BIC hodnot
BIC_1 <- BIC(model_1)
BIC_2 <- BIC(model_2)
BIC_3 <- BIC(model_3)


# Vytvořil jsem taublku pro srovnání hodnot
comparison_table <- data.frame(
    Model = c("Model 1", "Model 2", "Model 3"),
    R_squared = c(r_squared_1, r_squared_2, r_squared_3),
    AIC = c(AIC_1, AIC_2, AIC_3),
    BIC = c(BIC_1, BIC_2, BIC_3)

)


# Vypisuji tabulku srovnání do konzole
print(comparison_table)

# Ověření residuals
par(mfrow = c(2, 2))
plot(model_1$residuals)
hist(model_1$residuals)
qqnorm(model_1$residuals)
qqline(model_1$residuals)

par(mfrow = c(2, 2))
plot(model_2$residuals)
hist(model_2$residuals)
qqnorm(model_2$residuals)
qqline(model_2$residuals)

par(mfrow = c(2, 2))
plot(model_3$residuals)
hist(model_3$residuals)
qqnorm(model_3$residuals)
qqline(model_3$residuals)

# Rozděluji do trénovací a testovací množiny
set.seed(123)  # pro reprodukovatelnost
train_index <- sample(nrow(data), 0.8*nrow(data))
test_data <- data[-train_index, ]
train_data <- data[train_index, ]

# Tvorba modelů na trénovací množině
model_1_train <- lm(pocet_pacientu ~ vekova_kategorie * pohlavi * alzheimerova_nemoc, data = train_data)
model_2_train <- lm(pocet_pacientu ~ vekova_kategorie + pohlavi + alzheimerova_nemoc, data = train_data)
model_3_train <- lm(pocet_pacientu ~ vekova_kategorie + pohlavi + alzheimerova_nemoc + vekova_kategorie:pohlavi + vekova_kategorie:alzheimerova_nemoc, data = train_data)

# Predikce hodnot pro testovací množinu
model_1_test_pred <- predict(model_1_train, newdata = test_data)
model_1_test_perf <- cor(model_1_test_pred, test_data$pocet_pacientu)^2


model_2_test_pred <- predict(model_2_train, newdata = test_data)
model_2_test_perf <- cor(model_2_test_pred, test_data$pocet_pacientu)^2


model_3_test_pred <- predict(model_3_train, newdata = test_data)
model_3_test_perf <- cor(model_3_test_pred, test_data$pocet_pacientu)^2

# Vypisuji závěry testu
cat("R-squared pro testovací model 1:", model_1_test_perf, "\n")
cat("R-Squared pro testovací model 2:", model_2_test_perf, "\n")
cat("R-Squared pro testovací model 3:", model_3_test_perf, "\n")
