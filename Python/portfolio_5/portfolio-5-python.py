def create_diagnosis_category(self):
    self.data['diagnosis_category'] = pd.cut(self.data['diagnoza_kod'],
                                             bins=['C00', 'C97', 'D10', 'D36'],
                                             labels=['Zhoubný nádor', 'Nezhoubný nádor', 'Nejednoznačný nádor'],
                                             include_lowest=True)

def calculate_diagnosis_counts(self):
    return self.data.groupby('diagnosis_category').size()

def filter_data(self, kraj):
    return self.data[self.data['kraj_kod'] == kraj]

def combine_data(self, ustek_data, praha_data):
    return pd.concat([ustek_data, praha_data])

def create_bar_chart(self, diagnosis_counts):
    sns.set()
    plt.figure(figsize=(10, 6))
    sns.barplot(x='diagnosis_category', y='count', hue='kraj', data=diagnosis_counts)
    plt.xlabel('Kategorie diagnózy')
    plt.ylabel('Počet případů')
    plt.title('Počet případů podle kategorie diagnózy a kraje')
    plt.show()

def create_pie_chart(self, smrtnost_pocet):
    plt.figure(figsize=(8, 8))
    sns.set()
    sns.pieplot(x='count', hue='smrtnost', data=smrtnost_pocet, autopct='%1.1f%%')
    plt.title('Smrtnost u karcinomu jater')
    plt.show()

def analyze_data(self):
    self.create_diagnosis_category()
    ustek_data = self.filter_data(self.KRAJ_USTECKY)
    praha_data = self.filter_data(self.KRAJ_PRAHA)
    combined_data = self.combine_data(ustek_data, praha_data)
    diagnosis_counts = combined_data.groupby(['kraj', 'diagnosis_category']).size().reset_index(name='count')
    self.create_bar_chart(diagnosis_counts)

    jaterni_karcinom_data = self.data[self.data['diagnoza_kod'] == 'C22']
    smrtnost_pocet = jaterni_karcinom_data.groupby('umrti').size().reset_index(name='count')
    smrtnost_pocet['smrtnost'] = smrtnost_pocet['umrti'].apply(lambda x: 'Mrtvý' if x == 1 else 'Živý')
    self.create_pie_chart(smrtnost_pocet)
