import 'package:hive/hive.dart';
part 'statistic_class.g.dart';

@HiveType(typeId: 6)
class StatisticClass extends HiveObject {
  dynamic id;
  @HiveField(0)
  int year;
  @HiveField(1)
  int finished;
  @HiveField(2)
  int current;
  @HiveField(3)
  int abandonned;
  @HiveField(4)
  int totalFinishedPage;
  @HiveField(5)
  List<Map<DateTime, int>> finishedPerMonth;
  @HiveField(6)
  List<Map<String, int>> categories;
  @HiveField(7)
  int paperBook;
  @HiveField(8)
  int digitalBook;
  @HiveField(9)
  int paperPages;
  @HiveField(10)
  int digitalPages;
  @HiveField(11)
  int englishVersion;
  @HiveField(12)
  int frenchVersion;
  @HiveField(13)
  int pagesPerDay;

  StatisticClass({
    this.id,
    required this.year,
    required this.finished,
    required this.current,
    required this.abandonned,
    required this.categories,
    required this.digitalBook,
    required this.digitalPages,
    required this.englishVersion,
    required this.finishedPerMonth,
    required this.frenchVersion,
    required this.pagesPerDay,
    required this.paperBook,
    required this.paperPages,
    required this.totalFinishedPage,
  });
}
