import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
from sklearn.metrics import r2_score


class AlzheimerAnalysis:
    def __init__(self, data_file):
        self.data_file = data_file
        self.data = pd.read_csv(data_file)
        self.models = []


    def explore_data(self):
        print(self.data.describe())
        print(self.data.info())


    def visualize_data(self):
        plt.scatter(self.data['vekova_kategorie'], self.data['pocet_pacientu'])
        plt.xlabel('Vekova kategorie')
        plt.ylabel('Pocet pacientu')

        plt.show()


    def create_models(self):
        X = self.data[['vekova_kategorie', 'pohlavi', 'alzheimerova_nemoc']]
        y = self.data['pocet_pacientu']


        model_1 = LinearRegression()
        model_1.fit(X, y)
        self.models.append(model_1)


        model_2 = LinearRegression()
        model_2.fit(X.drop('alzheimerova_nemoc', axis=1), y)
        self.models.append(model_2)


        model_3 = LinearRegression()
        model_3.fit(X, y, interact_terms=['vekova_kategorie:pohlavi', 'vekova_kategorie:alzheimerova_nemoc'])
        self.models.append(model_3)


    def evaluate_models(self):
        X_train, X_test, y_train, y_test = train_test_split(self.data[['vekova_kategorie', 'pohlavi', 'alzheimerova_nemoc']], self.data['pocet_pacientu'], test_size=0.2, random_state=123)
        results = []
        for model in self.models:
            y_pred = model.predict(X_test)
            r2 = r2_score(y_test, y_pred)
            results.append(r2)
          
        comparison_table = pd.DataFrame({'Model': ['Model 1', 'Model 2', 'Model 3'], 'R-squared': results})
        print(comparison_table)


    def run_analysis(self):
        self.explore_data()
        self.visualize_data()
        self.create_models()
        self.evaluate_models()


if __name__ == '__main__':
    analysis = AlzheimerAnalysis('alzheimer-data.csv')
    analysis.run_analysis()
