# Importování potřebných knihoven
import numpy as np


# Definování třídy pro proměnné
class Variable:
    def __init__(self, value):
        self.value = value
        self.type = type(value)


    def __str__(self):
        return f"{self.value} (type: {self.type.__name__})"


# Vytvořil jsem proměnné různého datového typu
x1 = Variable(True)  # logical
x2 = Variable(1)  # integer
x3 = Variable(1.5)  # double
x4 = Variable("Hello")  # character

# Vypisuje datové typy proměnných do konzole
print(f"x1: {x1}")
print(f"x2: {x2}")
print(f"x3: {x3}")
print(f"x4: {x4}")


# Převádí konkrétní proměnné na jiný datový typ
x5 = Variable(int(x3.value))  # convert double to integer
x6 = Variable(str(x2.value))  # convert integer to character
x7 = Variable(bool(x4.value))  # convert character to logical


# Vypisuji do konzole transformované proměnné
print(f"\nx5: {x5}")
print(f"\nx6: {x6}")
print(f"\nx7: {x7}")


# Provádím aritmetické operace s proměnnými
x8 = Variable(x2.value + x3.value)
x9 = Variable(x2.value * x3.value)
x10 = Variable(x3.value ** 2)
x11 = Variable(x2.value // x3.value)
x12 = Variable(x2.value % x3.value)


# Vypisuji do konzole výsledky aritmetických operací
print(f"\nx8: {x8}")
print(f"\nx9: {x9}")
print(f"\nx10: {x10}")
print(f"\nx11: {x11}")
print(f"\nx12: {x12}")


# Performuji logické operace na proměnných 
x13 = Variable(x1.value and x2.value > 0)
x14 = Variable(x1.value or x2.value > 0)
x15 = Variable(not x1.value)


# Tisknu výsledky logických operací s proměnnými
print(f"\nx13: {x13}")
print(f"\nx14: {x14}")
print(f"\nx15: {x15}")
