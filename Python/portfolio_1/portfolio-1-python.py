import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import linregress

class PenguinPlotter:
    def __init__(self, data):
        self.data = data

    def scatter_plot(self, x, y, title, xlabel, ylabel):
        plt.scatter(self.data[x], self.data[y])
        plt.xlabel(xlabel)
        plt.ylabel(ylabel)
        plt.title(title)
        plt.show()

    def scatter_plot_with_color_and_shape(self, x, y, title, xlabel, ylabel):
        plt.scatter(self.data[x], self.data[y], c=self.data['species'], marker=self.data['species'].map({'Adelie': 'o', 'Chinstrap': 's', 'Gentoo': '^'}))
        plt.xlabel(xlabel)
        plt.ylabel(ylabel)
        plt.title(title)
        plt.legend(title='Species')
        plt.show()

    def scatter_plot_with_linear_regression(self, x, y, title, xlabel, ylabel):
        for species in self.data['species'].unique():
            species_data = self.data[self.data['species'] == species]
            slope, intercept, r_value, p_value, std_err = linregress(species_data[x], species_data[y])
            plt.scatter(species_data[x], species_data[y], label=species)
            plt.plot(species_data[x], intercept + slope * species_data[x], label=f'{species} regression')
        plt.xlabel(xlabel)
        plt.ylabel(ylabel)
        plt.title(title)
        plt.legend(title='Species')
        plt.show()

    def scatter_plot_with_linear_regression_and_custom_labels(self, x, y, title, xlabel, ylabel):
        plt.scatter(self.data[x], self.data[y], c=self.data['species'], marker=self.data['species'].map({'Adelie': 'o', 'Chinstrap': 's', 'Gentoo': '^'}))
        for species in self.data['species'].unique():
            species_data = self.data[self.data['species'] == species]
            slope, intercept, r_value, p_value, std_err = linregress(species_data[x], species_data[y])
            plt.plot(species_data[x], intercept + slope * species_data[x], label=f'{species} regression')
        plt.xlabel(xlabel)
        plt.ylabel(ylabel)
        plt.title(title)
        plt.legend(title='Species')
        plt.show()

# Načítání datasetu penguins jakoby byl CSV soubor
penguins = pd.read_csv("penguins.csv")

# Vytvoření PenguinPlotter objektu
plotter = PenguinPlotter(penguins)

# Vytvoření série grafů
plotter.scatter_plot('flipper_length_mm', 'body_mass_g', 'Body mass and flipper length', 'Flipper length (mm)', 'Body mass (g)')
plotter.scatter_plot_with_color_and_shape('flipper_length_mm', 'body_mass_g', 'Body mass and flipper length', 'Flipper length (mm)', 'Body mass (g)')
plotter.scatter_plot_with_linear_regression('flipper_length_mm', 'body_mass_g', 'Body mass and flipper length', 'Flipper length (mm)', 'Body mass (g)')
plotter.scatter_plot_with_linear_regression_and_custom_labels('flipper_length_mm', 'body_mass_g', 'Body mass and flipper length', 'Flipper length (mm)', 'Body mass (g)')
