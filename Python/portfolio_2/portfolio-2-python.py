# Importování potřebných knihoven
import pandas as pd
import matplotlib.pyplot as plt


class DataVisualizer:
    def __init__(self, data):
        self.data = data


    def plot_bar_chart(self, x, y, title, xlabel, ylabel):
        fig, ax = plt.subplots()
        ax.bar(self.data[x], self.data[y])
        ax.set_xlabel(xlabel)
        ax.set_ylabel(ylabel)
        ax.set_title(title)
        plt.show()


    def customize_plot(self, ax, x, xlabel, ylabel, title):
        ax.set_xlabel(xlabel)
        ax.set_ylabel(ylabel)
        ax.set_title(title)
        ax.tick_params(axis='x', labelrotation=45, ha='right', labelsize=10)
        ax.tick_params(axis='x', labelsize=12)
        ax.legend().set_visible(False)


# Naáčtení dat ze souboru
data = pd.read_csv("data.csv")


# Vytvoření a DataVisualizer objektu
visualizer = DataVisualizer(data)


# Vytvoření bar chart
fig, ax = plt.subplots()
visualizer.plot_bar_chart('Právní.forma', 'count', 'Rozdělení dětských lékařů v Kralovehradeckém kraji dle právní formy', 'Typ právní formy', 'Počet subjektů')


# Upráva formátování grafu
visualizer.customize_plot(ax, 'Právní.forma', 'Typ právní formy', 'Počet subjektů', 'Rozdělení dětských lékařů v Kralovehradeckém kraji dle právní formy')


plt.show()
