# Chapání základních danavých typů v jazyce R

# Vytvářím různé typy proměnných v R
x1 <- TRUE  # logical
x2 <- 1L    # integer
x3 <- 1.5   # double
x4 <- "Hello"  # character


# Zobrazuji typy jednotlivých proměnných
cat("x1: ", class(x1), "\n")
cat("x2: ", class(x2), "\n")
cat("x3: ", class(x3), "\n")
cat("x4: ", class(x4), "\n")


# Převádím a ukládám nové typy proměnných
x5 <- as.integer(x3)  # převod double na integer
x6 <- as.character(x2)  # převod integer na character
x7 <- as.logical(x4)  # převod character na logical


# Zobrazuji převedené proměnné
cat("\nx5: ", x5, " (type: ", class(x5), ")\n")
cat("\nx6: ", x6, " (type: ", class(x6), ")\n")
cat("\nx7: ", x7, " (type: ", class(x7), ")\n")


# Aritmetické operace s proměnnými
x8 <- x2 + x3
x9 <- x2 * x3
x10 <- x3 ^ 2
x11 <- x2 %/% x3
x12 <- x2 %% x3


# Zobrazení výsledků aritmetických operací
cat("\nx8: ", x8, " (type: ", class(x8), ")\n")
cat("\nx9: ", x9, " (type: ", class(x9), ")\n")
cat("\nx10: ", x10, " (type: ", class(x10), ")\n")
cat("\nx11: ", x11, " (type: ", class(x11), ")\n")
cat("\nx12: ", x12, " (type: ", class(x12), ")\n")


# Logické operace s proměnnými
x13 <- x1 & x2 > 0
x14 <- x1 | x2 > 0
x15 <- !x1


# Výsledky logických operací s proměnnými
cat("\nx13: ", x13, " (type: ", class(x13), ")\n")
cat("\nx14: ", x14, " (type: ", class(x14), ")\n")
cat("\nx15: ", x15, " (type: ", class(x15), ")\n")
