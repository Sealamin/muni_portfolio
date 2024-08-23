#  Importování potřebných knihoven
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

class DataVisualizer:
    def __init__(self, data):
        self.data = data

    def plot_bar_chart(self, x, y, title, xlabel, ylabel):
        fig, ax = plt.subplots()
        sns.barplot(x=x, y=y, data=self.data)
        ax.set_title(title)
        ax.set_xlabel(xlabel)
        ax.set_ylabel(ylabel)
        plt.show()

    def customize_plot(self, ax, x, xlabel, ylabel, title):
        ax.set_xlabel(xlabel)
        ax.set_ylabel(ylabel)
        ax.set_title(title)
        ax.tick_params(axis='x', labelrotation=45, ha='right', labelsize=10)
        ax.tick_params(axis='x', labelsize=12)
        ax.legend().set_visible(False)


# Načítání dat z CSV souboru
data = pd.read_csv("data-vysetreni.csv")


# Ošetření případných chybějících dat
data = data.dropna(subset=["vek", "pocet_vysetreni", "kraj_nazev"])


# Vytvoření DataVisualizer objektu
visualizer = DataVisualizer(data)


# Vytvoření grafu pro věkovou distribuci porměnné
fig, ax = plt.subplots()
visualizer.plot_bar_chart('vek', 'pocet_vysetreni', 'Rozdělení počtu preventivních vyšetření podle věku', 'Věk', 'Počet vyšetření')


# Úpravu formátování grafu
visualizer.customize_plot(ax, 'vek', 'Věk', 'Počet vyšetření', 'Rozdělení počtu preventivních vyšetření podle věku')


# Vytvoření grafu pro územní distribuci proměnné
fig, ax = plt.subplots()
visualizer.plot_bar_chart('kraj_nazev', 'pocet_vysetreni', 'Počet preventivních vyšetření podle krajů', 'Kraj', 'Počet vyšetření')


# Formátování grafu
visualizer.customize_plot(ax, 'kraj_nazev', 'Kraj', 'Počet vyšetření', 'Počet preventivních vyšetření podle krajů')


plt.show()
