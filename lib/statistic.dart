import 'package:andrianiaiina_quote/models/statisticModel.dart';
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
  final List<statisticClass> allStats = statisticModel.getAllData().toList();
  late statisticClass stat;
  late int perDay;

  @override
  void initState() {
    super.initState();
    stat = fetchStatistics(year);
    perDay = DateTime.now().year == year
        ? (stat.totalFinishedPage /
                DateTime.now().difference(DateTime(year)).inDays)
            .round()
        : stat.pagesPerDay;
  }

  statisticClass fetchStatistics(int year) {
    return allStats.firstWhere((e) => e.year == year,
        orElse: () => statisticClass(
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
        title: const Text('Statistique'),
        actions: [
          Container(
            child: SelectFormField(
              style: const TextStyle(color: Colors.grey),
              initialValue: '2024',
              type: SelectFormFieldType.dropdown,
              items: [
                {'value': 2022, 'label': '2022'},
                {'value': 2023, 'label': '2023'},
                {'value': 2024, 'label': '2024'},
              ],
              onChanged: (value) async {
                setState(() {
                  stat = fetchStatistics(int.parse(value));

                  perDay = (stat.totalFinishedPage /
                          DateTime.now().difference(DateTime(year)).inDays)
                      .round();
                });
              },
            ),
            width: 80,
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
                      "${stat.current.toString()} en cours \n${stat.abandonned.toString()} abandonnés "),
                ],
              ),
            ),
            Container(
              height: 300,
              margin: EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width,
              child: SfCartesianChart(
                title: const ChartTitle(text: "Statistique des livres lus"),
                primaryXAxis: const DateTimeCategoryAxis(
                  intervalType: DateTimeIntervalType.months,
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
              margin: EdgeInsets.only(top: 20),
              width: MediaQuery.of(context).size.width,
              child: SfCircularChart(
                title: const ChartTitle(text: "Statistiques des categories"),
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
              margin: EdgeInsets.only(top: 20),
              padding: const EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    child: Text(
                      "Autre informations",
                      style: TextStyle(fontSize: 20, color: Colors.black87),
                    ),
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      statisticText('${perDay} pages/jours'),
                      statisticText('${stat.englishVersion} livres Vf'),
                      statisticText('${stat.frenchVersion} livres Vo')
                    ],
                  ),
                  statisticText(
                      '${stat.paperBook} livres papier : ${stat.paperPages} pages'),
                  statisticText(
                      ' ${stat.digitalBook} livres numerique : ${stat.digitalPages} pages'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
