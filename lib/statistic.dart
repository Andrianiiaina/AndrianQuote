import 'models/BookModel.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'models/models.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({Key? key}) : super(key: key);

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  int finished = 0;
  int pages = 0;
  int current = 0;
  int abandonned = 0;
  int electroPages = 0;
  int electroBooks = 0;
  int paperBooks = 0;
  int paperPages = 0;
  int englishBook = 0;
  int frenchBook = 0;
  final year = 2023;
  List<finishedPerMonth> datas = [];
  List<bestCategories> categories = [];
  @override
  void initState() {
    super.initState();
    fetchStatistics(year);
  }

  fetchStatistics(int year) async {
    List<BookClass> books = BookModel.getAllData().toList();
    books = books.where((element) => year <= element.date.year).toList();
    books.sort((a, b) => a.date.compareTo(b.date));
    final List<BookClass> finishedBook =
        books.where((value) => value.status == "finished").toList();
    Map<DateTime, int> monthly = {};
    Map<String, int> catego = {};
    setState(() {
      current = books.where((x) => x.status == "current").length;
      abandonned = books.where((x) => x.status == "abandonned").length;

      finished = finishedBook.length;
      paperBooks = finishedBook.where((x) => x.isPaper == true).length;
      electroBooks = finished - paperBooks;

      finishedBook.forEach((element) {
        int p = int.tryParse(element.nbrPage) ?? 0;
        pages = pages += p;
        if (element.isPaper) paperPages += p;
        DateTime monthK = DateTime(element.date.year, element.date.month);
        catego.update(element.category, (value) => value + 1,
            ifAbsent: () => 0);
        monthly.update(monthK, (currentValue) => currentValue + 1,
            ifAbsent: () => 0);
      });
      electroPages = pages - paperPages;

      englishBook = finishedBook.where((x) => x.version == "Anglaise").length;

      frenchBook = finished - englishBook;
    });
    monthly.forEach((key, value) {
      datas.add(finishedPerMonth(key, value));
    });
    catego.forEach((key, value) {
      categories.add(bestCategories(key, value));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statistique'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 80,
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Text("Lus: ${finished.toString()}")),
                    flex: 1,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Text("${pages.toString()} pages")),
                    flex: 1,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                            "${current.toString()} courrants \n ${abandonned.toString()} abandonnés ")),
                    flex: 1,
                  ),
                ],
              ),
            ),
            Container(
              height: 300,
              child: SfCartesianChart(
                title: const ChartTitle(text: "Statistique des livre lus"),
                primaryXAxis: const DateTimeCategoryAxis(
                  intervalType: DateTimeIntervalType.months,
                  interval: 1,
                ),
                series: <CartesianSeries<finishedPerMonth, DateTime>>[
                  ColumnSeries<finishedPerMonth, DateTime>(
                      dataSource: datas.reversed.take(7).toList(),
                      xValueMapper: (finishedPerMonth book, _) => book.month,
                      yValueMapper: (finishedPerMonth book, _) =>
                          book.bookTotal)
                ],
              ),
            ),
            Container(
              height: 200,
              child: SfCircularChart(
                title: const ChartTitle(text: "Statistiques des categories"),
                series: <CircularSeries>[
                  PieSeries<bestCategories, String>(
                    dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        labelPosition: ChartDataLabelPosition.outside,
                        useSeriesColor: true,
                        showZeroValue: false),
                    dataSource: categories,
                    xValueMapper: (bestCategories c, _) => c.category,
                    yValueMapper: (bestCategories c, _) => c.number,
                    dataLabelMapper: (bestCategories c, _) => c.category,
                    radius: '70%',
                    explode: true,
                    explodeAll: true,
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Autres information"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('$englishBook livres Vo'),
                      Text('$frenchBook livres Vf')
                    ],
                  ),
                  Text(
                    'Papier: $paperBooks livres/ $paperPages pages',
                  ),
                  Text(
                      'Electronique: $electroBooks livres/ $electroPages  pages')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
