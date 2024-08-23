# Smazání případných jiných uložených proměnných při posledním otevření programu
rm(list = ls())

#Instalace připadně chybějících knihoven pro jazyk R
install.packages("tidyverse")
install.packages("palmerpenguins")
install.packages("ggthemes")

# Načtení potřebných knihoven
library(tidyverse)
library(palmerpenguins)
library(ggthemes)

#Hraji si s ggplot knihovnou dle knihy R for Data Science
ggplot(data= penguins)

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
)

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point()

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)
) +
  geom_point()

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = species)
) +
  geom_point() +
  geom_smooth(method = "lm")

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(mapping = aes(color = species, shape = species)) +
  geom_smooth(method = "lm")

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(mapping = aes(color = species, shape = species)) +
  geom_smooth(method = "lm") +
  labs(
    title = "Body mass and flipper length",
    subtitle = "Dimensions for Adelie, Chinstrap, and Gentoo Penguins",
    x = "Flipper length (mm)", y  = "Body mass (g)",
    color = "Species", shape = "Species"
  ) +
  scale_color_colorblind()
