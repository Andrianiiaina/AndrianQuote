class Models {
  static final List<Map<String, dynamic>> bookCategory = [
    {'value': 'tout', 'label': 'Touts'},
    {'value': 'BD/mangas/Fiction', 'label': 'BD/mangas/fiction'},
    {
      'value': 'Biographie/Autobiographie',
      'label': 'Biographie/Autobiographie'
    },
    {'value': 'Classique', 'label': 'Classique'},
    {'value': 'Développement personnel', 'label': 'Développement personnel'},
    {'value': 'Essai/document', 'label': 'Essai/document'},
    {
      'value': 'Histoire/linguistique/etc',
      'label': 'Histoire/linguistique/etc'
    },
    {'value': 'Jeunesse', 'label': 'Jeunesse'},
    {'value': 'Policier', 'label': 'Policier'},
    {'value': 'Roman', 'label': 'Roman'},
    {'value': 'Romance', 'label': 'Romance'},
    {'value': 'SF/Fantasy', 'label': 'SF/Fantasy'},
    {'value': 'Théatre/Poesie', 'label': 'Théatre/Poesie'},
    {'value': 'Thriller/Horreur', 'label': 'Thriller/Horreur'},
    {'value': 'Nouvelle', 'label': 'Nouvelle'},
    {'value': 'Philosophie', 'label': 'Philosophie'},
    {'value': 'autre', 'label': 'Autre'},
  ];

  static final List<Map<String, dynamic>> bookversion = [
    {'value': 'Francaise', 'label': 'Francaise'},
    {'value': 'Anglaise', '': 'Anglaise'},
    {'value': 'Malgache', 'label': 'Malgache'},
    {'value': 'tout', 'label': 'Toutes'}
  ];
}

class StatFinishedPerMonth {
  DateTime month;
  int bookTotal;
  StatFinishedPerMonth(this.month, this.bookTotal);
}

class StatCategories {
  String category;
  int number;
  StatCategories(this.category, this.number);
}
