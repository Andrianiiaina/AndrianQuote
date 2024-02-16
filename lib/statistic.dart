import 'package:andrianiaiina_quote/models/statistic_model.dart';
import 'package:andrianiaiina_quote/widgets/style.dart';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:select_form_field/select_form_field.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({Key? key}) : super(key: key);

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  int year = 2024;
  TextEditingController yearController = TextEditingController();
  final List<StatisticClass> allStats = statisticModel.getAllData().toList();
  late StatisticClass stat;
  late int perDay;

  @override
  void initState() {
    super.initState();
    stat = fetchStatistics(year);
    perDay = getPerDay(year);
  }

  int getPerDay(year) {
    return DateTime.now().year == year
        ? (stat.totalFinishedPage /
                DateTime.now().difference(DateTime(year)).inDays)
            .round()
        : stat.pagesPerDay;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      appBar: AppBar(
        title: const Text('Statistiques'),
        actions: [
          SizedBox(
            child: SelectFormField(
              style: const TextStyle(color: Colors.white),
              initialValue: '2024',
              type: SelectFormFieldType.dropdown,
              items: const [
                {'value': 2022, 'label': '2022'},
                {'value': 2023, 'label': '2023'},
                {'value': 2024, 'label': '2024'},
              ],
              onChanged: (value) async {
                setState(() {
                  stat = fetchStatistics(int.parse(value));
                  perDay = getPerDay(int.parse(value));
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
                  statisticButton("${stat.finished.toString()} livres lus"),
                  statisticButton("${stat.totalFinishedPage.toString()} pages"),
                  statisticButton(
                      "${stat.current.toString()} en cours \n${stat.abandonned.toString()} abandonnés"),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    child: Text(
                      "Autres informations",
                      style: TextStyle(
                          fontSize: 16, color: Color.fromARGB(198, 0, 0, 0)),
                    ),
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      statisticText('${stat.englishVersion} livres en anglais'),
                      statisticText('${stat.frenchVersion} livres en francais')
                    ],
                  ),
                  statisticText('$perDay pages par jour en moyenne.'),
                  statisticText(
                      '${stat.paperBook} livres en papier: ${stat.paperPages} pages.'),
                  statisticText(
                      ' ${stat.digitalBook} livres numerique: ${stat.digitalPages} pages.'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
