class Models {
  static final List<Map<String, dynamic>> bookCategory = [
    {'value': 'tout', 'label': 'Touts'},
    {'value': 'BD/mangas', 'label': 'BD/mangas'},
    {'value': 'Biographie', 'label': 'Biographie/Autobiographie'},
    {'value': 'Classique', 'label': 'Classique'},
    {'value': 'Développement personnel', 'label': 'Développement personnel'},
    {'value': 'Essais /documents', 'label': 'Essais /documents'},
    {
      'value': 'Histoire/linguistique/etc',
      'label': 'Histoire/linguistique/etc'
    },
    {'value': 'Jeunesse', 'label': 'Jeunesse'},
    {'value': 'Policier', 'label': 'Policier'},
    {'value': 'Roman', 'label': 'Roman'},
    {'value': 'Romance', 'label': 'Romance'},
    {'value': 'SF /Fantasy', 'label': 'SF /Fantasy'},
    {'value': 'Théatre/Poesie', 'label': 'Théatre/Poesie'},
    {'value': 'Thriller', 'label': 'Thriller'},
    {'value': 'autre', 'label': 'Autre'},
  ];

  static final List<Map<String, dynamic>> bookCategory1 = [
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

class statFinishedPerMonth {
  DateTime month;
  int bookTotal;
  statFinishedPerMonth(this.month, this.bookTotal);
}

class statCategories {
  String category;
  int number;
  statCategories(this.category, this.number);
}
