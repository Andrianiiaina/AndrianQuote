import 'package:hive/hive.dart';
import 'statistic_class.dart';
import 'book_model.dart';
export 'statistic_class.dart';
import 'statistic_model.dart';
import 'models.dart';

final box = Hive.box<StatisticClass>('stats');

class statisticModel {
  static getAllData() {
    return box.keys.map((e) {
      final value = box.get(e);
      return StatisticClass(
        finished: value!.finished,
        categories: value.categories,
        current: value.current,
        pagesPerDay: value.pagesPerDay,
        paperBook: value.paperBook,
        paperPages: value.paperPages,
        digitalPages: value.digitalPages,
        finishedPerMonth: value.finishedPerMonth,
        totalFinishedPage: value.totalFinishedPage,
        abandonned: value.abandonned,
        digitalBook: value.digitalBook,
        year: value.year,
        frenchVersion: value.frenchVersion,
        englishVersion: value.englishVersion,
      );
    }).toList();
  }

  static populateStatistic() async {
    try {
      await box.clear();
      box.add(getData(2022));
      box.add(getData(2023));
      box.add(getData(2024));
    } catch (e) {
      print(e);
    }
  }
}

StatisticClass getData(year) {
  int finishedPages = 0;
  int paperPages = 0;
  Map<DateTime, int> monthly = {};
  Map<String, int> catego = {};
  List<Map<DateTime, int>> datas = [];
  List<Map<String, int>> categories = [];
  List<BookClass> books = BookModel.getAllData().toList();
  books = books.where((element) => year == element.date.year).toList();
  books.sort((a, b) => a.date.compareTo(b.date));
  final finishedBook =
      books.where((value) => value.status == "finished").toList();

  final finished = finishedBook.length;
  final paperBooks = finishedBook.where((x) => x.isPaper == true).length;

  for (var element in finishedBook) {
    int p = element.nbrPage;
    finishedPages = finishedPages += p;
    if (element.isPaper) paperPages += p;
    DateTime monthK = DateTime(element.date.year, element.date.month);

    catego.update(element.category, (value) => value + 1, ifAbsent: () => 0);
    monthly.update(monthK, (currentValue) => currentValue + 1,
        ifAbsent: () => 0);
  }

  final englishBook = finishedBook.where((x) => x.version == "Anglaise").length;

  monthly.forEach((key, value) {
    datas.add({key: value});
  });
  for (var element in Models.bookCategory) {
    final String x = element.entries.first.value;
    if (catego.keys.contains(x)) {
      final category = catego.entries.firstWhere((element) => element.key == x);
      categories.add({category.key: category.value});
    } else {
      categories.add({x: 0});
    }
  }
  return StatisticClass(
      year: year,
      finished: finished,
      current: books.where((x) => x.status.contains("current")).length,
      abandonned: books.where((x) => x.status.contains("aband")).length,
      categories: categories,
      digitalBook: finished - paperBooks,
      digitalPages: finishedPages - paperPages,
      englishVersion: englishBook,
      finishedPerMonth: datas,
      frenchVersion: finished - englishBook,
      pagesPerDay: (finishedPages / 365).round(),
      paperBook: paperBooks,
      paperPages: paperPages,
      totalFinishedPage: finishedPages);
}
