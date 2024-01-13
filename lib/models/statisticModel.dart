import 'package:hive/hive.dart';
import 'statisticClass.dart';
import 'BookModel.dart';
export 'statisticClass.dart';
import 'statisticModel.dart';
import 'models.dart';

final box = Hive.box<statisticClass>('stats');

class statisticModel {
  static getAllData() {
    return box.keys.map((e) {
      final value = box.get(e);
      return statisticClass(
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

statisticClass getData(year) {
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

  final current = books.where((x) => x.status == "current").length;
  final abandonned = books.where((x) => x.status == "abandonned").length;

  final finished = finishedBook.length;
  final paperBooks = finishedBook.where((x) => x.isPaper == true).length;
  final numericBooks = finished - paperBooks;

  finishedBook.forEach((element) {
    int p = int.tryParse(element.nbrPage) ?? 0;
    finishedPages = finishedPages += p;
    if (element.isPaper) paperPages += p;
    DateTime monthK = DateTime(element.date.year, element.date.month);

    catego.update(element.category, (value) => value + 1, ifAbsent: () => 0);
    monthly.update(monthK, (currentValue) => currentValue + 1,
        ifAbsent: () => 0);
  });

  final numericPages = finishedPages - paperPages;
  final englishBook = finishedBook.where((x) => x.version == "Anglaise").length;
  final frenchBook = finished - englishBook;

  final int pagesPerDay = (finishedPages / 365).round();
  monthly.forEach((key, value) {
    datas.add({key: value});
  });
  Models.bookCategory1.forEach((element) {
    final String x = element.entries.first.value;
    if (catego.keys.contains(x)) {
      final category = catego.entries.firstWhere((element) => element.key == x);
      categories.add({category.key: category.value});
    } else {
      categories.add({x: 0});
    }
  });

  return statisticClass(
      year: year,
      finished: finished,
      current: current,
      abandonned: abandonned,
      categories: categories,
      digitalBook: numericBooks,
      digitalPages: numericPages,
      englishVersion: englishBook,
      finishedPerMonth: datas,
      frenchVersion: frenchBook,
      pagesPerDay: pagesPerDay,
      paperBook: paperBooks,
      paperPages: paperPages,
      totalFinishedPage: finishedPages);
}
