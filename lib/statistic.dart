import 'package:andrianiaiina_quote/models/statistic_model.dart';
import 'package:andrianiaiina_quote/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:select_form_field/select_form_field.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({Key? key}) : super(key: key);

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  int year = DateTime.now().year;
  final List<StatisticClass> allStats = StatisticModel.getAllData().toList();
  late StatisticClass stat;
  late int perDay;

  @override
  void initState() {
    super.initState();
    stat = fetchStatistics(year);
    perDay = getPerDayPages(year);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      appBar: AppBar(
        title: const Text('Statistiques'),
        actions: [
          SizedBox(
            child: SelectFormField(
              initialValue: '2024',
              type: SelectFormFieldType.dialog,
              items: const [
                {'value': 2022, 'label': '2022'},
                {'value': 2023, 'label': '2023'},
                {'value': 2024, 'label': '2024'},
              ],
              onChanged: (value) async {
                setState(() {
                  year = int.parse(value);
                  stat = fetchStatistics(year);
                  perDay = getPerDayPages(year);
                });
              },
            ),
            width: 100,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 80,
              child: Row(
                children: [
                  statisticButton(
                      "${stat.finished.toString()} livres lus\n${stat.totalFinishedPage.toString()} pages",
                      () {
                    context.go('/search_book/${0}/$year');
                  }),
                  statisticButton("${stat.current.toString()} \nen cours", () {
                    context.go('/search_book/${1}/$year');
                  }),
                  statisticButton(
                    "${stat.abandonned.toString()} \nabandonnés",
                    () {
                      context.go('/search_book/${2}/$year');
                    },
                  )
                ],
              ),
            ),
            Container(
              height: 300,
              margin: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width,
              child: SfCartesianChart(
                title: const ChartTitle(text: "Statistique des livres lus"),
                primaryXAxis: const DateTimeCategoryAxis(
                  intervalType: DateTimeIntervalType.months,
                  interval: 1,
                  //dateFormat: DateFormat().m,
                ),
                primaryYAxis: const NumericAxis(
                  initialVisibleMinimum: 0,
                  interval: 1,
                ),
                series: <CartesianSeries<Map<DateTime, int>, DateTime>>[
                  ColumnSeries<Map<DateTime, int>, DateTime>(
                      dataSource: stat.finishedPerMonth,
                      xValueMapper: (Map<DateTime, int> book, _) =>
                          book.entries.first.key,
                      yValueMapper: (Map<DateTime, int> book, _) =>
                          book.entries.first.value),
                ],
              ),
            ),
            Container(
              height: 200,
              margin: const EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width,
              child: SfCircularChart(
                title: const ChartTitle(text: "Statistique des categories"),
                series: <CircularSeries<Map<String, int>, String>>[
                  PieSeries<Map<String, int>, String>(
                    dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        labelPosition: ChartDataLabelPosition.outside,
                        useSeriesColor: true,
                        showZeroValue: false),
                    dataSource: stat.categories,
                    xValueMapper: (Map<String, int> c, _) =>
                        c.entries.first.key.toString(),
                    yValueMapper: (Map<String, int> c, _) =>
                        c.entries.first.value,
                    dataLabelMapper: (Map<String, int> c, _) =>
                        c.entries.first.key.toString(),
                    radius: '70%',
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width,
              height: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    child: Text(
                      "Autres informations",
                      style: TextStyle(fontSize: 16),
                    ),
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      statisticButton(
                          "${stat.englishVersion} livres en anglais", () {
                        context.go('/search_book/${3}/$year');
                      }),
                      statisticButton(
                          "${stat.frenchVersion} livres en francais", () {
                        context.go('/search_book/${4}/$year');
                      }),
                    ],
                  ),
                  statisticButton('$perDay pages par jour en moyenne.', () {}),
                  statisticButton(
                      '${stat.paperBook} livres en papier: ${stat.paperPages} pages.',
                      () {
                    context.go('/search_book/${5}/$year');
                  }),
                  statisticButton(
                      ' ${stat.digitalBook} livres numeriques: ${stat.digitalPages} pages.',
                      () {
                    context.go('/search_book/${6}/$year');
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  StatisticClass fetchStatistics(int year) {
    return allStats.firstWhere((e) => e.year == year,
        orElse: () => StatisticClass(
            year: 0,
            finished: 0,
            current: 0,
            abandonned: 0,
            categories: [],
            digitalBook: 0,
            digitalPages: 0,
            englishVersion: 0,
            finishedPerMonth: [],
            frenchVersion: 0,
            pagesPerDay: 0,
            paperBook: 0,
            paperPages: 0,
            totalFinishedPage: 0));
  }

  int getPerDayPages(year) {
    return DateTime.now().year == year
        ? (stat.totalFinishedPage /
                DateTime.now().difference(DateTime(year)).inDays)
            .round()
        : stat.pagesPerDay;
  }
}
